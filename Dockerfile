FROM ubuntu:22.04 AS bootstrapper
ARG EXTRA_PACKAGES=ca-certificates
RUN apt update && \
	apt install -y mmdebstrap ca-certificates && \
	mmdebstrap --include=${EXTRA_PACKAGES} --arch=riscv64 beige /rootfs "deb [trusted=yes] https://mirror.iscas.ac.cn/deepin-riscv/deepin-stage1/ beige main"


FROM scratch
COPY --from=bootstrapper /rootfs/ /
ENV LANG=en_US.UTF-8
CMD ["/bin/bash"]
