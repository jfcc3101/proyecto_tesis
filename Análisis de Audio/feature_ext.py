# -*- coding: utf-8 -*-
import librosa
#import librosa.display
import numpy as np
#import matplotlib.pyplot as plt
import xml.etree.cElementTree as ET
from pydub import AudioSegment
#import eyed3

filename = ""
y = np.empty(0, dtype=object)
sr = 0
onset_env = np.empty(0, dtype=object)
tempo = 0.0
dtempo = np.empty(0, dtype=object)
chroma_stft = np.empty(0, dtype=object)
#chroma_cens = np.empty(0, dtype=object)
#chroma_cq = np.empty(0, dtype=object)
rms = np.empty(0, dtype=object)
#tempogram = np.empty(0, dtype=object)

def analyze(archivo):
    
    global filename
    global y
    global sr
    global onset_env
    global tempo
    global dtempo
    global chroma_stft
    #global chroma_cens
    #global chroma_cq
    global rms
    #global tempogram
    
    filename = archivo
    print("Nombre Cambiado a "+filename)
    #Carga de archivo
    y, sr = librosa.load(filename)
    onset_env = librosa.onset.onset_strength(y, sr=sr)
    
    #Promedio de Tempo
    tempo =librosa.beat.tempo(onset_envelope=onset_env, sr=sr)[0]
    #print(tempo)
    
    #Tempo Dinamico
    dtempo = librosa.beat.tempo(onset_envelope=onset_env, sr=sr, aggregate=None)
    
    #visualizar tempo a traves del tiempo
    #plt.figure()
    #tg = librosa.feature.tempogram(onset_envelope=onset_env, sr=sr,hop_length=512)
    #librosa.display.specshow(tg, x_axis='time', y_axis='tempo')
    #plt.plot(librosa.frames_to_time(np.arange(len(dtempo))), dtempo, color='w', linewidth=1.5, label='Tempo estimate')
    #plt.title('Dynamic tempo estimation')
    #plt.show()
    
    #Visualizar de otra manera 
    #plt.figure()
    #time = np.arange(0,len(dtempo),1)
    #plt.title('Estimacion dinamica de Tempo')
    #plt.plot(time,dtempo)
    #plt.show()
    
    #Chromagrama
    chroma_stft = librosa.feature.chroma_stft(y=y, sr=sr)
    #chroma_cens = librosa.feature.chroma_cens(y=y, sr=sr)
    #chroma_cq = librosa.feature.chroma_cqt(y=y, sr=sr)
    
    #plt.figure()
    #librosa.display.specshow(chroma, y_axis='chroma', x_axis='time')
    #plt.title('chroma')
    #plt.colorbar()
    #plt.figure()
    #librosa.display.specshow(chroma_cq, y_axis='chroma', x_axis='time')
    #plt.title('chroma_cq')
    #plt.colorbar()
    #plt.figure()
    #librosa.display.specshow(chroma_cens, y_axis='chroma', x_axis='time')
    #plt.title('chroma_cens')
    #plt.colorbar()
    #plt.tight_layout()
    #plt.show()
    
    #Energia
    librosa.feature.rmse(y=y)
    S, phase = librosa.magphase(librosa.stft(y))
    rms = librosa.feature.rmse(S=S)
    #plt.figure()
    #plt.semilogy(rms.T, label='RMS Energy')
    #plt.xticks([])
    #plt.xlim([0, rms.shape[-1]])
    #plt.legend()
    #plt.show()
    
    #Tempograma
    #tempogram = librosa.feature.tempogram(onset_envelope=onset_env, sr=sr, hop_length=512)
    #ac_global = librosa.autocorrelate(onset_env, max_size=tempogram.shape[0])
    #ac_global = librosa.util.normalize(ac_global)
    #tempo = librosa.beat.tempo(onset_envelope=onset_env, sr=sr,hop_length=512)[0]
    #plt.figure()
    #plt.plot(onset_env, label='Onset Strength')
    #plt.xticks([])
    #plt.legend(frameon=True)
    #plt.axis('tight')
    #plt.show()
    to_ogg()
    to_XML()
    

