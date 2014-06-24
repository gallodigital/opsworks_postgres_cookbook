case node["platform"]
when "amazon"
  # A different Postgres cookbook computes these smarter.
  default["opsworks_postgres"]["pgdg_repo_config"] = "/etc/yum.repos.d/pgdg-93-redhat.repo"
  default["opsworks_postgres"]["pgdg_repo_url"] = {
    "i386" => "http://yum.postgresql.org/9.3/redhat/rhel-6-i386/pgdg-redhat93-9.3-1.noarch.rpm",
    "x86_64" => "http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-redhat93-9.3-1.noarch.rpm"
  }
else
  raise "Unsupported platform #{node["platform"]}"
end
