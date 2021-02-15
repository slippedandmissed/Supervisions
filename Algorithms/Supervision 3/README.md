# Supervision 3

## Exercise 36

![Graph](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Algorithms/Supervision%203/imgs/36.svg)

```
k = 2

a = 0
b = 5
c = 4
```

##  Exercise 37

If no right subtree exists, it means that the current node is in the right-most part of the larger left subtree of some ancestor node. As such, the successor will be the smallest element of the right subtree of the smallest such ancestor node.

Travelling up the tree gives ancestor nodes, and if you go up-and-right, it means that the current node is in the left subtree of the ancestor node. The first occurance of this gives the smallest such ancestor.

The successor can then be found by travelling into the right subtree of the anestor node (containing all of the nodes greater than the current one) and then going down-and-left as many times as possible (yielding the smallest node which is greater than the current on &ndash; the successor)

![Graph](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Algorithms/Supervision%203/imgs/37.svg)

## Exercise 38

If a node `n` has two children, then its right subtree contains the successor of `n`. Furthermore, all elements of its right subtree are greater than `n`.

Assume that the sucessor of `n`, `p`, has a left child, `o`. It follows that `o<p` and `o>n`, and so `o` falls between `n` and its successor, which is a contradiction.

Therefore `p` has no left child.

## Exercise 39

Lemma:

    A binary tree is a valid BST iff an in-order DFS traversal of its nodes yields the keys in their natural order.

Suppose an arbitrary BST with keys `a`, `b`, `c`, `d`, &hellip;
where `a<b<c<d<`&hellip; such that the in-order DFS traversal of the keys is

    a, b, c, d, …

Without loss of generality, suppose we want to remove key `b`. First, replace it with its successor, `c`. Now, the in-order DFS traversal of the keys os

    a, c, b, d, …

Now, removing the key `b` results in a tree whose in-order DFS traversal is

    a, c, d, …

Which is a sorted list. By the lemma, the tree must therefore be a valid BST

## Exercise 40

Min:

![](https://latex.codecogs.com/gif.latex?2^{\left&space;\lceil&space;\frac{h}{2}&space;\right&space;\rceil&space;&plus;&space;2}&space;-&space;3&space;-&space;2&space;(h&space;\mod{2}))

Max:

![](https://latex.codecogs.com/gif.latex?2^{h+1}-1)

## Exercise 41

![Graph](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Algorithms/Supervision%203/imgs/41.svg)

## Exercise 42

If `p` has a black child and `u` does not, then the total number of black nodes in a given path is still invariant

## Exercise 44

![Graph](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Algorithms/Supervision%203/imgs/44.svg)

## Exercise 45

    How many times did you insert into a node that still had room?

14

    How many node splits did you perform?

6

    What is the depth of the final tree?

3

    What is the ratio of free space to total space?

1/3

![Graph](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Algorithms/Supervision%203/imgs/45.svg)

## Exercise 46

If a key is not in a bottom node, it must have a subtree to its immediate right. This subtree contains its successor, and each key in this subtree is greater than it.

It therefore follows that the successor is the smallest key in that subtree, and can thus be reached by following the left-most branch until a leaf is reached.

Since all paths are the same length, all leaves are bottom nodes.

Therefore the successor is a bottom node.

## Exercise 47

![Graph](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Algorithms/Supervision%203/imgs/47.svg)

## Exercise 48

Each non-empty location in the table could contain a key-value pair, rather than just the value. Then, when looking up a key, you could compare the key with the key stored at the location. If they match, you have found the right value. Otherwise, perform the same procedure as insertion until the location with the matching key is found.

## Exercise 49

When deleting a value at a location, instead of marking the location as empty, mark it as `deleted`. Then, in insertion you can treat it as empty, but in searches you can treat it as non-empty.

This solves the problem of searching for a key which has been placed after a deleted key. If deleted cells are just made empty, this result is hard to distinguish from the key simply not being in the table.

## Exercise 50

Bubble sort has quadratic cost when it takes up to `n` passes through the array to sort it. However, we can guarantee here that it will only take a constant number of passes through the array to sort it, and so the cost is linear.

## Exercise 51

Construct a heap using all of the elements from both heaps. This has complexity `n log(n)`.

## Exercise 52

![Graph](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Algorithms/Supervision%203/imgs/52.svg)


## Exercise 54

Since a binomial tree of order 0 has 2^0=1 nodes and a binomial tree of order (k+1) has twice the number of nodes of a binomial tree of order k, a binomial tree of order n contains 2^n nodes.

Binary positional notation tells you which powers of 2 you need to sum in order to get a particular number. As such, it tells you which degrees of binary tree to use in order to have that number of total nodes.