"""
Pintado de onda
plt.figure()
librosa.display.waveplot(y, sr=sr)
plt.title('wave')
"""
    
#Convierte los datos obtenidos a partir de la pista en un archivo XML que puede
#ser procesado por Godot Engine
def to_XML():
    
    root = ET.Element("root")

    root = ET.Element("cancion")
    #ET.SubElement(root, "nombre").text = "nombre"
    ET.SubElement(root, "ruta").text = filename
    ET.SubElement(root, "tempoM").text = str(tempo)
    
    strdtempo =' '.join(str(e) for e in dtempo)
    strdtempo = '[' + strdtempo + ']'
    
    ET.SubElement(root, "tempoD").text = strdtempo
    chroma = ET.SubElement(root, "chromaCQ")
    strchB = "[" + ' '.join(str(i) for i in chroma_stft[0]) + "]"
    ET.SubElement(chroma, "B").text = strchB
    strchAsus = "[" + ' '.join(str(i) for i in chroma_stft[1]) + "]"
    ET.SubElement(chroma, "A#").text = strchAsus
    strchA = "[" + ' '.join(str(i) for i in chroma_stft[2]) + "]"
    ET.SubElement(chroma, "A").text = strchA
    strchGsus = "[" + ' '.join(str(i) for i in chroma_stft[3]) + "]"
    ET.SubElement(chroma, "G#").text = strchGsus
    strchG = "[" + ' '.join(str(i) for i in chroma_stft[4]) + "]"
    ET.SubElement(chroma, "G").text = strchG
    strchFsus = "[" + ' '.join(str(i) for i in chroma_stft[5]) + "]"
    ET.SubElement(chroma, "F#").text = strchFsus
    strchF = "[" + ' '.join(str(i) for i in chroma_stft[6]) + "]"
    ET.SubElement(chroma, "F").text = strchF
    strchE = "[" + ' '.join(str(i) for i in chroma_stft[7]) + "]"
    ET.SubElement(chroma, "E").text = strchE
    strchDsus = "[" + ' '.join(str(i) for i in chroma_stft[8]) + "]"
    ET.SubElement(chroma, "D#").text = strchDsus
    strchD = "[" + ' '.join(str(i) for i in chroma_stft[9]) + "]"
    ET.SubElement(chroma, "D").text = strchD
    strchCsus = "[" + ' '.join(str(i) for i in chroma_stft[10]) + "]"
    ET.SubElement(chroma, "C#").text = strchCsus
    strchC = "[" + ' '.join(str(i) for i in chroma_stft[11]) + "]"
    ET.SubElement(chroma, "C").text = strchC
    
    strEnergy = ' '.join(str(i) for i in rms.T)
    strEnergy = "[" + strEnergy + "]"
    ET.SubElement(root, "energy").text = strEnergy
    
    #ET.SubElement(root, "tempograma").text = str(*tempogram)
    
    new_xmlfilename = filename.replace(".mp3", ".xml")

    tree = ET.ElementTree(root)
    tree.write(new_xmlfilename)
    
#Convierte la pista de mp3 a ogg para que pueda ser reproducida en Godot Engine
def to_ogg():
    mp3_audio = AudioSegment.from_file(filename, format = "mp3")
    new_filename = filename.replace(".mp3", ".ogg")
    mp3_audio.export(new_filename, format ="ogg")

#Lee del archivo .txt creado por godot, el archivo sobre el cual debe hacer análisis    
def leer_de_archivo():
    global filename
    archivo = open("toAnalyze.txt","r")
    filename = archivo.read()
    archivo.close()
    
#Vacía en archivo .txt donde se abía puesto el nombre del archivo a analizar
def limpiar_archivo():
    archivo = open("toAnalyze.txt","r+")
    archivo.truncate(0)
    archivo.close()
    
leer_de_archivo()
analyze(filename)
limpiar_archivo()
print("filename: "+filename)

