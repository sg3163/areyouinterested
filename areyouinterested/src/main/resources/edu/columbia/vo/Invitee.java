package edu.columbia.vo;

public class Invitee extends User {

	public String status;  // I, A, R
	
	public Invitee(int id, String email, String firstName, String lastName, String action) {
		super(id, email, firstName, lastName, action);
		this.status = "I";
	}
	
	public Invitee(int id, String email, String firstName, String lastName, String status, String action) {
		super(id, email, firstName, lastName, action);
		this.status = status;
	}
	
	public void setStatus(String status) { this.status = status; }
	public String getStatus() { return this.status; }
}
