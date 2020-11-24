# Supervision 2

23. 
    ```
    1 1
    2 2
    ```
    In the first function call, immutable primitives are passed to the function and so the values in the array are not modified, whereas on the second function call the array itself is passed to the function by reference and its contents are modified.

24. Inheritance requires that a child class can be treated as an instance of its parent class if the occasion calls for it. In this instance, a 3D vector should not be able to be treated as a 2D vector. This can be seen in the following example.
    ```java
    public class Example {

        public float dot(Vector2 a, Vector2 b) {
            return a.x*b.x + a.y*b.y;
        }

        public static void main(String[] args) {
            Vector3 a = new Vector3(1, 2, 3);
            Vector3 b = new Vector3(4, 5, 6);

            System.out.println(dot(a, b));
            // Will print "14" which is misleading
            // As it is not the dot product of the vectors
        }

    }
    ```

25. https://github.com/slippedandmissed/Supervisions/tree/master/Object%20Oriented%20Programming/Supervision%202/code/Question25

26.
    1. <br/><img style="height: 400px" src="https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Object%20Oriented%20Programming/Supervision%202/figures/26-a.svg" />
    2. <br/><img style="height: 400px" src="https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Object%20Oriented%20Programming/Supervision%202/figures/26-b.svg" />

27.
    |   | public | private | protected | package-protected |
    |---|--------|---------|-----------|-------------------|
    | a |    Y   |    N    |     Y     |         Y         |
    | b |    Y   |    N    |     Y     |         N         |
    | c |    Y   |    N    |     Y     |         Y         |
    | d |    Y   |    N    |     N     |         N         |