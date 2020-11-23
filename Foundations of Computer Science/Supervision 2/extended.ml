
type literal =
    | Lint of int
    | Lbool of bool

type expr =
    | Evar of string
    | Eliteral of literal
    | Eplus of expr * expr
    | Eand of expr * expr
    | Eor of expr * expr
    | Enot of expr
    | Eequals of expr * expr
    | Etimes of expr * expr
    | Elet of string * expr * expr
    | Eif of expr * expr * expr

let makeint (x:int) = Eliteral (Lint x);;
let makebool (x:bool) = Eliteral (Lbool x);;
                
exception Missing of string 

let rec lookup = function
    | [], a -> raise (Missing a)
    | (x, y) :: pairs, a ->
        if a = x then y else lookup (pairs, a)		   

let update (l, b, y) = (b, y) :: l

type environment = (string * literal) list 

exception TypeError of string

let rec eval ((env, e) : environment * expr) : literal  =
    match e with
    | Eliteral(n) -> n
    | Evar(x) -> lookup (env, x)
    | Eplus(a,b) ->
        let v1 = eval (env, a)
        and v2 = eval (env, b)
        in (match v1, v2 with
        | Lint(a), Lint(b) -> Lint(a + b)
        | Lbool(_), Lbool(_) -> raise (TypeError "Cannot add bool to bool")
        | Lint(_), Lbool(_) -> raise (TypeError "Cannot add int to bool")
        | Lbool(_), Lint(_) -> raise (TypeError "Cannot add bool to int"))
    | Etimes(a,b) ->
        let v1 = eval (env, a)
        and v2 = eval (env, b)
        in (match v1, v2 with
        | Lint(a), Lint(b) -> Lint(a * b)
        | Lbool(_), Lbool(_) -> raise (TypeError "Cannot multiply bool by bool")
        | Lint(_), Lbool(_) -> raise (TypeError "Cannot multiply int by bool")
        | Lbool(_), Lint(_) -> raise (TypeError "Cannot multiply bool by int"))
    | Eand(a,b) ->
        let v1 = eval (env, a)
        and v2 = fun () -> eval (env, b)
        in (match v1 with
        | Lint(c) -> (match (v2 ()) with 
            | Lint(d) -> Lint(c land d)
            | Lbool(_) -> raise (TypeError "Cannot AND int with bool"))
        | Lbool(false) -> Lbool (false)
        | Lbool(true) -> (match (v2 ()) with
            | Lint(d) -> raise (TypeError "Cannot AND int with bool")
            | Lbool(d) -> Lbool(d)))
    | Eor(a,b) ->
        let v1 = eval (env, a)
        and v2 = fun () -> eval (env, b)
        in (match v1 with
        | Lint(c) -> (match (v2 ()) with 
            | Lint(d) -> Lint(c lor d)
            | Lbool(_) -> raise (TypeError "Cannot OR int with bool"))
        | Lbool(true) -> Lbool (true)
        | Lbool(false) -> (match (v2 ()) with
            | Lint(d) -> raise (TypeError "Cannot OR int with bool")
            | Lbool(d) -> Lbool(d)))
    | Enot(a) ->
        let v1 = eval (env, a)
        in (match v1 with
        | Lint(_) -> raise (TypeError "Cannot NOT int")
        | Lbool(a) -> Lbool (not a))
    | Eequals(a,b) ->
        let v1 = eval (env, a)
        and v2 = eval (env, b)
        in (match v1, v2 with
        | Lint(a), Lint(b) -> Lbool (a=b)
        | Lbool(a), Lbool(b) -> Lbool (a=b)
        | Lint(_), Lbool(_) -> raise (TypeError "Cannot compare int with bool")
        | Lbool(_), Lint(_) -> raise (TypeError "Cannot compare bool with int"))
    | Elet(x, y, k) -> eval ((update (env, x, eval (env, y))), k)
    | Eif (c, a, b) ->
        let v = eval (env, c)
        in (match v with
        | Lbool(p) -> if p then eval (env, a) else eval(env, b)
        | Lint(p) -> if p = 0 then eval (env, b) else eval (env, a))
    ;;

type intruction =
    | Ipush of literal
    | Iplus
    | Itimes
    | Iand
    | Ior
    | Inot
    | Iequals
    | Ifind of string
    | Ibind of string
    | Iif

type code = intruction list
            
type stack = literal list
                
type state = State of environment * code * stack

exception RuntimeError

let rec run s =
match s with
| State(_,                   [],                             [v]) -> v
| State(env, (Ifind s) :: insts,                           stack) -> run (State(env, insts, (lookup(env, s)) :: stack))
| State(env, (Ibind s) :: insts,                      v :: stack) -> run (State(update(env, s, v), insts, stack)) 
| State(env, (Ipush v) :: insts,                           stack) -> run (State(env, insts, v :: stack))
| State(env,     Iplus :: insts,     Lint(a) :: Lint(b) :: stack) -> run (State(env, insts, Lint(a + b) :: stack))
| State(env,    Itimes :: insts,     Lint(a) :: Lint(b) :: stack) -> run (State(env, insts, Lint(a * b) :: stack))
| State(env,      Iand :: insts,     Lint(a) :: Lint(b) :: stack) -> run (State(env, insts, Lint(a land b) :: stack))
| State(env,      Iand :: insts,   Lbool(a) :: Lbool(b) :: stack) -> run (State(env, insts, Lbool(a && b) :: stack))
| State(env,       Ior :: insts,     Lint(a) :: Lint(b) :: stack) -> run (State(env, insts, Lint(a lor b) :: stack))
| State(env,       Ior :: insts,   Lbool(a) :: Lbool(b) :: stack) -> run (State(env, insts, Lbool(a || b) :: stack))
| State(env,      Inot :: insts,               Lbool(a) :: stack) -> run (State(env, insts, Lbool(not a) :: stack))
| State(env,   Iequals :: insts,     Lint(a) :: Lint(b) :: stack) -> run (State(env, insts, Lbool(a = b) :: stack))
| State(env,   Iequals :: insts,   Lbool(a) :: Lbool(b) :: stack) -> run (State(env, insts, Lbool(a = b) :: stack))
| State(env,       Iif :: insts,  Lbool(true) :: a :: b :: stack) -> run (State(env, insts, b::stack))
| State(env,       Iif :: insts, Lbool(false) :: a :: b :: stack) -> run (State(env, insts, a::stack))
| _ -> raise RuntimeError 						       

let rec compile (e : expr) : code =
    match e with
    | Eliteral(n) -> [Ipush n]
    | Eplus(a,b) -> (compile a) @ (compile b) @ [Iplus]
    | Etimes(a,b) -> (compile a) @ (compile b) @ [Itimes]
    | Eand(a,b) -> (compile a) @ (compile b) @ [Iand]
    | Eor(a,b) -> (compile a) @ (compile b) @ [Ior]
    | Enot(a) -> (compile a) @ [Inot]
    | Eequals(a,b) -> (compile a) @ (compile b) @ [Iequals]
    | Evar(x) -> [Ifind x]
    | Elet(x,v,k) -> (compile v) @ [Ibind x] @ (compile k)
    | Eif (c, a, b) -> (compile a) @ (compile b) @ (compile c) @ [Iif];;

let compile_and_run e = run (State([], compile e, []));;


let example1 = Eif(Eequals(Elet("x", makeint 17, Elet("y", Eplus(Evar "x", makeint 21), Etimes (Evar "x", Eplus(Evar "y", makeint 19)))), makeint 969), makeint 123, makeint 456);;

(* eval ([] ,example1);; *)
compile_and_run example1;;