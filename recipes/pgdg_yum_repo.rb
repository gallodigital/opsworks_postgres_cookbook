#
# Cookbook Name:: opsworks_postgres
# Recipe:: pgdg_yum_repo
#
# Adds the PGDG repository to Yum

arch = node["kernel"]["machine"]

# Download the Postgres repo RPM
remote_file "#{Chef::Config[:file_cache_path]}/pgdg.rpm" do
  source node["opsworks_postgres"]["pgdg_repo_url"][arch]
  mode "0644"
end

# Install the Postgres repo RPM
rpm_package "pgdg" do
  source "#{Chef::Config[:file_cache_path]}/pgdg.rpm"
  action :install
end

# Fix the broken repo configuration
ruby_block "fix PGDG broken repo configuration" do
  block do
    fe = Chef::Util::FileEdit.new(node["opsworks_postgres"]["pgdg_repo_config"])
    # They put $releasever, when they mean 6. $releasever on AWS Linux is something like 2014.03.
    fe.search_file_replace(/\$releasever/, "6")
    fe.write_file
  end
  only_if { File.exist?(node["opsworks_postgres"]["pgdg_repo_config"]) && File.read(node["opsworks_postgres"]["pgdg_repo_config"]).include?("$releasever") }
end

# Exclude PostgreSQL updates coming from Amazon in the future or things could break in
# horrifying and interesting ways.
ruby_block "exclude Amazon-provided PostgreSQL updates" do
  block do
    fe = Chef::Util::FileEdit.new("/etc/yum.repos.d/amzn-updates.repo")
    fe.insert_line_after_match(/\[amzn-updates\]/, "exclude=postgresql*")
    fe.write_file
  end
  only_if { File.exist?("/etc/yum.repos.d/amzn-updates.repo") && !File.read("/etc/yum.repos.d/amzn-updates.repo").include?("exclude=postgresql*")  }
end
