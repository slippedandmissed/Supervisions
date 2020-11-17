# Supervision 1
2.
    1. They only test one or two values for the function, which is not a wide enough range
    2. Just because one takes less time than the other does not mean that the time complexity is less. FibonacciTable may run faster than Fibonacci for small inputs.

3. Instruction coverage is the proportion of instructions which are run when performing a test. For example:
    ```java
    public class Fibonacci {
        public int fib(int n) {
            return 1
        }
    }
    ```
    ```java
    import static com.google.common.truth.Truth.assertThat;

    import org.junit.Test;
    import org.junit.runner.RunWith;
    import org.junit.runners.JUnit4;

    @RunWith(JUnit4.class)
    public class FibonacciTest {

        @Test
        public void fibonacci_returns1_for1() {
            // ARRANGE
            Fibonacci fibonacci = new Fibonacci();

            // ACT
            int result = fibonacci.fib(1);

            // ASSERT
            assertThat(result).isEqualTo(1);
        }

    ```
    The test passes with 100% instruction coverage, but the function does not work.

4. Functional languages require problems to be broken down into many nested (often recursive) function calls. Data is often immutable and the code is stateless, with no side-effects. Imperative languages are stateful and do have side-effects. Programming in imperative languages requires the programmer to specify a list of steps which the computer must execute in order to solve the problem.

5. INCOMPLETE

6.
    ```java
    public static int lowestCommon(long a, long b) {
        int i=0;
        while ((a&1) != (b&1)) {
        i++;
        a = a>>1;
        b = b>>1;
        if (i == 64) {
            i = -1;
            break;
        }
        }
        return i;
    }
    ```

7.
    - Primitives: `d`, `5.0`, `1`, `2`, `3`, `4`, `f`
    - References: `i`, `l`, `k`, `t`, `c`
    - Classes: `LinkedList`, `Double`, `Tree`, `Computer`
    - Objects: `{1,2,3,4}`, the `LinkedList` referenced by `l`, the `Double` referenced by `k`.

8. https://chime.cl.cam.ac.uk/page/repos/jbs52/classic_collections_lists_and_queues/code
    1. An empty list is represented by an instance of `LinkList` whose `head` attribute is `null`.
    2. After converting the current value to a `String`, the `toString` function recursively calls `toString` on the `head` `Node` which will in turn do the same, thus traversing the list.
    3. It would be bad practice to do the logic inside the constructor itself because we are using the object's own `addFirst` method, and it is often dangerous to call the methods of an object while we are still meant to be initialising it, i.e. within the constructor.
    4. <img src="https://github.com/slippedandmissed/"/>