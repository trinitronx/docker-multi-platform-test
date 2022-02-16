FROM --platform=$BUILDPLATFORM tonistiigi/xx AS xx

FROM --platform=$BUILDPLATFORM alpine:edge as compile
ARG BUILDPLATFORM

COPY --from=xx / /

RUN echo "Hello from ${BUILDPLATFORM} compile stage"
RUN echo "BUILDPLATFORM=${BUILDPLATFORM}" | tee /etc/arch-release
RUN uname -m
RUN xx-info

FROM alpine:edge as release
ARG TARGETPLATFORM

COPY --from=compile /etc/arch-release /etc/

RUN echo "Hello from ${TARGETPLATFORM} release stage"
RUN echo "TARGETPLATFORM=${TARGETPLATFORM}" | tee -a /etc/arch-release
CMD uname -m
