# Python TensorFlow Lite for amazonlinux

In this repo everything is provided to create the python dependencies nessessary to use tensoflow lite on amazonlinux, which is including support for aws lambda.

## Docker

First, if you dont already have it, install Docker. https://www.docker.com/

## Dockerfile

Then create this Dockerfile (also available in the repo).
The second *pip3 install* of the dockerfile might change with future versions.

    FROM amazonlinux

    WORKDIR /tflite

    RUN yum groupinstall -y development
    RUN yum install -y python3.7
    RUN yum install -y python3-devel
    RUN pip3 install numpy wheel
    RUN git clone --branch v2.2.0-rc0 https://github.com/tensorflow/tensorflow.git
    RUN sh ./tensorflow/tensorflow/lite/tools/pip_package/build_pip_package.sh
    RUN pip3 install tensorflow/tensorflow/lite/tools/pip_package/gen/tflite_pip/python3/dist/tflite_runtime-2.2.0rc0-cp37-cp37m-linux_x86_64.whl
    
    CMD tail -f /dev/null

## Commands

Run the following commands in the same directory where you created the Dockerfile.

    docker build -t tflite_amazonlinux .
    docker run -d --name=tflite_amazonlinux tflite_amazonlinux
    docker cp tflite_amazonlinux:/usr/local/lib64/python3.7/site-packages .
    docker stop tflite_amazonlinux

## Site-Packages

In the directory where you ran the commands there should now be a folder called *site-packages*. In that folder are the correctly compiled tflite python dependencies for amazonlinux. Copy them into your environment in your docker or lambda function and you are good to go.

Warning: These packages will probably not work with other linux distributions or other architectures than amazonlinux. They are specificly created for amazonlinux.

## Sources

https://www.tensorflow.org/lite/guide/python
https://github.com/tensorflow/tensorflow/tree/master/tensorflow/lite/tools/pip_package

And probably many more :D 
