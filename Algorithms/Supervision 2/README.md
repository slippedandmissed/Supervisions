# Supervision 2

## Exercise 24

```python
cache = {}
def fibonacci(n):
    if n not in cache:
        cache[n] = 1 if n <= 1 else (fibonacci(n-1) + fibonacci(n-2))
    return cache[n]
```

(or I prefer)
```python
import json

def memoize(func):
    cache = {}
    def helper(*args, **kwargs):
        key = json.dumps([args, kwargs])
        if key not in cache:
            cache[key] = func(*args, **kwargs)
        return cache[key]
    return helper

@memoize
def fibonacci(n):
    return 1 if n <= 1 else (fibonacci(n-1) + fibonacci(n-2))
```

(or non-memoized version)
```python
def fibonacci(n):
    return 1 if n <= 1 else (fibonacci(n-1) + fibonacci(n-2))
```

|  n | Predicted # function calls in memoized version | Actual # function calls in memoized version | Predicted # function calls in non-memoized version | Actual # function calls in non-memoized version |
|:--:|:----------------------------------------------:|:-------------------------------------------:|:--------------------------------------------------:|:-----------------------------------------------:|
| 10 |                       10                       |                      11                     |                        2<sup>10</sup>                        |                       177                       |
| 20 |                       20                       |                      21                     |                        2<sup>20</sup>                        |                      21891                      |
| 30 |                       30                       |                      31                     |                        2<sup>30</sup>                        |                     2692537                     |

## Exercise 25
Let `A` be an `w`&times;`x` matrix

Let `B` be an `x`&times;`y` matrix

Let `C` be an `y`&times;`z` matrix

|               Product              | Number of multiplications |
|:----------------------------------:|:-------------------------:|
|           `A` &times; `B`          |           `wxy`           |
|          `B`  &times;  `C`         |           `xyz`           |
|   `A`  &times;  (`B` &times; `C`)  |      `xyz` + `wx`<sup>`2`</sup>`z`      |
| (`A`  &times;  `B` )  &times;  `C` | `wxy` + `wy`<sup>`2`</sup>`z`           |

## Exercise 26
In the above algorithm, this case would be represented by the case in which both arguments to the `max` function are equal.

