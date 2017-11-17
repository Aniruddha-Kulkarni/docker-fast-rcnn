xhost +local:

docker run --rm -it \
    -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0 \
    fast-rcnn \
    python ./tools/demo.py --cpu
