# Supervision 5

## Question 1

| Iteration | Path                | &delta; |
|-----------|---------------------|---------|
| 0         | s &rarr; a &rarr; t | 1000    |
| 1         | s &rarr; b &rarr; t | 1000    |

2 iterations. Flow = 2000

Worst case:
| Iteration | Path | &delta; |
|----|---|---|
| 0 | s &rarr; a &rarr; b &rarr; t | 1 |
| 1 | s &rarr; b &rarr; a &rarr; t | 1 |
| 2 | s &rarr; a &rarr; b &rarr; t | 1 |
| 3 | s &rarr; b &rarr; a &rarr; t | 1 |
| 4 | s &rarr; a &rarr; b &rarr; t | 1 |
| 5 | s &rarr; b &rarr; a &rarr; t | 1 |
| &vellip; | &vellip; | &vellip; |
|1999 | s &rarr; b &rarr; a &rarr; t | 1 |

The flow starts at 0. Each iteration increases the flow by 1. The algorithm is guaranteed to eventually reach the maximum flow. The maximum flow is 2000. Therefore there are 2000 iterations.

## Question 2

For a given vertex v, 
![](https://latex.codecogs.com/svg.latex?%5Csum_%7Bw%7Df%28v%5Crightarrow%20w%29%20-%5Csum_%7Bu%7D%20f%28u%20%5Crightarrow%20v%29) is the net flow out of v (the sum of the outgoing minus the sum of the incoming).

Since by definition s is the only source and t is the only sink, for all other vertices v, the net flow out of v must be zero.

Therefore the sum of the net flows out of all such vertices v is also 0.

![](https://latex.codecogs.com/gif.latex?%5Ctextrm%7Bvalue%7D%28f%29%20%5C%5C%20%3D%20%5Csum_%7Bw%7Df%28s%5Crightarrow%20w%29%20-%5Csum_%7Bu%7D%20f%28u%20%5Crightarrow%20s%29%20%5C%5C%20%3D%20%5Cleft%20%28%20%5Csum_%7Bw%7Df%28s%5Crightarrow%20w%29%20-%5Csum_%7Bu%7D%20f%28u%20%5Crightarrow%20s%29%20%5Cright%20%29%20&plus;%20%5Cleft%20%28%20%5Csum_%7Bv%5Cneq%20s%2Ct%7D%20%5Cleft%20%28%5Csum_%7Bw%7Df%28v%5Crightarrow%20w%29%20-%5Csum_%7Bu%7D%20f%28u%20%5Crightarrow%20v%29%20%5Cright%20%29%5Cright%20%29%20%5C%5C%20%3D%20%5Csum_%7Bv%5Cneq%20t%7D%20%5Cleft%20%28%5Csum_%7Bw%7Df%28v%5Crightarrow%20w%29%20-%5Csum_%7Bu%7D%20f%28u%20%5Crightarrow%20v%29%20%5Cright%20%29%20%5C%5C%20%3D%20%5Cleft%20%28%5Csum_%7Bv%7D%20%5Cleft%20%28%5Csum_%7Bw%7Df%28v%5Crightarrow%20w%29%20-%5Csum_%7Bu%7D%20f%28u%20%5Crightarrow%20v%29%20%5Cright%20%29%20%5Cright%20%29%20-%20%5Cleft%20%28%5Csum_%7Bw%7Df%28t%5Crightarrow%20w%29%20-%5Csum_%7Bu%7D%20f%28u%20%5Crightarrow%20t%29%20%5Cright%20%29%20%5C%5C%20%3D%20%5Csum_%7Bu%7D%20f%28u%20%5Crightarrow%20t%29%20-%20%5Csum_%7Bw%7Df%28t%5Crightarrow%20w%29)

## Question 3

It should assume that the augmenting path is acyclic. For example:

![](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Algorithms/Supervision%205/imgs/3.svg)

Since the residual graph is