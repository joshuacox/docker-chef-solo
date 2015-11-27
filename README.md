docker-chef-solo
================

Basic Docker Image with Chef-Solo installed

warning under development there be dragons here

## Example usage

Make a docker file that starts with a FROM statements like this:

```
FROM joshuacox/docker-chef-solo:wheezy
```

The important parts you need to customize are the chef specific files especially roles, 

You’ll then need to include the chef stuff in your Dockerfile, here is an example of what you need to put in your dockerfile to make use of this base container
```
COPY ./Berksfile /Berksfile
COPY ./chef/roles /var/chef/roles
COPY ./chef/solo.rb /var/chef/solo.rb
COPY ./chef/solo.json /var/chef/solo.json
```

Then you’ll need to tell Docker to execute chef solo to execute your above additions
```
RUN cd / && /opt/chef/embedded/bin/berks vendor /var/chef/cookbooks
RUN chef-solo -c /var/chef/solo.rb -j /var/chef/solo.json
```

then you’ll need to start your app using supervisor or S6 or similar here is an example of a typical supervisord starting apache:
```
RUN easy_install supervisor
RUN echo "foo...."
COPY ./start.sh /start.sh
COPY ./foreground.sh /etc/apache2/foreground.sh
COPY ./supervisord.conf /etc/supervisord.conf

RUN chmod 755 /start.sh /etc/apache2/foreground.sh
EXPOSE 80
CMD ["/bin/bash", "/start.sh"]
```

You will find examples of all the above files in this directory
