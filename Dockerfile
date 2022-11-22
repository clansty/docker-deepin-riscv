FROM ubuntu:22.04 AS bootstrapper
RUN apt update && \
	apt install -y mmdebstrap ca-certificates && \
	mmdebstrap --include=ca-certificates --arch=riscv64 beige /rootfs "deb [trusted=yes] https://mirror.iscas.ac.cn/deepin-riscv/deepin-stage1/ beige main"


FROM scratch
COPY --from=bootstrapper /rootfs/ /
ENV LANG=en_US.UTF-8
CMD ["/bin/bash"]
