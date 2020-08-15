# proyecto_tesis
#Proyecto: Generación procedural de elementos jugables inmersivos a partir de caracteristicas obtenidas de una pista de música

Se necesita instalar ffmpeg Windows:

- Descargar los archivos: https://ffmpeg.org/download.html
- Agregar la carpeta ffmpeg a las variables de entorno.

Para crear el .exe o .sh

En la carpeta de Análisis de audio:
- conda activate
- pyinstaller --onefile --hidden-import="sklearn.utils._cython_blas" --hidden-import="sklearn.neighbors.typedefs" --hidden-import="sklearn.neighbors.quad_tree" --hidden-import="sklearn.tree._utils" feature_ext.py



Proyecto creado usando:
Godot Engine 3.2
Python 3.7 - Anaconda 3
