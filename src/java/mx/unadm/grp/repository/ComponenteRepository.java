package mx.unadm.grp.repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import mx.unadm.grp.model.Componente;

public class ComponenteRepository {

    private static final Map<String, List<Componente>> componentesPorProducto = new HashMap<>();

    static {
        // ======================
        // OLLAS
        // ======================
        List<Componente> olla4 = new ArrayList<>();
        olla4.add(new Componente("Olla", 1, "RP-OLLA-4QT"));
        olla4.add(new Componente("Tapa", 1, "RP-TAPA-4QT"));
        olla4.add(new Componente("Válvula", 1, "RP-VALV-01"));
        componentesPorProducto.put("OLLA-4QT", olla4);

        List<Componente> olla8 = new ArrayList<>();
        olla8.add(new Componente("Olla", 1, "RP-OLLA-8QT"));
        olla8.add(new Componente("Tapa", 1, "RP-TAPA-8QT"));
        olla8.add(new Componente("Válvula", 1, "RP-VALV-01"));
        componentesPorProducto.put("OLLA-8QT", olla8);

        // ======================
        // SARTENES
        // ======================
        List<Componente> sarten8 = new ArrayList<>();
        sarten8.add(new Componente("Sartén", 1, "RP-SART-8"));
        sarten8.add(new Componente("Mango", 1, "RP-MANGO-01"));
        componentesPorProducto.put("SARTEN-8", sarten8);

        List<Componente> sarten10 = new ArrayList<>();
        sarten10.add(new Componente("Sartén", 1, "RP-SART-10"));
        sarten10.add(new Componente("Mango", 1, "RP-MANGO-01"));
        componentesPorProducto.put("SARTEN-10", sarten10);

        // ======================
        // CUCHILLOS
        // ======================
        List<Componente> cuchillo5 = new ArrayList<>();
        cuchillo5.add(new Componente("Cuchillo 5 pulgadas", 1, "RP-CUCH-5"));
        componentesPorProducto.put("CUCHILLO-5", cuchillo5);

        List<Componente> cuchillo7 = new ArrayList<>();
        cuchillo7.add(new Componente("Cuchillo 7 pulgadas", 1, "RP-CUCH-7"));
        componentesPorProducto.put("CUCHILLO-7", cuchillo7);
    }

    public static List<Componente> obtenerComponentes(String codigoProducto) {
        return componentesPorProducto.get(codigoProducto);
    }
}
