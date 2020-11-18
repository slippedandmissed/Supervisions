# Supervision 1
2. https://chime.cl.cam.ac.uk/page/repos/jbs52/fibonacci/code
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
    }
    ```
    The test passes with 100% instruction coverage, but the function does not work.

4. Functional languages require problems to be broken down into many nested (often recursive) function calls. Data is often immutable and the code is stateless, with no side-effects. Imperative languages are stateful and do have side-effects. Programming in imperative languages requires the programmer to specify a list of steps which the computer must execute in order to solve the problem.

5.
    ```java
    class Main {
        public static int factorial(int n) {
            if (n == 0) {
            return 1;
            }
            return n * factorial(n-1);
        }

        public static int factorialTCO(int n, int acc) {
            if (n == 0) {
            return acc;
            }
            return factorialTCO(n-1, n*acc);
        }

        public static int factorialTCO(int n) {
            return factorialTCO(n, 1);
        }


        public static void main(String[] args) throws Exception {
            int input = 10000000;
            try {
            factorial(input);
            System.out.println("No stack overflow on non-TCO method");
            } catch (StackOverflowError e) {
            System.out.println("Stack overflow on non-TCO method");
            }

            try {
            factorialTCO(input);
            System.out.println("No stack overflow on TCO method");
            } catch (StackOverflowError e) {
            System.out.println("Stack overflow on TCO method");
            }
        }
    }
    ```
    ```
    Stack overflow on non-TCO method
    Stack overflow on TCO method
    ```
    If there was TCO optimisation, the tail-recursive method would not result in a stack overflow error. Therefore there is no TCO optimisation.

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

8. https://chime.cl.cam.ac.uk/page/repos/jbs52/classic_collections_lists_and_queues/code/477ff3b974521963c2afefb210d3ff5aa06340d7
    1. An empty list is represented by an instance of `LinkList` whose `head` attribute is `null`.
    2. After converting the current value to a `String`, the `toString` function recursively calls `toString` on the `head` `Node` which will in turn do the same, thus traversing the list.
    3. It would be bad practice to do the logic inside the constructor itself because we are using the object's own `addFirst` method, and it is often dangerous to call the methods of an object while we are still meant to be initialising it, i.e. within the constructor.
    4. <br /><img src="https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Object%20Oriented%20Programming/Supervision%201/figures/LinkList%20UML.svg"/>

9. https://github.com/slippedandmissed/Supervisions/tree/master/Object%20Oriented%20Programming/Supervision%201/code/Question9

10. The keyword `void` shows that `Test` here is a regular method and not a constructor. Therefore the default constructor is used which does not modify `x`.

11. One advantage of using private state with public getters and setters is that if you want to change your state implementation you just need to change the getters and setters and you won't have to worry about other code which might use instances of this class. Another benefit is that you can perform checks to make sure that other parts of the code cannot modify the state in a way which might break other methods of the class. A disadvantage is that it can make the code very clunky and verbose.

12. This approach does reduce the verbosity of the code, but it doesn't provide the iron-clad compile-time security that Java's approach does. It is quite possible that one of these *meant-to-be-private* variables was used during prototyping and it was never refactored. Furthermore, if a variable is supposed to be accessed, the class itself cannot perform checks to make sure the new value is valid whenever it is set. Any attempt to implement such a thing would be, in essence, trying to simulate a setter.

13. https://chime.cl.cam.ac.uk/page/repos/jbs52/matrices/code
    1. `double`s can be subject to rounding errors in Java, and so the results may not be exactly accurate.
    2. The notation of squares and rotations are not relevant to what a matrix does and how a matrix is implemented, so they should not be defined in the `Matrix` class.

14.
    1. https://github.com/slippedandmissed/Supervisions/tree/master/Object%20Oriented%20Programming/Supervision%201/code/Question14
    2. Remove the setters for `x` and `y`. Make the `add` method return a new instance of `Vector2D` instead of modifying `this`, and likewise for the `normalize` method. Perhaps the latter would be better renamed to `normalized` to indicate that no action is being performed on the object itself. `x` and `y` could also be made final, but this is not necessary.
    3. In the mutable case, either of the first two definitions would work well, as the addition is being performed on a vector (`this`) and the action is that of adding another vector (`v`) to it. It is a matter of preference whether or not this method should also return the modified `this`. In the immutable case, either the second or the fourth prototypes would work. In the second prototype, a new vector would be created which is the sum of `this` and `v` but without modifying either, and then this new object is returned. In the fourth prototype, a new vector would be created which is the sum of `v1` and `v2` and then this is returned.
    4. Using static methods to perform operations on the vectors would be a good signal that the objects are immutable, but this can be clunky to use. Making `x` and `y` final and giving them no setters would also be a good indicator to the user, as would be renaming `normalize` to `normalized`. Of course, you could also just use javadocs or code comments.

15. Due to type erasure, all generic classes are considered to be instances of `Object` at runtime. All classes inherit from `Object`, but primitives do not and so cannot be used as a generic type. Similarly, you cannot instantiate objects of the template type because, due to type erasure, they would just be treated as instances of `Object` at runtime.

16. https://chime.cl.cam.ac.uk/page/repos/jbs52/classic_collections_lists_and_queues/code/277f2538cf2500e433439239480949ed113af732

17. https://chime.cl.cam.ac.uk/page/repos/jbs52/sorting/code
    1. When an array is allocated in Java, memory is allocated based on the type of the elements in the array. However at runtime due to type erasure the information about the generic type is not available, and so an array of such cannot be allocated. `Object[]` will work because any generic class inherits from `Object` and so can be implicitly cast to an `Object`. `ArrayList<T>` also works because `ArrayList`s do not require information about the class in order to allocate memory in the same way that arrays do.

18. Wildcards are a mechanism for casting a collection of one type to a collection of another. Specifically, it can be used to cast collections of one type, to a collection of subclasses/superclasses of that type. 

    For example, if you had the following class hierarchy:
    ```java
    abstract class Animal {public abstract void eat();}

    class Cat extends Animal {
        public void eat() {System.out.println("nom nom nom");}
    }

    class Horse extends Animal {
        public void eat() {System.out.println("om nom nom");}
    }
    ```
    And we wanted a method which would feed all the animals in a list, like so:
    ```java
    class Farmer {
        public void feed(List<Animal> farmyard) {
            for (Animal animal : farmyard) {
                animal.eat();
            }
        }
    }
    ```
    We would not be able to pass in an object of type `List<Cat>` or `List<Horse>` as the compiler is unable to implicitly cast either of these to a `List<Animal>` object. If it did so, it could potentially create the following problem:
    ```java
    List<Cat> cats = new ArrayList<Cat>();
    List<Animal> a = cats; // Compiler will throw an error here
    a.add(new Horse());    // Because this part shouldn't be allowed
    ```
    As such you could use a wildcard to allow the `feed` method to accept an list of an unknown class which extends `Animal`, whether that's a `List<Animal>`, `List<Cat>`, or `List<Horse>`.
    ```java
    class Farmer {
        public void feed(List<? extends Animal> farmyard) {
            for (Animal animal : farmyard) {
                animal.eat();
            }
        }
    }
    ```
    Similarly, imagine a scenario in which the farmer wants to buy a new horse.
    ```java
    public void buyNewHorse(List<Animal> farmyard) {
        farmyard.add(new Horse());
    }
    ```
    The compiler would now throw an error if we tried to pass in a `List<Horse>` object, because it cannot implicitly cast this to a `List<Animal>` object. Instead we can use a wildcard to allow the method to accept a list of any superclass of `Horse` (including `Horse` itself).
    ```java
    public void buyNewHorse(List<? super Horse> farmyard) {
        farmyard.add(new Horse());
    }
    ```
    Now we can pass in either a `List<Horse>` or a `List<Animal>` object and the compiler will be able to add a `Horse` object to it safely. 

19. A reference is guaranteed by the compiler to always be pointing to some data of the correct type - either an instance of the correct class, or null. Pointers on the other hand can be pointing to a random chunk of memory which, if you were to try to use as if it were of the correct type, would cause problems in your code.

20. <br /><img src="https://raw.githubusercontent.com/slippedandmissed/Supervisions/master/Object%20Oriented%20Programming/Supervision%201/figures/Helpful%20diagrams.svg"/>

21.
    1. Delegation of responsibility - the notion of splitting code up into sections which are each responsible for their own portion of the problem. This allows you to treat certain parts of the code like a black box, which makes it easier to break up the problem into smaller problems.
    2. References and pointers, and how they relate to im/mutability.
    3. Unit tests

22. Question 5 about how to test for TCO, and question 17 about type erasure.