type datatype =
    | Tint
    | Tbool;;

type expr =
    | Evar of string
    | Eint of int
    | Ebool of bool
    | Eplus of expr * expr
    | Etimes of expr * expr
    | Eand of expr * expr
    | Eor of expr * expr
    | Enot of expr
    | Eequals of expr * expr
    | Elet of string * expr * expr
    | Eif of expr * expr * expr
    | Eletfunc of string * (string * datatype) list * expr * expr * datatype
    | Ecallfunc of string * expr list;;

type texpr =
    | TEvar of string * datatype
    | TElit of int * datatype
    | TEplus of texpr * texpr * datatype
    | TEtimes of texpr * texpr * datatype
    | TEand of texpr * texpr * datatype
    | TEor of texpr * texpr * datatype
    | TEnot of texpr * datatype
    | TEequals of texpr * texpr
    | TElet of string * texpr * texpr * datatype
    | TEif of texpr * texpr * texpr * datatype
    | TEletfunc of string * (string * datatype) list * texpr * texpr * datatype
    | TEcallfunc of string * texpr list * datatype;;

let typeof = function
    | TEvar(_, dt) -> dt
    | TElit(_, dt) -> dt
    | TEplus(_, _, dt) -> dt
    | TEtimes(_, _, dt) -> dt
    | TEand(_, _, dt) -> dt
    | TEor(_, _, dt) -> dt
    | TEnot(_, dt) -> dt
    | TEequals(_, _) -> Tbool
    | TElet(_, _, _, dt) -> dt
    | TEif(_, _, _, dt) -> dt
    | TEletfunc(_,_,_,_,dt) -> dt
    | TEcallfunc(_,_,dt) -> dt;;

exception Missing of string;;
exception TypeError;;
exception ArgumentMismatchError;;

type environment = (string * int) list;;
type type_environment = (string * datatype) list;;
type func_type_environment = (string * (datatype list * datatype)) list;;
type func_environment = (string * ((string * datatype) list * texpr)) list;;


let rec lookup = function
    | [], a -> raise (Missing a)
    | (x, y) :: pairs, a ->
        if a = x then y else lookup (pairs, a);;	   

let update (l, b, y) = (b, y) :: l;;

let rec update_all ((env,args) : type_environment * type_environment) : type_environment =
    match args with
    | [] -> env
    | (b,y)::l -> update_all(update(env,b,y), l);;

let rec zipargs names values =
    match names, values with
    | [], [] -> []
    | (a,at)::atail, (b,bt)::btail -> (a,b) :: (zipargs atail btail)
    | _, _ -> raise ArgumentMismatchError;;

let rec argtypes (args : (string * datatype) list) =
    match args with
    | [] -> []
    | (n,t)::tail -> t::(argtypes tail) 

let rec all_match a b =
    match a, b with
    | [], [] -> true
    | a::atail, b::btail -> a=b && all_match atail btail
    | _, _ -> false;;

