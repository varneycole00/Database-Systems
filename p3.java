import java.sql.*;
import java.util.Scanner;
public class p3
{

// Replace the "USERID" and "PASSWORD" with your CS server username and password to get this to work.
// Note: Remember that your Oracle USERID for some of you is different than your regular login name

    static String USERID = "";
    static String PASSWORD = "";
    private static String location = "";
    private static String path = "";
    private static String account = "";
    private static String updatelocation = "";
    private static String query = "";


    public static void main(String[] args)
    {
        USERID = args[0];
        PASSWORD = args[1];

        System.out.println("-------Oracle JDBC COnnection Testing ---------");
        try
        {
            Class.forName("oracle.jdbc.driver.OracleDriver");

        }
        catch (ClassNotFoundException e)
        {
            System.out.println("Where is your Oracle JDBC Driver?");
            e.printStackTrace();
            return;
        }

        System.out.println("Oracle JDBC Driver Registered!");
        Connection connection = null;

        try
        {
            connection = DriverManager.getConnection(
                    "jdbc:oracle:thin:@csorcl.cs.wpi.edu:1521:orcl", USERID, PASSWORD);
        }
        catch (SQLException e)
        {
            System.out.println("Connection Failed! Check output console");
            e.printStackTrace();
            return;
        }
        System.out.println("Oracle JDBC Driver Connected!");

        //zero based indexing gives us args 0 and 1 as username and password, arg 2 is command

        if (args.length <= 2)
        {
            System.out.println("1 - Report Location Information");
            System.out.println("2 - Report Path Information");
            System.out.println("3 - Report Staff Office Information");
            System.out.println("4 - Update Location Type");
            System.out.println("5 - Exit Program");
            return;
        }
        else if (args[2].equals("1"))
        {
            System.out.println("Enter Location ID: ");
            Scanner userInput = new Scanner(System.in);
            location = userInput.nextLine();
            query = "SELECT * From Location WHERE locationID = " + "'" + location + "'";
            // Performing the query
            try
            {
                Statement stmt = connection.createStatement();
                ResultSet rset = stmt.executeQuery(query);
                String locationID = "";
                String locationName = "";
                String locationType = "";
                int xcoord = 0;
                int ycoord = 0;
                String floor = "";
                // Process the results
                rset.next();
                    locationID = rset.getString("locationID");
                    System.out.println("Location ID: " + locationID);
                    locationName = rset.getString("locationName");
                    System.out.println("Location Name: " + locationName);
                    locationType = rset.getString("locationType");
                    System.out.println("Location Type: " + locationType);
                    xcoord = rset.getInt("xcoord");
                    System.out.println("X-Coordinate: " + xcoord);
                    ycoord = rset.getInt("ycoord");
                    System.out.println("X-Coordinate: " + ycoord);
                    floor = rset.getString("floor");
                    System.out.println("Floor: " + floor);
                 // end while

                rset.close();
                stmt.close();
                connection.close();
            }
            catch (SQLException e)
            {
                System.out.println("Get Data Failed! Check output console");
                e.printStackTrace();
                return;
            }
        }
            else if (args[2].equals("2"))
            {
                System.out.println("Enter Path ID: ");
                Scanner userInput = new Scanner(System.in);
                path = userInput.nextLine();
                query = "SELECT * From PathEdge WHERE pathID = " + "'" + path + "'";
                // Performing the query
                try
                {
                    Statement stmt = connection.createStatement();
                    ResultSet rset = stmt.executeQuery(query);
                    String startingID = "";
                    String endingID = "";
                    while(rset.next()){
                        startingID = rset.getString("startingID");
                        endingID = rset.getString("endingID");
                        System.out.println(startingID + " " + endingID);
                    }
					// end while

                    rset.close();
                    stmt.close();
                    connection.close();
                }
                catch (SQLException e)
                {
                    System.out.println("Get Data Failed! Check output console");
                    e.printStackTrace();
                    return;
                }
        }

        else if (args[2].equals("3"))
        {
            System.out.println("Enter Account Name: ");
            Scanner userInput = new Scanner(System.in);
            account = userInput.nextLine();
            query = "SELECT * From Staff S JOIN LOCATION L ON S.locationID =" +
                    " L.locationID JOIN Office O on S.locationID = O.locationID WHERE " +
                    "S.accountName = " + "'" + account + "'";
            // Performing the query
            try
            {
                Statement stmt = connection.createStatement();
                ResultSet rset = stmt.executeQuery(query);
                String accountName = "";
                String officeName = "";
                int xcoord = 0;
                int ycoord = 0;
                String floor = "";
                int maxOcc = 0;


                rset.next();
                    accountName = rset.getString("accountName");
                    System.out.println("Account Name: " + accountName);
                    officeName = rset.getString("locationID");
                    System.out.println("Office Name: " + officeName);
                    xcoord = rset.getInt("xcoord");
                    System.out.println("X-Coordinate: " + xcoord);
                    ycoord = rset.getInt("ycoord");
                    System.out.println("Y-Coordinate: " + ycoord);
                    floor = rset.getString("floor");
                    System.out.println("Floor: " + floor);
                    maxOcc = rset.getInt("maxoccupancy");
                    System.out.println("Maximum Occupancy: " + maxOcc);

                 // end while

                rset.close();
                stmt.close();
                connection.close();
            }
            catch (SQLException e)
            {
                System.out.println("Get Data Failed! Check output console");
                e.printStackTrace();
                return;
            }
        }
        else if (args[2].equals("4"))
        {

            System.out.println("Enter the Location ID: ");
            Scanner userInput = new Scanner(System.in);
            location = userInput.nextLine();
            System.out.println("Enter the updated Location Type: ");
            Scanner userInput1 = new Scanner(System.in);
            updatelocation = userInput1.nextLine();
            query = "UPDATE Location SET locationType = " + "'" + updatelocation + "'" + " WHERE " +
                    "locationID = " + "'" + location + "'";
            try
            {
                Statement stmt = connection.createStatement();
                int update = stmt.executeUpdate(query);
                stmt.close();
                System.out.println("Row has been updated successfully.");
                connection.close();
            }
            catch (SQLException e)
            {
                System.out.println("Get Data Failed! Check output console");
                e.printStackTrace();
                return;
            }
        }
        else if (args[2].equals("5"))
        {
            System.out.println("Exiting Program!");
            try
            {
                connection.close();
            }
            catch (SQLException e)
            {
                return;
            }
            return;
        }
        else // this is where we will eventually close the connection
        {
            System.out.println("Invalid argument somewhere, make sure the arguments follow the format:" +
                    "USERNAME PASSWORD ARGUMENT");
        }
        return;
    }

}

