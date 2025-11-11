Proyecciones de Población - CONAPO
Este proyecto en R analiza y visualiza las proyecciones de población de México utilizando los datos publicados por CONAPO.
Incluye scripts de procesamiento, gráficos y resultados derivados de las proyecciones oficiales.
Estructura del proyecto
conapo-proyecciones/
•	01-datos/ → Archivo(s) de entrada (Excel con proyecciones)
•	02-codigo/ → Scripts en R para análisis y visualización
•	03-output/ → Gráficas y resultados generados
•	conapo-proyecciones.Rproj → Archivo de proyecto de RStudio
•	.Rhistory → Historial de comandos de R

Descripción de las carpetas
01-datos/
Contiene el archivo de entrada con las proyecciones de población.
Debido a su tamaño, esta carpeta la subí en formato ZIP. 

02-codigo/
Incluye los scripts de análisis y visualización en R:
01-paquetes-datos.R  Carga de librerías y lectura de datos
02-grafica-años-con-decrecimiento.R  Gráfica en donde se identifican los años con decreecimiento poblacional 
03-evolucion-poblacion-entidad.R  Muestra la evolución de la población por entidad 
04-mapa-calor-poblacion-entidad.R  Mapa de calor de cada entidad por año
05-grafica-republica-mexicana.R  Evolución de la población a nivel nacional 

03-output/
Contiene las salidas generadas por los scripts de R:
•	Gráficas (archivos PNG)

Requisitos
Para ejecutar los scripts, se recomienda tener instalado:
•	R (versión 4.0 o superior)
•	RStudio
•	Librerías principales de R:
install.packages(c("tidyverse", "readxl", "ggplot2", "sf", "viridis"))

Cómo usar el proyecto
1.	Clona o descarga este repositorio.
2.	Descomprime la carpeta 01-datos/.
3.	Abre el proyecto en RStudio con el archivo conapo-proyecciones.Rproj.
4.	Ejecuta los scripts de la carpeta 02-codigo/ en orden.
5.	Los resultados se guardarán automáticamente en 03-output/.

Fuente de datos
Datos obtenidos del Consejo Nacional de Población (CONAPO) Conciliación Demográfica de 1950 a 2019 y Proyecciones de la población de México y de las entidades federativas 2020 a 2070.

Autora: Paola BF
Noviembre 2025 
