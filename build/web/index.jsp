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

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-5">

    <!-- Bienvenida -->
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

                        <% if ("ADMIN".equalsIgnoreCase(rol)) { %>
                            <a class="btn btn-primary" href="Administrador.jsp">Catálogo de productos</a>
                        <% } %>

                        <% if ("ADMIN".equalsIgnoreCase(rol) || "SUPERVISOR".equalsIgnoreCase(rol) || "AGENTE".equalsIgnoreCase(rol)) { %>
                            <a class="btn btn-outline-primary" href="busqueda.jsp">Búsqueda de productos</a>
                        <% } %>

                        <% if ("ADMIN".equalsIgnoreCase(rol) || "SUPERVISOR".equalsIgnoreCase(rol) || "AGENTE".equalsIgnoreCase(rol)) { %>
                            <a class="btn btn-outline-primary" href="garantias.jsp">Gestión de garantías</a>
                        <% } %>

                        <% if ("ADMIN".equalsIgnoreCase(rol) || "SUPERVISOR".equalsIgnoreCase(rol) || "AGENTE".equalsIgnoreCase(rol)) { %>
                            <a class="btn btn-outline-primary" href="manuales.jsp">Biblioteca de manuales</a>
                        <% } %>

                        <% if ("ADMIN".equalsIgnoreCase(rol)) { %>
                            <a class="btn btn-outline-danger" href="Usuario.jsp">Administración de usuarios</a>
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