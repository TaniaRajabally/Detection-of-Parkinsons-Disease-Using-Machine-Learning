import os
import argparse
from pydub import AudioSegment
import time
#os.chdir("D:/Downloads/mPower/")
path="D:/Downloads/mPower/"
l=[i[0:len(i)-3] for i in os.listdir("D:/Downloads/mpwav")]
s_file = [file for file in os.listdir(path) if (file.lower().endswith('.m4a'))]
destination="D:/Downloads/mpwav/"
formats_to_convert = ['.m4a']
for filename in s_file:
    if filename.endswith(tuple(formats_to_convert)):
        if(filename[0:len(filename)-3] not in l):
            filepath = path + filename
            try:
                track = AudioSegment.from_file(filepath)
                wav_path = destination + '/' + filename[0:len(filename)-3]+'wav'
                print('CONVERTING: ' + str(filepath))
                file_handle = track.export(wav_path, format='wav')
                time.sleep(1)
            except Exception as e:
                print("ERROR CONVERTING " + str(filepath))
                print(e)