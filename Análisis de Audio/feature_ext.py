import librosa
import librosa.display
import numpy as np
import matplotlib.pyplot as plt

filename = "Notion.mp3"

#Carga de archivo
y, sr = librosa.load(filename)
onset_env = librosa.onset.onset_strength(y, sr=sr)

#Promedio de Tempo
tempo = librosa.beat.tempo(onset_envelope=onset_env, sr=sr)
print(tempo[0])

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
chroma_cens = librosa.feature.chroma_cens(y=y, sr=sr)
chroma_cq = librosa.feature.chroma_cqt(y=y, sr=sr)

plt.figure()
librosa.display.specshow(chroma_cq, y_axis='chroma', x_axis='time')
plt.title('chroma_cq')
plt.colorbar()
#plt.subplot(2,1,2)
#librosa.display.specshow(chroma_cens, y_axis='chroma', x_axis='time')
#plt.title('chroma_cens')
#plt.colorbar()
#plt.tight_layout()
plt.show()
