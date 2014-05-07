package edu.columbia.vo;

import java.util.ArrayList;

public class Event {

	private int id;
	private String type;  // M, R, X
	private String title;
	private String location;
	private String dateTime;
	private String description;
	private User host;
	private ArrayList<Invitee> invitees;
	private String action;
	
	public Event(int id, String type, String title, String location, String dateTime, String description, String action) {
		this.id = id;
		this.type = type;
		this.title = title;
		this.location = location;
		this.dateTime = dateTime;
		this.description = description;
		this.host = null;
		this.invitees = new ArrayList<Invitee>();
		this.action = action;
	}
	
	public Event(int id, String type, String title, String location, String dateTime, String description, User host, ArrayList<Invitee> invitees, String action) {
		this.id = id;
		this.type = type;
		this.title = title;
		this.location = location;
		this.dateTime = dateTime;
		this.description = description;
		this.host = host;
		this.invitees = invitees;
		this.action = action;
	}
	
	public void setID(int id) { this.id = id; }
	public void setType(String type) { this.type = type; }
	public void setTitle(String title) { this.title = title; }
	public void setLocation(String location) { this.location = location; }
	public void setDescription(String description) { this.description = description; }
	public void setHost(User host) { this.host = host; }
	public void setInvitees(ArrayList<Invitee> invitees) { this.invitees = invitees; }

	public void addInvitee(Invitee invitee) {
		if (!hasInvitee(invitee))
			invitees.add(invitee);
	}

	public int getID() { return this.id; }
	public String getType() { return this.type; }
	public String getTitle() { return this.title; }
	public String getLocation() { return this.location; }
	public String getDateTime() { return this.dateTime; }
	public String getDescription() { return this.description; }
	public User getHost() { return this.host; }
	public ArrayList<Invitee> getInvitees() { return this.invitees; }
	public String getAction() { return this.action; }
	
	private boolean hasInvitee(Invitee invitee) {
		for (Invitee i : invitees) {
			if (i.getEmail().length() > 0 && invitee.getEmail().length() > 0 && i.getEmail().equalsIgnoreCase(invitee.getEmail()))
				return true;
		}
		
		return false;
	}
}
