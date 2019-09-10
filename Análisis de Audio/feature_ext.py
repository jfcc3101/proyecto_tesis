import librosa
import librosa.display
import numpy as np
import matplotlib.pyplot as plt
import xml.etree.cElementTree as ET
#import eyed3


filename = "First date.mp3"

#Carga de archivo
y, sr = librosa.load(filename)
onset_env = librosa.onset.onset_strength(y, sr=sr)

#Promedio de Tempo
tempo =librosa.beat.tempo(onset_envelope=onset_env, sr=sr)[0]
print(tempo)

#Témpo Dinámico
dtempo = librosa.beat.tempo(onset_envelope=onset_env, sr=sr, aggregate=None)

#visualizar tempo a traves del tiempo
plt.figure()
tg = librosa.feature.tempogram(onset_envelope=onset_env, sr=sr,hop_length=512)
librosa.display.specshow(tg, x_axis='time', y_axis='tempo')
plt.plot(librosa.frames_to_time(np.arange(len(dtempo))), dtempo, color='w', linewidth=1.5, label='Tempo estimate')
plt.title('Dynamic tempo estimation')
plt.show()

#Visualizar de otra manera 
plt.figure()
time = np.arange(0,len(dtempo),1)
plt.title('Estimación dinámica de Tempo')
plt.plot(time,dtempo)
plt.show()

#Chromagrama
chroma = librosa.feature.chroma_stft(y=y, sr=sr)
chroma_cens = librosa.feature.chroma_cens(y=y, sr=sr)
chroma_cq = librosa.feature.chroma_cqt(y=y, sr=sr)

plt.figure()
librosa.display.specshow(chroma, y_axis='chroma', x_axis='time')
plt.title('chroma')
plt.colorbar()
plt.figure()
librosa.display.specshow(chroma_cq, y_axis='chroma', x_axis='time')
plt.title('chroma_cq')
plt.colorbar()
plt.figure()
librosa.display.specshow(chroma_cens, y_axis='chroma', x_axis='time')
plt.title('chroma_cens')
plt.colorbar()
plt.tight_layout()
plt.show()

#Energía
librosa.feature.rmse(y=y)
S, phase = librosa.magphase(librosa.stft(y))
rms = librosa.feature.rmse(S=S)
plt.figure()
plt.semilogy(rms.T, label='RMS Energy')
plt.xticks([])
plt.xlim([0, rms.shape[-1]])
plt.legend()
plt.show()

#Tempograma
tempogram = librosa.feature.tempogram(onset_envelope=onset_env, sr=sr, hop_length=512)
#ac_global = librosa.autocorrelate(onset_env, max_size=tempogram.shape[0])
#ac_global = librosa.util.normalize(ac_global)
#tempo = librosa.beat.tempo(onset_envelope=onset_env, sr=sr,hop_length=512)[0]
plt.figure()
plt.plot(onset_env, label='Onset Strength')
plt.xticks([])
plt.legend(frameon=True)
plt.axis('tight')
plt.show()

"""
Pintado de onda
plt.figure()
librosa.display.waveplot(y, sr=sr)
plt.title('wave')
"""

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
    strchB = "[" + ' '.join(str(i) for i in chroma_cq[0]) + "]"
    ET.SubElement(chroma, "B").text = strchB
    strchAsus = "[" + ' '.join(str(i) for i in chroma_cq[1]) + "]"
    ET.SubElement(chroma, "A#").text = strchAsus
    strchA = "[" + ' '.join(str(i) for i in chroma_cq[2]) + "]"
    ET.SubElement(chroma, "A").text = strchA
    strchGsus = "[" + ' '.join(str(i) for i in chroma_cq[3]) + "]"
    ET.SubElement(chroma, "G#").text = strchGsus
    strchG = "[" + ' '.join(str(i) for i in chroma_cq[4]) + "]"
    ET.SubElement(chroma, "G").text = strchG
    strchFsus = "[" + ' '.join(str(i) for i in chroma_cq[5]) + "]"
    ET.SubElement(chroma, "F#").text = strchFsus
    strchF = "[" + ' '.join(str(i) for i in chroma_cq[6]) + "]"
    ET.SubElement(chroma, "F").text = strchF
    strchE = "[" + ' '.join(str(i) for i in chroma_cq[7]) + "]"
    ET.SubElement(chroma, "E").text = strchE
    strchDsus = "[" + ' '.join(str(i) for i in chroma_cq[8]) + "]"
    ET.SubElement(chroma, "D#").text = strchDsus
    strchD = "[" + ' '.join(str(i) for i in chroma_cq[9]) + "]"
    ET.SubElement(chroma, "D").text = strchD
    strchCsus = "[" + ' '.join(str(i) for i in chroma_cq[10]) + "]"
    ET.SubElement(chroma, "C#").text = strchCsus
    strchC = "[" + ' '.join(str(i) for i in chroma_cq[11]) + "]"
    ET.SubElement(chroma, "C").text = strchC
    
    strEnergy = ' '.join(str(i) for i in rms.T)
    strEnergy = "[" + strEnergy + "]"
    ET.SubElement(root, "energy").text = strEnergy
    
    #ET.SubElement(root, "tempograma").text = str(*tempogram)

    tree = ET.ElementTree(root)
    tree.write("actual.xml")
    
to_XML()
