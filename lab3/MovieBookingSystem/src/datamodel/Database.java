package datamodel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Predicate;

import javax.naming.spi.DirStateFactory.Result;
import javax.swing.text.html.ListView;

import com.mysql.jdbc.MySQLConnection;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

/**
 * Database is a class that specifies the interface to the 
 * movie database. Uses JDBC and the MySQL Connector/J driver.
 */
public class Database {
    /** 
     * The database connection.
     */
    private Connection conn;
    private boolean isLive;
    private String currName;
    /*
     * ADDED BY ME
     */
    
    enum IV {
    	HOME(0),
    	SCHOOL(1);
    	
    	int value;
    	private IV(int i) {
    		this.value = i;
    	}
    	public int getValue() {
    		return this.value;
    	}
    }
    
    
    /*
     * ADDED BY ME ENDS 
     */
    /**
     * Create the database interface object. Connection to the database
     * is performed later.
     */
    public Database() {
        conn = null;
    }
        
    /** 
     * Open a connection to the database, using the specified user name
     * and password.
     *
     * @param userName The user name.
     * @param password The user's password.
     * @return true if the connection succeeded, false if the suppliedDriverManager.getCon
     * user name and password were not recognized. Returns false also
     * if the JDBC driver isn't found.
     */
    public boolean openConnection(String userName, String password) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/lab2?" +
            		"user=root&password=abc123"); 
            // conn = DriverManager.getConnection("jdbc:mysql://" + server[IV.HOME.getValue()] + "/lab2", usrName[IV.HOME.getValue()], pword[IV.HOME.getValue()]);
        }
        catch (SQLException e) {
            System.err.println(e);
            e.printStackTrace();
            return false;
        }
        catch (ClassNotFoundException e) {
            System.err.println(e);
            e.printStackTrace();
            return false;
        }
        return true;
    }
        

    public List<Show> grabShows() {
		List<Show> theData = null;
		java.sql.Statement stmt = null;
		
		try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM Shows");
            if(!rs.wasNull()) theData = new ArrayList<Show>();
            while (rs.next()) {
                Show current = new Show(rs.getString("movieTitle"), rs.getString("dayOfShow"), rs.getString("theaterName"), rs.getInt("freeSeats"));
                theData.add(current);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
		return theData;
    }
    
    public boolean login(String uname) {
        java.sql.Statement stmt = null;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT username FROM User WHERE username = '" + uname + "'");
            if (rs.next()) {
                currName = uname;
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Close the connection to the database.
     */
    public void closeConnection() {
        try {
            if (conn != null)
                conn.close();
        }
        catch (SQLException e) {
        	e.printStackTrace();
        }
        conn = null;
        System.err.println("Database connection closed.");
    }
        
    /**
     * Check if the connection to the database has been established
     *
     * @return true if the connection has been established
     */
    public boolean isConnected() {
        return conn != null;
    }
    
    public List<String> getTitles() {
        List<String> titles = new ArrayList<>();
        try {
            ResultSet rs = conn.createStatement().executeQuery("SELECT movieTitle FROM Shows");
            while (rs.next()) {
                titles.add(rs.getString("movieTitle"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return titles;    	
    }
    
    public List<String> getDates(String m) {
        List<String> dates = new ArrayList<>();
        try {
            ResultSet rs = conn.createStatement().executeQuery("SELECT dayOfShow FROM Shows WHERE movieTitle = '" + m +"'");
            while (rs.next()) {
                dates.add(rs.getString("dayOfShow"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dates;
    }
    
    public void makeBooking(Show s) {
    	try {
    			//update db
    			java.sql.Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        		String reserve = "select * from Reservation";
        		ResultSet rsa = stmt.executeQuery(reserve);
        		// move to insert row into Reservation 
        		rsa.moveToInsertRow();
        		rsa.updateString("username", currName);
        		rsa.updateString("movieTitle", s.getTitle());
        		rsa.updateString("dayOfShow", s.getDate());
        		rsa.updateString("theaterName", s.getVenue());
        		// commit insertion
        		rsa.insertRow();
        		
        		// update free seats
        		rsa = stmt.executeQuery("select freeSeats from Shows where movieTitle='"+s.getTitle()+"'"+" and dayOfShow='"+s.getDate() + " and theaterName='" + s.getVenue());
        		rsa.updateInt("freeSeats", s.getSeats()-1);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        	System.err.println(e.getStackTrace());
        }
    }
    
  	public Show getShowData(String mTitle, String mDate) {
		Integer mFreeSeats = null;
		String mVenue = null;
        if(isConnected()) {
        	System.out.println("We are live. biatch");
        	try {
        		String query = null;
        		query = "select movieTitle, dayOfShow, freeSeats, theaterName from Shows where movieTitle='"+mTitle + "' and " + "dayOfShow='" + mDate+"'";
    			java.sql.Statement stmta = conn.createStatement();
    			ResultSet rs = stmta.executeQuery(query);
    			//		rs.last(); // used to go "beyond" the table, therefore grab the last row
    			if(rs.next()) {
    				mVenue = rs.getString("theaterName");
        			mFreeSeats = rs.getInt("freeSeats");
        			System.out.println("Found movie showing at: " + mVenue + " at the date you given; " + rs.getString("dayOfShow"));
        			System.out.println("Remaining seats are : " + mFreeSeats);	
    			}
    		} catch (SQLException e) {
    			// TODO Auto-generated catch block
    			System.out.println(e.getMessage());
    			System.err.println(e.getStackTrace());
    		}
        }
		return new Show(mTitle, mDate, mVenue, mFreeSeats);
	}
    /* --- TODO: insert more own code here --- */
}
