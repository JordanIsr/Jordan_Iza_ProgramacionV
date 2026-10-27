# Tema 1.2: Entorno portable de Dart y Flutter

## Caracteristicas del equipo
* Sistema Operativo: Windows 11 (25H2, Version 10.0.26200.9711)
* Procesador (CPU): AMD Athlon Silver 3050U con Radeon Graphics (2 nucleos, 2 hilos @ 2.30 GHz)
* Memoria RAM: 8.0 GB DDR4 (2400 MT/s)
* Almacenamiento Principal (Disco C): SSD NVMe de 224 GB (WDC WDS240G2G0C-00AJM0)
* Almacenamiento Secundario (Disco D): HDD SATA de 932 GB / 1 TB (WDC WD10SPZX-60Z10T0)
* Graficos (GPU): AMD Radeon(TM) Graphics (2.0 GB VRAM dedicada)
* Idioma / Configuracion regional: es-MX

## Versiones de herramientas (flutter doctor)
* Flutter SDK: Channel stable, version 3.47.7
* Dart SDK: Integrado con Flutter
* Estado del entorno: 
  * Flutter configurado correctamente.
  * Google Chrome disponible para desarrollo web.
  * Herramientas de Android y Visual Studio pendientes (enfocado para desarrollo web y consola en esta practica).
  
## Ruta del entorno y estructura
* Ruta de trabajo: D:\dev (Configurado mediante script portable iniciar.bat)
* Destinos de prueba utilizados: Google Chrome (-d chrome)

## Problema resuelto durante la practica
* Problema: Al intentar ejecutar el proyecto de Flutter por primera vez, el sistema arrojo un error de bloqueo en la carpeta de compilacion (build\flutter_assets) debido a procesos activos y bloqueos temporales de lectura/escritura.
* Solucion: Se cerraron los procesos colgados desde el Administrador de tareas de Windows, se limpio manualmente la carpeta de compilacion bloqueada y se aseguro una correcta ejecucion local de la app.