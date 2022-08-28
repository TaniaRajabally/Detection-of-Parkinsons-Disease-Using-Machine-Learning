import os
import argparse

from pydub import AudioSegment
import time
os.chdir("D:/Downloads/mPower")
s_file = [file for file in os.listdir("D:/Downloads/mPower") if (file.lower().endswith('.m4a'))]


dirpath = ''
convpath = "Converted/"
formats_to_convert = ['.m4a']
print(s_file)
for filename in s_file:
	print(filename)
	if filename.endswith(tuple(formats_to_convert)):
		print("yes")
		filepath = dirpath  + filename
		(path, file_extension) = os.path.splitext(filepath)
		file_extension_final = file_extension.replace('.', '')
		try:
			print('oit')
			print(filepath)
			print(os. getcwd() )
			track = AudioSegment.from_file(filepath,
			      file_extension_final)
			print('y')
			wav_filename = filename.replace(file_extension_final, 'wav')
			wav_path = Converted + '/' + wav_filename
			print('CONVERTING: ' + str(filepath))
			file_handle = track.export(wav_path, format='wav')
			#os.remove(filepath)
			time.sleep(1)
		except Exception as e:
			print("ERROR CONVERTING " + str(filepath))
			print(e)
			break