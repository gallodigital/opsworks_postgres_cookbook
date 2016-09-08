#
# Cookbook Name:: opsworks_postgres
# Recipe:: client
#

case node["platform"]
when "amazon"
  include_recipe "opsworks_postgres::pgdg_yum_repo"

  yum_package "postgresql93" do
    flush_cache [:before, :after]
  end

  yum_package "postgresql93-libs" do
    flush_cache [:before, :after]
  end

  yum_package "postgresql93-devel" do
    flush_cache [:before, :after]
  end

  # Next, link pg_config to /usr/local/bin to make Ruby able to compile the pg gem.
  # Pretty much _every other_ PG utility exists in /etc/alternatives and is symlinked
  # automatically. There is probably a better way to do this, but this definitely works
  # for now. :)
  link "/usr/local/bin/pg_config" do
    to "/usr/pgsql-9.3/bin/pg_config"
  end
else
  raise "Unsupported platform #{node["platform"]}"
end