let rec calculate_types ((fenv,env,e) : func_type_environment * type_environment * expr) : texpr =
    match e with
    | Evar(x) -> TEvar(x, lookup(env, x))
    | Eint(n) -> TElit(n, Tint)
    | Ebool(n) -> TElit((match n with true -> 1 | false -> 0), Tbool)
    | Eplus(a, b) -> let p=calculate_types(fenv,env,a) and q=calculate_types(fenv,env,b) in (match typeof p, typeof q with Tint, Tint -> TEplus(p, q, Tint) | _, _ -> raise TypeError)
    | Etimes(a, b) -> let p=calculate_types(fenv,env,a) and q=calculate_types(fenv,env,b) in (match typeof p, typeof q with Tint, Tint -> TEtimes(p, q, Tint) | _, _ -> raise TypeError)
    | Eand(a, b) -> let p=calculate_types(fenv,env,a) and q=calculate_types(fenv,env,b) in (match typeof p, typeof q with pt, qt when pt=qt -> TEand(p, q, pt) | _, _ -> raise TypeError)
    | Eor(a, b) -> let p=calculate_types(fenv,env,a) and q=calculate_types(fenv,env,b) in (match typeof p, typeof q with pt, qt when pt=qt -> TEor(p, q, pt) | _, _ -> raise TypeError)
    | Enot(a) -> let p=calculate_types(fenv,env,a) in TEnot(p, typeof p) 
    | Eequals(a, b) -> let p=calculate_types(fenv,env,a) and q=calculate_types(fenv,env,b) in (match typeof p, typeof q with pt, qt when pt=qt -> TEequals(p, q) | _, _ -> raise TypeError)
    | Elet(x, k, y) -> let q = calculate_types(fenv,env, k) in let p=calculate_types(fenv,update (env,x,typeof q), y) in TElet(x, q, p, typeof p)
    | Eif(x, a, b) -> let r = calculate_types(fenv,env,x) in (match typeof r with
        | Tbool -> let p=calculate_types(fenv,env,a) and q=calculate_types(fenv,env,b) in (match typeof p, typeof q with
            | pt, qt when pt=qt -> TEif(r, p, q, pt)
            | _, _ -> raise TypeError)
        | _ -> raise TypeError)
    | Eletfunc(x, args, k, y, r) -> let newfenv=update(fenv,x,(argtypes args, r)) in let p=calculate_types(newfenv,update_all(env,args),k) in let q = calculate_types(newfenv,env,y) in (match typeof p=r with true -> TEletfunc(x, args, p, q, r) | false -> raise TypeError)
    | Ecallfunc(x, args) -> let (properargtypes, r) = lookup(fenv, x) in if all_match properargtypes (List.map typeof (List.map (fun x -> calculate_types(fenv,env,x)) args)) then TEcallfunc(x,List.map (fun a -> calculate_types(fenv,env,a)) args, r) else raise TypeError;;

let bitwise_and (a:int*datatype) (b:int*datatype) =
    match a, b with
    | (p, _), (q, _) -> p land q;;

let bitwise_or (a:int*datatype) (b:int*datatype) =
    match a, b with
    | (p, _), (q, _) -> p lor q;;


let eval (e: expr) : int*datatype  =
    let rec aux((fenv,env,t) : func_environment*environment*texpr) : int*datatype =
        match t with
        | TEvar(x, dt) -> (lookup(env, x), dt)
        | TElit(n, dt) -> (n, dt)
        | TEplus(a, b, dt) -> let (p,pt)=aux(fenv,env,a) and (q,qt)=aux(fenv,env,b) in (p+q, dt)
        | TEtimes(a, b, dt) ->  let (p,pt)=aux(fenv,env,a) and (q,qt)=aux(fenv,env,b) in (p*q, dt)
        | TEand(a, b, dt) -> let (p,pt)=aux(fenv,env,a) in (match dt with
            | Tint -> (bitwise_and (p,pt) (aux(fenv,env, b)), Tint)
            | Tbool -> (match p with 0 -> (0, Tbool) | _ -> aux (fenv,env,b)))
        | TEor(a, b, dt) -> let (p,pt)=aux(fenv,env,a) in (match dt with
            | Tint -> (bitwise_or (p,pt) (aux(fenv,env, b)), Tint)
            | Tbool -> (match p with 1 -> (1, Tbool) | _ -> aux (fenv,env,b)))
        | TEnot(a, dt) -> let (p,pt) = aux(fenv,env,a) in (match dt with
            | Tint -> (lnot p, Tint)
            | Tbool -> (1-p, Tbool))
        | TEequals(a,b) -> ((match aux(fenv,env,a) = aux(fenv,env,b) with false -> 0 | true -> 1), Tbool)
        | TElet(x,k,y,dt) -> let (p,pt)=aux(fenv,env,k) in aux(fenv,update(env,x,p),y)
        | TEif(x,a,b,dt) -> let (r,rt)=aux(fenv,env,x) in (match r with 1 -> aux(fenv,env,a) | _ -> aux(fenv,env,b))
        | TEletfunc(x,args,k,y,dt) -> aux(update(fenv,x,(args,k)), env, y)
        | TEcallfunc(x,args,dt) -> let (a,k)=lookup(fenv, x) in aux(fenv, List.fold_left (fun acc (name,value) -> update(acc,name,value)) env (zipargs a (List.map (fun arg -> aux(fenv,env,arg)) args)), k)
    in aux ([], [], calculate_types([],[], e));;

