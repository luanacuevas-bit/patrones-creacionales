"""
============================================================
 PATRÓN BUILDER - Implementación en Python
 Semana 4-5 | Patrones Creacionales
 Combo de Fast Food
 Lenguajes de POO II - UNA Puno
============================================================

 TEORÍA:
 Builder separa la CONSTRUCCIÓN de un objeto complejo de su
 REPRESENTACIÓN, de modo que el mismo proceso de construcción
 puede crear diferentes representaciones.

 ¿POR QUÉ ES ÚTIL Builder?
 Sin Builder, para crear un combo deberías pasar todos los
 parámetros al constructor de una sola vez:
     Combo("BigBurger", "grande", "Coca-Cola", "500ml",
           "papas medianas", True, True, 3.90)
 Esto es difícil de leer, propenso a errores y poco flexible.

 Con Builder, cada paso es claro, legible y encadenable:
     ComboBuilder().set_hamburguesa("BigBurger").set_bebida(...)
                   .set_papas(...).build()

 CASOS DE USO REALES:
 - Construcción de queries SQL complejas
 - Generación de documentos PDF con múltiples secciones
 - Configuración de objetos con decenas de parámetros opcionales
 - SDKs de APIs (ej: boto3 de AWS)

 DIAGRAMA UML (texto):

   +----------------------+          +-------------------+
   |        Combo         |          |    ComboBuilder   |
   +----------------------+  crea    +-------------------+
   | - hamburguesa: str   | <------- | - combo: Combo    |
   | - tamanio_h: str     |          +-------------------+
   | - bebida: str        |          | +set_hamburguesa() |
   | - tamanio_b: str     |          | +set_bebida()      |
   | - papas: str         |          | +set_papas()       |
   | - tamanio_p: str     |          | +agregar_postre()  |
   | - postre: str        |          | +agregar_salsa()   |
   | - salsas: list       |          | +con_juguete()     |
   | - juguete: bool      |          | +build()           |
   | - precio_total: float|          +-------------------+
   +----------------------+
   | + mostrar()          |
   | + precio_formateado()|
   +----------------------+

============================================================
"""


# ============================================================
#  PRODUCTO: Combo
#  El objeto complejo que queremos construir
# ============================================================
class Combo:
    """
    Representa un combo de fast food con múltiples componentes opcionales.
    No debe instanciarse directamente; usar ComboBuilder.
    """

    def __init__(self):
        # Componentes principales
        self.nombre_combo   = "Combo Sin Nombre"
        self.hamburguesa    = None
        self.tamanio_h      = None
        self.bebida         = None
        self.tamanio_b      = None
        self.papas          = None
        self.tamanio_p      = None
        # Componentes opcionales
        self.postre         = None
        self.salsas         = []
        self.juguete        = False
        # Precio
        self.precio_total   = 0.0

    def mostrar(self):
        """Imprime la descripción completa del combo."""
        print(f"\n{'='*45}")
        print(f"  🍔  {self.nombre_combo.upper()}")
        print(f"{'='*45}")

        # Hamburguesa
        if self.hamburguesa:
            print(f"  Hamburguesa : {self.hamburguesa} ({self.tamanio_h})")
        else:
            print("  Hamburguesa : *** No incluida ***")

        # Bebida
        if self.bebida:
            print(f"  Bebida      : {self.bebida} ({self.tamanio_b})")
        else:
            print("  Bebida      : *** No incluida ***")

        # Papas
        if self.papas:
            print(f"  Papas       : {self.papas} ({self.tamanio_p})")
        else:
            print("  Papas       : *** No incluidas ***")

        # Opcionales
        if self.postre:
            print(f"  Postre      : {self.postre}")
        if self.salsas:
            print(f"  Salsas      : {', '.join(self.salsas)}")
        if self.juguete:
            print("  Juguete     : ¡Incluido! 🎁")

        print(f"{'─'*45}")
        print(f"  PRECIO TOTAL: S/. {self.precio_total:.2f}")
        print(f"{'='*45}\n")

    def precio_formateado(self) -> str:
        return f"S/. {self.precio_total:.2f}"


