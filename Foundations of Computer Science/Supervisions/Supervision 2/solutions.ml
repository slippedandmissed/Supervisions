(*
Given code:
*)

type expr =                        (* representing     *) 
  | Evar of string                 (* x                *) 
  | Eint of int                    (* n                *) 
  | Eplus of expr * expr           (* e1 + e2          *) 
  | Etimes of expr * expr          (* e1 * e2          *) 
  | Elet of string * expr * expr   (* let x = e1 in e2 *)

let example1 = Elet("x", Eint 17, Elet("y", Eplus(Evar "x", Eint 21), Etimes (Evar "x", Eplus(Evar "y", Eint 19))))
			      
exception Missing of string 

let rec lookup = function
  | [], a -> raise (Missing a)
  | (x, y) :: pairs, a ->
    if a = x then y else lookup (pairs, a)		   

let update (l, b, y) = (b, y) :: l

type environment = (string * int) list

(*
My code:
*)

let rec eval ((env, e) : environment * expr) : int  =
    match e with
    | Eint(n) -> n
    | Evar(x) -> lookup (env, x)
    | Eplus(a,b) -> (eval (env, a)) + (eval (env, b))
    | Etimes(a,b) -> (eval (env, a)) * (eval (env, b))
    | Elet(x, y, k) -> eval ((update (env, x, eval (env, y))), k);;

(*
More given code:
*)

type intruction = Ipush of int | Iplus | Itimes | Ifind of string | Ibind of string

type code = intruction list
		       
type stack = int list
				
type state = State of environment * code * stack

exception RuntimeError

let rec run s =
  match s with
  | State(_,                   [],             [v]) -> v
  | State(env, (Ifind s) :: insts,           stack) -> run (State(env, insts, (lookup(env, s)) :: stack))
  | State(env, (Ibind s) :: insts,      v :: stack) -> run (State(update(env, s, v), insts, stack)) 
  | State(env, (Ipush v) :: insts,           stack) -> run (State(env, insts, v :: stack))
  | State(env,     Iplus :: insts, a :: b :: stack) -> run (State(env, insts, (a + b) :: stack))
  | State(env,    Itimes :: insts, a :: b :: stack) -> run (State(env, insts, (a * b) :: stack))
  | _ -> raise RuntimeError 						       

(*
My code:
*)

let rec compile (e : expr) : code =
    match e with
    | Eint(n) -> [Ipush n]
    | Eplus(a,b) -> (compile a) @ (compile b) @ [Iplus]
    | Etimes(a,b) -> (compile a) @ (compile b) @ [Itimes]
    | Evar(x) -> [Ifind x]
    | Elet(x,v,k) -> (compile v) @ [Ibind x] @ (compile k);;

(*
More given code:
*)

let compile_and_run e = run (State([], compile e, []));;

