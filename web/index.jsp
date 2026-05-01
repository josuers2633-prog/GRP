<%-- 
    Document   : index
    Created on : 28 ene. 2026, 22:36:05
    Author     : Joshk
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="mx.unadm.grp.model.Usuario"%>

<%
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");

    if (usuarioLogueado == null) {
        response.sendRedirect("Login");
        return;
    }

    String rol = usuarioLogueado.getRol();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CTPD - Inicio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container py-5">

    <div class="mb-3 d-flex justify-content-between align-items-center">
        <span class="fw-semibold">
            Bienvenido, <%= usuarioLogueado.getNombreVisible() %> | Rol: <%= rol %>
        </span>

        <a class="btn btn-sm btn-outline-danger" href="logout">Cerrar sesión</a>
    </div>

    <div class="row justify-content-center">
        <div class="col-12 col-md-8 col-lg-6">
            <div class="card shadow-sm">
                <div class="card-body p-4">

                    <h1 class="h4 mb-2">CTPD - Sistema de gestión documental</h1>
                    <p class="text-muted mb-4">Versión web (prototipo académico)</p>

                    <div class="d-grid gap-2">

                        <!-- 🔹 BIBLIOTECA (TODOS) -->
                        <a class="btn btn-outline-primary" href="Biblioteca.jsp">
                            Biblioteca de productos
                        </a>

                        <!-- 🔹 BÚSQUEDA -->
                        <a class="btn btn-outline-primary" href="busqueda.jsp">
                            Búsqueda de productos
                        </a>

                        <!-- 🔹 GARANTÍAS -->
                        <a class="btn btn-outline-primary" href="garantias.jsp">
                            Gestión de garantías
                        </a>

                        <!-- 🔹 MANUALES -->
                        <a class="btn btn-outline-primary" href="manuales.jsp">
                            Biblioteca de manuales
                        </a>

                        <!-- 🔹 ADMIN -->
                        <% if ("ADMIN".equalsIgnoreCase(rol)) { %>
                            <a class="btn btn-danger" href="Administrador.jsp">
                                Panel de administración
                            </a>
                        <% } %>

                    </div>

                    <hr class="my-4">

                    <small class="text-muted">
                        Proyecto en desarrollo. Módulos implementados de forma incremental.
                    </small>

                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>