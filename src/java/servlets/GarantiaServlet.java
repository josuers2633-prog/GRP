
package servlets;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "GarantiaServlet", urlPatterns = {"/garantia"})
public class GarantiaServlet extends HttpServlet {

    // "Catálogo" mínimo en memoria: código -> meses de garantía
    private static final Map<String, Integer> GARANTIA_MESES = new HashMap<>();
    static {
        GARANTIA_MESES.put("OLLA-5P", 24);
        GARANTIA_MESES.put("SARTEN-8", 12);
        GARANTIA_MESES.put("FILTRO-01", 6);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String codigo = safeTrimUpper(request.getParameter("codigo"));
        String fechaCompraStr = safeTrim(request.getParameter("fechaCompra"));

        if (codigo.isEmpty() || fechaCompraStr.isEmpty()) {
            request.setAttribute("error", "Debe proporcionar código del producto y fecha de compra.");
            request.getRequestDispatcher("/garantias.jsp").forward(request, response);
            return;
        }

        Integer mesesGarantia = GARANTIA_MESES.get(codigo);
        if (mesesGarantia == null) {
            request.setAttribute("error", "Producto no encontrado. Pruebe con: OLLA-5P, SARTEN-8, FILTRO-01.");
            request.getRequestDispatcher("/garantias.jsp").forward(request, response);
            return;
        }

        LocalDate fechaCompra;
        try {
            fechaCompra = LocalDate.parse(fechaCompraStr);
        } catch (DateTimeParseException ex) {
            request.setAttribute("error", "La fecha de compra no tiene un formato válido.");
            request.getRequestDispatcher("/garantias.jsp").forward(request, response);
            return;
        }

        LocalDate fechaFin = fechaCompra.plusMonths(mesesGarantia);
        LocalDate hoy = LocalDate.now();

        long diasRestantes = ChronoUnit.DAYS.between(hoy, fechaFin);

        String estado;
        String mensaje;
        if (diasRestantes >= 0) {
            estado = "Vigente";
            mensaje = "La garantía se encuentra vigente para el producto " + codigo + ".";
        } else {
            estado = "Expirada";
            mensaje = "La garantía se encuentra expirada para el producto " + codigo + ".";
        }
        
        if (diasRestantes < 0) {
    long diasVencida = Math.abs(diasRestantes);

    String notaExcepcion;
    if (diasVencida <= 90) {
        notaExcepcion = "Se puede gestionar por excepción dentro de los 90 días posteriores al vencimiento.";
    } else {
        notaExcepcion = "No aplica excepción (supera los 90 días posteriores al vencimiento).";
    }

    request.setAttribute("notaExcepcion", notaExcepcion);
    request.setAttribute("diasVencida", diasVencida);
}


        request.setAttribute("estado", estado);
        request.setAttribute("mensaje", mensaje);
        request.setAttribute("mesesGarantia", mesesGarantia);
        request.setAttribute("fechaFin", fechaFin.toString());
        request.setAttribute("diasRestantes", diasRestantes);

        request.getRequestDispatcher("/garantias.jsp").forward(request, response);
    }

    private static String safeTrim(String s) {
        return s == null ? "" : s.trim();
    }

    private static String safeTrimUpper(String s) {
        return safeTrim(s).toUpperCase();
    }
}
