package logic;

public class B extends A {

	// Gotta have this or else the B constructor won't know how to make an A object
	// from which to inherit
	
	public B(int eger) {
		super(eger);
	}

}