type intruction =
    | Ipush of int
    | Iplus
    | Itimes
    | Ibitand
    | Ibitor
    | Ibitnot
    | Inot
    | Iequals
    | Ijz of int
    | Ijump of int
    | Igoto
    | Iswitch
    | Ipushaddr
    | Iletfunc of string * int
    | Icallfunc of string
    | Ifind of string
    | Ibind of string
    | Iunbind of string
    | Icast of datatype;;

type code = intruction list;;
type func_map = (string * int) list;;

            
type stack = int list;;
                
type state = State of int * environment * code * stack * func_map;;

exception RuntimeError;;

let rec drop list n =
    match list, n with
    | list, 0 -> list
    | a::rest, k -> drop rest (k-1)
    | [], _ -> raise RuntimeError;;

let rec remove = function
    | [], _ -> raise RuntimeError
    | (s,v)::tail, n when s=n -> tail
    | (s,v)::tail, n -> (s,v)::(remove(tail, n));; 

let run ((Icast dt)::code) =
    let rec aux s =
        match s with
        | State(_,   _,                     [],             [v], _) -> v
        | State(k, env,     (Ipush v) :: insts,           stack, fmap) -> aux (State((k+1), env, insts, v :: stack, fmap))
        | State(k, env,         Iplus :: insts, a :: b :: stack, fmap) -> aux (State((k+1), env, insts, (a + b) :: stack, fmap))
        | State(k, env,        Itimes :: insts, a :: b :: stack, fmap) -> aux (State((k+1), env, insts, (a * b) :: stack, fmap))
        | State(k, env,       Ibitand :: insts, a :: b :: stack, fmap) -> aux (State((k+1), env, insts, (a land b) :: stack, fmap))
        | State(k, env,        Ibitor :: insts, a :: b :: stack, fmap) -> aux (State((k+1), env, insts, (a lor b) :: stack, fmap))
        | State(k, env,       Ibitnot :: insts,      a :: stack, fmap) -> aux (State((k+1), env, insts, (lnot a) :: stack, fmap))
        | State(k, env,          Inot :: insts,      a :: stack, fmap) -> aux (State((k+1), env, insts, (1 - a) :: stack, fmap))
        | State(k, env,       Iequals :: insts, a :: b :: stack, fmap) -> aux (State((k+1), env, insts, (match a=b with false -> 0 | true -> 1) :: stack, fmap))
        | State(k, env,       (Ijz v) :: insts,      a :: stack, fmap) -> aux (State((match a with 0 -> k+1+v | _ -> k+1), env, (match a with 0 -> drop insts v | _ -> insts), stack, fmap))
        | State(k, env,     (Ijump v) :: insts,           stack, fmap) -> aux (State((k+1+v), env, drop insts v, stack, fmap))
        | State(k, env,         Igoto :: insts,      a :: stack, fmap) -> aux (State(a+1, env, drop code (a+1), stack, fmap))
        | State(k, env,       Iswitch :: insts, a :: b :: stack, fmap) -> aux (State((k+1), env, insts, b :: a :: stack, fmap))
        | State(k, env,     Ipushaddr :: insts,           stack, fmap) -> aux (State((k+1), env, insts, k :: stack, fmap))
        | State(k, env, Iletfunc(n,l) :: insts,           stack, fmap) -> aux (State((k+1+l), env, drop insts l, stack, update(fmap, n, (k+1))))
        | State(k, env, (Icallfunc n) :: insts,           stack, fmap) -> let addr = lookup(fmap, n) in aux (State(addr, env, drop code addr, stack, fmap))
        | State(k, env,     (Ifind s) :: insts,           stack, fmap) -> aux (State((k+1), env, insts, (lookup(env, s)) :: stack, fmap))
        | State(k, env,     (Ibind s) :: insts,      v :: stack, fmap) -> aux (State((k+1), update(env, s, v), insts, stack, fmap)) 
        | State(k, env,   (Iunbind s) :: insts,           stack, fmap) -> aux (State((k+1), remove(env, s), insts, stack, fmap)) 
        | _ -> raise RuntimeError
    in (aux (State(0, [], code, [], [])), dt);;

