import socket
import pyaudio
import threading
import pygame
import mutagen.mp3

mp3 = mutagen.mp3.MP3("connected.mp3")
pygame.mixer.init(frequency=mp3.info.sample_rate)
pygame.mixer.music.load("connected.mp3")


#마이크 입력
RATE = 44100
CHANNELS = 1
FORMAT = pyaudio.paInt16
I_DEVICE_INDEX = 5 #마이크 장치 인덱스. 동봉된 mic_info 파일로 마이크 장치확인해서 변경
O_DEVICE_INDEX = 3 #스피커 장치 인덱스 확인
#success 5, 3

CHUNK = 16000

pa = pyaudio.PyAudio()

def callback(in_data, frame_count, time_info, status):
    global conn
    #print(in_data)
    conn.sendall(in_data)  # buffer size
    return (None, pyaudio.paContinue)
def speaker_thread():
    global data, stream1
    while True:
        if data:
            stream1.write(data[0])
            del data[0]

stream = pa.open(rate=RATE, channels=CHANNELS, format=FORMAT, input=True,
                        input_device_index=I_DEVICE_INDEX,
                        frames_per_buffer=CHUNK, start=False, stream_callback=callback)

stream1 = pa.open(rate=RATE, channels=CHANNELS, format=FORMAT, output=True,
                        output_device_index=O_DEVICE_INDEX,
                        frames_per_buffer=CHUNK, start=False)#, stream_callback=callback)

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    print('서버시작')
    host ='192.168.0.86'
    port = 2411
    s.bind((host, port))
    s.listen(1)
    conn, addr= s.accept()
    conn1, addr1 = s.accept()
    print('클라이언트 접속')

    pygame.mixer.music.play()

    stream.start_stream()
    stream1.start_stream()
    data = []
    t1 = threading.Thread(target=speaker_thread)
    t1.start()

    while True:
        data.append(conn1.recv(16000))
    stream.stop_stream()
    stream1.stop_stream()