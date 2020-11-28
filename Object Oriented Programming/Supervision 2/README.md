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
    |   | **public** | **private** | **protected** | **package-protected** |
    |---|------------|-------------|---------------|-----------------------|
    | a |      Y     |      N      |       Y       |           Y           |
    | b |      Y     |      N      |       Y       |           N           |
    | c |      Y     |      N      |       Y       |           Y           |
    | d |      Y     |      N      |       N       |           N           |
 
28. Dynamic polymorphism is when a call to an overridden method is resolved at runtime. It is useful because it allows child classes to override methods of their parent classes.
    ```java
    public class Person {
        public void greet() {
            System.out.println("Hello there");
        }
    }

    public class JudgementalPerson extends Person {
        @Override
        public void greet() {
            System.out.println("Oh.... hi....");
        }
    }
    ```

29. While this would give the user more flexibility, it could also lead to a lot of problems. For example:
    ```java
    public class Frog {
        public FrogArm leftArm, rightArm;

        public void clap() {
            leftArm.slamInto(rightArm);
        }
    }

    public class OneArmedFrog extends Frog[leftArm, clap] {
        // Suppose the above syntax means that only the leftArm member and the clap method are inherited, not the rightArm member.
    }

    public class Main {
        public static void main(String[] args) {
            OneArmedFrog frog = new OneArmedFrog();
            frog.clap(); // Problem here, because frog doesn't have a rightArm attribute.
        } 
    }
    ```

30. 
    ```java
    public class Student {
        public int ticks;
        public final int ticksToPass;

        public boolean pass() {
            return ticks > ticksToPass;
        }
    }

    public class CSStudent extends Student {
        public final int ticksToPass = 20;
    }
    
    public class NSStudent extends Student {
        public final int ticksToPass = 10;
    }
    ```

31. https://chime.cl.cam.ac.uk/page/repos/jbs52/chess/code
    1. Some methods of the `Piece` class used large unwieldly switch statements to return a different value based on which piece it represents

    2. My new code is easier to maintain because errors are easier to spot. For example you can no longer create a piece whose name is an invalid character, and it is easier to make changes to a specific piece's icons or value. The drawback is that I need a seprarate class for each piece which makes my codebase quite a lot bigger.

32. 
    ```java
    public abstract class Shape {
        public static final String type = "Shape";

        abstract void draw(AsciiImage asciiImage);
    }
    ```
    ```java
    public class Circle extends Shape {

        private final int x;
        public static final String type = "Circle";

        public Circle(int x) {
            this.x = x;
        }

        @Override
        void draw(AsciiImage asciiImage) {
            asciiImage.draw(x, 'o');
        }
    }
    ```
    And likewise for `Square` and `Stick`

33. A non-abstract class has fields and methods and can be instantiated. An abstract class cannot be instantiated, but classes which inherit from it can. Abstract classes can have fields and methods, but some of those methods do not need to be implemented, but instead are required to be implemented by any non-abstract child class. An interface provides a promise of funtionality in any class which implements it. The interface itself does not contain the functionality.

34. 
    1. 
        | Operation       | **Complexity** |
        |-----------------|----------------|
        | Append          | O(1)           |
        | Insert          | O(N)           |
        | Search by value | O(N)           |
        | Get by index    | O(1)           |
        | Remove by value | O(N)           |
        | Remove by index | O(N)           |
    
    2. https://chime.cl.cam.ac.uk/page/repos/jbs52/classic_collections_lists_and_queues/code/b1aa189c4e5569e93f7878039c93e72487939ce5

    3. 
        |              | **Complexity** |
        |--------------|----------------|
        | Best case    | O(1)           |
        | Average case | O(N)           |
        | Worst case   | O(N)           |

35. 
    1. 
        https://chime.cl.cam.ac.uk/page/repos/jbs52/classic_collections_lists_and_queues/code/f506f56acae1605edeeb42c4a050a8c7689c9f41

        https://chime.cl.cam.ac.uk/page/repos/jbs52/classic_collections_lists_and_queues/code/680517678dc15de394bdc8f36f400107053a03e1

    2. 
        |                   | **Complexity** |
        |-------------------|----------------|
        | Push Best case    | O(1)           |
        | Push Average case | O(1)           |
        | Push Worst case   | O(1)           |
        | Pop Best Case     | O(1)           |
        | Pop Average Case  | O(N)           |
        | Pop Worst Case    | O(N)           |

36. 
    ```java
    public class Employee {
        public void doInsiderTrading() {
            System.out.println("Sell all my stock");
        }
    }
    ```
    ```java
    public class Ninja {
        public void beMysterious() {
            System.out.println("\uD83D\uDC7B");
        }
    }
    ```
    ```java
    public interface IsAlsoNinja {
        final Ninja ninjaBehavior = new Ninja();

        default public void beMysterious() {
            ninjaBehavior.beMysterious();
        }
    }
    ```
    ```java
    public class NinjaEmployee extends Employee implements IsAlsoNinja {

    }
    ```
    ```java
    public class Main {
        public static void main (String[] args) {
            NinjaEmployee ninjaEmployee = new NinjaEmployee();
            ninjaEmployee.doInsiderTrading();
            ninjaEmployee.beMysterious();
        }
    }
    ```
37. https://github.com/slippedandmissed/Supervisions/tree/master/Object%20Oriented%20Programming/Supervision%202/code/Question37

38. The *mark-sweep* technique is the fastest of the three techniques in that it takes the least amount of time to perform. However it requires keeping a data structure full of memory locations and so it is not the most efficient space-wise. The *mark-sweep-compact* technique eliminates the need for storing a list of all of the available memory locations. Furthermore, having larger chunks of adjacent free memory means that the application can easily allocate large data structures there. However, moving surviving objects takes time. The *mark-copy* technique is very inefficient in terms of memory, because only half of the memory is ever in use by the application at a time. However it also leaves large consecutive chunks of available memory.

39. If objects are mutable, then often copies of the object have to be made in order to stop the user accidentally modifying an important attribute of the original. This means that more memory is allocated and so the garbage collector takes longer to run.

40. In Java, there is no guarantee that the finalizers will run. Therefore it is bad practice to do important manual garbage collection in the finalizer.

41. 
    ```java
    public interface Destructable {
        public void onDestruction();
    }
    ```
    ```java
    public class TestClass implements Destructable {

        private String[] largeResource;

        public void doSomeStuff() {
            largeResource = new String[] {
                "All", "the", "birds", "died", "in", "1986", "due", "to", "Reagan", "killing", "them", "and", "replacing", "them", "with", "spies", "that", "are", "now", "watching", "us.", "The", "birds", "work", "for", "the", "bourgeoisie."
            };

            System.out.println(String.join(" ", largeResource));
        }

        public void onDestruction() {
            largeResource = null;
        }
    }
    ```
    ```java
    public class Main {
        public static void main (String[] args) {
            TestClass test = new TestClass();
            try {
                test.doSomeStuff();
            } finally {
                test.onDestruction();
            }
        }
    }
    ```

42. The `finally` block is executed.