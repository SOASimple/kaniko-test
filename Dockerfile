FROM roybrumby/git-tool:1.0 as gitapp
LABEL stage=gitapp

ARG GITHUB_TOKEN

RUN  echo ${GITHUB_TOKEN}
RUN  mkdir /packages && cd /packages \
 &&  git clone https://x-access-token:${GITHUB_TOKEN}@github.com/SOASimple/kaniko-test.git \
 &&  git clone https://x-access-token:${GITHUB_TOKEN}@github.com/SOASimple/git-tool.git

FROM alpine:3.17.3
ARG TARGET_FOLDER=/demo/folder/packages
RUN  mkdir -p ${TARGET_FOLDER}
COPY --from=gitapp /packages ${TARGET_FOLDER}

