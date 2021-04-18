# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "centos/7"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.

  # ディレクトリ、フォルダのパーミッション
  # よくある 755 / 644 で設定
  config.vm.synced_folder "./next", "/home/chat-next", :mount_options => ['dmode=755', 'fmode=644']
  config.vm.synced_folder "./rails", "/home/chat-rails", :mount_options => ['dmode=755', 'fmode=644']

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    # vb.gui = true

    # Customize the amount of memory on the VM:
    vb.memory = "4096"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    # 予めSELinuxを無効化して再起動を促す
   # line=$(cat /etc/selinux/config | wc -l)
   # if [ ${line} -eq 14 ]; then
   #   rm /etc/selinux/config
   #   echo SELINUX=disabled >> /etc/selinux/config
   #   echo SELINUXTYPE=targeted >> /etc/selinux/config
   #   echo "---------------------------"
   #   echo "Please Re:Provision Vagrant"
   #   echo "---------------------------"
   #   shutdown -h now
   # fi
    # yumのパッケージ最新化
    yum -y update
    yum -y install yum-utils wget
    # nginxをインストール
    rpm -ivh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
    yum install -y nginx
    # nginxを常時起動に変更
    systemctl enable nginx.service
    systemctl start nginx
    # rbenvとRubyのインストール
    yum groupinstall -y 'Development Tools'
    git clone https://github.com/rbenv/rbenv.git /usr/local/rbenv
    git clone https://github.com/rbenv/ruby-build.git /usr/local/rbenv/plugins/ruby-build
    RBENV_ROOT=/usr/local/rbenv /usr/local/rbenv/bin/rbenv init -
    yum install -y openssl-devel readline-devel zlib-devel
    RBENV_ROOT=/usr/local/rbenv /usr/local/rbenv/bin/rbenv install 2.7.0
    RBENV_ROOT=/usr/local/rbenv /usr/local/rbenv/bin/rbenv global 2.7.0
    # rbenvでインストールしたrubyへパスを通すために /etc/profile に設定を追記
    echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile
    echo 'export PATH="/usr/local/rbenv/bin:$PATH"' >> /etc/profile
    echo 'eval "$(rbenv init -)"' >> /etc/profile
    # mysqlをインストール
    # https://dev.mysql.com/downloads/repo/yum/
    yum localinstall -y https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
    yum install -y mysql-community-server mysql-devel
    # mysqlを常時起動に変更
    systemctl enable mysqld
    systemctl start mysqld
    # 初期パスワードはこれで表示できる
    # grep 'temporary password' /var/log/mysqld.log
    # confの差し替え
    mv /etc/my.cnf /etc/my.cnf.bk
    cp /vagrant/conf/my.cnf /etc/my.cnf
  SHELL
end
