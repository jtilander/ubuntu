FROM ubuntu:16.04
MAINTAINER Jim Tilander

ENV DEBIAN_FRONTEND=noninteractive

# printf 'Dir::Cache \"\";\nDir::Cache::archives \"\";\n' > /etc/apt/apt.conf.d/02nocache && \
RUN printf 'path-exclude=/usr/share/locale/*\npath-exclude=/usr/share/man/*\n\npath-exclude=/usr/share/doc/*\npath-include=/usr/share/doc/*/copyright\n' > /etc/dpkg/dpkg.cfg.d/01_nodoc

RUN apt-get -y update && \
	apt-get install -y --no-install-recommends \
	git \
	make \
	vim-tiny \
	dnsutils \
	iputils-ping \
	curl && \
	rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /usr/share/doc/* /usr/share/man/* /usr/share/locale/*

ENV VISUAL=vi

ENV P4_VERSION 16.1
RUN curl -sSL -O http://cdist2.perforce.com/perforce/r${P4_VERSION}/bin.linux26x86_64/p4 && mv p4 /usr/bin/p4 && chmod +x /usr/bin/p4

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["ping"]
