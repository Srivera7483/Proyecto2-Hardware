# Proyecto2-Hardware

## Descripción del Proyecto
Este repositorio contiene la solución para el Laboratorio #2 de la asignatura INFO1155 (Arquitectura de Hardware y Microcontroladores). El objetivo principal es desarrollar un simulador de voltímetro digital capaz de muestrear 4 canales analógicos simultáneamente utilizando el microcontrolador **PIC12F675** y mostrar las mediciones en un display LCD alfanumérico serial (2x40).

El principal desafío técnico de este proyecto es la implementación de la comunicación serial (TX) hacia el LCD **sin utilizar librerías de terceros o integradas en el compilador**, escribiendo la lógica de transmisión bit a bit utilizando código Pascal nativo.

## Herramientas Utilizadas
* **Compilador:** MikroPascal PRO for PIC.
* **Simulador:** Proteus Design Suite.
* **Control de Versiones:** Git & GitHub.
* **Lenguaje:** Pascal.

## Arquitectura del Software
Para mantener el código escalable, testeable y ordenado, el proyecto se ha estructurado siguiendo principios de **Clean Architecture**, aislando la lógica de negocio de las dependencias de hardware:

* **Capa de Dominio (Core):** Contiene la lógica matemática pura. Se encarga de convertir la lectura bruta del conversor Analógico-Digital (ADC) a un valor de voltaje real (0.0V - 5.0V) y darle el formato de cadena de texto necesario. Esta capa es agnóstica al hardware.
* **Capa de Infraestructura (Drivers):** Contiene los controladores específicos del hardware (HAL).
  * `adc_hal`: Gestiona la configuración de los pines y el muestreo interno del PIC.
  * `lcd_serial`: Implementa la generación manual de pulsos (baud rate y bit-banging) para comunicarse con el módulo LCD.
* **Punto de Entrada (Main):** Orquesta la ejecución inicializando el hardware, leyendo los sensores mediante los drivers, delegando el cálculo al Core y enviando los resultados al display.

## Estructura del Repositorio

├── sim/                     # Archivos de simulación de Proteus (.pdsprj)
└── src/                     # Código fuente de la aplicación
    ├── core/                # Lógica de cálculo y formateo de datos
    ├── drivers/             # Abstracción de hardware y comunicación serial manual
    └── main.mpas            # Archivo principal y bucle de ejecución principal

## Instrucciones de Uso y Compilación

### 1. Compilación del Código
1. Clonar el repositorio.
2. Abrir el proyecto en **MikroPascal**.
3. Asegurarse de que la configuración del reloj del microcontrolador coincida con la requerida por los tiempos de retardo (delays) de la comunicación serial.
4. Compilar el proyecto (Build). Esto generará el archivo `.hex` necesario para la simulación.

### 2. Simulación en Proteus
1. Abrir el archivo de simulación ubicado en la carpeta `sim/` usando Proteus.
2. Hacer doble clic sobre el microcontrolador PIC12F675 (U1).
3. En el campo "Program File", cargar el archivo `.hex` generado en el paso anterior (ubicado en la carpeta `src/`).
4. Iniciar la simulación.
5. Ajustar los potenciómetros (P0, P1, P2, P3) para verificar los cambios de voltaje reflejados en tiempo real en la pantalla LCD.

## Autores
* Sebastian Rivera
* Benjamin Soto
* Pablo Urra

---
**Nota para la evaluación:** El código encargado de la comunicación serial ha sido desarrollado íntegramente de forma manual, controlando los tiempos de alto y bajo (High/Low) de los pines de salida según la tasa de baudios requerida por el simulador de Proteus.
