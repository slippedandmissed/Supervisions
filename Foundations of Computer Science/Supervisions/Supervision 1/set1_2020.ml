(*
   FoCS 2020 : Problem Set 1 (assigned by tgg22@cam.ac.uk).

   YCGH (at end of this file) stands for "Your Code Goes Here".  
   Please make an attempt to write some 
   code before the first supervision and email it to me even if you have 
   not finished all of the problems. 

   This file uses some code introduced in Lecture 04, but 
   understanding exactly how that code works is not required 
   solving the problems set at the end of this file. 

   This first set of problems is meant to help you become familiar with with 
   OCaml and with using the read-eval-print-loop (REPL). 
   I would suggest going through this file, step-by-step, 
   by cutting and pasting each bit of code into the REPL. 

   If you want to load the entire file into the REPL, then 
   
        #use "set1_2020.ml";; 

   IF YOU WOULD RATHER DO THIS IN A JUPYTER NOTEBOOK, LET ME KNOW...

   Have fun! ---tim 
 *)

(* 
  Here is a simple function "descend n" that returns 
  the list [n, n-1, ...., 1]. 

  For example, typing 

      descend 10;;

  in the REPL will return 

  int list = [10; 9; 8; 7; 6; 5; 4; 3; 2; 1]
*) 
let descend n = 
    let rec aux (carry, k) = 
            if k = n then n :: carry else aux(k::carry, k+1) 
    in aux ([], 1);; 



(* 
  Here is a the code from Sections 4.6--4.8 of the lecture notes that makes 
  change from a till of coins. 

  DON'T PANIC if you do not yet understand how this works. Just read 
  the lecture notes about WHAT it is doing. 

  If "till" is a list of coin values in in descending order and "amt" is some amount, 
  then the function call 

      change till amt;; 

  will return a list of lists recording all ways that that amount can be 
  given with coins of the values provided (we can have many duplicates of 
  a coin of any given value). 

  So for UK coins we could use the list of coin values (in pense)

   [200; 100; 50; 20; 10; 5; 2; 1] 

  as the till. 

  So typing this 

      change [200, 100, 50, 20, 10, 5, 2, 1] 17;; 

  will give the result -- all ways of breaking 17 down into 
  UK coins: 

[[10; 5; 2]; [10; 5; 1; 1]; [10; 2; 2; 2; 1]; [10; 2; 2; 1; 1; 1];
 [10; 2; 1; 1; 1; 1; 1]; [10; 1; 1; 1; 1; 1; 1; 1]; [5; 5; 5; 2];
 [5; 5; 5; 1; 1]; [5; 5; 2; 2; 2; 1]; [5; 5; 2; 2; 1; 1; 1];
 [5; 5; 2; 1; 1; 1; 1; 1]; [5; 5; 1; 1; 1; 1; 1; 1; 1];
 [5; 2; 2; 2; 2; 2; 2]; [5; 2; 2; 2; 2; 2; 1; 1];
 [5; 2; 2; 2; 2; 1; 1; 1; 1]; [5; 2; 2; 2; 1; 1; 1; 1; 1; 1];
 [5; 2; 2; 1; 1; 1; 1; 1; 1; 1; 1]; [5; 2; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1];
 [5; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1]; [2; 2; 2; 2; 2; 2; 2; 2; 1];
 [2; 2; 2; 2; 2; 2; 2; 1; 1; 1]; [2; 2; 2; 2; 2; 2; 1; 1; 1; 1; 1];
 [2; 2; 2; 2; 2; 1; 1; 1; 1; 1; 1; 1];
 [2; 2; 2; 2; 1; 1; 1; 1; 1; 1; 1; 1; 1];
 [2; 2; 2; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1];
 [2; 2; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1];
 [2; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1];
 [1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1; 1]]

 Note that the function change has type 

 val change : int list -> int -> int list list 

 So we can define another function 

  let uk_change = change [200; 100; 50; 20; 10; 5; 2; 1];; 

 of type 

  val uk_change : int -> int list list 

 and then evaluate expression like 

 uk_change 9;; 

 returning 

[[5; 2; 2]; [5; 2; 1; 1]; [5; 1; 1; 1; 1]; [2; 2; 2; 2; 1];
 [2; 2; 2; 1; 1; 1]; [2; 2; 1; 1; 1; 1; 1]; [2; 1; 1; 1; 1; 1; 1; 1];
 [1; 1; 1; 1; 1; 1; 1; 1; 1]]

*) 

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
(* 
  Hey, here is a cool idea --- let's use "change" to compute all integer partitions of a integer n. 
  An integer partition of n is all ways of expressing n as a sum of positive 
  integers.  For example, here are the partitions of n = 6: 
     6
     5 + 1 
     4 + 2 
     4 + 1 + 1 
     3 + 3
     3 + 2 + 1 
     3 + 1 + 1 + 1 
     2 + 2 + 2 
     2 + 2 + 1 + 1 
     2 + 1 + 1 + 1 + 1 
     1 + 1 + 1 + 1 + 1 + 1 

See http://en.wikipedia.org/wiki/Partition_(number_theory)
for more information on integer partitions. 

*) 
let partitions n = change (descend n) n;;

