package edu.columbia.vo;

public class User {

	private int id;
	private String email;
	private String firstName;
	private String lastName;
	private String action;
	
	public User(int id, String email, String firstName, String lastName, String action) {
		this.id = id;
		this.email = email;
		this.firstName = firstName;
		this.lastName = lastName;
		this.action = action;
	}
	
	public void setEmail(String email) { this.email = email; }
	public void setFirstName(String firstName) { this.firstName = firstName; }
	public void setLastName(String lastName) { this.lastName = lastName; }
	public void setAction(String action) { this.action = action; }
	
	public int getID() { return this.id; }
	public String getEmail() { return this.email; }
	public String getFirstName() { return this.firstName; }
	public String getLastName() { return this.lastName; }
	public String getAction() { return this.action; }
}
