package uk.ac.cam.jbs52.q9;

public class BinaryTreeNode {
	
	private int mValue;
	private BinaryTreeNode mLeft;
	private BinaryTreeNode mRight;
	
	public BinaryTreeNode(int value) {
		mValue = value;
	}
	
	public int getValue () {
		return mValue;
	}
	
	public void setValue(int value) {
		mValue = value;
	}
	
	public BinaryTreeNode getLeft() {
		return mLeft;
	}
	
	public BinaryTreeNode getRight() {
		return mRight;
	}
	
	public void setLeft(BinaryTreeNode left) {
		mLeft = left;
	}
	
	public void setRight(BinaryTreeNode right) {
		mRight = right;
	}

}
