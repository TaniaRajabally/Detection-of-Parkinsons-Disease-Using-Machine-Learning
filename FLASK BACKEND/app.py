import numpy as np
from flask import Flask, request, jsonify, render_template,flash
import pickle
import werkzeug
from tensorflow.keras.applications import VGG19
from tensorflow.keras.preprocessing.image import img_to_array
from tensorflow.keras.preprocessing.image import load_img
from keras.applications.vgg19 import preprocess_input
from tensorflow import keras
import tensorflow as tf
import cv2
import json
import glob
import pandas as pd
import parselmouth
import os
from parselmouth.praat import call
from convert import measurePitch
import joblib
loaded_rf = joblib.load("./rf.joblib")

with open('m.json', 'r') as json_file:
    m1 = json_file.read()
m = keras.models.model_from_json(m1)
m.load_weights('m.h5')
inputShape = (224, 224)
preprocess = preprocess_input




app = Flask(__name__)

#model = pickle.load(open('model.pkl', 'rb'))

UPLOAD_FOLDER = '/path/to/the/uploads'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg'}
ALLOWED_EXTENSIONS_sound = {'wav', 'mp3'}

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/')
def home():
    return render_template('index.html')


@app.route('/preds',methods=['POST'])
def pred():
    if('image' not in request.files):
        flash('No file found')
    imagefile = request.files['image']
    print(imagefile.name)
    if imagefile:
            filename = werkzeug.utils.secure_filename(imagefile.filename)
            imagefile.save(filename)
            img = load_img(filename,target_size=(224,224))
            img=np.array(img)
            img=preprocess(img)
            p=m.predict(np.array([img]))        
            if(p>0.5):
                output='Patient'
            else:
                output='control'
            return jsonify(str(p[0][0]),output)
    else:
        return "JINGU SUCKS"



@app.route('/sound',methods=['POST'])
def sound():
    if('sound' not in request.files):
        flash('No file found')
    
    sound = request.files['sound']
    print(sound.name)
    try :
        if sound:
                filename = werkzeug.utils.secure_filename(sound.filename)
                sound.save(filename)
                sound = parselmouth.Sound(filename)
                (localJitter, localabsoluteJitter, rapJitter, ppq5Jitter, ddpJitter, localShimmer, localdbShimmer, apq3Shimmer, aqpq5Shimmer, apq11Shimmer, ddaShimmer, ac, nth, htn,median_pitch, meanF0, stdevF0, min_pitch, max_pitch, n_pulses, n_periods, mean_period, standard_deviation_period, fraction_unvoiced_frames, num_voice_breaks, degree_voice_breaks) = measurePitch(sound, 75, 500, "Hertz")
                X=[localJitter, localabsoluteJitter, rapJitter, ppq5Jitter, ddpJitter, localShimmer, localdbShimmer, apq3Shimmer, aqpq5Shimmer, apq11Shimmer, ddaShimmer, ac, nth, htn,median_pitch, meanF0, stdevF0, min_pitch, max_pitch, n_pulses, n_periods, mean_period, standard_deviation_period, fraction_unvoiced_frames, num_voice_breaks, degree_voice_breaks]
                prediction=loaded_rf.predict(np.array([X]))[0]
                if(prediction==0):
                    output='Control'
                else:
                    output='Parkinson\'s'
                return jsonify(str(prediction),output)
    except Exception as e:
        print(e)
        return 'Error encountered while processing file'

@app.route('/res',methods=['POST'])
def res():
    imagefile = flask.request.files['image']
    filename = werkzeug.utils.secure_filename(imagefile.filename)
    print("\nReceived image File name : " + imagefile.filename)
   # imagefile.save(filename)
    return "Image Uploaded Successfully"


@app.route('/results',methods=['POST'])
def results():

    data = request.get_json(force=True)
    prediction = model.predict([np.array(list(data.values()))])

    output = prediction[0]
    return jsonify(output)

if __name__ == "__main__":
    app.run(debug=True)