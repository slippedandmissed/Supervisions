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

49.
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

            float[] scores = new float[]{100, 90, 40, 50, 10, 0, 43, 23, 11};

            Leaderboard lb = Leaderboard.from(names, scores);

            System.out.println(lb.getNames());
            System.out.println(lb.getBest(50));
            System.out.println(lb.getMedian());
        }
    }
    ```