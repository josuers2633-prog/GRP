package servlets;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import mx.unadm.grp.repository.ProductoRepository;

@WebServlet("/EliminarProducto")
public class EliminarProductoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String codigo = request.getParameter("codigo");

        ProductoRepository.eliminarProducto(codigo);

        response.sendRedirect("Administrador.jsp");
    }
}