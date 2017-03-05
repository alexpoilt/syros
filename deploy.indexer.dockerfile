FROM alpine:3.5

ARG APP_VERSION=unkown
ARG BUILD_DATE=unkown
ARG GIT_REPOSITORY=unkown
ARG GIT_BRANCH=unkown
ARG GIT_COMMIT=unkown
ARG MAINTAINER=unkown

LABEL syros.version=$APP_VERSION \
      syros.build=$BUILD_DATE \
      syros.repository=$GIT_REPOSITORY \
      syros.branch=$GIT_BRANCH \
      syros.revision=$GIT_COMMIT \
      syros.maintainer=$MAINTAINER

EXPOSE 8887

COPY /dist/indexer /syros/indexer

RUN apk add --no-cache --virtual curl && chmod 777 /syros/indexer

HEALTHCHECK --interval=30s --timeout=15s --retries=3\
  CMD curl -f http://localhost:8887/status || exit 1

WORKDIR /syros
ENTRYPOINT ["/syros/indexer"]
