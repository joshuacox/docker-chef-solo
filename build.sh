#/bin/sh
echo 'Build'
/usr/bin/time -v nice ionice -c3 docker build -t docker-chef-solo . 
aplay /usr/share/sounds/alsa/Front_Center.wav
