#!/bin/bash
docker run -it -p 7777:7777 -p 8501:8501 -p 8000:8000 --name ml -v "$PWD":/usr/src/  ml_jupyter
