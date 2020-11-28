package logic;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.TreeSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Main {
	
	static class Pair implements Comparable<Pair> {
		
		private int a, b;
		
		public Pair(int a, int b) {
			this.a = a;
			this.b = b;
		}
		
		@Override
		public int compareTo(Pair arg0) {
			if (a == arg0.a) {
				return b - arg0.b;
			}
			return a - arg0.a;
		}
		
		@Override
		public String toString() {
			return String.format("%d,%d", a, b);
		}
		
	}
	
	public static void main(String[] args) {
		try {
			TreeSet<Pair> pairs = new TreeSet<Pair>();
			
			File file = new File("resources/data.csv");
			Scanner scanner = new Scanner(file);
			
			Pattern re = Pattern.compile("^(\\d+),(\\d+)$");
			
			while (scanner.hasNextLine()) {
				String line = scanner.nextLine();
				Matcher matcher = re.matcher(line);
				
				if (matcher.find()) {
					int a = Integer.parseInt(matcher.group(1));
					int b = Integer.parseInt(matcher.group(2));
					
					pairs.add(new Pair(a, b));
				}
			}
			
			for (Pair p : pairs) {
				System.out.println(p);
			}
			
			scanner.close();
		}
		catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		
	}

}
