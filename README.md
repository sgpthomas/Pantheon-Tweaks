Pantheon Tweaks
--------------------------------------------------------------------------------
Switchboard Plug that helps you tweak some settings in elementary OS

## OPTIONAL
sudo add-apt-repository ppa:elementary-os/daily

## DEPENDENCIES
cmake (>= 2.8)
libswitchboard-2.0-dev
libgranite-dev
libgtk-3-dev
valac (>= 0.22)

## INSTALLATION
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr ../
sudo make install

## UNINSTALL
"from previously created build directory"
sudo make uninstall
