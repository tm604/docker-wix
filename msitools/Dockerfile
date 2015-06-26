FROM ubuntu:14.04
MAINTAINER Tom Molesworth <tom@perlsite.co.uk>
ENV REFRESHED_AT 2015-03-28

# Generic dev deps - C compiler and autotools
RUN apt-get update && apt-get install -y build-essential libgmp-dev pkg-config autoconf automake intltool libtool git

# Start with the gcab/msitools repositories
RUN cd /usr/src && git clone git://git.gnome.org/gcab
RUN cd /usr/src && git clone git://git.gnome.org/msitools

# Dependencies specific to msitools/gcab
RUN apt-get install -y gobject-introspection libgirepository1.0-dev valac gtk-doc-tools libgsf-1-dev uuid-dev bison

# gcab mostly builds cleanly, we request static but shared should probably work too
RUN cd /usr/src/gcab && ./autogen.sh && ./configure --disable-shared --enable-static && make && make install
# msitools is a different matter, libs are in the wrong order/missing (so shared
# doesn't work out-of-the-box) and the include/libmsi subdirectories aren't processed
# correctly. Work around this as follows:
RUN cd /usr/src/msitools && ./autogen.sh && ./configure --disable-shared --enable-static
RUN cd /usr/src/msitools/include && make && make install
RUN cd /usr/src/msitools/libmsi && make && make install

# Finally, we can build+install
RUN cd /usr/src/msitools && make && make install
# If we have shared libs, make sure the system knows about 'em
RUN ldconfig

# Finally, deps for the Perl .wxs template generation
RUN apt-get install -y libtemplate-perl
RUN mkdir /usr/src/wix
WORKDIR /usr/src/wix
ADD . /usr/src/wix
CMD /bin/bash
