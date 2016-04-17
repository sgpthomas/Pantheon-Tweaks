Pantheon Tweaks
================================================================================
Switchboard Plug that helps you tweak some settings in elementary OS

### Optional
`sudo add-apt-repository ppa:elementary-os/daily`

### Dependencies
- cmake (>= 2.8)
- libswitchboard=2.0=dev
- libgranite=dev
- libgtk=3=dev
- valac (>= 0.22)

### Install from source
    mkdir build
    cd build
    cmake =DCMAKE_INSTALL_PREFIX=/usr ../
    sudo make install

### Uninstall
from previously created build directory  
`sudo make uninstall`
