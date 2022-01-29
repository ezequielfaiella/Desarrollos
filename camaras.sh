#!/bin/bash

duracion=5
posicion="100%:100%"
tamano="400x400"
ch1=rtsp://weme:200161walter@192.168.1.50:554/h264/ch1/sub/av_stream
ch2=rtsp://weme:200161walter@192.168.1.50:554/h264/ch2/main/av_stream
ch3=rtsp://weme:200161walter@192.168.1.50:554/h264/ch3/main/av_stream
ch4=rtsp://weme:200161walter@192.168.1.50:554/h264/ch4/main/av_stream
ch5=rtsp://weme:200161walter@192.168.1.50:554/h264/ch5/main/av_stream
ch6=rtsp://weme:200161walter@192.168.1.50:554/h264/ch6/main/av_stream
ch7=rtsp://weme:200161walter@192.168.1.50:554/h264/ch7/main/av_stream
ch8=rtsp://weme:200161walter@192.168.1.50:554/h264/ch8/main/av_stream
ch9=rtsp://weme:200161walter@192.168.1.50:554/h264/ch9/main/av_stream
ch10=rtsp://weme:200161walter@192.168.1.50:554/h264/ch10/main/av_stream
ch11=rtsp://weme:200161walter@192.168.1.50:554/h264/ch11/main/av_stream
ch12=rtsp://weme:200161walter@192.168.1.50:554/h264/ch12/main/av_stream
ch13=rtsp://weme:200161walter@192.168.1.50:554/h264/ch13/main/av_stream
ch14=rtsp://weme:200161walter@192.168.1.50:554/h264/ch14/main/av_stream
ch15=rtsp://weme:200161walter@192.168.1.50:554/h264/ch15/main/av_stream
ch16=rtsp://weme:200161walter@192.168.1.50:554/h264/ch16/main/av_stream

mpv --end=$duracion --loop --mute --title="Camaras" --ontop --no-border --autofit=$tamano --geometry=$posicion $ch1 $ch2 $ch3 $ch4 $ch5 $ch6 $ch7 $ch8 $ch9 $ch10 $ch11 $ch12 $ch13 $ch14 $ch15 $ch16

