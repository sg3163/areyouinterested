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
				Event event = new Event(Integer.parseInt(rs.getString("Event_ID")), rs.getString("Event_Type"), rs.getString("Title"), rs.getString("Location"), rs.getString("Date_Time"), rs.getString("Description"), "");
				events.add(event);
			}
			
			for (Event event : events) {
				sql = "SELECT u.Usr_ID, u.Email, u.First_Name, u.Last_Name, x.Status " +
					  "FROM Usr u " +
					  "  INNER JOIN Usr_Event x ON u.Usr_ID = x.Usr_ID " +
					  "WHERE x.Event_ID = " + event.getID();
				
				rs = stmt.executeQuery(sql);
				
				while (rs.next()) {
					if (rs.getString("Status").trim().equalsIgnoreCase("H")) {
						User host = new User(Integer.parseInt(rs.getString("Usr_ID")), rs.getString("Email"), rs.getString("First_Name"), rs.getString("Last_Name"), "");
						event.setHost(host);
					}
					else {
						Invitee invitee = new Invitee(Integer.parseInt(rs.getString("Usr_ID")), rs.getString("Email"), rs.getString("First_Name"), rs.getString("Last_Name"), rs.getString("Status"), "");
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
				Event event = new Event(Integer.parseInt(rs.getString("Event_ID")), rs.getString("Event_Type"), rs.getString("Title"), rs.getString("Location"), rs.getString("Date_Time"), rs.getString("Description"), "");
				events.add(event);
			}
			
			for (Event event : events) {
				sql = "SELECT u.Usr_ID, u.Email, u.First_Name, u.Last_Name, x.Status " +
					  "FROM Usr u " +
					  "  INNER JOIN Usr_Event x ON u.Usr_ID = x.Usr_ID " +
					  "WHERE x.Event_ID = " + event.getID();
				
				rs = stmt.executeQuery(sql);
				
				while (rs.next()) {
					if (rs.getString("Status").trim().equalsIgnoreCase("H")) {
						User host = new User(Integer.parseInt(rs.getString("Usr_ID")), rs.getString("Email"), rs.getString("First_Name"), rs.getString("Last_Name"), "");
						event.setHost(host);
					}
					else {
						Invitee invitee = new Invitee(Integer.parseInt(rs.getString("Usr_ID")), rs.getString("Email"), rs.getString("First_Name"), rs.getString("Last_Name"), rs.getString("Status"), "");
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
				Event event = new Event(Integer.parseInt(rs.getString("Event_ID")), rs.getString("Event_Type"), rs.getString("Title"), rs.getString("Location"), rs.getString("Date_Time"), rs.getString("Description"), "");
				events.add(event);
			}
			
			for (Event event : events) {
				sql = "SELECT u.Usr_ID, u.Email, u.First_Name, u.Last_Name, x.Status " +
					  "FROM Usr u " +
					  "  INNER JOIN Usr_Event x ON u.Usr_ID = x.Usr_ID " +
					  "WHERE x.Event_ID = " + event.getID();
				
				rs = stmt.executeQuery(sql);
				
				while (rs.next()) {
					if (rs.getString("Status").trim().equalsIgnoreCase("H")) {
						User host = new User(Integer.parseInt(rs.getString("Usr_ID")), rs.getString("Email"), rs.getString("First_Name"), rs.getString("Last_Name"), "");
						event.setHost(host);
					}
					else {
						Invitee invitee = new Invitee(Integer.parseInt(rs.getString("Usr_ID")), rs.getString("Email"), rs.getString("First_Name"), rs.getString("Last_Name"), rs.getString("Status"), "");
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
	
	public void saveEvent(Event event) throws SQLException {
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
				sql = "SELECT TOP 1 e.Event_ID " +
					  "FROM EVENT e " +
					  "ORDER BY Event_ID DESC";
				
				ResultSet rs = stmt.executeQuery(sql);
				rs.next();
				event.setID(rs.getInt("Event_ID"));
			}
			
			sql = "";
			
			if (event.getHost() != null) {
				sql = "IF NOT EXISTS (SELECT USR_ID FROM USR WHERE EMAIL = '" + event.getHost().getEmail() + "') THEN " +
					  "  INSERT INTO USR (EMAIL, FIRST_NAME, LAST_NAME) " +
					  "  VALUES ('" + event.getHost().getEmail() + "', " + event.getHost().getFirstName() + "' " + event.getHost().getLastName() + "') " +
					  "END IF";
				
				stmt.executeUpdate(sql);
			}
			
			sql = "";
			
			if (event.getHost().getAction().trim().equalsIgnoreCase("A")) {
				sql = "INSERT INTO USR_EVENT " +
					  "VALUES ((SELECT USR_ID FROM USR WHERE EMAIL = '" + event.getHost().getEmail() + "'), " + event.getID() + ", 'H'";
			}
			else if (event.getHost().getAction().trim().equalsIgnoreCase("D")) {
				sql = "DELETE USR_EVENT " +
					  "WHERE USR_ID = " + event.getHost().getID() + " " +
					  "  AND EVENT_ID = " + event.getID();
			}
			
			if (sql.length() > 0)
				stmt.executeUpdate(sql);
			
			sql = "";
			
			for (Invitee invitee : event.getInvitees()) {
				sql = "IF NOT EXISTS (SELECT USR_ID FROM USR WHERE EMAIL = '" + invitee.getEmail() + "') THEN " +
					  "  INSERT INTO USR (EMAIL, FIRST_NAME, LAST_NAME) " +
					  "  VALUES ('" + invitee.getEmail() + "', " + invitee.getFirstName() + "' " + invitee.getLastName() + "') " +
					  "END IF";
				
				stmt.executeUpdate(sql);
				
				sql = "";
				
				if (invitee.getAction().trim().equalsIgnoreCase("A")) {
					sql = "INSERT INTO USR_EVENT " +
						  "VALUES ((SELECT USR_ID FROM USR WHERE EMAIL = '" + invitee.getEmail() + "'), " + event.getID() + ", 'I'";
				}
				else if (event.getHost().getAction().trim().equalsIgnoreCase("D")) {
					sql = "DELETE USR_EVENT " +
						  "WHERE USR_ID = " + invitee.getID() + " " +
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
}