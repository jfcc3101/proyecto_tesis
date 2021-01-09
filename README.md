# proyecto_tesis
#Proyecto: Generación procedural de elementos jugables inmersivos a partir de caracteristicas obtenidas de una pista de música

## Plataforma

_Este proyecto está construido para su funcionamiento en plataformas de escritorio Windows 7 o superiores._

## Construido con 🛠

* [Godot Engine](https://godotengine.org/download/windows) Motor de juego usado en su última versión a la fecha 3.2.3
* Python 3.7 usando [Anaconda](https://www.anaconda.com).
* [ffmpeg](https://ffmpeg.org/download.html) Librería usada para conversión de archivos de audio.
* [libROSA](https://librosa.org) Librería de Python usada para el análisis de las pistas de audio.

## Expotación a Windows 👾

_Para realizar la correcta exportación del videojuego a Windows se siguen los pasos de la [documentación de Godot Engine](https://docs.godotengine.org/es/stable/getting_started/workflow/export/exporting_for_pc.html)._

_Para crear el archivo ejecutable del Script de análisis, usando una terminal ubicarse en el directorio <b>Análisis de Audio</b> y ejecutar:_

```
 conda activate
 pyinstaller --onefile --hidden-import="sklearn.utils._cython_blas" --hidden-import="sklearn.neighbors.typedefs" --hidden-import="sklearn.neighbors.quad_tree" --hidden-import="sklearn.tree._utils" feature_ext.py

```

_Es necesario instalar las librerías [ffmpeg](https://ffmpeg.org/download.html) y agregarlas a las variables de ambiente para que el videojuego funcione correctamente._

_Para introducir nuevas pistas, se deben introducir archivos en formato .mp3 al directorio Audios dentro de la directorio del Videojuego_

## Sobre derechos

_Este es un proyecto personal y académico y no tiene ningún fin comercial._

## Captura de pantalla del videojuego

[ejemplo1](ScreenShots/test1.GIF)
[ejemplo2](ScreenShots/test2.GIF)


