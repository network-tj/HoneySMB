FROM ubuntu

MAINTAINER T.J. but forked from Rohit Sehgal (rsehgal@iitk.ac.in)

RUN apt-get update
RUN apt-get install software-properties-common -y
RUN apt-add-repository universe -y

RUN apt-get update && apt-get install -y \
    python3 \
    python \
    tcpdump \
    apt-utils 


RUN apt-get install aptitude -y
RUN apt-get install python3-pip -y


RUN mkdir -p /home/smb

COPY libs /home/smb/libs
COPY credentials_file /home/smb/credentials_file
COPY __init__.py /home/smb/__init__.py
COPY shares.conf /home/smb/shares.conf
COPY smbserver.py /home/smb/smbserver.py
COPY smb.conf /home/smb/smb.conf

COPY startup_scripts.sh /home/smb/startup_scripts.sh
RUN chmod 754 /home/smb/startup_scripts.sh

COPY requirements.txt /home/smb/requirements.txt
RUN pip3 install -r /home/smb/requirements.txt

EXPOSE 445 139

ENTRYPOINT ["bash"]
CMD ["-c","/home/smb/startup_scripts.sh"]
