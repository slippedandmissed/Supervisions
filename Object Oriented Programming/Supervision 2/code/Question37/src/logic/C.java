package logic;

public class C extends B {

	// Gotta have this or else the C constructor won't know how to make a B object
	// from which to inherit

	public C(int eger) {
			super(eger);
		}

}
