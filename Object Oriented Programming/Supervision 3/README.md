# Supervision 3
45. 
    | Collection | Internal Data Structure                          | Thread-Safe | Allows Duplicate Values | Ordering  | Other Details                                                          |
    |------------|--------------------------------------------------|-------------|-------------------------|-----------|------------------------------------------------------------------------|
    | `Vector`     | Array                                            | Y           | Y                       | Insertion | Internal array doubles in size when it needs to be expanded            |
    | `ArrayList`  | Array                                            | N           | Y                       | Insertion | Internal array increases by half its size when it needs to be expanded |
    | `LinkedList` | Value and reference to next value/reference pair | N           | Y                       | Insertion |                                                                        |
    | `TreeSet`    | Tree                                             | N           | N                       | Natural   |                                                                        |

46. https://github.com/slippedandmissed/Supervisions/tree/master/Object%20Oriented%20Programming/Supervision%203/code/Question46

    A problem I encountered frequently was that, although several method were not abstract and so no compile-time error was thrown for my not implementing them, an error would instead be thrown whenever I tried to use them. As such, further to the `get(index)` and `length()` method the compiler required me to override, I also had to override `add(index, element)`, `set(index, element)`, `clear()`, and `remove(index)`. Luckily, I did not then have to implement `add(element)`, `addAll(index, elements)`, `equals(other)`, `hashCode()`, `indexOf(element`, `iterator()`, `listIterator()`, `remove(element)`, `removeRange(from, to)`, or `subList(from, to)` as these were implemented for me based on my implementations of the others.

47. 
    ```java
    public class Main {
	
        public static float forLoopMean(List<Integer> list) {
            float total = 0;
            for (int i=0; i<list.size(); i++) {
                total += list.get(i);
            }
            return total/list.size();
        }
        
        public static float forEachLoopMean(List<Integer> list) {
            float total = 0;
            for (int i : list) {
                total += i;
            }
            return total/list.size();
        }
        
        public static float iteratorMean(List<Integer> list) {
            Iterator<Integer> it = list.iterator();
            float total = 0;
            while (it.hasNext()) {
                total += it.next();
            }
            return total/list.size();
        }
    }
    ```
    Using a `for` loop is not the best way to go in this scenario because the syntax is clunky and more verbose than a `for-each` loop, as we don't really need the index for anything other than getting the integer at that index. Similarly, an iterator is overkill here because it requires allocating a whole new object for it, and we don't need to modify the list while iterating through it (in which case an iterator might be justified). Here, a `for-each` loop is the best solution.

48. This is because when defining a `String` as a literal, the compiler can tell that they have the same value and so only one `String` object is allocated. This is safe because `String`s are immutable. On the other hand, when creating a `String` via the constructor, no such optimisation is performed and so even when the `String`s have the same value, two objects are allocated.

49. https://chime.cl.cam.ac.uk/page/repos/jbs52/classic_collections_lists_and_queues/code

50. 
    ```java
    public class Point implements Comparable<Point> {

        private final int x, y, z;

        public Point(int x, int y, int z) {
            this.x = x;
            this.y = y;
            this.z = z;
        }

        @Override
        public int compareTo(Point other) {
            if (this.z == other.z) {
            if (this.y == other.y) {
                return this.x - other.x;
            }
            return this.y - other.y;
            }
            return this.z - other.z;
        }

        @Override
        public String toString() {
            return String.format("(%d, %d, %d)", x, y, z);
        }

    }
    ```

51. 
    ```java
    import java.util.*;

    class Leaderboard {

        private Map<String, Float> nameToScore;
        private Map<Float, String> scoreToName;
        private int length = 0;

        public Leaderboard() {
            nameToScore = new TreeMap<String, Float>();
            scoreToName = new TreeMap<Float, String>((Float a, Float b) -> Float.compare(b, a));
        }

        public static Leaderboard from(String[] names, float[] scores) {
            Leaderboard lb = new Leaderboard();
            for (int i=0; i<names.length; i++) {
                lb.add(names[i], scores[i]);
            }
            return lb;
        }

        public void add(String name, float mark) {
            nameToScore.put(name, mark);
            scoreToName.put(mark, name);
            length++;
        }

        public List<String> getNames() {
            return new ArrayList<String>(nameToScore.keySet());
        }

        public List<String> getBest(float P) {
            float fraction = P/100f;
            List<String> names = new ArrayList<String>();
            for (Map.Entry<Float, String> entry : scoreToName.entrySet()) {
                if ((names.size()+1)/((float)length) <= fraction) {
                    names.add(entry.getValue());
                }
            }
            return names;
        }

        public float getMedian() {
            List<Float> vals = new ArrayList<Float>(scoreToName.keySet());
            if (length % 2 == 1) {
                return vals.get(length/2);
            }
            return (vals.get(length/2) + vals.get(length/2 - 1))/2f;
        }


    }


    class Main {

        public static void main(String[] args) {
            // Made using namefake.com
            String[] names = new String[]{"Eldora White", "Landen Spinka", "Demetris Raynor", "Reuben Bruen", "Bernardo Bailey", "Myriam Berge", "Edmund Weber", "Clyde Braun", "Kenna Nikolaus"};
            
            // Made using my brain
            float[] scores = new float[]{100, 90, 40, 50, 10, 0, 43, 23, 11};

            Leaderboard lb = Leaderboard.from(names, scores);

            System.out.println(lb.getNames());
            System.out.println(lb.getBest(50));
            System.out.println(lb.getMedian());
        }
    }
    ```

