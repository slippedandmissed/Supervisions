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

## Exercise 41 again

![Graph](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Algorithms/Supervision%203/imgs/41-2.svg)

## Exercise 42

