FROM binhex/arch-base:latest
LABEL org.opencontainers.image.authors = "binhex"
LABEL org.opencontainers.image.source = "https://github.com/binhex/arch-couchpotato-git"

# additional files
##################

# add supervisor conf file for app
ADD build/*.conf /etc/supervisor/conf.d/

# add install and packer bash script
ADD build/root/*.sh /root/

# install app
#############

# make executable and run bash scripts to install app
RUN chmod +x /root/*.sh && \
	/bin/bash /root/install.sh

# docker settings
#################

# map /config to host defined config path (used to store configuration from app)
VOLUME /config

# map /data to host defined data path (used to store downloads or use blackhole)
VOLUME /data

# map /media to host defined media path (used to read/write to media library)
VOLUME /media

# expose port for http
EXPOSE 5050

# set permissions
#################

# run script to set uid, gid and permissions
CMD ["/bin/bash", "/usr/local/bin/init.sh"]