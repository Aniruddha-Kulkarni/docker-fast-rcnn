xhost +local:

docker run --rm -it \
    --name fast-rcnn \
    -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0 \
    -v $(pwd)/shared:/cv/shared \
    -p 8888:8888 \
    fast-rcnn \
    jupyter notebook --ip='0.0.0.0' --no-browser --allow-root --NotebookApp.token=
