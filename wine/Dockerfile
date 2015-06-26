FROM ubuntu:14.04
MAINTAINER Tom Molesworth <tom@perlsite.co.uk>
ENV REFRESHED_AT 2015-06-08

# Ensure we support 32-bit for wine apps
RUN dpkg --add-architecture i386
# add-apt-repository support
RUN apt-get install -y software-properties-common
# Recent versions of wine are more likely to work
RUN add-apt-repository -y ppa:ubuntu-wine/ppa
# Install wine itself, some utilities and VNC so we can see what it's doing if necessary
RUN apt-get update -y && apt-get install -y git wget tightvncserver xvfb wine1.7 winetricks

# Grab the WiX MSI and apply it
RUN mkdir /usr/src/wix
WORKDIR /usr/src/wix
RUN wget -O wix.msi 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=wix&DownloadId=1421696&FileTime=130661188674870000&Build=21018'
RUN xvfb-run -a wine msiexec /i /qn wix.msi

# Candle/light are the two most likely apps users will want to run here
ENTRYPOINT ["xvfb-run", "-a", "wine", "candle.exe" ]

