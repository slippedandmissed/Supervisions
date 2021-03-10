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

![](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Algorithms/Supervision%205/img/3.svg)

Since the residual graph is cyclic, a valid augmenting path is s &rarr; a &rarr; b &rarr; a &rarr; b  &rarr; t.

&delta; will be calculated as 1, but edges a &rarr; b and b &rarr; a will be augmented twice resulting in a flow of 2 each, which is greater than their capacities.

Under this new assumption, each edge u &rarr; v is augmented at most once in the loop on line 34.

If the edge has the label "inc", it must be because f(u &rarr; v) < c(u &rarr; v). Neither of those values could have been changed up to this point. &delta; must be less than or equal to c(u &rarr; v) - f(u &rarr; v) because of the operation on line 30. After that time, &delta; can never increase.

As such, increasing f(u &rarr; v) by &delta; still keeps f(u &rarr; v) &leq; c(u &rarr; v).

If the edge has the label "dec", it must be because f(v &rarr; u) > 0 and it could not have been changed up to this point. &delta; must be less than or equal to f(v &rarr; u) because of the operation on line 32. After that time, &delta; can never increase.

As such, decreasing f(v &rarr; u) by &delta; still keeps f(v &rarr; u) &geq; 0.

Therefore f is still a valid flow by the time line 39 is reached.

## Question 4

Replace each vertex v (excluding the source and the sink) with a pair of vertices v<sub>in</sub>, v<sub>out</sub>. All incoming flows to v now go into v<sub>in</sub> and all outgoing flows from v come from v<sub>out</sub>. In addition, create an edge v<sub>in</sub> &rarr; v<sub>out</sub> with capacity c<sub>V</sub>(v)

## Question 5

Consider a single source s with edges from s to each supply vertex v of capacity s<sub>v</sub>. This contstrains the max-flow to only those in which the supply vertices are not producing more than its maximum amount.

Consider also a single sink t with edges from each demand vertex v to t of capacity d<sub>v</sub>. This contraint makes it inefficient to have more than the demand flow into a demand vertex when it could go to a different demand vertex. (*)

The demand is meetable if there exists a max-flow of the resulting graph has a flow of at least d<sub>v</sub> from each demand vertex v to t. However (*) guarantees that if one such max-flow exists, every max-flow must also have this property, and so only one needs to be found.

## Question 7

My solution satisfied Comrade A because each demand vertex has a cap on how much it can send to the sink. I could satisfy Comrade B by making each of the demand vertices a sink. However this does not guarantee that all max-flows are a solution to the problem.

## Question 8

<b>Note:</b> The numbers along each edge in these diagrams represent the order in which they were added to the tree, not the weights.

### Kruskal's algorithm
![](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Algorithms/Supervision%205/img/8.1.svg)


### Prim's algorithm
![](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Algorithms/Supervision%205/img/8.1.svg)

## Question 9

i.
    Yes. The issue with adding some constant to each weight to make them all positive is that you penalise routes with more edges. However for a MST the number of edges is always one less than the number of nodes. This is to say that the total weight of the a spanning tree in the modified graph is k+EC where k is the weight of the equivalent spanning tree in the original graph and E is the number of edges. Since EC is constant, minimising k+EC also minimises k.

ii.
    It would nonetheless terminate giving you the correct answer. The issue of negative weight cycles (as with Djikstra) is avoided by the fact that vertices which are already in the tree are never pushed back into the tree. I.e. a spanning tree must be acyclical.

## Question 10

Proof by induction.

Base case: F contains 0 edges. Therefore F is trivially contained within an MST.

Suppose that F contains k edges and is contained within an MST. Prim's algorithm dictates that we add to F a min-weight edge that crosses C. Therefore by the theorem, F is still contained within an MST when it has k+1 edges.

Therefore for all F generated by Prim's algorithm, F is contained within an MST. Since we add one edge per iteration, after one fewer iterations than the number of vertices, Prim's algorithm will terminate with a forest F containing every vertex and which is contained by an MST. Therefore F is an MST.

## Question 11

Yes. The directed property is clearly preserved as the direction of each edge is simply reversed. No edge loses direction. The acyclic property is also preserved by the following reasoning:

A cycle is still a cycle when all of its edges are reversed. Therefore there are cycles in the reversed graph iff there are cycles in the original graph. There are no cycles in the original graph. Therefore there are no cycles in the reversed graph.

## Question 12

i.
    ![](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Algorithms/Supervision%205/img/12.1.png)

ii.
    ![](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Algorithms/Supervision%205/img/12.2.png)

## Question 13

```python
def isDAG(g):
    # Don't need to explicitly check whether it's directed because if it's undirected it's cyclical by definition.
    for v in g.vertices:
        # Can I do a depth-first-search from "a" and end up back at "a"?
        if has_cycle_through(g, a):
            return False
    return True

def has_cycle_through(g, a):
    for v in g.vertices:
        v.seen = False
    a.seen = True
    for i in a.neighbours:
        return visit_from(a, i)

def visit_from(a, i):
    for b in i.neighbours:
        if b == a:
            return True
        if not b.seen:
            b.seen = True
            if visit_from(a, b):
                return True
    return False
```