52. 
    1. 
        ```java
        public class Car extends Comparable<Car> {
            private String manufacturer;
            private int age;

            public int compareTo(Car other) {
                return String.compareTo(manufacturer, other.manufacturer);
            }
        }
        ```
        ```java
        public class Main {
            public static void main(String[] args) {
                TreeSet<Car> cars = new TreeSet<Car>();
                // will be sorted alphabetically by manufacturer
            }
        }
        ```
    
    2. 
        ```java
        public class Car {
            private String manufacturer;
            private int age;

            public String getManufacturer() {
                return manufacturer;
            }

            public int getAge() {
                return age;
            }
        }
        ```
        ```java
        public class Main {
            public static void main(String[] args) {
                TreeSet<Car> cars = new TreeSet<Car>((Car c0, Car c1) -> {
                    int strCmp = c0.getManufacturer().compareTo(c1.getManufacturer());
                    if (strCmp == 0) {
                        return c0.getAge() - c1.getAge();
                    }
                    return strCmp;
                });
                // will be sorted manufacturer, then age
            }
        }
        ```

53. https://github.com/slippedandmissed/Supervisions/tree/master/Object%20Oriented%20Programming/Supervision%203/code/Question53

54. 
    ```java
    class SequenceEmptyException extends Exception {}
    class NoCamEmailFoundException extends Exception {}

    public class RetValTest {

        public static String extractCamEmail(String sentence) {
            if (sentence==null || sentence.length()==0)
                throw new SequenceEmptyException();
            String tokens[] = sentence.split(" "); // split into tokens
            for (int i=0; i< tokens.length; i++) {
                if (tokens[i].endsWith("@cam.ac.uk")) {
                    return tokens[i];
                }
            }
            throw new NoCamEmailFoundException();
        }

        public static void main(String[] args) {
            try {
                String sEmail = RetValTest.extractCamEmail("My email is rkh23@cam.ac.uk");
                System.out.println("Success: "+sEmail);
            } catch (SequenceEmptyException e) {
                System.out.println("Supplied string empty");
            } catch (NoCamEmailFoundException e) {
                System.out.println("No @cam address in supplied string");
            } 
        }
    }
    ```

55. 
    ```java
    public static double sqrt (double x) {
        if (x < 0) {
            throw new ArithmeticException("Can't take the square root of "+x+" because it is negative");
        }
        double guess = x/2.0;
        double diff;
        do {
            //Simplified Newton-Raphson formula
            double nextGuess = (guess+x/guess)/2.0;
            diff = Math.abs(guess-nextGuess);
            guess = nextGuess;
        } while (diff > 10E-20);
        return guess;
    }
    ```

56. This implementation would technically work, but it would be very difficult to debug. This is because exceptions and exception handling are not designed for cases in which the program is working as expected. Throwing an exception is much like a `goto` statement in that it disrupts the flow of the program in ways that clash with best-practices Java.

    Furthermore, if a negative number is passed as the exponent, there will be an unhandled `StackOverflowException`.

57. 
    ```java
    public class Main {

        public static void main(String[] args) {

            String[] strings = new String[]{"And", "they", "were", "roommates"}
            Object[] objects = strings;
            objects[0] = new Integer(0); //Runtime error because it's still technically a String array

        }

    }
    ```

58. 
    |                         | Can access static variables | Can access instance variables    | Can access local variables |
    |-------------------------|-----------------------------|----------------------------------|----------------------------|
    | Inner-classes           | Y                           | Only when non-static             | N                          |
    | Method-local classes    | Y                           | Only when in a non-static method | Y                          |
    | Anonymous inner classes | Y                           | Only when in a non-static method | Y                          |
    | Lambda functions        | Y                           | Only when in a non-static method | Y                          |

    Anonoymous inner classes define a single instance of a class which is defined in the same place in which it is instantiated.
    
    Lambda functions do not define a class, but rather an instance of some child of an interface which only has one method. The lambda function defines the implementation of that method. 

    Use an inner class when the class is going to be used in multiple methods of the outer class. Use a method-local class when the class is only going to be used within that one method. Use an anonymous inner class when instances of the class only need to be created at that one point in the code. Use lambda functions to instantiate a child of an interface which only has one method.

59. https://chime.cl.cam.ac.uk/page/repos/jbs52/alice_in_wonderland/code

60. The `BufferedReader` class is a subclass of `Reader` and has a constructor which accepts another instance of `Reader`. A reference this this instance is stored and used by the `BufferedReader` instance in its own implementation of the `Reader` methods, along with some added functionality. 

61. There aren't really any advantages to using `int`s to store the state as opposed to an enum. The advantages of using an enum rather than `int`s is that enums are closed, meaning they are only allowed to have a finite set of values, whereas if the state was an `int` it could be accidentally set to one which does not correspond with a state. However, a disadvantage is that it's a lot of work to add a new state. Using subclasses of a `State` interface makes the code more maintainable and easier to expand but it does make the code a bit more verbose and clunky.

    The final solution demonstrates the open-closed principle because if a new state was to be added, all you would have to do is create a new subclass of the `State` inferface. You would not have to modify the `State` interface itself or the code which uses an instance thereof.

62. 

63. The state pattern allows you to make changes to an object's behaviour based on a change to an internal state, whereas the strategy pattern allows you to select an algorithm to use based on any number of criteria at runtime.

64. 
    1. Yes

    2. 
        ```java
        public void drawShapes() {
            for (Shape shape : shapes) {
                shape.draw();
            }
        }
        ```

    3. 
        ```java
        class GroupOfShapes extends Shape {
            private final List<Shape> children;

            public GroupOfShapes(List<Shape> shapes) {
                children = List.copyOf(shapes);
            }

            public GroupOfShapes(Shape... shapes) {
                children = List.copyOf(Arrays.asList(shapes));
            }

            public void draw() {
                for (Shape child : children) {
                    child.draw();
                }
            }
        }
        ```

    4. 