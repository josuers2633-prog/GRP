<%-- 
    Document   : Biblioteca
    Created on : 13 feb. 2026, 16:21:05
    Author     : Joshk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="mx.unadm.grp.model.Producto"%>
<%@page import="mx.unadm.grp.repository.ProductoRepository"%>

<%
    List<Producto> productos = ProductoRepository.getAll();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Biblioteca de productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container py-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="h4 m-0">Biblioteca de productos</h1>
        <a class="btn btn-outline-secondary btn-sm" href="index.jsp">Volver</a>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">

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