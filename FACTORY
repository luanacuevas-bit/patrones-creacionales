"""
============================================================
 PATRÓN FACTORY METHOD - Implementación en Python
 Semana 4-5 | Patrones Creacionales
 Lenguajes de POO II - UNA Puno
============================================================

 TEORÍA:
 Factory Method centraliza la creación de objetos en un
 único lugar. El cliente solicita un objeto por tipo sin
 conocer la clase concreta que se instanciará.
 Esto desacopla la lógica de creación de la lógica de uso,
 cumpliendo el principio Abierto/Cerrado (OCP de SOLID):
 se pueden agregar nuevos tipos SIN modificar la Factory.

 CASOS DE USO REALES:
 - Django ORM: `Model.objects.create()`
 - Frameworks de UI: creación de widgets por tipo
 - Drivers de base de datos: conexión según motor (MySQL, Postgres...)

 DIAGRAMA UML (texto):

       <<abstract>>
      +-------------+
      |  Transporte |
      +-------------+
      | + entregar()|  <-- método abstracto
      +------+------+
             |
    +--------+----------+----------+
    |        |                     |
+--------+ +-------+         +-----------+
| Camion | | Barco |         |   Avion   |
+--------+ +-------+         +-----------+
|entregar| |entregar|         |  entregar |
+--------+ +-------+         +-----------+
                   ^
                   |
          +------------------+
          | TransporteFactory|
          +------------------+
          | +get(tipo:str)   |  <-- método estático
          +------------------+

============================================================
"""

from abc import ABC, abstractmethod


# ============================================================
#  CLASE BASE ABSTRACTA
#  Define el contrato que todas las subclases deben cumplir
# ============================================================
class Transporte(ABC):
    """Interfaz abstracta para todos los medios de transporte."""

    @abstractmethod
    def entregar(self) -> str:
        """Retorna una descripción de la entrega."""
        pass

    @abstractmethod
    def tiempo_estimado(self) -> str:
        """Retorna el tiempo estimado de entrega."""
        pass

    @abstractmethod
    def costo_base(self) -> float:
        """Retorna el costo base del transporte en soles."""
        pass

    def resumen(self) -> str:
        """Método concreto compartido: genera un resumen completo."""
        return (
            f"  Método   : {self.entregar()}\n"
            f"  Tiempo   : {self.tiempo_estimado()}\n"
            f"  Costo    : S/. {self.costo_base():.2f}"
        )


# ============================================================
#  CLASES CONCRETAS (productos)
# ============================================================

class Camion(Transporte):
    """Transporte terrestre por carretera."""

    def entregar(self) -> str:
        return "Entrega por carretera en camión"

    def tiempo_estimado(self) -> str:
        return "2 a 5 días"

    def costo_base(self) -> float:
        return 120.00


class Barco(Transporte):
    """Transporte marítimo para cargas pesadas."""

    def entregar(self) -> str:
        return "Entrega por vía marítima en barco"

    def tiempo_estimado(self) -> str:
        return "15 a 30 días"

    def costo_base(self) -> float:
        return 450.00


class Avion(Transporte):
    """Transporte aéreo para entregas urgentes."""

    def entregar(self) -> str:
        return "Entrega urgente por vía aérea"

    def tiempo_estimado(self) -> str:
        return "1 a 2 días"

    def costo_base(self) -> float:
        return 980.00


class Drone(Transporte):
    """Transporte por dron para zonas urbanas (innovación)."""

    def entregar(self) -> str:
        return "Entrega automatizada por dron"

    def tiempo_estimado(self) -> str:
        return "30 minutos a 2 horas"

    def costo_base(self) -> float:
        return 25.00


# ============================================================
#  CLASE FACTORY
#  Centraliza la lógica de creación de objetos Transporte
# ============================================================
class TransporteFactory:
    """
    Factory que crea instancias de Transporte según el tipo solicitado.
    El cliente solo necesita conocer esta clase, no las clases concretas.
    """

    # Catálogo de tipos disponibles (fácil de extender)
    _tipos_disponibles = {
        "camion": Camion,
        "barco":  Barco,
        "avion":  Avion,
        "drone":  Drone,
    }

    @staticmethod
    def get_transporte(tipo: str) -> Transporte:
        """
        Retorna una instancia del transporte solicitado.

        Args:
            tipo (str): Tipo de transporte ('camion', 'barco', 'avion', 'drone').

        Returns:
            Transporte: Instancia concreta del transporte.

        Raises:
            ValueError: Si el tipo no existe en el catálogo.
        """
        tipo_normalizado = tipo.lower().strip()

        if tipo_normalizado not in TransporteFactory._tipos_disponibles:
            tipos_validos = list(TransporteFactory._tipos_disponibles.keys())
            raise ValueError(
                f"Tipo de transporte '{tipo}' no reconocido.\n"
                f"Tipos disponibles: {tipos_validos}"
            )

        # Instancia la clase concreta correspondiente
        clase = TransporteFactory._tipos_disponibles[tipo_normalizado]
        return clase()

    @staticmethod
    def listar_tipos() -> list:
        """Retorna la lista de tipos disponibles."""
        return list(TransporteFactory._tipos_disponibles.keys())


# ============================================================
#  DEMOSTRACIÓN EN CONSOLA
# ============================================================
def main():
    print("=" * 55)
    print("  DEMO: Patrón Factory Method en Python")
    print("=" * 55)

    # ---- Mostrar tipos disponibles ----
    print(f"\nTipos de transporte disponibles: {TransporteFactory.listar_tipos()}\n")

    # ---- Crear y usar cada tipo de transporte ----
    tipos_a_probar = ["camion", "barco", "avion", "drone"]

    for tipo in tipos_a_probar:
        print(f"[Factory] Creando transporte tipo: '{tipo}'")
        t = TransporteFactory.get_transporte(tipo)
        print(t.resumen())
        print()

    # ---- Prueba de manejo de error ----
    print("-" * 55)
    print("PRUEBA DE ERROR: solicitando tipo inexistente 'tren'")
    print("-" * 55)
    try:
        t_invalido = TransporteFactory.get_transporte("tren")
    except ValueError as e:
        print(f"[ERROR capturado correctamente]\n{e}\n")

    # ---- Prueba de polimorfismo ----
    print("-" * 55)
    print("PRUEBA DE POLIMORFISMO: lista de transportes")
    print("-" * 55)
    pedidos = [
        ("camion", "Puno → Arequipa"),
        ("avion",  "Lima → Cusco (urgente)"),
        ("drone",  "Miraflores → San Isidro"),
    ]

    for tipo, ruta in pedidos:
        t = TransporteFactory.get_transporte(tipo)
        print(f"  Ruta: {ruta}")
        print(f"    → {t.entregar()} | {t.tiempo_estimado()} | S/. {t.costo_base():.2f}")
    print()


if __name__ == "__main__":
    main()
