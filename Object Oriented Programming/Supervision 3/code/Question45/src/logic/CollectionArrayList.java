package logic;

import java.util.AbstractList;

public class CollectionArrayList<T> extends AbstractList<T> {

	private Object[] array;
	private int length = 0;
	
	public CollectionArrayList() {
		array = new Object[1];
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public T get(int n) {
		if (n < 0 || n >= length) {
			throw new IndexOutOfBoundsException();
		}
		return (T) array[n];
	}
	
	@Override
	public void add(int n, T element) {
		if (n < 0 || n > length) {
			throw new IndexOutOfBoundsException();
		}
		if (length == array.length) {
			Object[] newArray = new Object[array.length*2];
			for (int i=0; i<n;i++) {
				newArray[i] = array[i];
			}
			newArray[n] = element;
			for (int i=n; i<length; i++) {
				newArray[i+1] = array[i];
			}
			array = newArray;
		} else {
			for (int i=length-1; i>n; i--) {
				array[i+1] = array[i];
			}
			array[n] = element;
		}
		length++;
	}
	
	@Override
	public T set(int n, T element) {
		if (n < 0 || n >= length) {
			throw new IndexOutOfBoundsException();
		}
		@SuppressWarnings("unchecked")
		T original = (T) array[n];
		array[n] = element;
		return original;
	}
	
	@Override
	public void clear() {
		array = new Object[1];
		length = 0;
	}
	
	@Override
	public T remove(int n) {
		if (n < 0 || n >= length) {
			throw new IndexOutOfBoundsException();
		}
		@SuppressWarnings("unchecked")
		T original = (T) array[n];
		for (int i=n; i<length; i++) {
			array[i] = array[i+1];
		}
		array[length] = null;
		length--;
		
		return original;
	}
	
	@Override
	public int size() {
		return length;
	}


}
