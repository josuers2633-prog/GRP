package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import mx.unadm.grp.model.Usuario;
import mx.unadm.grp.repository.UsuarioRepository;

@WebServlet(name = "LoginServlet", urlPatterns = {"/Login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        Usuario u = UsuarioRepository.validarCredenciales(usuario, contrasena);

        if (u != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", u);
            response.sendRedirect("index.jsp");
        } else {
            request.setAttribute("error", "Usuario, contraseña o estado no válido.");
            request.getRequestDispatcher("/Login.jsp").forward(request, response);
        }
    }
}
