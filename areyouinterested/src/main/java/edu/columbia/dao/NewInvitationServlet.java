package edu.columbia.dao;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import edu.columbia.dao.DataManager;
import edu.columbia.vo.Event;

public class NewInvitationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public NewInvitationServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Gson gson = new Gson();
		try {
			
			Event event = gson.fromJson(request.getParameter("data"), Event.class);
			if(event!= null) {
				DataManager.saveEvent(event);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		
		RequestDispatcher view = request.getRequestDispatcher("eventDetail.jsp");
		view.forward(request, response);
	}

}
