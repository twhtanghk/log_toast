FROM	node

WORKDIR /usr/src/app
ADD	https://github.com/twhtanghk/imsails/archive/master.tar.gz /tmp
RUN	tar --strip-components=1 -xzf /tmp/master.tar.gz && \
	npm install
EXPOSE	8080

CMD npm test