# ============================================================
#  BUILDER: ComboBuilder
#  Construye el objeto Combo paso a paso con métodos encadenables
# ============================================================
class ComboBuilder:
    """
    Builder para construir objetos Combo de forma legible y flexible.
    Cada método retorna `self` para permitir el encadenamiento (fluent interface).
    """

    # Tabla de precios por componente
    _PRECIOS = {
        # Hamburguesas
        "clásica": 12.00, "doble": 16.00, "BigBurger": 18.00,
        "veggie": 14.00, "premium triple": 24.00,
        # Bebidas
        "Coca-Cola": 5.00, "Sprite": 5.00, "Agua": 3.00,
        "jugo natural": 6.50, "malteada": 8.00,
        # Papas
        "papas fritas": 6.00, "papas onduladas": 7.00,
        "aros de cebolla": 8.00,
        # Extras
        "helado": 5.00, "brownie": 6.50, "manzana": 2.00,
        "juguete": 3.50,
    }

    def __init__(self):
        """Inicializa un nuevo Combo vacío para construir."""
        self._combo = Combo()

    def set_nombre(self, nombre: str) -> "ComboBuilder":
        """Define el nombre descriptivo del combo."""
        self._combo.nombre_combo = nombre
        return self   # retorna self para encadenamiento

    def set_hamburguesa(self, tipo: str, tamanio: str = "normal") -> "ComboBuilder":
        """
        Define la hamburguesa del combo.
        Args:
            tipo    : Nombre de la hamburguesa (ej: 'clásica', 'BigBurger')
            tamanio : 'pequeño', 'normal', 'grande', 'extra grande'
        """
        self._combo.hamburguesa = tipo
        self._combo.tamanio_h   = tamanio
        # Multiplicador de precio según tamaño
        mult = {"pequeño": 0.85, "normal": 1.0, "grande": 1.2, "extra grande": 1.4}
        precio_base = self._PRECIOS.get(tipo, 15.00)
        self._combo.precio_total += precio_base * mult.get(tamanio, 1.0)
        return self

    def set_bebida(self, tipo: str, tamanio: str = "mediano") -> "ComboBuilder":
        """
        Define la bebida del combo.
        Args:
            tipo    : Nombre de la bebida (ej: 'Coca-Cola', 'malteada')
            tamanio : 'pequeño', 'mediano', 'grande', 'jumbo'
        """
        self._combo.bebida    = tipo
        self._combo.tamanio_b = tamanio
        mult = {"pequeño": 0.8, "mediano": 1.0, "grande": 1.3, "jumbo": 1.6}
        precio_base = self._PRECIOS.get(tipo, 5.00)
        self._combo.precio_total += precio_base * mult.get(tamanio, 1.0)
        return self

    def set_papas(self, tipo: str = "papas fritas", tamanio: str = "mediano") -> "ComboBuilder":
        """
        Define las papas del combo.
        Args:
            tipo    : 'papas fritas', 'papas onduladas', 'aros de cebolla'
            tamanio : 'pequeño', 'mediano', 'grande'
        """
        self._combo.papas     = tipo
        self._combo.tamanio_p = tamanio
        mult = {"pequeño": 0.8, "mediano": 1.0, "grande": 1.25}
        precio_base = self._PRECIOS.get(tipo, 6.00)
        self._combo.precio_total += precio_base * mult.get(tamanio, 1.0)
        return self

    def agregar_postre(self, postre: str) -> "ComboBuilder":
        """Agrega un postre opcional al combo."""
        self._combo.postre        = postre
        self._combo.precio_total += self._PRECIOS.get(postre, 5.00)
        return self

    def agregar_salsa(self, salsa: str) -> "ComboBuilder":
        """Agrega una salsa (se pueden agregar varias llamando al método varias veces)."""
        self._combo.salsas.append(salsa)
        # Las salsas son gratuitas en este modelo
        return self

    def con_juguete(self) -> "ComboBuilder":
        """Agrega un juguete sorpresa (ideal para combos infantiles)."""
        self._combo.juguete        = True
        self._combo.precio_total  += self._PRECIOS["juguete"]
        return self

    def build(self) -> Combo:
        """
        Finaliza la construcción y retorna el objeto Combo.
        Valida que tenga al menos hamburguesa y bebida.
        """
        if not self._combo.hamburguesa:
            raise ValueError("El combo debe tener al menos una hamburguesa.")
        if not self._combo.bebida:
            raise ValueError("El combo debe tener al menos una bebida.")
        return self._combo


# ============================================================
#  DEMOSTRACIÓN EN CONSOLA
# ============================================================
def main():
    print("=" * 55)
    print("  DEMO: Patrón Builder en Python - Fast Food")
    print("=" * 55)

    # ---- COMBO 1: Básico ----
    print("\n[Builder] Construyendo Combo Básico...")
    combo_basico = (
        ComboBuilder()
        .set_nombre("Combo Básico Estudiante")
        .set_hamburguesa("clásica", "normal")
        .set_bebida("Coca-Cola", "mediano")
        .set_papas("papas fritas", "pequeño")
        .agregar_salsa("kétchup")
        .agregar_salsa("mayonesa")
        .build()
    )
    combo_basico.mostrar()

    # ---- COMBO 2: Premium ----
    print("[Builder] Construyendo Combo Premium...")
    combo_premium = (
        ComboBuilder()
        .set_nombre("Combo Premium Deluxe")
        .set_hamburguesa("premium triple", "extra grande")
        .set_bebida("malteada", "jumbo")
        .set_papas("aros de cebolla", "grande")
        .agregar_postre("brownie")
        .agregar_salsa("BBQ especial")
        .agregar_salsa("guacamole")
        .agregar_salsa("mostaza")
        .build()
    )
    combo_premium.mostrar()

    # ---- COMBO 3: Infantil ----
    print("[Builder] Construyendo Combo Infantil...")
    combo_nino = (
        ComboBuilder()
        .set_nombre("Combo Happy Kids")
        .set_hamburguesa("clásica", "pequeño")
        .set_bebida("jugo natural", "pequeño")
        .set_papas("papas fritas", "pequeño")
        .agregar_postre("manzana")
        .agregar_salsa("kétchup")
        .con_juguete()
        .build()
    )
    combo_nino.mostrar()

    # ---- Resumen comparativo ----
    print("─" * 45)
    print("  COMPARATIVO DE PRECIOS")
    print("─" * 45)
    combos = [combo_basico, combo_premium, combo_nino]
    for c in combos:
        print(f"  {c.nombre_combo:<30} {c.precio_formateado():>10}")
    print("─" * 45)

    # ---- Prueba de validación ----
    print("\nPRUEBA DE ERROR: construir combo sin bebida")
    try:
        combo_invalido = (
            ComboBuilder()
            .set_nombre("Combo Incompleto")
            .set_hamburguesa("clásica")
            .build()   # falta bebida → debe lanzar error
        )
    except ValueError as e:
        print(f"  [ERROR capturado] {e}\n")


if __name__ == "__main__":
    main()
