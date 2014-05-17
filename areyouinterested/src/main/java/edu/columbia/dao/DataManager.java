package edu.columbia.dao;

import java.sql.*;
import java.util.ArrayList;
import oracle.jdbc.pool.OracleDataSource;
import edu.columbia.vo.*;

public class DataManager {

	private static final String connect_string = "jdbc:oracle:thin:ayi/columbia@//ayidbinstance.cmwcsrjrhfvr.us-east-1.rds.amazonaws.com:1521/AYIDB";
	
	public static ArrayList<Event> getEvents(String email) throws SQLException {
		ArrayList<Event> events = new ArrayList<Event>();
		Connection conn = null;
		
		try {
			OracleDataSource ods = new OracleDataSource();
			ods.setURL(connect_string);
			conn = ods.getConnection();	
			Statement stmt = conn.createStatement();
			String sql = "SELECT e.Event_ID, e.Event_Type, e.Title, e.Location, e.Date_Time, e.Description " +
						 "FROM Usr u " +
						 "  INNER JOIN Usr_Event x ON u.Usr_ID = x.Usr_ID " +
						 "  INNER JOIN Event e ON x.Event_ID = e.Event_ID " +
						 "WHERE u.Email = '" + email + "'";
			
			ResultSet rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				int eventID = (rs.getString("Event_ID") != null) ? Integer.parseInt(rs.getString("Event_ID").trim()) : -1;
				String eventType = (rs.getString("Event_Type") != null) ? rs.getString("Event_Type").trim() : "";
				String title = (rs.getString("Title") != null) ? rs.getString("Title").trim() : "";
				String location = (rs.getString("Location") != null) ? rs.getString("Location").trim() : "";
				String dateTime = (rs.getString("Date_Time") != null) ? rs.getString("Date_Time").trim() : "";
				String description = (rs.getString("Description") != null) ? rs.getString("Description").trim() : "";
				
				Event event = new Event(eventID, eventType, title, location, dateTime, description, "");
				events.add(event);
			}
		
			for (Event event : events) {
				sql = "SELECT u.Usr_ID, u.Email, u.First_Name, u.Last_Name, x.Status " +
					  "FROM Usr u " +
					  "  INNER JOIN Usr_Event x ON u.Usr_ID = x.Usr_ID " +
					  "WHERE x.Event_ID = " + event.getID();
				
				rs = stmt.executeQuery(sql);
				
				while (rs.next()) {
					int userID = (rs.getString("Usr_ID").trim() != null) ? Integer.parseInt(rs.getString("Usr_ID").trim()) : -1;
					String emailAddr = (rs.getString("Email") != null) ? rs.getString("Email").trim() : "";
					String firstName = (rs.getString("First_Name") != null) ? rs.getString("First_Name").trim() : "";
					String lastName = (rs.getString("Last_Name") != null) ? rs.getString("Last_Name").trim() : "";
					String status = (rs.getString("Status") != null) ? rs.getString("Status").trim() : "";
					
					if (status.equalsIgnoreCase("H")) {
						User host = new User(userID, emailAddr, firstName, lastName, "");
						event.setHost(host);
					}
					else {
						Invitee invitee = new Invitee(userID, emailAddr, firstName, lastName, status);
						event.addInvitee(invitee);
					}
				}
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally
		{
			if (conn != null)
				conn.close();
		}
		
		return events;
	}
	
	public static ArrayList<Event> getHostingEvents(String email) throws SQLException {
		ArrayList<Event> events = new ArrayList<Event>();
		Connection conn = null;
		
		try {
			OracleDataSource ods = new OracleDataSource();
			ods.setURL(connect_string);
			conn = ods.getConnection();		
			Statement stmt = conn.createStatement();
			String sql = "SELECT e.Event_ID, e.Event_Type, e.Title, e.Location, e.Date_Time, e.Description " +
						 "FROM Usr u " +
						 "  INNER JOIN Usr_Event x ON u.Usr_ID = x.Usr_ID " +
						 "  INNER JOIN Event e ON x.Event_ID = e.Event_ID " +
						 "WHERE u.Email = '" + email + "' " +
						 "  AND x.Status = 'H'";
			
			ResultSet rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				int eventID = (rs.getString("Event_ID") != null) ? Integer.parseInt(rs.getString("Event_ID").trim()) : -1;
				String eventType = (rs.getString("Event_Type") != null) ? rs.getString("Event_Type").trim() : "";
				String title = (rs.getString("Title") != null) ? rs.getString("Title").trim() : "";
				String location = (rs.getString("Location") != null) ? rs.getString("Location").trim() : "";
				String dateTime = (rs.getString("Date_Time") != null) ? rs.getString("Date_Time").trim() : "";
				String description = (rs.getString("Description") != null) ? rs.getString("Description").trim() : "";
				
				Event event = new Event(eventID, eventType, title, location, dateTime, description, "");
				events.add(event);
			}
			
			for (Event event : events) {
				sql = "SELECT u.Usr_ID, u.Email, u.First_Name, u.Last_Name, x.Status " +
					  "FROM Usr u " +
					  "  INNER JOIN Usr_Event x ON u.Usr_ID = x.Usr_ID " +
					  "WHERE x.Event_ID = " + event.getID();
				
				rs = stmt.executeQuery(sql);
				
				while (rs.next()) {
					int userID = (rs.getString("Usr_ID").trim() != null) ? Integer.parseInt(rs.getString("Usr_ID").trim()) : -1;
					String emailAddr = (rs.getString("Email") != null) ? rs.getString("Email").trim() : "";
					String firstName = (rs.getString("First_Name") != null) ? rs.getString("First_Name").trim() : "";
					String lastName = (rs.getString("Last_Name") != null) ? rs.getString("Last_Name").trim() : "";
					String status = (rs.getString("Status") != null) ? rs.getString("Status").trim() : "";
					
					if (status.equalsIgnoreCase("H")) {
						User host = new User(userID, emailAddr, firstName, lastName, "");
						event.setHost(host);
					}
					else {
						Invitee invitee = new Invitee(userID, emailAddr, firstName, lastName, status);
						event.addInvitee(invitee);
					}
				}
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally
		{
			if (conn != null)
				conn.close();
		}
		
		return events;
	}
	
	public static ArrayList<Event> getInvitedEvents(String email) throws SQLException {
		ArrayList<Event> events = new ArrayList<Event>();
		Connection conn = null;
		
		try {
			OracleDataSource ods = new OracleDataSource();
			ods.setURL(connect_string);
			conn = ods.getConnection();		
			Statement stmt = conn.createStatement();
			String sql = "SELECT e.Event_ID, e.Event_Type, e.Title, e.Location, e.Date_Time, e.Description " +
						 "FROM Usr u " +
						 "  INNER JOIN Usr_Event x ON u.Usr_ID = x.Usr_ID " +
						 "  INNER JOIN Event e ON x.Event_ID = e.Event_ID " +
						 "WHERE u.Email = '" + email + "' " +
						 "  AND x.Status != 'H'";
			
			ResultSet rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				int eventID = (rs.getString("Event_ID") != null) ? Integer.parseInt(rs.getString("Event_ID").trim()) : -1;
				String eventType = (rs.getString("Event_Type") != null) ? rs.getString("Event_Type").trim() : "";
				String title = (rs.getString("Title") != null) ? rs.getString("Title").trim() : "";
				String location = (rs.getString("Location") != null) ? rs.getString("Location").trim() : "";
				String dateTime = (rs.getString("Date_Time") != null) ? rs.getString("Date_Time").trim() : "";
				String description = (rs.getString("Description") != null) ? rs.getString("Description").trim() : "";
				
				Event event = new Event(eventID, eventType, title, location, dateTime, description, "");
				events.add(event);
			}
			
			for (Event event : events) {
				sql = "SELECT u.Usr_ID, u.Email, u.First_Name, u.Last_Name, x.Status " +
					  "FROM Usr u " +
					  "  INNER JOIN Usr_Event x ON u.Usr_ID = x.Usr_ID " +
					  "WHERE x.Event_ID = " + event.getID();
				
				rs = stmt.executeQuery(sql);
				
				while (rs.next()) {
					int userID = (rs.getString("Usr_ID").trim() != null) ? Integer.parseInt(rs.getString("Usr_ID").trim()) : -1;
					String emailAddr = (rs.getString("Email") != null) ? rs.getString("Email").trim() : "";
					String firstName = (rs.getString("First_Name") != null) ? rs.getString("First_Name").trim() : "";
					String lastName = (rs.getString("Last_Name") != null) ? rs.getString("Last_Name").trim() : "";
					String status = (rs.getString("Status") != null) ? rs.getString("Status").trim() : "";
					
					if (status.equalsIgnoreCase("H")) {
						User host = new User(userID, emailAddr, firstName, lastName, "");
						event.setHost(host);
					}
					else {
						Invitee invitee = new Invitee(userID, emailAddr, firstName, lastName, status);
						event.addInvitee(invitee);
					}
				}
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally
		{
			if (conn != null)
				conn.close();
		}
		
		return events;	
	}
	
	public static Event getEvent(String eventID) throws SQLException {
		Event event = null;
		Connection conn = null;
		
		try {
			OracleDataSource ods = new OracleDataSource();
			ods.setURL(connect_string);
			conn = ods.getConnection();		
			Statement stmt = conn.createStatement();
			String sql = "SELECT e.Event_ID, e.Event_Type, e.Title, e.Location, e.Date_Time, e.Description " +
						 "FROM Event e " +
						 "WHERE e.Event_ID = " + eventID;
			
			ResultSet rs = stmt.executeQuery(sql);
			rs.next();
			
			int eventID2 = (rs.getString("Event_ID") != null) ? Integer.parseInt(rs.getString("Event_ID").trim()) : -1;
			String eventType = (rs.getString("Event_Type") != null) ? rs.getString("Event_Type").trim() : "";
			String title = (rs.getString("Title") != null) ? rs.getString("Title").trim() : "";
			String location = (rs.getString("Location") != null) ? rs.getString("Location").trim() : "";
			String dateTime = (rs.getString("Date_Time") != null) ? rs.getString("Date_Time").trim() : "";
			String description = (rs.getString("Description") != null) ? rs.getString("Description").trim() : "";
			
			event = new Event(eventID2, eventType, title, location, dateTime, description, "");
			
			sql = "SELECT u.Usr_ID, u.Email, u.First_Name, u.Last_Name, x.Status " +
				  "FROM Usr u " +
				  "  INNER JOIN Usr_Event x ON u.Usr_ID = x.Usr_ID " +
				  "WHERE x.Event_ID = " + event.getID();
			
			rs = stmt.executeQuery(sql);
				
			while (rs.next()) {
				int userID = (rs.getString("Usr_ID").trim() != null) ? Integer.parseInt(rs.getString("Usr_ID").trim()) : -1;
				String emailAddr = (rs.getString("Email") != null) ? rs.getString("Email").trim() : "";
				String firstName = (rs.getString("First_Name") != null) ? rs.getString("First_Name").trim() : "";
				String lastName = (rs.getString("Last_Name") != null) ? rs.getString("Last_Name").trim() : "";
				String status = (rs.getString("Status") != null) ? rs.getString("Status").trim() : "";
				
				if (status.equalsIgnoreCase("H")) {
					User host = new User(userID, emailAddr, firstName, lastName, "");
					event.setHost(host);
				}
				else {
					Invitee invitee = new Invitee(userID, emailAddr, firstName, lastName, status);
					event.addInvitee(invitee);
				}
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally
		{
			if (conn != null)
				conn.close();
		}
		
		return event;	
	}
	
	public static void saveEvent(Event event) throws SQLException {
		Connection conn = null;
		
		try {
			OracleDataSource ods = new OracleDataSource();
			ods.setURL(connect_string);
			conn = ods.getConnection();		
			Statement stmt = conn.createStatement();
			String sql = "";
			
			if (event.getAction().trim().equalsIgnoreCase("A")) {
				sql = "INSERT INTO EVENT (EVENT_TYPE, TITLE, LOCATION, DATE_TIME, DESCRIPTION) " +
					  "VALUES ('" + event.getType() + "', '" + event.getTitle() + "', '" + event.getLocation() + "', '" + event.getDateTime() + "', '" + event.getDescription() + "')";
			}
			else if (event.getAction().trim().equalsIgnoreCase("E")) {
				sql = "UPDATE EVENT " +
					  "SET EVENT_TYPE = '" + event.getType() + "', " +
					  "    TITLE = '" + event.getTitle() + "', " +
					  "    LOCATION = '" + event.getLocation() + "', " +
					  "    DATE_TIME = '" + event.getDateTime() + "', " +
					  "    DESCRIPTION = '" + event.getDescription() + "' " +
					  "WHERE EVENT_ID = " + event.getID();
			}
			else if (event.getAction().trim().equalsIgnoreCase("D")) {
				sql = "DELETE EVENT " +
					  "WHERE EVENT_ID = " + event.getID() + " " +
					  "DELETE USR_EVENT " +
					  "WHERE EVENT_ID = " + event.getID();
			}
			
			if (sql.length() > 0)
				stmt.executeUpdate(sql);
			
			sql = "";
			
			if (event.getAction().trim().equalsIgnoreCase("A")) {
				sql = "SELECT MAX(Event_ID) AS Event_ID " +
					  "FROM EVENT";
				
				ResultSet rs = stmt.executeQuery(sql);
				rs.next();
				event.setID(Integer.parseInt(rs.getString("Event_ID")));
			}
			
			sql = "";
			
			if (event.getHost() != null) {
				sql = "SELECT USR_ID " + 
					  "FROM USR " +
					  "WHERE EMAIL = '" + event.getHost().getEmail().trim() + "'";
				
				ResultSet rs = stmt.executeQuery(sql);
				if (!rs.next()) {
					sql = "INSERT INTO USR (EMAIL, FIRST_NAME, LAST_NAME) " +
						  "VALUES ('" + event.getHost().getEmail() + "', '" + event.getHost().getFirstName() + "', '" + event.getHost().getLastName() + "')";
				
					stmt.executeUpdate(sql);
				}
			}
			
			sql = "";
			
			if (event.getHost().getAction().trim().equalsIgnoreCase("A")) {
				sql = "INSERT INTO USR_EVENT " +
					  "VALUES ((SELECT USR_ID FROM USR WHERE EMAIL = '" + event.getHost().getEmail() + "'), " + event.getID() + ", 'H')";
			}
			else if (event.getHost().getAction().trim().equalsIgnoreCase("D")) {
				sql = "DELETE USR_EVENT " +
					  "WHERE USR_ID = " + event.getHost().getID() +
					  "  AND EVENT_ID = " + event.getID();
			}
			
			if (sql.length() > 0)
				stmt.executeUpdate(sql);
			
			sql = "";
			
			for (Invitee invitee : event.getInvitees()) {
				sql = "SELECT USR_ID " + 
					  "FROM USR " +
					  "WHERE EMAIL = '" + invitee.getEmail().trim() + "'";
					
				ResultSet rs = stmt.executeQuery(sql);
				if (!rs.next()) {
					sql = "INSERT INTO USR (EMAIL, FIRST_NAME, LAST_NAME) " +
						  "VALUES ('" + invitee.getEmail() + "', '" + invitee.getFirstName() + "', '" + invitee.getLastName() + "')";
				
					stmt.executeUpdate(sql);
				}
				
				sql = "";
				
				if (invitee.getAction().trim().equalsIgnoreCase("A")) {
					sql = "INSERT INTO USR_EVENT " +
						  "VALUES ((SELECT USR_ID FROM USR WHERE EMAIL = '" + invitee.getEmail() + "'), " + event.getID() + ", 'I')";
				}
				else if (event.getHost().getAction().trim().equalsIgnoreCase("D")) {
					sql = "DELETE USR_EVENT " +
						  "WHERE USR_ID = " + invitee.getID() +
						  "  AND EVENT_ID = " + event.getID();
				}
				
				if (sql.length() > 0)
					stmt.executeUpdate(sql);
				
				sql = "";
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally
		{
			if (conn != null)
				conn.close();
		}
	}
	
	public static void updateStatus(String userID, String eventID, String status) throws SQLException {
		Connection conn = null;
		
		try {
			OracleDataSource ods = new OracleDataSource();
			ods.setURL(connect_string);
			conn = ods.getConnection();		
			Statement stmt = conn.createStatement();
			String sql = "UPDATE USR_EVENT " +
						 "SET Status = '" + status + "' " +
						 "WHERE USR_ID = " + userID +
						 "  AND EVENT_ID = " + eventID;
			stmt.executeUpdate(sql);
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally
		{
			if (conn != null)
				conn.close();
		}
	}
}