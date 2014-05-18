package edu.columbia.dao;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.columbia.dao.DataManager;

public class UpdateStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UpdateStatusServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			if (request.getParameter("buttonName").trim().equalsIgnoreCase("accept")) {
				DataManager.updateStatus(request.getParameter("UserID"), request.getParameter("EventID"), "A");
			}
			else if (request.getParameter("buttonName").trim().equalsIgnoreCase("reject")) {
				DataManager.updateStatus(request.getParameter("UserID"), request.getParameter("EventID"), "R");
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		
		RequestDispatcher view = request.getRequestDispatcher("index.jsp");
		view.forward(request, response);
	}

}
