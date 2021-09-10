#!/bin/bash

sudo apt install v4l2loopback-dkms

sudo echo "v4l2loopback" | sudo tee /etc/modules-load.d/v4l2loopback.conf
sudo echo "options v4l2loopback video_nr=10 card_label=\"V4L2 Video Source\" exclusive_caps=1" | sudo tee /etc/modprobe.d/v4l2loopback.conf

echo "Restart computer and use ffmpeg to use your RTSP camera as webcam example command:"
echo "sudo ffmpeg -i rtsp://user:password@192.168.0.1/stream1 -pix_fmt yuv420p -f v4l2 /dev/video10"
