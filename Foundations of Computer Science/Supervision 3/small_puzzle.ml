class helper =
    object
        val mutable x = (-1)
        method next () = x <- x+1; x
    end;;

let next = (new helper)#next;;