We could generate them all by modifying the algorithm as follows:
![](https://latex.codecogs.com/gif.latex?%5Ctextrm%7Blcs%7D(i%2Cj)%26space%3B%3D%26space%3B%5Cleft%5C%7B%5Cbegin%7Bmatrix%7D%26space%3B%5B%5C%3B%5D%26space%3B%26%26space%3B%5Ctextrm%7Bif%7D%5C%3B%26space%3Bi%3D0%26space%3B%5C%3B%5Ctextrm%7Bor%7D%5C%3B%26space%3Bj%3D0%26space%3B%5C%5C%26space%3B%5B%5C%3Bs%26plus%3Bx_i%5C%3B%5Ctextrm%7Bfor%7D%5C%3Bs%5C%3B%5Ctextrm%7Bin%26space%3Blcs%7D(i-1%2Cj-1)%26space%3B%5C%3B%26space%3B%5D%26space%3B%26%26space%3B%5Ctextrm%7Bif%7D%5C%3B%26space%3Bx_i%3Dy_j%5C%5C%26space%3B%5Ctextrm%7Blcs%7D(i-i%2Cj)%26space%3B%26%26space%3B%5Ctextrm%7Bif%26space%3Blen%7D(%5Ctextrm%7Blcs%7D(i-1%2Cj)%5B0%5D)%3E%5Ctextrm%7Blen%7D(%5Ctextrm%7Blcs%7D(i%2Cj-1)%5B0%5D)%26space%3B%5C%5C%26space%3B%5Ctextrm%7Blcs%7D(i%2Cj-1)%26space%3B%26%26space%3B%5Ctextrm%7Bif%26space%3Blen%7D(%5Ctextrm%7Blcs%7D(i-1%2Cj)%5B0%5D)%3C%5Ctextrm%7Blen%7D(%5Ctextrm%7Blcs%7D(i%2Cj-1)%5B0%5D)%26space%3B%5C%5C%26space%3B%5Ctextrm%7Blcs%7D(i-1%2Cj)%26plus%3B%5Ctextrm%7Blcs(i%2Cj-1)%7D%26space%3B%26%26space%3B%5Ctextrm%7Botherwise%7D%26space%3B%5Cend%7Bmatrix%7D%5Cright.)

## Exercise 27
If the backpack has a capacity of 100kg:
| Mass/kg | Price/£ | Price/Mass / (£/kg) |
|:-------:|:-------:|:-------------------:|
|    50   |    50   |          1          |
|    50   |    50   |          1          |
|    51   |    99   |         1.94        |

The optimal solution consists of the first two blocks, but the greedy algorithm would suggest choosing the third block.

## Exercise 28
![](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Algorithms/Supervision%202/imgs/27.png)

## Exercise 29
```c
struct ListWagon list;
```

```java
ListWagon list = new ListWagon();

// Empty list
ListWagon list = null;
```

## Exercise 30
The fact that the empty list has to have a value of null means that the class can't have an `isEmpty` method, because this would always raise a `NullPointerException` when run on an empty list, and return `true` otherwise. Similarly, there could not be an `append` method which might add an element to the end of the list, because again this would raise a `NullPointerException` when it is run on an empty list.

## Exercise 31
![](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Algorithms/Supervision%202/imgs/31.png)


## Exercise 32
The code for converting between infix and postfix is available at https://github.com/slippedandmissed/Supervisions/blob/master/Algorithms/Supervision%202/code/expression.py

It is far easier to convert from postfix to infix than from infix to postfix.

## Exercise 33
Assuming that the number of keys is far fewer than the total number of English words, I would use the natural ordering of strings such that the dictionary is a binary tree. Each node has a key-value pair and the left child is composed of a sub-tree all of whose keys are less than the current node's, and the right child composed of those greater.

If the keys were likely to be very long (e.g. if they were German words) then I would use the natural ordering of the hashes of the string (e.g. MD5) to the same effect, but most English words are in fact shorter than their hashes under most hashing schemes.

Either of these techniques would allow `log(n)` complexity for both `get()` and `set()`

## Exercise 34
If the list is a LinkedList, the new key-value pair should be added at the position which the natural ordering of the keys dictates. If you assume that the list was sorted by key initially (which, if this technique is always used, it would be), then the list will remain sorted after the `set()`. As such, `get()` can use a binary search to reduce its time complexity from `n` to `log(n)`.

If the keys have no natural ordering, then it does not matter where the new pair is inserted.

## Exercise 35
![](https://latex.codecogs.com/gif.latex?%5Ctextrm%7BLet%26space%3B%7Dn%3D2%5Em%26space%3B%5C%5C%26space%3B%5Cbegin%7Balign*%7D%26space%3Bf(2%5Em)%26space%3B%26%3D%26space%3Bf(2%5E%7Bm-1%7D)%26space%3B%26plus%3B%26space%3Bk%26space%3B%5C%5C%26space%3B%26%3D%26space%3Bf(2%5E%7Bm-2%7D)%26space%3B%26plus%3B%26space%3B2k%26space%3B%5C%5C%26space%3B%26%26space%3B%5Cvdots%26space%3B%5C%5C%26space%3B%26%3D%26space%3Bf(2%5E%7Bm-i%7D)%26space%3B%26plus%3B%26space%3Bik%26space%3B%5C%5C%26space%3B%26%26space%3B%5Cvdots%26space%3B%5C%5C%26space%3B%26%3D%26space%3Bf(2%5E0)%26space%3B%26plus%3B%26space%3Bmk%26space%3B%5C%5C%26space%3B%5Cend%7Balign*%7D%26space%3B%5C%5C%26space%3B%5Ctherefore%26space%3Bf(n)%26space%3B%3D%26space%3Bf(1)%26space%3B%26plus%3B%26space%3Bk%5Clog_2(n))