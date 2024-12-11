package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
	
	
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=SistemaCompras;encrypt=true;trustServerCertificate=true";
    private static final String USER = "User";
    private static final String PASSWORD = "157359x";

    public static Connection getConnection() throws SQLException {
    	
    	try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            System.out.println("Error: No se encontró el driver JDBC");
            e.printStackTrace();
        }
    	
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
