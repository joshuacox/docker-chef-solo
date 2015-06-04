FROM debian:wheezy
MAINTAINER Josh Cox <josh 'at' webhosting.coop>

ENV DOCKER_CHEF_SOLO_UPDATED 20150604
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update
RUN apt-get -y install python-software-properties curl build-essential libxml2-dev libxslt-dev git ruby ruby-dev ca-certificates sudo net-tools vim
RUN apt-get -y dist-upgrade

# This block became necessary with the new chef 12
RUN apt-get -y install locales
# RUN echo 'en_US.ISO-8859-15 ISO-8859-15'>>/etc/locale.gen
# RUN echo 'en_US ISO-8859-1'>>/etc/locale.gen
RUN echo 'en_US.UTF-8 UTF-8'>>/etc/locale.gen
RUN locale-gen
ENV LANG en_US.UTF-8

RUN echo "Installing Chef This may take a few minutes..."
RUN curl -L https://www.getchef.com/chef/install.sh | sudo bash
RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
RUN /opt/chef/embedded/bin/gem install berkshelf
RUN echo "Installing mysql now as the cookbook is failing This may take a few minutes..."

# Example usage
#RUN echo "Installing berksfile..."
#ADD ./Berksfile /Berksfile
#ADD ./chef/roles /var/chef/roles
#ADD ./chef/solo.rb /var/chef/solo.rb
#ADD ./chef/solo.json /var/chef/solo.json

#RUN echo "Installing berks This may take a few minutes..."
#RUN cd / && /opt/chef/embedded/bin/berks vendor /var/chef/cookbooks
#RUN chef-solo -c /var/chef/solo.rb -j /var/chef/solo.json

#RUN easy_install supervisor
#RUN echo "foo...."
#ADD ./start.sh /start.sh
#ADD ./foreground.sh /etc/apache2/foreground.sh
#ADD ./supervisord.conf /etc/supervisord.conf

#RUN chmod 755 /start.sh /etc/apache2/foreground.sh
#EXPOSE 80
#CMD ["/bin/bash", "/start.sh"]
