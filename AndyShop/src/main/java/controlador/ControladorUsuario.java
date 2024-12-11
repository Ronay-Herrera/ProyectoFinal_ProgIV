package controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.UsuarioDAO;
import modelo.Usuario;

public class ControladorUsuario extends HttpServlet {
	
    private static final long serialVersionUID = -6007124671126957730L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Entrando en doPost");
        
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error interno: driver JDBC no encontrado.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("errorMessage", "Por favor, complete todos los campos.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        
        if (!email.matches("^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$")) {
            request.setAttribute("errorMessage", "El correo electrónico no es válido.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try (Connection connection = DriverManager.getConnection(
                "jdbc:sqlserver://localhost:1433;databaseName=SistemaCompras;encrypt=true;trustServerCertificate=true", 
                "User", "157359x")) {
            
            UsuarioDAO usuarioDAO = new UsuarioDAO(connection);
            Usuario user = usuarioDAO.authenticateUser(email, password);

            if (user != null) {
                
                HttpSession session = request.getSession(true);  
                session.setAttribute("user", user);
                session.setAttribute("id", user.getId()); 
                session.setAttribute("nombreCliente", user.getName()); 
                response.sendRedirect("productos");
                System.out.println("Sesión creada.");
            } else {
                request.setAttribute("errorMessage", "Correo o contraseña incorrectos.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Hubo un problema al procesar su solicitud. Por favor, inténtelo más tarde.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }
}
