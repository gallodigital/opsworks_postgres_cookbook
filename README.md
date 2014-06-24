opsworks_postgres Cookbook
==========================

This cookbook is designed for OpsWorks and currently supports installing the PostgreSQL client on Amazon Linux only.
This is needed as Amazon Linux does not currently support Postgres 9.3.

Installation
------------

1. Use Chef 11.10 in your OpsWorks stack.
2. Use Berkshelf in your stack.
3. Use custom cookbooks in your stack.
4. Add this line to your Berksfile (create this file in the root of your custom cookbooks repository if needed):

    ```ruby
    cookbook 'opsworks_postgres', git: 'https://github.com/ziggythehamster/opsworks_postgres_cookbook.git'
    ```

5. Add this recipe to the setup phase of any applicable layers.
6. Use Postgres, I guess. That's why you went through this trouble, I hope.
