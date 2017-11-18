# fetch and check pre-train models
bash ./selective_search/fast-rcnn/data/scripts/fetch_fast_rcnn_models.sh
bash ./selective_search/fast-rcnn/data/scripts/fetch_fast_rcnn_models.sh

# build
docker build . -t fast-rcnn
