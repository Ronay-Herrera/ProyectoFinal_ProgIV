package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.DatabaseConnection;
import modelo.Usuario;

public class UsuarioDAO {
	
	
    private Connection connection;

    public UsuarioDAO(Connection connection) {
    	try {
			this.connection = DatabaseConnection.getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }

    public Usuario authenticateUser(String email, String password) throws SQLException {
        String query = "{call sp_AutenticarUsuario(?, ?)}"; // Llamada al procedimiento almacenado
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, email);
            statement.setString(2, password); // Asegúrate de que la contraseña esté encriptada y se compare correctamente.

            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return new Usuario(
                    resultSet.getInt("id_usuario"),
                    resultSet.getString("nombre"),
                    resultSet.getString("correo"),
                    resultSet.getString("contrasena")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            connection.close();
        }
        return null;
    }
}
