# Supervision 1

## Exercise 0
For a string of length `n`, there is one (empty) substring of length 0, and otherwise `n+1-k` substrings of length `k`. Therefore the total number of substrings is

![](https://latex.codecogs.com/svg.latex?1%20+%20\sum_{k=1}^{n}(n+1-k)=%201+%20\frac{n(n+1)}{2})

And so the total number of substring comparisons is

![](https://latex.codecogs.com/svg.latex?(1+%20\frac{n(n+1)}{2})(1+%20\frac{m(m+1)}{2}))

## Exercise 1
```python
for i from 1 included to len(a) excluded:
    j = i - 1
    tmp = a[i]
    while j >= 0 and a[j] > a[j + 1]:
        a[j + 1] = a[j]
        j = j - 1
    a[j] = tmp
```

## Exercise 2
`assert (j == 0 or a[j] >= a[j - 1])`

## Exercise 3
![](https://latex.codecogs.com/svg.latex?f%28n%29%20\in%20o%28g%28n%29%29%20\iff%20\exists%20n_0,%20c_2%20%3E%200%20s.t.%20\forall%20n%3En_0%20:%200%20\leq%20f%28n%29%20%3C%20c_2g%28n%29)

k = 4, N = 0

## Exercise 4
1. k=1, N=0
2. k<sub>2</sub> would have to be 0 which is not allowed
3. k<sub>1</sub>=199, k<sub>2</sub>=201, N=0
4. k<sub>1</sub>=123456, k<sub>2</sub>=1234567, N=654321
5. k=1, N=0
6. k=1, N=0
7. For 0 < k<sub>1</sub> < 1/(e*ln(2)), k<sub>1</sub>*1 always overtakes lg(n) at some finite n, and for greater k<sub>1</sub>, it is always greater than or equal to lg(n)
8. k=1, N=997
9. k<sub>1</sub>=1, k<sub>2</sub>=5, N=25

## Exercise 5
O(n<sup>2</sup>)

## Exercise 6
Each exchange can put up to 2 elements in the correct position - i.e. not always just 1.

## Exercise 7
7, 6, 5, 4, 3, 2, 1

## Exercise 8
```python
def binaryInsertSort(a):
    for k from 1 included to len(a) excluded:
        #########################
                                #
        l = 0                   #
        r = int (k / 2)         #
        i = int ((l + r) / 2)   #
        while l < r:            #
            if a[i] < a[k]:     #
                l = i+1         #
            else:               #
                r = i-1         #
                                #
        #########################
        if i != k:
            tmp = a[k]
            for j from k-1 included down to i-1 excluded:
                a[j + 1] = a[j]
            a[i] = tmp
```

## Exercise 9
The heaviest key will reach its final position faster, because the heaviest key is always greater than the key after it, so it will be carried to the end of the array in the first pass. The lightest key will only be moved one spot backwards each pass and so takes longer to reach the start of the array.

## Exercise 10
In the i<sup>th</sup> pass, the i<sup>th</sup> largest element is carried to its correct position, and since there are only n elements, there have to be at most n passes for each element to be in the correct position

## Exercise 11
Such a call to `min(a1[i1], a2[i2])` only returns the smallest value, and doesn't tell you whether it came from the first argument or the second, and so you won't know which index to increment. I would prefer to leave that line as it is, and implement it as follows:

```python
def smallest(a1, i1, a2, i2):
    if a1[i1] < a2[i2]:
        i1 = i1 + 1
        return a1[i1]
    else:
        i2 = i2 + 1
        return a2[i2]
```
A downside to this implementation is that it isn't clear from the name of the function that it has side effects, which might cause bugs. However, a positive for having side effects is that the caller does not have to worry about incrementing the index after the function returns.

Returning a pair of the smallest value and also the index to increment would also be a viable solution, but clunky.

## Exercise 12
For input lists with more than one element, this will not be a problem because any case in which the input list is returned is a case in which the input list is a new list created by an earlier step in the algorithm.

However, if there is a chance that the input list has one or fewer elements, then it is unclear whether or not the returned list and the input list are referencing the same object or different ones.

For example:
```python
def sortAndSometimesAddTen(a):
    b = mergeSort(a)
    a.append(10)
    return b

sortAndSometimesAddTen([1,2])   # [1,2]
sortAndSometimesAddTen([1,2,3]) # [1,2,3]
sortAndSometimesAddTen([1])     # [1,10]
```
The behaviour of the above function is different when the input has only one or zero elements in an opaque way

## Exercise 13
 - Partition the list into two partitions of size n/2 and sort each recursively as before.
 - Move the first such partition into the workspace of size n/2
 - Merge the two partitions into the space at the start of the original array.

## Exercise 14
 - In the case each comparison results in the element from the first partition being selected, it simply moves back into the space from which it was just taken, and so there will always be space for it.
 - For each comparison in which the element from the second partition is selected, an element is moved from the right hand side of the empty space to the left. As such, the total number of empty spaces stays the same.

## Exercise 15
```python
def buMergeSort(a):
    extraSpace = new array[len(a)]
    size = 1
    while (size < len(a)):
        for i from 0 inclusive to len(a) exclusive incrementing by 2*size:
            if (i + size < len(a)):
                for j from 0 inclusive to size exclusive:
                    extraSpace[j] = a[i + j]
                i1 = 0
                i2 = i + size
                i3 = 0
                while i1<size and i2<i+2*size and i2<len(a) and i3<2*size:
                    if extraSpace[i1] < a[i2]:
                        a[i+i3] = extraSpace[i1]
                        i1 += 1
                    else:
                        a[i+i3] = a[i2]
                        i2 += 1
                    i3 += 1
                while i1 < size:
                    a[i+i3] = extraSpace[i1]
                    i1 += 1
                    i3 += 1
        size *= 2
```

## Exercise 16
min = 2<sup>h</sup>

max = 2<sup>h+1</sup> - 1

## Exercise 17
The choice of pivot only affects the expected performance if you can say something about the distribution of the elements of the input list. If each element was generated independently then the choice of pivot will not make a difference to the average case, however, if you can say that earlier elements in the list are more likely to be smaller than later elements, then picking a pivot in the middle is likely to partition the list into more evenly-sized partitions than picking the last element as the pivot.

Because of this, unless you have some very precise prior knowledge about how your input list is distributed (for example if you knew that the list was in ascending order), in which case a generic sorting algorithm probably isn't even necessary, choosing the pivot at random will not affect the worst case performance.

Similarly, if you know that the elements of your input are all independent (e.g. each drawn from a uniform distribution one by one) then choosing a pivot at random will not affect the average case either.

If you know very little about your input data, then choosing the pivot at random will overcome any potential biases towards large or small partitions which may arise from how your data was collected, and so will improve the average case performance.

## Exercise 18
Insert sort is very efficient when the list is almost sorted. In fact, if each element is at most k spots away from its correct position, the complexity of insert sort is O(kn). The average complexity of quicksort is O(n log n) so the threshold should be set such that the partitions reach a size smaller than log n

## Exercise 19
n-1

## Exercise 20
2(n-2) + 1

For the first two elements, it takes one comparison to tell which is smaller. This is the running smallest value and the other is the running second smallest value. For each of the remainining (n-2) elements, compare it to the running smallest value. If it is smaller, replace it as the running smallest and replace the running second smallest with the old running smallest. If it is greater, compare it to the running second smallest value to determine the new running second smallest value.

That is a total of 1 initial comparison plus a maximum of 2 for each of the remaining n-2 elements.

## Exercise 21
Insertion sort: stable

Binary insertion sort: not stable

Bubble sort: stable

Selection sort: not stable

Quick sort: not stable

Heap sort: not stable

Counting sort: stable

Bucket sort: stable (if the underlying sort is stable)

Radix sort: stable

## Exercise 22
```python
def countingSort(a, alph):
    howMany = new array[len(alph)]
    pointer = new array[len(alph)]
    result = new array[len(a)]

    for i from 0 inclusive to len(a) exclusive:
        for j from 0 inclusive to len(alph) exclusive:
            if (a[i] == alph[j]):
                howMany[j] += 1
                break
    
    for j from 1 inclusive to len(alph) exclusive:
        pointer[j] = howMany[j - 1] + pointer[j - 1]
    
    for i from 0 inclusive to len(a) exclusive:
        for j from 0 inclusive to len(alph) exclusive:
            if (a[i] == alph[j]):
                result[pointer[j]] = a[i]
                pointer[j] += 1
                break

    return result
```

## Exercise 23
Since we often have to iterate over the entire alphabet, if the size of the alphabet is large the performance can become just as slow as if the input were large.

The time complexity is proportional to n*a where a is the size of the alphabet.