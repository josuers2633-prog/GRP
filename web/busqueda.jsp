<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="mx.unadm.grp.model.Producto"%>

<!DOCTYPE html>
<html>
<head>
    <title>CTPD - Búsqueda de productos</title>
    <%@include file="WEB-INF/head.jsp" %>
</head>
<body class="bg-light">
<div class="container py-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h4 m-0">Búsqueda de productos / códigos</h1>
        <a class="btn btn-sm btn-outline-secondary" href="index.jsp">Volver</a>
    </div>

<%
    // --- leer selections desde attribute o parameter ---
    String catSel = (String) request.getAttribute("categoria");
    if (catSel == null) catSel = request.getParameter("categoria");
    if (catSel == null) catSel = "";

    String ordSel = (String) request.getAttribute("orden");
    if (ordSel == null) ordSel = request.getParameter("orden");
    if (ordSel == null || ordSel.isEmpty()) ordSel = "nombre";

    String qSel = (String) request.getAttribute("q");
    if (qSel == null) qSel = request.getParameter("q");
    if (qSel == null) qSel = "";

    String estSel = (String) request.getAttribute("estado");
    if (estSel == null) estSel = request.getParameter("estado");
    if (estSel == null) estSel = "";

    String vigSel = (String) request.getAttribute("vigencia");
    if (vigSel == null) vigSel = request.getParameter("vigencia");
    if (vigSel == null) vigSel = "";

    Integer pageNum = (Integer) request.getAttribute("page");
    Integer totalPages = (Integer) request.getAttribute("totalPages");
    Integer total = (Integer) request.getAttribute("total");
    if (pageNum == null) pageNum = 1;
    if (totalPages == null) totalPages = 1;
    if (total == null) total = 0;
%>

    <div class="card shadow-sm mb-3">
        <div class="card-body">

            <form method="get" action="busqueda">
                <div class="row g-3">

                    <div class="col-12 col-md-6">
                        <label class="form-label">Texto (nombre o código)</label>
                        <input class="form-control" name="q"
                               value="<%= qSel %>"
                               placeholder="Ej. olla, sartén, cuchillo, OLLA-4QT">
                    </div>

                    <div class="col-12 col-md-4">
                        <label class="form-label">Categoría</label>
                        <select class="form-select" name="categoria">
                            <option value="" <%= catSel.isEmpty() ? "selected" : "" %>>Todas</option>
                            <option value="Ollas" <%= "Ollas".equalsIgnoreCase(catSel) ? "selected" : "" %>>Ollas</option>
                            <option value="Sartenes" <%= "Sartenes".equalsIgnoreCase(catSel) ? "selected" : "" %>>Sartenes</option>
                            <option value="Cuchillería" <%= "Cuchillería".equalsIgnoreCase(catSel) ? "selected" : "" %>>Cuchillería</option>
                        </select>
                    </div>

                    <div class="col-12 col-md-2 d-flex align-items-end">
                        <button class="btn btn-primary w-100" type="submit">Buscar</button>
                    </div>

                    <div class="col-12 col-md-4">
                        <label class="form-label">Estado</label>
                        <select class="form-select" name="estado">
                            <option value="" <%= estSel.isEmpty() ? "selected" : "" %>>Todos</option>
                            <option value="Disponible" <%= "Disponible".equalsIgnoreCase(estSel) ? "selected" : "" %>>Disponible</option>
                            <option value="Descontinuado" <%= "Descontinuado".equalsIgnoreCase(estSel) ? "selected" : "" %>>Descontinuado</option>
                        </select>
                    </div>

                    <div class="col-12 col-md-4">
                        <label class="form-label">Vigencia de garantía</label>
                        <select class="form-select" name="vigencia">
                            <option value="" <%= vigSel.isEmpty() ? "selected" : "" %>>Todas</option>
                            <option value="con" <%= "con".equalsIgnoreCase(vigSel) ? "selected" : "" %>>Con garantía</option>
                            <option value="sin" <%= "sin".equalsIgnoreCase(vigSel) ? "selected" : "" %>>Sin garantía</option>
                        </select>
                    </div>

                    <div class="col-12 col-md-4">
                        <label class="form-label">Ordenar por</label>
                        <select class="form-select" name="orden">
                            <option value="nombre" <%= "nombre".equalsIgnoreCase(ordSel) ? "selected" : "" %>>Nombre (A–Z)</option>
                            <option value="codigo" <%= "codigo".equalsIgnoreCase(ordSel) ? "selected" : "" %>>Código (A–Z)</option>
                            <option value="categoria" <%= "categoria".equalsIgnoreCase(ordSel) ? "selected" : "" %>>Categoría (A–Z)</option>
                        </select>
                    </div>

                </div>
            </form>

            <div class="d-flex justify-content-between align-items-center mt-3">
                <div class="small text-muted">
                    Mostrando página <%= pageNum %> de <%= totalPages %> (total: <%= total %>)
                </div>

                <nav>
                    <ul class="pagination pagination-sm mb-0">
                        <li class="page-item <%= (pageNum <= 1) ? "disabled" : "" %>">
                            <a class="page-link"
                               href="busqueda?q=<%= qSel %>&categoria=<%= catSel %>&orden=<%= ordSel %>&estado=<%= estSel %>&vigencia=<%= vigSel %>&page=<%= pageNum - 1 %>">
                                Anterior
                            </a>
                        </li>

                        <li class="page-item <%= (pageNum >= totalPages) ? "disabled" : "" %>">
                            <a class="page-link"
                               href="busqueda?q=<%= qSel %>&categoria=<%= catSel %>&orden=<%= ordSel %>&estado=<%= estSel %>&vigencia=<%= vigSel %>&page=<%= pageNum + 1 %>">
                                Siguiente
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>

        </div>
    </div>

<%
    String error = (String) request.getAttribute("error");
    if (error != null) {
%>
    <div class="alert alert-warning"><b>Error:</b> <%= error %></div>
<%
    }

    List<Producto> resultados = (List<Producto>) request.getAttribute("resultados");
    if (resultados != null) {
%>
    <div class="card shadow-sm">
        <div class="card-body">

            <div class="d-flex justify-content-between align-items-center mb-2">
                <div class="fw-semibold">Resultados: <%= resultados.size() %></div>
            </div>

            <div class="table-responsive">
                <table class="table table-sm table-striped align-middle">
                    <thead>
                        <tr>
                            <th>Código</th>
                            <th>Nombre</th>
                            <th>Categoría</th>
                            <th>Garantía (meses)</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        for (Producto p : resultados) {
                    %>
                        <tr>
                            <td><%= p.getCodigo() %></td>
                            <td><%= p.getNombre() %></td>
                            <td><%= p.getCategoria() %></td>
                            <td><%= p.getGarantiaMeses() %></td>
                            <td class="text-end">
                                <a class="btn btn-sm btn-outline-primary"
                                   href="detalle.jsp?codigo=<%= p.getCodigo() %>&q=<%= qSel %>&categoria=<%= catSel %>&orden=<%= ordSel %>&estado=<%= estSel %>&vigencia=<%= vigSel %>&page=<%= pageNum %>">
                                    Ver detalle
                                </a>
                            </td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
<%
    }
%>

</div>
</body>
</html>
