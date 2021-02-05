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
