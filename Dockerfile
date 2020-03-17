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
