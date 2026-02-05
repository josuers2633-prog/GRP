
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="WEB-INF/head.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>CTPD - Gestión de garantías</title>



</head>
<body class="bg-light">
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h4 m-0">Gestión de garantías</h1>
        <a class="btn btn-sm btn-outline-secondary" href="index.jsp">Volver</a>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">
            <form method="post" action="garantia">
                <div class="row g-3">
                    <div class="col-12 col-md-6">
                        <label class="form-label">Código del producto</label>
                       <input class="form-control" name="codigo"
       value="<%= request.getParameter("codigo") != null ? request.getParameter("codigo") : "" %>"
       placeholder="Ej. OLLA-5P" required>

                        <div class="form-text">Para pruebas: OLLA-5P, SARTEN-8, FILTRO-01</div>
                    </div>

                    <div class="col-12 col-md-6">
                        <label class="form-label">Fecha de compra</label>
                        <input class="form-control" type="date" name="fechaCompra" required>
                    </div>

                    <div class="col-12">
                        <button class="btn btn-primary" type="submit">Calcular vigencia</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%
        String estado = (String) request.getAttribute("estado");
        if (estado != null) {
            String mensaje = (String) request.getAttribute("mensaje");
            String meses = String.valueOf(request.getAttribute("mesesGarantia"));
            String fin = (String) request.getAttribute("fechaFin");
            String diasRestantes = String.valueOf(request.getAttribute("diasRestantes"));
            String alertClass = "Vigente".equalsIgnoreCase(estado) ? "alert-success" : "alert-danger";
    %>
    <div class="alert <%=alertClass%> mt-3" role="alert">
        <div class="fw-semibold">Estado: <%=estado%></div>
        <div><%=mensaje%></div>
        <div class="mt-2 small">
            <div><b>Garantía (meses):</b> <%=meses%></div>
            <div><b>Fecha fin:</b> <%=fin%></div>
            <div><b>Días restantes:</b> <%=diasRestantes%></div>
        </div>
    </div>
        <%
    String notaExcepcion = (String) request.getAttribute("notaExcepcion");
    Object diasVencidaObj = request.getAttribute("diasVencida");

    if (notaExcepcion != null && diasVencidaObj != null) {
        long diasVencida = (long) diasVencidaObj;
%>
<div class="alert alert-warning mt-3" role="alert">
    <div class="fw-semibold">Nota de excepción</div>
    <div><%= notaExcepcion %></div>
    <div class="small mt-2"><b>Días desde vencimiento:</b> <%= diasVencida %></div>
</div>
<%
    }
%>

    <%
        }
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
    <div class="alert alert-warning mt-3" role="alert">
        <b>Error:</b> <%=error%>
    </div>
    <%
        }
    %>
</div>
</body>
</html>
