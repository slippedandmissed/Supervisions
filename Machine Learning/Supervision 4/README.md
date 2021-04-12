# Supervision 4

## Graph algorithms

Let A be an arbitrary node in the graph. Peform a breadth-first search from A. Let B be a furthest node from A. Perform another breadth-first search from B. The maximum distance from B to any node is the diameter of the graph.

![](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Machine%20Learning/Supervision%204/imgs/1.svg)

In the above graph, the diameter is calculated to be 2 when in fact it is 3.

## Betweenness centrality and Newman-Girvan method examples

### 1

| Node | Centrality |
|------|------------|
| 1    | 1.0        |
| 2    | 1.0        |
| 3    | 1.0        |
| 4    | 1.0        |
| 5    | 1.0        |

| Edge  | Centrality |
|-------|------------|
| (1,2) | 3.0        |
| (2,3) | 3.0        |
| (3,4) | 3.0        |
| (4,5) | 3.0        |
| (1,5) | 3.0        |

![](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Machine%20Learning/Supervision%204/imgs/g1.svg)

### 2

| Node | Centrality |
|------|------------|
| 1    | 6.0        |
| 2    | 0.0        |
| 3    | 0.0        |
| 4    | 0.0        |
| 5    | 0.0        |

| Edge  | Centrality |
|-------|------------|
| (1,2) | 4.0        |
| (1,3) | 4.0        |
| (1,4) | 4.0        |
| (1,5) | 4.0        |

![](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Machine%20Learning/Supervision%204/imgs/g2.svg)

### 3

| Node | Centrality |
|------|------------|
| 1    | 5.0        |
| 2    | 0.0        |
| 3    | 0.0        |
| 4    | 0.0        |
| 5    | 0.0        |

| Edge  | Centrality |
|-------|------------|
| (1,2) | 3.0        |
| (1,3) | 3.0        |
| (1,4) | 4.0        |
| (1,5) | 4.0        |
| (2,3) | 1.0        |


![](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Machine%20Learning/Supervision%204/imgs/g3.svg)


### 4

| Node | Centrality |
|------|------------|
| 1    | 0.0        |
| 2    | 3.0        |
| 3    | 0.0        |
| 4    | 3.0        |
| 5    | 0.0        |

| Edge  | Centrality |
|-------|------------|
| (1,2) | 4.0        |
| (2,3) | 2.0        |
| (2,4) | 4.0        |
| (3,4) | 2.0        |
| (4,5) | 4.0        |


![](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Machine%20Learning/Supervision%204/imgs/g4.svg)

### 5

| Node | Centrality |
|------|------------|
| 1    | 0.0        |
| 2    | 3.0        |
| 3    | 4.0        |
| 4    | 0.0        |
| 5    | 0.0        |

| Edge  | Centrality |
|-------|------------|
| (1,2) | 4.0        |
| (2,3) | 6.0        |
| (3,4) | 3.0        |
| (4,5) | 1.0        |
| (3,5) | 3.0        |


![](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Machine%20Learning/Supervision%204/imgs/g5.svg)

### 6

| Node | Centrality |
|------|------------|
| 1    | 0.0        |
| 2    | 5.0        |
| 3    | 0.0        |
| 4    | 0.0        |
| 5    | 0.0        |

| Edge  | Centrality |
|-------|------------|
| (1,2) | 4.0        |
| (2,3) | 3.0        |
| (3,4) | 1.0        |
| (2,4) | 3.0        |
| (2,5) | 4.0        |


![](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Machine%20Learning/Supervision%204/imgs/g6.svg)

### 7

| Node | Centrality |
|------|------------|
| 1    | 3.0        |
| 2    | 1.0        |
| 3    | 0.0        |
| 4    | 1.0        |
| 5    | 0.0        |

| Edge  | Centrality |
|-------|------------|
| (1,2) | 3.0        |
| (2,3) | 2.0        |
| (2,4) | 1.0        |
| (3,4) | 2.0        |
| (1,4) | 3.0        |
| (1,5) | 4.0        |


![](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Machine%20Learning/Supervision%204/imgs/g7.svg)

## Random graphs and metrics

### Erdős–Rényi

The degree of the nodes is going to be binomally distributed.

Most of the nodes will probably be connected assuming p and n are both large enough.

The lengths of the shortest paths will be binomially disributed

There will be little clustering

### Watts-Strogatz model

For a given node, its degree will vary from k to a a uniformly random integer as p varies from 0 to 1.

Most of the nodes will be connected.

There will probably be a high degree of clustering

## Collaboration network

The degrees of nodes will probably be distributed normally

Most of the components will be connected

The shortest paths will also be distributed normally

There will be a high degree of clustering