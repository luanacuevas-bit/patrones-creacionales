# Patrones de Diseño Creacionales — POO II UNA Puno

Implementaciones de los patrones Singleton, Builder y Factory Method para la Semana 4-5.

## Archivos

- singleton.cpp — Patrón Singleton en C++
- builder.py — Patrón Builder en Python
- factory.py — Patrón Factory Method en Python

## Cómo ejecutar

Python:
```bash
python builder.py
python factory.py
```

C++:
```bash
g++ singleton.cpp -o singleton
./singleton
```

## Qué hace cada patrón

**Singleton** garantiza que una clase tenga una sola instancia en todo el programa. Se logra haciendo el constructor privado y exponiendo un método estático llamado getInstance() que crea la instancia solo la primera vez y la reutiliza siempre.

**Builder** separa la construcción de un objeto complejo de su representación. En lugar de pasar todos los parámetros al constructor de golpe, se configuran paso a paso con métodos encadenables. Cada método retorna el mismo Builder (return self) para poder seguir encadenando. Al final se llama build() que valida y entrega el objeto.

**Factory Method** centraliza la creación de objetos en un solo lugar. El cliente pide un objeto por tipo (por ejemplo "camion" o "avion") sin saber qué clase concreta se instancia internamente. Esto permite agregar nuevos tipos sin modificar el código existente.
