(*
   FoCS 2020 : Problem Set 2 (assigned by tgg22@cam.ac.uk).
   
   Part 1: We will use data type declarations in OCaml 
   to implement an interpreter and compiler for a small 
   toy expression language. 

*)

exception ToDo;;
let ycgh () = raise ToDo;; (* ycgh = your code goes here *) 


(* The type expr represents abstract syntax trees in our 
   little language of expressions. 
*) 
type expr =                        (* representing     *) 
  | Evar of string                 (* x                *) 
  | Eint of int                    (* n                *) 
  | Eplus of expr * expr           (* e1 + e2          *) 
  | Etimes of expr * expr          (* e1 * e2          *) 
  | Elet of string * expr * expr   (* let x = e1 in e2 *)


(* For example, the an experssion like 
  
   let x = 17 
   in let y = x + 21 
      in x * (y + 99) 

   is represented as 
*) 			      
let example1 = Elet("x", Eint 17, Elet("y", Eplus(Evar "x", Eint 21), Etimes (Evar "x", Eplus(Evar "y", Eint 19))))
			      
(* we now implement an evaluation function for expressions. 
   First, we need a way of associating variables with values. 
*) 			      
exception Missing of string 

let rec lookup = function
  | [], a -> raise (Missing a)
  | (x, y) :: pairs, a ->
    if a = x then y else lookup (pairs, a)		   

let update (l, b, y) = (b, y) :: l

type environment = (string * int) list
				  
(* Now, write  the function 

   eval : environment * expr -> int 

   Given the expression example1 above, eval([], example1) should return 969. 
*) 				   
let rec eval ((env, e) : environment * expr) : int  =
    match e with
    | Eint(n) -> n
    | Evar(x) -> lookup (env, x)
    | Eplus(a,b) -> (eval (env, a)) + (eval (env, b))
    | Etimes(a,b) -> (eval (env, a)) * (eval (env, b))
    | Elet(x, y, k) -> eval ((update (env, x, eval (env, y))), k);;

(* Now we implement a low-level stack machine with an instruction set *) 	    

type intruction = Ipush of int | Iplus | Itimes | Ifind of string | Ibind of string

type code = intruction list
		       
type stack = int list
				
type state = State of environment * code * stack

exception RuntimeError

(* run : state -> int 

   The idea is this. If we start with an initial state with c of type code 

   State([], c, []) 

   then "run (State([], c, []))" should perform each intruction in c and eventually reach a state 
   of the form State(_, [], [v]), where v is the result of running the code c. 

*) 
let rec run s =
  match s with
  | State(_,                   [],             [v]) -> v
  | State(env, (Ifind s) :: insts,           stack) -> run (State(env, insts, (lookup(env, s)) :: stack))
  | State(env, (Ibind s) :: insts,      v :: stack) -> run (State(update(env, s, v), insts, stack)) 
  | State(env, (Ipush v) :: insts,           stack) -> run (State(env, insts, v :: stack))
  | State(env,     Iplus :: insts, a :: b :: stack) -> run (State(env, insts, (a + b) :: stack))
  | State(env,    Itimes :: insts, a :: b :: stack) -> run (State(env, insts, (a * b) :: stack))
  | _ -> raise RuntimeError 						       


(* Write the function 

   compile : expr -> code 

   that translates an expression into code that when run will return the 
   same value as eval. 

   The basic idea is this: "compile e" generates code that when run will leave the
   value of e on top of the stack. 

   For example, "compile example1" should return the code 

    [Ipush 17; 
     Ibind "x"; 
     Ifind "x"; 
     Ipush 21; 
     Iplus; 
     Ibind "y"; 
     Ifind "x";
     Ifind "y"; 
     Ipush 19; 
     Iplus; 
     Itimes]

   If this is unclear, then here is a hint: 
   https://en.wikipedia.org/wiki/Reverse_Polish_notation
*) 	       
let rec compile (e : expr) : code = ycgh ()

(* "compile_and_run example1" should return 969 *) 
let compile_and_run e = run (State([], compile e, []))

(* Optional fun. 
   Extend expr/eval/compile to include 
   -- booean values and operations (and, or, not, =) 
   -- conditions (if ... then ... else) 
   -- type checking (for example, you can't add a boolean to an int) 
   -- simple functions    (difficult!) 
   -- recursive functions (even more difficult!) 
*) 
   			    