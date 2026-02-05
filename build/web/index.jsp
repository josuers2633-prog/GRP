<%-- 
    Document   : index
    Created on : 28 ene. 2026, 22:36:05
    Author     : Joshk
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    CTPD - Inicio

    <!-- Bootstrap por CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-12 col-md-8 col-lg-6">
            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <h1 class="h4 mb-2">CTPD - Sistema de gestión documental</h1>
                    <p class="text-muted mb-4">Versión web (prototipo académico)</p>

                    <div class="d-grid gap-2">
                        <a class="btn btn-primary" href="garantias.jsp">Gestión de garantías</a>
                        <a class="btn btn-outline-primary" href="busqueda.jsp">Búsqueda de productos</a>
                        <a class="btn btn-outline-primary" href="manuales.jsp">Biblioteca de manuales</a>
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
