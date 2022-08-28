import os
import argparse
from pydub import AudioSegment
import time
#os.chdir("D:/Downloads/mPower/")
path="D:/Downloads/mpow3/"
s_file = [file for file in os.listdir(path) if (file.lower().endswith('.m4a'))]
l=[i[0:len(i)-3] for i in os.listdir("D:/Downloads/mpwav")]
destination="D:/Downloads/mpwav/"
formats_to_convert = ['.m4a']
for filename in s_file:
    print(filename)
    if filename.endswith(tuple(formats_to_convert)):
        if(filename[0:len(filename)-3] not in l):
            filepath = path + filename
            try:
                print(filepath)
                track = AudioSegment.from_file(filepath)
                wav_path = destination + '/' + filename[0:len(filename)-3]+'wav'
                file_handle = track.export(wav_path, format='wav')
                #os.remove(filepath)
                time.sleep(1)
            except Exception as e:
                print("ERROR CONVERTING " + str(filepath))
                print(e)
