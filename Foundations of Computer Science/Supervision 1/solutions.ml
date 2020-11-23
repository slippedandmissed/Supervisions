(*
Given functions:
*)
let descend n = 
    let rec aux (carry, k) = 
            if k = n then n :: carry else aux(k::carry, k+1) 
    in aux ([], 1);; 

let rec change till amt =
  if amt = 0
  then [ [] ]
  else match till with
       | [] -> []
       | c::till ->
          if amt < c
	  then change till amt
          else let rec allc = function
                   | [] -> []
                   | cs :: css -> (c::cs) :: allc css
               in
                 allc (change (c::till) (amt - c)) @
                 change till amt ;; 

let partitions n = change (descend n) n;;


(*
Problems:
   1) List all integer partitions of n containing only odd integers. 
   2) List all integer partitions of n containing distinct integers (no duplicates). 
   3) List all integer partitions of n containing only duplicate integers

My solutions:
*)

(*
My implementation of List.for_all
*)
let rec for_all predicate = function
   | [] -> true
   | a::rest -> if predicate a then for_all predicate rest else false;;

(*
My implementation of List.exists
*)
let rec for_any predicate = function
   | [] -> false
   | a::rest -> if predicate a then true else for_any predicate rest;;

(*
Returns the subset of the input list which satisfy the predicate
*)
let rec filter predicate = function 
    | [] -> [] 
    | a::rest -> if predicate a then a :: (filter predicate rest) else (filter predicate rest);;


(*
Problem 1
*)
let is_odd x = x mod 2 = 1;;
let solution1 n = filter (for_all is_odd) (partitions n);;

(*
Problem 2
*)
let rec distinct_integers = function
   | [] -> true
   | a::rest -> if for_any (fun x -> x=a) rest then false else distinct_integers rest;;

let solution2 n = filter distinct_integers (partitions n);;

(*
Problem 3
*)
let rec only_duplicates = function
   | [] -> true
   | [a] -> true
   | a::(b::rest) -> if a=b then only_duplicates (b::rest) else false;;

let solution3 n = filter only_duplicates (partitions n);;

(*
Convert solution 1 to solution 2 and vice versa
*)
let count_occurances list x =
   let rec aux count = function
      | [] -> count
      | a :: rest -> if a = x then aux (count + 1) rest else aux count rest
   in aux 0 list;;

(*
NOTE: This assumes that duplicates appear consecutively, which they do when using output from 'solution1'. It also assumes that the first element of the list is not -1
*)
let remove_duplicates list =
   let rec aux prev = function
      | [] -> []
      | a::rest -> if a=prev then aux a rest else a :: (aux a rest)
   in aux (-1) list;;

let mult a x = x * a;;

let rec binary_decompose x =
   match x, x mod 2 with
   | 0, p -> []
   | x, 1 ->  (List.map (mult 2) (binary_decompose (x/2))) @ [1]
   | x, 0 -> List.map (mult 2) (binary_decompose (x/2));;
   
let rec flatten = function
   | [] -> []
   | a::rest -> a @ flatten rest;;

let biject_1_to_2 part =
   let odd_numbers = remove_duplicates part
   in List.sort (fun x y -> y-x) (flatten (List.mapi (fun x pows -> List.map (mult (List.nth odd_numbers x)) pows) (List.map binary_decompose (List.map (count_occurances part) odd_numbers))));;

let solution2_alt n =
   List.map biject_1_to_2 (solution1 n);;


let rec repeat atom = function
   | 0 -> []
   | count -> atom :: (repeat atom (count - 1));;

let split_part x =
   let rec aux pow stub =
      match stub mod 2 with
      | 0 -> aux (2 * pow) (stub/2)
      | 1 -> repeat stub pow
   in aux 1 x;;

let biject_2_to_1 part =
   List.sort (fun x y -> y-x) (flatten (List.map split_part part));;

let solution1_alt n =
   List.map biject_2_to_1 (solution2 n);;