<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="mx.unadm.grp.model.Usuario"%>
<%@page import="mx.unadm.grp.model.Producto"%>

<%
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");

    if (usuarioLogueado == null) {
        response.sendRedirect("Login");
        return;
    }

    if (!"ADMIN".equalsIgnoreCase(usuarioLogueado.getRol())) {
        response.sendRedirect("index.jsp");
        return;
    }

    Producto producto = (Producto) request.getAttribute("producto");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar producto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container py-4">
    <h1 class="h4 mb-4">Editar producto</h1>

    <form method="post" action="EditarProducto">
        <input type="hidden" name="codigo" value="<%= producto.getCodigo() %>">

        <div class="mb-3">
            <label>Nombre</label>
            <input type="text" name="nombre" class="form-control" value="<%= producto.getNombre() %>" required>
        </div>

        <div class="mb-3">
            <label>Categoría</label>
            <input type="text" name="categoria" class="form-control" value="<%= producto.getCategoria() %>" required>
        </div>

        <div class="mb-3">
            <label>Garantía</label>
            <input type="number" name="garantiaMeses" class="form-control" value="<%= producto.getGarantiaMeses() %>" required>
        </div>

        <div class="mb-3">
            <label>Manual</label>
            <input type="text" name="manualPdf" class="form-control" value="<%= producto.getManualPdf() %>">
        </div>

        <div class="mb-3">
            <label>Estado</label>
            <select name="estado" class="form-select">
                <option <%= producto.getEstado().equals("Disponible") ? "selected" : "" %>>Disponible</option>
                <option <%= producto.getEstado().equals("Descontinuado") ? "selected" : "" %>>Descontinuado</option>
            </select>
        </div>

        <button class="btn btn-primary">Actualizar</button>
        <a href="Administrador.jsp" class="btn btn-secondary">Cancelar</a>
    </form>
</div>

</body>
</html>
