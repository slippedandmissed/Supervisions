package uk.ac.cam.jbs52.q9;

public class SearchSet {
	
	private int mElements;
	private BinaryTreeNode mHead;
	
	public SearchSet() {
	}
	
	public void insert(int element) {
		if (mHead == null) {
			mHead = new BinaryTreeNode(element);
			mElements++;
		} else {
			BinaryTreeNode current = mHead;
			boolean inserted = false;
			do {
				int val = current.getValue();
				if (val == element) {
					inserted = true;
				} else if (element < val){
					BinaryTreeNode left = current.getLeft();
					if (left == null) {
						current.setLeft(new BinaryTreeNode(element));
						inserted = true;
						mElements++;
					} else {
						current = left;
					}
				} else {
					BinaryTreeNode right = current.getRight();
					if (right == null) {
						current.setRight(new BinaryTreeNode(element));
						inserted = true;
						mElements++;
					} else {
						current = right;
					}
				}
			} while (!inserted);
		}
	}
	
	public int getNumberElements() {
		return mElements;
	}
	
	public boolean contains(int needle) {
		BinaryTreeNode haystack = mHead;
		while (haystack != null) {
			int val = haystack.getValue();
			if (needle == val) {
				return true;
			} else if (needle < val) {
				haystack = haystack.getLeft();
			} else {
				haystack = haystack.getRight();
			}
		}
		return false;
	}
	
	public static void main (String[] args) {
		SearchSet set = new SearchSet();
		
		set.insert(1);
		set.insert(2);
		set.insert(3);
		
		System.out.println(set.contains(2));
	}
	
	

}
