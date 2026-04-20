package servlets;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import mx.unadm.grp.model.Producto;
import mx.unadm.grp.repository.ProductoRepository;

@WebServlet("/EditarProducto")
public class EditarProductoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String codigo = request.getParameter("codigo");
        Producto p = ProductoRepository.buscarPorCodigo(codigo);

        request.setAttribute("producto", p);
        request.getRequestDispatcher("/EditarProducto.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String codigo = request.getParameter("codigo");
        String nombre = request.getParameter("nombre");
        String categoria = request.getParameter("categoria");
        int garantiaMeses = Integer.parseInt(request.getParameter("garantiaMeses"));
        String manualPdf = request.getParameter("manualPdf");
        String estado = request.getParameter("estado");

        Producto actualizado = new Producto(codigo, nombre, categoria, garantiaMeses, manualPdf, estado);

        ProductoRepository.actualizarProducto(actualizado);

        response.sendRedirect("Administrador.jsp");
    }
}