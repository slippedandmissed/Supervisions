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
The below code is also available at https://github.com/slippedandmissed/Supervisions/blob/master/Algorithms/Supervision%202/code/expression.py
```python
#!/usr/bin/python3.9

# This script has completely customiseable operators and order of operations

import re

notOperator = "[^^\\*\\/\\+-]" # Regex matching all characters which are not operators

orderOfOperations = [
    {"regex": re.compile("(\\()([^\\(\\)]*)\\)"), "opGroup": 0},                        # Brackets
    {"regex": re.compile(f"({notOperator}*)(\\^)({notOperator}*)"), "opGroup": 1},      # Exponentiation
    {"regex": re.compile(f"({notOperator}*)([\\*\\/])({notOperator}*)"), "opGroup": 1}, # Multiplication and division
    {"regex": re.compile(f"({notOperator}*)([\\+-])({notOperator}*)"), "opGroup": 1}    # Addition and subtraction
]

operatorInfo = {
    "(": {"information": False, "template": "({})", "importance": 0, "operands": 1}, # Here "information": False means that Expression('(', inner) is essentially the same as inner.
    "^": {"information": True, "template": "{}^{}", "importance": 1, "operands": 2}, # "importance" reflects order of operations
    "*": {"information": True, "template": "{}*{}", "importance": 2, "operands": 2},
    "/": {"information": True, "template": "{}/{}", "importance": 2, "operands": 2},
    "+": {"information": True, "template": "{}+{}", "importance": 3, "operands": 2},
    "-": {"information": True, "template": "{}-{}", "importance": 3, "operands": 2}
}

class Expression:
    def __init__(self, operator, *operands):
        self.operator = operator
        self.operands = operands

    def __repr__(self):
        return self.toInfix()

    # Factory method for constructing an expression from an infix string
    def fromInfix(infix, inner=None, escape=True):
        if inner is None:
            inner = []
        if escape:
            infix = infix.replace(" ", "").replace("&", "&amp;")

        foundAny = False
        for layer in orderOfOperations:
            match = 0
            while match is not None:
                match = layer["regex"].search(infix)
                if match is not None:
                    foundAny = True
                    groups = match.groups()
                    operands = []
                    operator = groups[layer["opGroup"]]
                    for i, g in enumerate(groups):
                        if i != layer["opGroup"]:
                            operands.append(Expression.fromInfix(g, inner, False))
                    infix = infix[:match.start()] + f"&{len(inner)};" + infix[match.end():]
                    if operatorInfo[operator]["information"]:
                        inner.append(Expression(operator, *operands))
                    else:
                        inner.append(operands[0])

        for i, k in enumerate(inner):
            if infix == f"&{i};":
                return k

        return infix.replace("&amp;", "&")

    # Returns an infix string from an expression
    def toInfix(self):
        children = []
        for i in self.operands:
            if type(i) == Expression:
                # Change comparison to >= if you want to make the assumption that operators of the same importance are associative
                tmplt = "({})" if operatorInfo[i.operator]["importance"] > operatorInfo[self.operator]["importance"] else "{}"
                children.append(tmplt.format(i.toInfix()))
            else:
                children.append(str(i))
        return operatorInfo[self.operator]["template"].format(*children)

    # Factory method for constructing an expression from an RPN string
    def fromRPN(rpn):
        stack = []
        tokens = [x for x in rpn.split(" ") if x != ""]
        for token in tokens:
            if token in operatorInfo and (info:=operatorInfo[token])["information"]:
                expr = Expression(token, *stack[-(opCount:=info["operands"]):])
                stack = stack[:-opCount]
                stack.append(expr)
            else:
                stack.append(token)
        return stack[0]

    # Returns an RPN string from an expression
    def toRPN(self):
        value = ""
        for i in self.operands:
            if type(i) == Expression:
                value += i.toRPN()+" "
            else:
                value += str(i)+" "
        return value+self.operator
            
print(Expression.fromInfix("(3+12)*4-2").toRPN())
# 3 12 + 4 * 2 -

print(Expression.fromRPN("3 12 + 4 * 2 -").toInfix())
# (3+12)*4-2
```

It is far easier to convert from postfix to infix than from infix to postfix.

## Exercise 