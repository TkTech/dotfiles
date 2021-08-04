# Installs rbenv and ruby-build plugin if rbenv is not available, since it
# might already be installed via a package manager.
if command -v rbenv &> /dev/null
then
    echo "rbenv is already present, not doing anything."
    exit 0
fi

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
mkdir -p ~/.rbenv/plugins
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
