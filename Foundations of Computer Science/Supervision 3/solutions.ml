(* Given Code *)
type 'a stream = StreamCons of 'a * (unit -> 'a stream);;
let stream_head (StreamCons(x, _))  = x;;
let stream_tail (StreamCons(_, xf)) = xf();;
let rec stream_filter f (StreamCons(x, xf)) = 
  if f x
  then StreamCons(x, fun () -> stream_filter f (xf()))
  else stream_filter f (xf());;
let rec stream_from k = StreamCons(k, fun () -> stream_from(k+1));;
let rec stream_get (n, StreamCons(x, xf)) = if n = 0 then [] else x :: stream_get (n-1, xf());;

(* My Code *)
let rec stream_map f (StreamCons(x, xf)) = StreamCons(f x, fun () -> stream_map f (xf()));;
let rec stream_interleave (StreamCons(x,xf), yq) = StreamCons(x, fun () -> stream_interleave (yq,(xf())));; 

let rec zip_streams f (StreamCons(x,xs)) (StreamCons(y,ys)) = StreamCons(f (x,y), fun () -> zip_streams f (xs ()) (ys ()));;

let rec eliminate_multiples n (StreamCons(x,xs)) =
    if (x mod n) = 0 then eliminate_multiples n (xs ())
    else StreamCons(x, fun () -> eliminate_multiples n (xs ()));;
let rec sieve (StreamCons(h, rest)) = StreamCons(h, fun () -> sieve (eliminate_multiples h (rest ())));;

(* Given Code *)
type 'a fltree = FLBr of 'a * (unit -> 'a fltree) * (unit -> 'a fltree);; 
let fltree_of_all_ints = 
    let rec aux k = FLBr(k, (fun () -> aux((2*k)+1)), (fun() -> aux((2*k)+2)))
    in aux 0 ;; 

(* My Code *)
let rec fltree_flatten (FLBr(x,tf1,tf2)) =  StreamCons(x, fun () -> stream_interleave (fltree_flatten (tf1()), fltree_flatten (tf2())));; 

let rec listify (FLBr(a, l, r)) = FLBr([a], (fun () -> listify (l())), (fun () -> listify (r())))
let rec fltree_merge (FLBr(x, xl, xr)) (FLBr(y, yl, yr)) = FLBr(x@y, (fun () -> fltree_merge (xl()) (xr())), (fun () -> fltree_merge (yl()) (yr())));;
let breadth_first (FLBr(a, left, right)) =
    let rec aux left right =
        match fltree_merge left right with
        | FLBr(x, l, r) -> StreamCons(x, fun () -> aux (l()) (r()))
    in StreamCons([a], (fun() -> aux (listify (left())) (listify (right()))));;


let result = breadth_first fltree_of_all_ints;;
stream_get (10, result);;