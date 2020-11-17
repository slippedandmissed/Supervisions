#!/usr/bin/python3.7

def memoize(func):
    cache = {}
    def aux(n):
        if n not in cache:
            cache[n] = func(n)
        return cache[n]
    return aux

def already_accounted_for(partition, results):
    for i in results:
        if len(i) == len(partition):
            for p in partition:
                if partition.count(p) != i.count(p):
                    break
            else:
                return True
    return False

@memoize
def partitions(n):
    if n == 0:
        return [[]]
    results = []
    for i in range(n, 0, -1):
        for x in partitions(n-i):
            partition = [i] + x
            if not already_accounted_for(partition, results):
                results.append(partition)
    return results

def shows_up_twice(haystack, needle):
    count = 0
    for i in haystack:
        if i == needle:
            count += 1
            if count > 1:
                return True
    return False

@memoize
def solution1(n):
    return list(x for x in partitions(n) if all(i%2==1 for i in x))

@memoize
def solution2(n):
    return list(x for x in partitions(n) if not any(shows_up_twice(x, i) for i in x))

@memoize
def solution3(n):
    return list(x for x in partitions(n) if all(i == x[0] for i in x))

for i in range(1, 100):
    print(f"{i}: {len(solution1(i))}, {len(solution2(i))}")

