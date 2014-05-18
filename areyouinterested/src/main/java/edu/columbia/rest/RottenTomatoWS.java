package edu.columbia.rest;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Response;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@Path("/rottentomato")
public class RottenTomatoWS {

	@GET
	@Path("/api")
	public Response savePayment(@QueryParam("q") String query) {
		
		StringBuilder builder = new StringBuilder();
		try {
			String urlStr = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?q=" + query + "&page_limit=10&apikey=s6psksgf6nn43x8hqv2yefnb";
			URL url = new URL(urlStr);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Accept", "application/json");
	 
			if (conn.getResponseCode() != 200) {
				throw new RuntimeException("Failed : HTTP error code : "
						+ conn.getResponseCode());
			}
	 
			BufferedReader br = new BufferedReader(new InputStreamReader(
				(conn.getInputStream())));
	 
			String output;
			
			System.out.println("Output from Server .... \n");
			while ((output = br.readLine()) != null) {
				builder.append(output);
				System.out.println(output);
			}
	 
			conn.disconnect();
	 
		  } catch (MalformedURLException e) {
	 
			e.printStackTrace();
	 
		  } catch (IOException e) {
	 
			e.printStackTrace();
	 
		  }
	
		return Response.status(200).entity(builder.toString()).build();

	}

}