# Supervision 6

## Question 1
Any N items in reverse order (i.e. ascending order for a max-heap or descending order for a min-heap)

## Question 2
i.
```python
def inc():
    def aux(index):
        if index >= A.length:
            return
        A[index] ^= 1 # The bit is xor'ed with 1
        aux(index + 1)
    
    aux(0)
```

ii.

In the worst case (all 1s) then all k bits have to be flipped

iii.
    
Bit 0 gets flipped m times. Bit 1 gets flipped m/2 times. In general bit j gets flipped m/(2<sup>j</sup>) times.

Therefore the total number of flips is

&Sigma;<sub>j=0</sub><sup>k-1</sup> m/(2<sup>j</sup>)
= m &times; (1 - 1/2<sup>k</sup>)/(1 - 1/2)
= m (2 - 1/2<sup>k-1</sup>)

Which is O(m(1/2)<sup>k</sup>)

## Question 3

Assume the stack uses a doubly linked list with a pointer to the last element.

### Push
c = 1
c' = c + &Delta;&Phi; = 1 + (n+1) - (n) = 1 = O(1)

### Pop
c = 1
c' = c + &Delta;&Phi; = 1 + (n-1) - (n) = 0 = O(1)

### Flush
c = n
c' = c + &Delta;&Phi; = n + (0) - (n) = 0 = O(1)

## Question 4

// TODO

## Question 5

If c = O(n) and &Delta;&Phi; = O(n) then their difference c' could be O(1)

This can be written informally as O(n) - O(n) = O(1)

## Question 6

Amortized analysis assumes that the data structure starts empty

## Question 7

i.

&Phi; = 2n - l except &Phi;(empty) = 0

In the case where we don't need to expand, c=O(1), &Delta;&Phi;=2 and so c' = O(1).

In the case where we do need to expand, c=O(n), &Delta;&Phi; = 2-k and so c'=O(n).

Therefore n append operations if O(n<sup>2</sup>)

ii.

The aggregate cost of n append operations is clearly O(n<sup>2</sup>/k) (since it is O(n<sup>2</sup>) for one k<sup>th</sup> of the operations and O(1) for the rest) and so this is a lower bound on amortised costs regardless of potential function.

iii.

// TODO

## Question 8

// TODO

## Question 9

// TODO

## Question 10

// TODO

## Question 11



## Question 12

## Question 13

## Question 14

