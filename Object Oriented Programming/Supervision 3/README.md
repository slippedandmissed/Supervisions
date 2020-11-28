# Supervision 3
45.
    | Collection | Internal Data Structure                          | Thread-Safe | Allows Duplicate Values | Ordering  | Other Details                                                          |
    |------------|--------------------------------------------------|-------------|-------------------------|-----------|------------------------------------------------------------------------|
    | `Vector`     | Array                                            | Y           | Y                       | Insertion | Internal array doubles in size when it needs to be expanded            |
    | `ArrayList`  | Array                                            | N           | Y                       | Insertion | Internal array increases by half its size when it needs to be expanded |
    | `LinkedList` | Value and reference to next value/reference pair | N           | Y                       | Insertion |                                                                        |
    | `TreeSet`    | Tree                                             | N           | N                       | Natural   |                                                                        |
