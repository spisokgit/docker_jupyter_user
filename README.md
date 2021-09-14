## related docker hub
+ https://hub.docker.com/repository/docker/spisok/ml_jupyter_user
## run user
+ docker run -it -p 7777:7777 -p 8501:8501 -p 8000:8000 --name ml_jupyter_user -v "$PWD":/usr/src/  ml_jupyter_user
## run root
+ docker run -it -p 7777:7777 -p 8501:8501 -p 8000:8000 --name ml -v "$PWD":/usr/src/  ml_jupyter
