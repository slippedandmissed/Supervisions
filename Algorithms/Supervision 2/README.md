# Supervision 1

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