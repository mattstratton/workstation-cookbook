# See http://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "mattstratton"
client_key               "#{current_dir}/mattstratton.pem"
validation_client_name   "matt-stratton-personal-validator"
validation_key           "#{current_dir}/matt-stratton-personal-validator.pem"
chef_server_url          "https://api.chef.io/organizations/matt-stratton-personal"
cookbook_path            ["#{current_dir}/../cookbooks"]
