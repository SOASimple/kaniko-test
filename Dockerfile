FROM alpine:latest
RUN  mkdir /something
COPY testfile.txt /something
