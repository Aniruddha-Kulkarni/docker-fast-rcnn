# docker-fast-rcnn
A docker image for [fast-rcnn](https://github.com/rbgirshick/fast-rcnn) building with CPU for the purpose of demo for Computer Vision university course presentation.

## Build & Run
```bash
./build.sh && ./run.sh
```

## Custom Data
Add your files in `/data`, they will then be included in the image.

## Customization
Edit `Makefile.config` to change build options.

## Note
Very heavy download, please build with good stable network.
