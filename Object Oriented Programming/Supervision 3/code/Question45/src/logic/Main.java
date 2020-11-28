package logic;

import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

public class Main {
	
	public static void main (String[] args) {
		
		List<Integer> list = new CollectionArrayList<Integer>();
		list.add(0, 1);
		list.clear();
		list.add(1);
		list.addAll(List.of(2, 3, 4, 5, 6, 7));
		System.out.println(list.equals(List.of(1,2,3,4,5,6,7)));
		System.out.println(list.equals(List.of(0,2,3,4,5,6,7)));
		list.set(1, 100);
		System.out.println(list.get(1));
		System.out.println(list.hashCode());
		System.out.println(list.indexOf(3));
		System.out.println(list.lastIndexOf(100));
		Iterator<Integer> it = list.iterator();
		while (it.hasNext()) {
			System.out.println(it.next());
		}
		
		ListIterator<Integer> lit = list.listIterator(3);
		while (lit.hasNext()) {
			System.out.println(lit.next());
		}
		
		list.remove(0);
		list.remove((Integer) 3);
		list.removeAll(List.of(4, 6));
		System.out.println(list.subList(1, 3));
		System.out.println(list);
		
		
	}

}
