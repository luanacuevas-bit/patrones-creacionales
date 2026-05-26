/**
 * ============================================================
 *  PATRÓN SINGLETON - Implementación en C++
 *  Semana 4-5 | Patrones Creacionales
 *  Lenguajes de POO II - UNA Puno
 * ============================================================
 *
 *  TEORÍA:
 *  El patrón Singleton garantiza que una clase tenga UNA SOLA
 *  instancia en toda la ejecución del programa, y provee un
 *  punto de acceso global a ella.
 *
 *  CASOS DE USO REALES:
 *  - Configuración global del sistema
 *  - Conexión a base de datos
 *  - Logger centralizado
 *  - Pool de recursos compartidos
 *
 *  DIAGRAMA UML (texto):
 *
 *  +-----------------------------+
 *  |          Config             |
 *  +-----------------------------+
 *  | - instance: Config*  (static|
 *  | - appName: string           |
 *  | - version: string           |
 *  | - debugMode: bool           |
 *  +-----------------------------+
 *  | - Config()  (privado)       |
 *  | + getInstance(): Config*    |  <-- static
 *  | + setAppName(string): void  |
 *  | + getAppName(): string      |
 *  | + setDebugMode(bool): void  |
 *  | + isDebugMode(): bool       |
 *  | + showInfo(): void          |
 *  +-----------------------------+
 *
 * ============================================================
 */

#include <iostream>
#include <string>
using namespace std;

// ============================================================
//  CLASE SINGLETON: Config
//  Simula la configuración global de una aplicación
// ============================================================
class Config {
private:
    // ----------------------------------------------------------
    // Atributo estático que almacena la ÚNICA instancia
    // Es nullptr al inicio; se crea solo cuando se necesita
    // ----------------------------------------------------------
    static Config* instance;

    // Atributos de configuración (estado compartido)
    string appName;
    string version;
    bool   debugMode;

    // ----------------------------------------------------------
    // Constructor PRIVADO: impide crear instancias desde afuera
    // con "Config c;" o "new Config()"
    // ----------------------------------------------------------
    Config() : appName("MiApp"), version("1.0.0"), debugMode(false) {
        cout << "[Config] Instancia creada por primera y única vez.\n";
    }

    // Destructor privado (buena práctica)
    ~Config() {}

    // Eliminar copia y asignación para reforzar el patrón
    Config(const Config&)            = delete;
    Config& operator=(const Config&) = delete;

public:
    // ----------------------------------------------------------
    // Método estático getInstance(): punto de acceso global
    // Crea la instancia solo si aún no existe (Lazy Initialization)
    // ----------------------------------------------------------
    static Config* getInstance() {
        if (instance == nullptr) {
            // Solo se ejecuta UNA sola vez en toda la vida del programa
            instance = new Config();
        }
        return instance;
    }

    // --- Getters y Setters ---

    void setAppName(const string& name) { appName = name; }
    string getAppName() const { return appName; }

    void setVersion(const string& ver) { version = ver; }
    string getVersion() const { return version; }

    void setDebugMode(bool mode) { debugMode = mode; }
    bool isDebugMode() const { return debugMode; }

    // Muestra toda la configuración actual
    void showInfo() const {
        cout << "\n===== CONFIGURACION GLOBAL =====\n";
        cout << "  Aplicacion : " << appName  << "\n";
        cout << "  Version    : " << version   << "\n";
        cout << "  Debug Mode : " << (debugMode ? "ACTIVADO" : "DESACTIVADO") << "\n";
        cout << "  Direccion  : " << this << "\n";
        cout << "================================\n";
    }
};

// Inicialización del puntero estático fuera de la clase (obligatorio en C++)
Config* Config::instance = nullptr;


// ============================================================
//  FUNCION AUXILIAR: simula un módulo que usa la configuración
// ============================================================
void moduloDeRed() {
    cout << "\n[ModuloDeRed] Obteniendo configuracion...\n";
    Config* cfg = Config::getInstance(); // No crea nueva instancia
    cout << "[ModuloDeRed] App: " << cfg->getAppName() << "\n";
    cout << "[ModuloDeRed] Debug: " << (cfg->isDebugMode() ? "SI" : "NO") << "\n";
}


// ============================================================
//  MAIN - Demostración del patrón
// ============================================================
int main() {
    cout << "======================================\n";
    cout << "  DEMO: Patron Singleton en C++        \n";
    cout << "======================================\n\n";

    // ---- Prueba 1: primera llamada crea la instancia ----
    cout << ">> Obteniendo instancia 1...\n";
    Config* obj1 = Config::getInstance();

    // ---- Prueba 2: segunda llamada reutiliza la misma instancia ----
    cout << "\n>> Obteniendo instancia 2...\n";
    Config* obj2 = Config::getInstance();

    // ---- Prueba 3: verificar que apuntan al mismo objeto ----
    cout << "\n>> Comparando direcciones de memoria:\n";
    cout << "   obj1 -> " << obj1 << "\n";
    cout << "   obj2 -> " << obj2 << "\n";
    cout << "   ¿Son identicas? " << (obj1 == obj2 ? "SI (mismo objeto)" : "NO") << "\n";

    // ---- Prueba 4: modificar desde obj1, ver cambio desde obj2 ----
    cout << "\n>> Modificando configuracion desde obj1...\n";
    obj1->setAppName("SistemaEstudiantil-UNA");
    obj1->setVersion("2.5.1");
    obj1->setDebugMode(true);

    cout << "\n>> Leyendo configuracion desde obj2 (debe reflejar los cambios):\n";
    obj2->showInfo();  // obj2 "ve" los cambios hechos por obj1

    // ---- Prueba 5: un módulo externo accede al Singleton ----
    moduloDeRed();

    // ---- Prueba 6: tercera referencia desde otra parte del código ----
    cout << "\n>> Obteniendo instancia 3 desde otra parte del programa...\n";
    Config* obj3 = Config::getInstance();
    cout << "   obj3 -> " << obj3 << "\n";
    cout << "   ¿obj1 == obj3? " << (obj1 == obj3 ? "SI" : "NO") << "\n";

    cout << "\n[INFO] El constructor 'Config()' solo se ejecuto 1 vez.\n";
    cout << "[INFO] Las 3 referencias apuntan al mismo objeto en memoria.\n\n";

    return 0;
}
