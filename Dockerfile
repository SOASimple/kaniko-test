FROM roybrumby/git-tool:1.0 as gitapp
LABEL stage=gitapp

ARG  GITHUB_APP_ID
ARG  GITHUB_TOKEN_URL
ARG  GITHUB_PRIVATE_KEY=/githubappkey.pem
COPY githubappkey.pem /githubappkey.pem

RUN  mkdir /packages && cd /packages \
 &&  token=$(/git-tool.sh jwt ${GITHUB_APP_ID} ${GITHUB_PRIVATE_KEY} | /git-tool.sh token ${GITHUB_TOKEN_URL}) \
 &&  git clone https://x-access-token:${GITHUB_TOKEN}@github.com/SOASimple/kaniko-test.git \
 &&  git clone https://x-access-token:${GITHUB_TOKEN}@github.com/SOASimple/git-tool.git

FROM alpine:3.17.3
ARG TARGET_FOLDER=/demo/folder/packages
RUN  mkdir -p ${TARGET_FOLDER}
COPY --from=gitapp /packages ${TARGET_FOLDER}