let compile (e : expr) : code =
    let typed = calculate_types([],[],e) in
    let rec aux t =
        match t with
        | TEvar(x, dt) -> [Ifind x]
        | TElit(n, dt) -> [Ipush n]
        | TEplus(a, b, dt) -> (aux a) @ (aux b) @ [Iplus]
        | TEtimes(a, b, dt) -> (aux a) @ (aux b) @ [Itimes]
        | TEand(a, b, dt) -> (aux a) @ (match dt with
            | Tint -> (aux b) @ [Ibitand]
            | Tbool -> let bcode = (aux b @ [Ijump 1]) in [Ijz (List.length bcode)] @ bcode @ [Ipush 0])
        | TEor(a, b, dt) -> (aux a) @ (match dt with
            | Tint -> (aux b) @ [Ibitor]
            | Tbool -> let bcode = (aux b @ [Ijump 1]) in [Inot; Ijz (List.length bcode)] @ bcode @ [Ipush 1])
        | TEnot(a, dt) -> (aux a) @ [match dt with
            | Tint -> Ibitnot
            | Tbool -> Inot]
        | TEequals(a, b) -> (aux a) @ (aux b) @ [Iequals]
        | TElet(x,k,y,dt) -> (aux k) @ [Ibind x] @ (aux y)
        | TEif(c,a,b,dt) -> let acode = aux a and bcode = aux b in (aux c) @ [Ijz ((List.length acode) + 1)] @ acode @ [Ijump (List.length bcode)] @ bcode
        | TEletfunc(x,args,k,y,dt) -> let funccode = (List.map (fun (arg,dt) -> Ibind arg) args) @ (aux k) @ (List.map (fun (arg,dt) -> Iunbind arg) args) @ [Iswitch; Igoto] in [Iletfunc (x,List.length funccode)] @ funccode @ (aux y)
        | TEcallfunc(x,args,dt) -> let pushargs = (List.flatten (List.map aux (List.rev args))) in [Ipushaddr; Ipush ((List.length pushargs) + 3); Iplus] @ pushargs @ [Icallfunc x]
    in (Icast (typeof typed)) :: (aux typed) ;;

let compile_and_run e = run (compile e);;

(*
example 1 should equal 578
let x = 17
in let y = x + 21
    in x * (y land 99)

example 2 should equal true
let y = ((15 | 20) = 31)
in y && true

example 3 should equal 2 
if (lnot 9) = (-9) then 1 else 2

example 4 should equal 30 
let add ((a,b) : int*int) : int = a + b
in add (10,20)

example 5 should equal 120
let factorial (n : int) : int = if n=0 then 1 else n * (factorial (n-1))
in factorial 5
*)
let example1 = Elet("x", Eint 17, Elet("y", Eplus(Evar "x", Eint 21), Etimes (Evar "x", Eand(Evar "y", Eint 99))));;
let example2 = Elet("y", Eequals(Eor(Eint 15, Eint 20), Eint 31), Eand(Evar "y", Ebool true));;
let example3 = Eif(Eequals(Enot(Eint 9), Eint (-9)), Eint 1, Eint 2);;
let example4 = Eletfunc("add", [("a", Tint);("b", Tint)], Eplus(Evar "a", Evar "b"), Ecallfunc("add", [Eint 10; Eint 20]), Tint);;
let example5 = Eletfunc("factorial", [("n",Tint)], Eif(Eequals(Evar "n", Eint 0), Eint 1, Etimes(Evar "n", Ecallfunc("factorial", [Eplus(Evar "n", Eint (-1))]))), Ecallfunc("factorial", [Eint 5]), Tint);;

compile_and_run example5;;