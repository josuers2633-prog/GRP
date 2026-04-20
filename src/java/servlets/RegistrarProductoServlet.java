/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import mx.unadm.grp.model.Producto;
import mx.unadm.grp.repository.ProductoRepository;

@WebServlet(name = "RegistrarProductoServlet", urlPatterns = {"/RegistrarProducto"})
public class RegistrarProductoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/RegistrarProducto.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String codigo = request.getParameter("codigo");
            String nombre = request.getParameter("nombre");
            String categoria = request.getParameter("categoria");
            int garantiaMeses = Integer.parseInt(request.getParameter("garantiaMeses"));
            String manualPdf = request.getParameter("manualPdf");
            String estado = request.getParameter("estado");

            Producto nuevo = new Producto(codigo, nombre, categoria, garantiaMeses, manualPdf, estado);
            ProductoRepository.addProducto(nuevo);

            response.sendRedirect("Administrador.jsp");

        } catch (Exception e) {
            request.setAttribute("error", "Error al registrar producto");
            request.getRequestDispatcher("/RegistrarProducto.jsp").forward(request, response);
        }
    }
}
