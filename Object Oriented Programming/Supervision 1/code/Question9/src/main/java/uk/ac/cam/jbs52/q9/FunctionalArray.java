package uk.ac.cam.jbs52.q9;

public class FunctionalArray {
	
	public static final int DEFAULT_VALUE = 0;
	private BinaryTreeNode mHead;
	private int size;
	
	public FunctionalArray(int size) {
		if (size < 0) {
			throw new NegativeArraySizeException();
		}
		this.size = size;
		// New branch objects are allocated when they are accessed
	}
	
	private BinaryTreeNode traverse(int index) {
		if (index < 0 || index >= size) {
			throw new ArrayIndexOutOfBoundsException();
		}
		index++;
		if (mHead == null) {
			mHead = new BinaryTreeNode(DEFAULT_VALUE);
		}
		BinaryTreeNode current = mHead;
		while (index > 1) {
			if (index % 2 == 1) {
				BinaryTreeNode right = current.getRight();
				if (right == null) {
					right = new BinaryTreeNode(0);
					current.setRight(right);
				}
				current = right;
			} else {
				BinaryTreeNode left = current.getLeft();
				if (left == null) {
					left = new BinaryTreeNode(0);
					current.setLeft(left);
				}
				current = left;
			}
			index = (int) Math.floor(index/2);
		}
		return current;
	}
	
	public void set(int index, int value) {
		traverse(index).setValue(value);
	}
	
	public int get(int index) {
		return traverse(index).getValue();
	}

}
