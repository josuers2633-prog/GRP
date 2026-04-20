<%-- 
    Document   : Administrador
    Created on : 13 feb. 2026, 16:21:46
    Author     : Joshk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="mx.unadm.grp.model.Usuario"%>
<%@page import="mx.unadm.grp.model.Producto"%>
<%@page import="mx.unadm.grp.repository.ProductoRepository"%>

<%
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");

    if (usuarioLogueado == null) {
        response.sendRedirect("Login");
        return;
    }

    String rol = usuarioLogueado.getRol();

    if (!"ADMIN".equalsIgnoreCase(rol)) {
        response.sendRedirect("index.jsp");
        return;
    }

    List<Producto> productos = ProductoRepository.getAll();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Administración de productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="h4 m-0">Administración de productos</h1>
        <a class="btn btn-outline-secondary btn-sm" href="index.jsp">Volver</a>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h2 class="h5 m-0">Catálogo actual</h2>
                <a class="btn btn-primary btn-sm" href="RegistrarProducto">Registrar producto</a>
            </div>

            <div class="table-responsive">
                <table class="table table-striped table-bordered align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Código</th>
                            <th>Nombre</th>
                            <th>Categoría</th>
                            <th>Estado</th>
                            <th>Garantía (meses)</th>
                            <th>Manual</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% for (Producto p : productos) { %>
                        <tr>
                            <td><%= p.getCodigo() %></td>
                            <td><%= p.getNombre() %></td>
                            <td><%= p.getCategoria() %></td>
                            <td><%= p.getEstado() %></td>
                            <td><%= p.getGarantiaMeses() %></td>
                            <td><%= p.getManualPdf() %></td>
                            <td>
                               <a class="btn btn-sm btn-outline-primary" href="EditarProducto?codigo=<%= p.getCodigo() %>">Editar</a>
                               <a class="btn btn-sm btn-outline-danger"
   href="EliminarProducto?codigo=<%= p.getCodigo() %>"
   onclick="return confirm('¿Eliminar este producto?');">
   Eliminar
</a>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
</div>

</body>
</html>