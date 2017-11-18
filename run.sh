xhost +local:

docker run --rm -it \
    -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0 \
    -p 8888:8888 \
    fast-rcnn \
    jupyter notebook --ip='0.0.0.0' --no-browser --allow-root
