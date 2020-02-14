FROM amazonlinux

WORKDIR /tflite

RUN yum groupinstall -y development && \
	yum install -y python3.7 && \
	yum install -y python3-devel && \
	pip3 install numpy wheel && \
	git clone https://github.com/tensorflow/tensorflow.git && \
	cd tensorflow && \
	sh tensorflow/lite/tools/pip_package/build_pip_package.sh && \
	pip3 install /tmp/tflite_pip/python3/dist/tflite_runtime-2.1.0-cp37-cp37m-linux_x86_64.whl

CMD tail -f /dev/null
