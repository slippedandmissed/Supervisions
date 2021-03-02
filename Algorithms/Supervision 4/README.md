# Supervision 4

## Question 1

i.
    ![](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Algorithms/Supervision%204/imgs/1.svg)

ii.
    This cannot exist because the longest acyclic path which can exist in an undirected graph is n-1 where n is the number of vertices. Any more than this and at least one node is guaranteed to be revisted by the pigeonhole principle, resulting in a cycle.

iii.
    ![](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Algorithms/Supervision%204/imgs/1.svg)

## Question 2

```python

def dfs_recurse_path(g, s, t):
    for v in g.vertices:
        v.visited = False
    return visit_path(s, t, [])

def visit_path(v, t, path):
    v.visited = True
    if v == t:
        return path+[t]
    for w in v.neighbours:
        if not w.visited:
            x = visit(w, t, path+[v])
            if x is not None:
                return x
    
    return None
```

## Question 3

It already has this property

## Question 4

![](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Algorithms/Supervision%204/imgs/4.svg)

In `dfs_recurse` the nodes are visited in the order 1, 2, 3. In `dfs` they are visited in the order 1, 3, 2.

```python
def dfs(g, s):
    for v in g.vertices:
        v.seen = False
    toexplore = Stack([s])
    s.seen = True

    while not toexplore.is_empty():
        v = toexplore.popright()
        # Reverse the neighbours list so that the first neighbour is the last one to be pushed on to the stack, so the neighbours are popped in their natural order as in dfs_recurse
        for w in v.neighbours.reverse():
            if not w.seen:
                toexplore.pushright(w)
                w.seen = True
```

## Question 5

```python
def calculate_m(g):
    for v in g.vertices:
        v.m = v.x
        v.visited = False

    sorted_vertices = sort(vertices) # O(V log V), e.g. heap sort, in ascending order of v.m

    for e in g.edges:
        # e: (e.u -> e.v)
        e.reverse_direction()
    
    for v in sorted_vertices:
        if not v.visited:
            dfs_propagate_m(g, v)

def dfs_propagate_m(g, s):
    toexplore = Stack([s])

    s.visited = True

    while not toexplore.is_empty():
        v = toexplore.popright()
        for w in v.neighbours:
            if not w.visited:
                w.m = s.m
                w.visited = True
                toexplore.pushright(w)

```

## Question 6

```python
def bfs_path(g, s, t):
    for v in g.vertices:
        v.seen = False
        v.come_from = []
    s.seen = True
    toexplore = Queue([s])

    while not toexplore.is_empty():
        v = toexplore.popleft()
        for w in v.neighbours:
            if w.seen:
                w.come_from.append(v)
            else:
                toexplore.pushright(w)
                w.seen = True
                w.come_from = [v]
    
    if len(t.come_from) == 0:
        return None
    else:
        return trace_path(s, t, {})

def trace_path(s, t, cache):
    if t == s:
        cache[t] = [[t]]
    else:
        paths = []
        for origin in t.come_from:
            for path in trace_path(s, origin, cache):
                paths.append(path+[t])
        cache[t] = paths
    return cache[t]
```

## Question 7

toexplore could use at worst &Omega;(V) if every vertex was stored in there at the same time (e.g. if the start vertex is adjacent to all of the others)

```python
def bfs_path(g, s, t):
    for v in g.vertices:
        v.seen = False
        v.come_from = None
        v.to_explore = -1
    
    s.seen = True
    s.to_explore = 0
    to_explore_counter = 0

    v = s
    while v is not None:
        for w in v.neighbours:
            if not w.seen:
                w.to_explore = to_explore_counter + 1
                w.seen = True
                w.come_from = v
        
        to_explore_counter++
        v = None
        for w in g.vertices:
            if w.to_explore == to_explore_counter:
                v = w
                break
    
    if t.comes_from is None:
        return None
    else:
        path = [t]
        while path[0].come_from != s:
            path.prepend(path[0].come_from)
        path.prepend(s)
        return path
```

## Question 8

Proof by contradiction.

Assume d(u,v) > d(u,w) + c(w &rarr; v)

Consider a path of minimum weight from u to w. This path, by definition, has weight d(u,w).

Following this path with the edge w &rarr; v gives a path from u to v whose weight is d(u,w) + c(w &rarr; v) which is stricly less than d(u,v).

Therefore there exists a path from u to v whose weight is less than d(u,v).

This is a contradiction.

Therefore d(u,v) &leq; d(u,w) + c(w &rarr; v)

## Question 9

The assertion on line 9 is true for u<sub>i-1</sub> at the time, t', at which it was popped. The only possible place in which the computed `.distance` value could be modified after t' is on line 14. However, in the following lines, it is clear that either u<sub>i-1</sub> is still in `toexplore` or it is immediately put into `toexplore`. Since we know that u<sub>i-1</sub> has previously been popped from `toexplore` at t', both of these cases violate the assertion on line 10, and so line 14 must never be reached with `w` being u<sub>i-1</sub> after t'. Therefore its `.distance` value can never be modified after t'.

## Question 10

For all graphs satisfying the contraints given, Djikstra's algorithm runs in O(k log k + k<sup>&alpha;</sup>).
For &alpha;=1, the kth graph is a long chain of k nodes with the start node on one of the extreme ends. This guarantees that every node will end up in the priority queue at some point, and that every edge will have to be explored. This ensures the worst case runtime.

## Question 11

The following algorithm assumes an implementation of the priority queue for which has O(1) running time for all of `push()`, `decreasekey()` and `popmin()` and so an overall running time of O(V + E)

```python

def check_path_correctness(g, s):
    djikstra(g, s)
    for v in g.vertices:
        if v.distance != g.djikstra_distance:
            return False
    
        if not g.edge_exists(v.comes_from, v):
            return False
    
    return True

```

## Question 12

F<sub>ij</sub>(0) = i &rarr; j if i &rarr; j exists, or else `null`

F<sub>ij</sub>(k) = shortest(F<sub>ij</sub>(k-1), F<sub>ik</sub>(k-1)+F<sub>kj</sub>(k-1))

## Question 13

For the first graph, Djikstra's algorithm does terminate and does compute the correct minimum weights.

For the second graph, Djikstra's algorithm does not terminate as there is an infinite negative weight loop.

## Question 14

Counterexample:


In the below diagram suppose the edges are ordered (such that this is the order in which they are relaxed) in the following way:
 - v &rarr; u
 - q &rarr; u
 - p &rarr; q
 - s &rarr; v
 - s &rarr; p

![](https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Algorithms/Supervision%204/imgs/14.svg)

After the first round of relaxing, `v.minweight` is correct. After the second round of relaxing, `u.minweight` is still incorrect, despite the fact that u &isin; neighbours(v)
