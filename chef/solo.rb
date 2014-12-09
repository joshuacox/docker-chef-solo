root = File.absolute_path(File.dirname(__FILE__))
file_cache_path root
cookbook_path '/var/chef/cookbooks'
role_path '/var/chef/roles'
ssl_verify_mode :verify_peer
