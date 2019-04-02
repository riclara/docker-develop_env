FROM centos:7

### Base Update
RUN yum -y update && \
  yum -y groupinstall development

### Extra packages
RUN yum -y install curl gpg gcc gcc-c++ make patch autoconf automake zsh wget git which\
  bison libffi-devel libtool patch readline-devel sqlite-devel zlib-devel openssl-devel &&\
  chsh -s /bin/zsh root &&\
  wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh &&\
  export LANG=en_US.UTF-8 && echo 'export LANG=en_US.UTF-8' >> ~/.zshrc &&\
  export LC_ALL=en_US.UTF-8 && echo 'export LC_ALL=en_US.UTF-8' >> ~/.zshrc &&\
  sed -i 's/robbyrussell/bullet-train/g' ~/.zshrc &&\
  wget http://raw.github.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme --directory-prefix=/root/.oh-my-zsh/custom/themes/ &&\
  git clone https://github.com/powerline/fonts.git --depth=1 && cd fonts && sh install.sh

### Install RVM
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB &&\
  curl -sSL https://get.rvm.io | sh -s stable &&\
  /usr/bin/zsh -l -c ". /etc/profile.d/rvm.sh && rvm install 2.5.3" && \
  echo 'source /etc/profile.d/rvm.sh' >> ~/.zshrc

CMD ["/usr/bin/zsh","-l"]