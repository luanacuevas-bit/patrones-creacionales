Patrones Creacionales – Singleton, Factory y Builder
📖 Descripción

Este repositorio contiene la implementación práctica de tres patrones de diseño creacionales en el contexto de la Programación Orientada a Objetos:

Singleton (C++)
Factory Method (Python)
Builder (Python)

El objetivo del proyecto es demostrar cómo estos patrones desacoplan la lógica de creación de objetos de la lógica de negocio, mejorando la mantenibilidad, escalabilidad y organización del software.

🧠 Patrones Implementados
🔹 1. Singleton (C++)

Garantiza que una clase tenga una única instancia durante toda la ejecución del programa y proporciona un punto de acceso global a ella.

Ejemplo aplicado: Configuración global del sistema.

🔹 2. Factory Method (Python)

Centraliza la creación de objetos concretos a través de una clase fábrica, evitando que el cliente instancie clases directamente.

Ejemplo aplicado: Creación de diferentes medios de transporte (Camión, Barco, Avión, Drone).

🔹 3. Builder (Python)

Permite construir objetos complejos paso a paso utilizando una interfaz fluida.

Ejemplo aplicado: Construcción de combos de fast food personalizados (Básico, Premium, Infantil).

🛠 Tecnologías Utilizadas
C++ (estándar C++11 o superior)
Python 3.x
Programación Orientada a Objetos
Principios SOLID
▶️ Cómo Ejecutar el Proyecto
🔹 Ejecutar Singleton (C++)
g++ singleton.cpp -o singleton
./singleton
🔹 Ejecutar Factory (Python)
python factory.py
🔹 Ejecutar Builder (Python)
python builder.py
📂 Estructura del Proyecto
patrones-creacionales/
│
├── singleton_cpp/
│   └── singleton.cpp
│
├── factory_python/
│   └── factory.py
│
├── builder_python/
│   └── builder.py
│
├── docs/
│   └── uml/
│       ├── singleton_uml.txt
│       ├── factory_uml.txt
│       └── builder_uml.txt
│
└── README.md
📊 Resultados
Se verificó que Singleton mantiene una única instancia.
Factory permite agregar nuevos tipos sin modificar el código cliente.
Builder facilita la construcción de objetos complejos evitando constructores extensos.
👩‍💻 Información Académica

Universidad: Universidad Nacional del Altiplano
Escuela Profesional: Ingeniería de Sistemas
Curso: Lenguajes de Programación Orientada a Objetos II
Docente: Mg. Aldo Hernán Zanabria Gálvez
Estudiante: Cuevas Yucra Angheli Luana
Año: 2026
