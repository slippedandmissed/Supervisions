package uk.ac.cam.jbs52.q14;

public class Vector2D {
	
	private float x, y;
	
	public Vector2D(float x, float y) { 
		this.x = x;
		this.y = y;
	}
	
	public float getX() {
		return x;
	}
	
	public void setX(float x) {
		this.x = x;
	}
	
	public float getY() {
		return y;
	}
	
	public void setY(float y) {
		this.y = y;
	}
	
	public void add(Vector2D other) {
		this.x += other.x;
		this.y += other.y;
	}
	
	public float dot(Vector2D other) {
		return (this.x * other.x) + (this.y * other.y);
	}
	
	public float magnitude() {
		return (float) Math.sqrt(dot(this));
	}
	
	public void normalize() {
		float mag = magnitude();
		this.x /= mag;
		this.y /= mag;
	}

}
