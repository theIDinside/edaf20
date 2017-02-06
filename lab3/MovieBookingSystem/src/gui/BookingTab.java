package gui;

import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.control.Button;
import javafx.scene.text.Text;

import java.util.List;

import datamodel.CurrentUser;
import datamodel.Database;
import datamodel.Show;

import java.util.ArrayList;


public class BookingTab {
	// top context message
	@FXML private Text topContext;
	// bottom message
	@FXML private Text bookMsg;
	
	// table references
	@FXML private ListView<String> moviesList;
	@FXML private ListView<String> datesList;
	
	// show info references
	@FXML private Label showTitle;
	@FXML private Label showDate;
	@FXML private Label showVenue;
	@FXML private Label showFreeSeats;
	
	// booking button
	@FXML private Button bookTicket;
	
	private Database db;
	private Show crtShow = new Show();
	
	@SuppressWarnings({ "unchecked", "restriction" })
	public void initialize() {
		System.out.println("Initializing BookingTab");
				
		fillNamesList();
		fillDatesList(null);
		fillShow(null,null);
		// set up listeners for the movie list selection
		moviesList.getSelectionModel().selectedItemProperty().addListener(
				(obs, oldV, newV) -> {
					// need to update the date list according to the selected movie
					// update also the details on the right panel
					String movie = newV;
					fillDatesList(newV);
					fillShow(movie,null);
				});
		
		// set up listeners for the date list selection
		datesList.getSelectionModel().selectedItemProperty().addListener(
				(obs, oldV, newV) -> {
					// need to update the details according to the selected date
					String movie = moviesList.getSelectionModel().getSelectedItem();
					String date = newV;
				    fillShow(movie, date);
				});

		// set up booking button listener
		// one can either use this method (setup a handler in initialize)
		// or directly give a handler name in the fxml, as in the LoginTab class
		bookTicket.setOnAction(
				(event) -> {
					String movie = moviesList.getSelectionModel().getSelectedItem();
					String date = datesList.getSelectionModel().getSelectedItem();
					System.out.println("Movie: " + movie + " date: " + date);
					Show s = db.getShowData(movie, date);
					int ticket = 0;
					if(!(s.getSeats() <= 0)) 
						ticket = db.makeBooking(s);
					else { 
						System.out.println("No seats left!");
					}
					report("Booked one ticket to "+movie+" on "+date +" \n with booking number: " + ticket);
				});
		
		report("Ready.");
	}
	
	// helpers	
	// updates user display
	private void fillStatus(String usr) {
		if(usr.isEmpty()) topContext.setText("You must log in as a known user!");
		else topContext.setText("Currently logged in as " + usr);
	}
	
	private void report(String msg) {
		bookMsg.setText(msg);
	}
	
	public void setDatabase(Database db) {
		this.db = db;
	}
	
	public boolean dbSet() {
		return this.db != null;
	}
	
	private void fillNamesList() {
		List<String> allmovies = new ArrayList<String>();
		ArrayList<Show> allData = null;
		// query the database via db
		/* --- TODO: replace with own code --- */
		if(dbSet()) {
			allmovies = db.getTitles();
		}
		moviesList.setItems(FXCollections.observableList(allmovies));
		// remove any selection
		moviesList.getSelectionModel().clearSelection();
	}

	private void fillDatesList(String m) {
        List<String> alldates = new ArrayList<String>();
        if(m!=null) {
            alldates = db.getDates(m);
        }
        datesList.setItems(FXCollections.observableList(alldates));
        // remove any selection
        datesList.getSelectionModel().clearSelection();
    }

	
	private void fillShow(String movie, String date) {
		if(movie==null) // no movie selected
			crtShow = new Show();
		else if(date==null) // no date selected yet
			crtShow = new Show(movie);
		else // query the database via db
			crtShow = db.getShowData(movie, date);
		
		showTitle.setText(crtShow.getTitle());
		showDate.setText(crtShow.getDate());
		showVenue.setText(crtShow.getVenue());
		if(crtShow.getSeats() >= 0) showFreeSeats.setText(crtShow.getSeats().toString());
		else showFreeSeats.setText("-");
	}
	
	// called in case the user logged in changed
	public void userChanged() {
		fillStatus(CurrentUser.instance().getCurrentUserId());
		fillNamesList();
		fillDatesList(null);
		fillShow(null,null);
	}
	
}
