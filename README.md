docker-chef-solo
================

Basic Docker Image with Chef-Solo installed

warning under development there be dragons here

## Example usage

Make a docker file that looks something like this:
https://github.com/joshuacox/ddd/blob/master/Dockerfile

The important parts you need to customize are the chef specific files especially roles, in the example above you can see how I applied the roles that were used from the VDD project 
https://www.drupal.org/project/vdd

I’ll copy the commented lines from the Dockerfile here as an example of what you need to uncomment and put in your dockerfile to make use of this base container
```
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
```
