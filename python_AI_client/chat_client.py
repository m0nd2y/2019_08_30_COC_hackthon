# -*- coding: utf-8 -*-
import math
import firebase_admin
from datetime import datetime
from firebase_admin import credentials
from firebase_admin import firestore
from firebase_admin import storage
import time
import socket
import pyaudio
import sys
import threading
import pygame
import mutagen.mp3

# 음성 출력 설정
RATE = 44100
CHANNELS = 1
FORMAT = pyaudio.paInt16
O_DEVICE_INDEX = 1  # 스피커 장치 인댁스 동봉된 mic_info 파일로 확인해서 변경
I_DEVICE_INDEX = 0  # 마이크 장치 인댁스 동봉된 mic_info 파일로 확인해서 변경
CHUNK = 16000

mp3 = mutagen.mp3.MP3("connected.mp3")#여기 수정
pygame.mixer.init(frequency=mp3.info.sample_rate)
pygame.mixer.music.load("./connected.mp3") #여기 수정


#시간체크
start_time = time.time()

#사용자이름
name = "이동준"

#거주지역
nlocation = "김포"

#통화시간
ncalltime = ""

#현재시간
now = datetime.now()
ntime = str(now.year)+"0" + str(now.month)+str(now.day)+str(now.hour)+str(now.minute)

#인증절차
cred = credentials.Certificate('mykey.json')
firebase_admin.initialize_app(cred, {
    'storageBucket' : ' gs://circlemanage-3027a.appspot.com '
})

db= firestore.client()
key = "ldj6192@gmail.com"

pa = pyaudio.PyAudio()

def callback(in_data, frame_count, time_info, status):
    global s1
    s1.sendall(in_data)  # buffer size

    return (None, pyaudio.paContinue)

def speaker_thread():
    global data, stream
    while True:
        if data:
            stream.write(data[0])
            del data[0]

stream = pa.open(rate=RATE, channels=CHANNELS, format=FORMAT, output=True,
                 output_device_index=O_DEVICE_INDEX,
                 frames_per_buffer=CHUNK, start=False)#, stream_callback=callback)

stream1 = pa.open(rate=RATE, channels=CHANNELS, format=FORMAT, input=True,
                 input_device_index=I_DEVICE_INDEX,
                 frames_per_buffer=CHUNK, start=False, stream_callback=callback)


# 소켓 설정
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s1:
        print('클라이언트 시작')
        host = '192.168.0.86'
        port = 2411
        s.connect((host, port))
        s1.connect((host, port))
        print('서버 접속')
        pygame.mixer.music.play()
        stream.start_stream()
        stream1.start_stream()
        data = []
        t1 = threading.Thread(target=speaker_thread)
        t1.start()

        try : 
            while True:
                # 음성 데이터 받기
                data.append(s.recv(16000))  # buffer size
                #print(data)
                # 음성 데이터 출력
                #stream.write(data)
                #data=''
                pass
            stream.stop_stream()
            stream1.stop_stream()
        except :
            print("[+] call finish")
            #유저이름 upload
            doc_ref = db.collection(u'user').document(key).collection('friends').document()
            doc_ref.set({
                u'friends' : name,
            })

            ncalltime = math.ceil(time.time() - start_time)

            if (ncalltime >= 60) :
               ncalltime = str(ncalltime/60) + "분" + str(ncalltime%60) + "초"
            else :
              ncalltime = str(ncalltime)+"초"

            doc_ref = db.collection(u'user').document(key).collection('recent').document()
            doc_ref.set({
              u'location': nlocation,
                u'ncalltime' : ncalltime,
                u'time' : ntime,
            })



