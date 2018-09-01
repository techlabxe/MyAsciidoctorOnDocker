FROM debian:stretch

MAINTAINER techlab

CMD echo "now running ..."

RUN apt update


RUN apt-get install -y \
  cmake \
  bison \
  flex \
  libpango1.0-dev \
  ttf-lyx \
  libxml2-dev \
  ruby ruby-dev

RUN gem install --no-ri \
    bundler \
    rake \
    gdk_pixbuf2
RUN gem install --no-ri thread_safe safe_yaml
RUN gem install --no-ri -v '0.2.2' prawn-table
RUN gem install --no-ri -v '1.5.3' treetop
RUN gem install --no-ri -v '1.4.0' prawn-icon
RUN gem install --no-ri -v '0.21.0' prawn-svg
RUN gem install --no-ri -v '0.1.1' prawn-templates
RUN gem install --no-ri asciidoctor coderay
    
# RUN apt install -y git  &&
#   mkdir -p /work && cd /work &&
#   git clone https://github.com/techlabxe/asciidoctor-pdf.git &&
#   cd asciidoctor-pdf &&
#   gem build asciidoctor-pdf.gemspec &&
#   gem install my-*.gem &&
#   cd /work && rm -rf ./*

WORKDIR /work
COPY my-asciidoctor-pdf-1.5.0.alpha.17.dev.gem /work/my-asciidoctor-pdf-1.5.0.alpha.17.dev.gem

RUN gem install --no-ri --local /work/my-asciidoctor-pdf-1.5.0.alpha.17.dev.gem
RUN gem install --no-ri asciidoctor-mathematical


ENTRYPOINT [ "asciidoctor-pdf" ]