(* if you write 
   partitions 6;;
 
   OCaml should return 

  [[6]; [5; 1]; [4; 2]; [4; 1; 1]; [3; 3]; [3; 2; 1]; [3; 1; 1; 1]; [2; 2; 2];
  [2; 2; 1; 1]; [2; 1; 1; 1; 1]; [1; 1; 1; 1; 1; 1]]  

  It works!
 *) 

(* using the built-in function "length" that returns the length of 
   a list, we can count the number of partitions and compute a 
   famous number-theoretic function 
   http://oeis.org/A000041
*) 
let num_partitions n = List.length (partitions n);; 

(* let's check if we get some of the same value as on
   http://oeis.org/A000041/list 

> num_partitions 25;;
- : int = 1958
> num_partitions 40;;
- : int = 37338
> num_partitions 49;
- : int = 173525

Yes! All good! 

Play with this! How large can you make n and still get a result? 
On my laptop I get this: 

num_partitions 65;;
- : int = 2012558

num_partitions 66;;
Stack overflow during evaluation (looping recursion?).

*) 


(* Time for YOUR CODE! 

   I want you to write several functions that list integer partitions having 
   particular properties.  Each of your functions will probably have the shape 

   let your_function n = ... (partitions n) .... 

   That is, your functions will first compute "partitions n" and then 
   process the resulting list of lists.  In other words, I don't want you 
   to modify the change function! 

   Here are the functions I would like you to write : 

   1) List all integer partitions of n containing only odd integers. 
   2) List all integer partitions of n containing distinct integers (no duplicates). 
   3) List all integer partitions of n containing only duplicate integers
     (for n = 6 this would be [[6]; [3; 3]; [2; 2; 2]; [1; 1; 1; 1; 1; 1]). 
      Note that these represent the integers that divide n. 
*) 

(*
This function is used in solution 1.
It accepts a list of ints and returns true if and only if they are all odd, and false otherwise.
Works by iterating over each element, returning false if the current one is odd, and returning true if the end of the list is reached without any falses being returned
*)
let all_odd elts =
   let rec aux k =
      if k = (List.length elts) then true
      else if (List.nth elts k) mod 2 = 1 then aux (k+1)
      else false
   in aux 0;;

(*
This function is used in solution 2.
It accepts a list of ints and returns true if and only if they are all distinct, and false otherwise.
n^2 (because it's tail-recursive) time complexity isn't ideal but what can you do.
Works by iterating over each element excluding the first. For each one, iterate over all the elements before it. Within this inner loop, check if the current element is the same as that of the outer loop (a duplicate), and so return false.
If the inner loop finishes without false being returned, it should return true, meaning that the current element in the outer loop has no duplicates before it.
Otherwise, if the inner loop returned false, the outer loop should do likewise as there is at least one duplicate.
If the outer loop completes without false being returned, there are no duplicates, so return true.
*)
let distinct_integers elts =
   let rec outer i =
      let rec inner j =
         if i = j then true
         else if (List.nth elts i) = (List.nth elts j) then false
         else inner (j + 1)
      in if i = (List.length elts) then true
      else if inner 0 then outer (i+1)
      else false
   in outer 1;;

(*
This function is used in solution 3.
It accepts a list of ints and returns true if and only if they are all the same.
Works by iterating over each element excluding the first. For each one, check if it is equal to the first element. If not, return false.
If the loop completes without false having been returned, return true.
*)
let only_duplicates elts =
   let rec aux k =
      if k = (List.length elts) then true
      else if (List.nth elts k) = (List.nth elts 0) then aux (k+1)
      else false
   in aux 1;;


(*
This function is used in all solutions.
It accepts a list of lists, and a boolean-valued function which itself accepts a list.
It returns the subset of the input list for which all the elements, when passed as inputs to the checker function, return true.
I like to think of this function as filtering out the elements which don't meet a given condition. All three problems can be phrased in such a manner.
*)
let filter list check =
   let rec eval parts valid k =
      if check (List.nth parts k) then
         if k < (List.length list) - 1 then
            eval parts ((List.nth parts k) :: valid) (k+1)
         else (List.nth parts k) :: valid
      else
         if k < (List.length list) -1 then
            eval parts valid (k+1)
         else
            valid
   in eval list [] 0;;

let solution1 n = filter (partitions n) all_odd;;
let solution2 n = filter (partitions n) distinct_integers;;
let solution3 n = filter (partitions n) only_duplicates;;

(* After you write your code, play with it.  Do you notice any
   interesting relationship between your answers from (1) and (2)?  
   Hint: count how many partitions there are. 
   Gosh, what is going on here?
*) 
  
