# Install Openscap dependencies
apt update
apt install -y curl bzip2 cmake python3-pip libxml2-utils ninja-build xsltproc cmake libdbus-1-dev libdbus-glib-1-dev libcurl4-openssl-dev libgcrypt20-dev libselinux1-dev libxslt1-dev libgconf2-dev libacl1-dev libblkid-dev libcap-dev libxml2-dev libldap2-dev libpcre3-dev python3-dev swig libxml-parser-perl libxml-xpath-perl libperl-dev libbz2-dev librpm-dev g++ libapt-pkg-dev libyaml-dev libxmlsec1-dev libxmlsec1-openssl

# Download Openscap source code
openscap_version=$(curl --silent "https://api.github.com/repos/OpenSCAP/openscap/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
openscap_url="https://github.com/OpenSCAP/openscap/releases/download/${openscap_version}/openscap-${openscap_version}.tar.gz"
curl -so /tmp/openscap-${openscap_version}.tar.gz -L "$openscap_url"
tar -xzpf /tmp/openscap-${openscap_version}.tar.gz -C /tmp

# Build Openscap
mkdir -p /tmp/openscap-${openscap_version}/build
cd /tmp/openscap-${openscap_version}/build
cmake -DCMAKE_INSTALL_PREFIX=/usr ../
make install

# Build Openscap Debian package
mkdir -p /tmp/oscap_${openscap_version}/DEBIAN
printf "Package: oscap\nVersion: ${openscap_version}\nArchitecture: amd64\n" > /tmp/oscap_${openscap_version}/DEBIAN/control

mkdir -p /tmp/oscap_${openscap_version}/usr/bin
cp /tmp/openscap-${openscap_version}/build/utils/oscap /tmp/oscap_${openscap_version}/usr/bin

mkdir -p /tmp/oscap_${openscap_version}/usr/lib
cp /tmp/openscap-${openscap_version}/build/src/libopenscap.so.25 /tmp/oscap_${openscap_version}/usr/lib
cp /tmp/openscap-${openscap_version}/build/src/SCE/libopenscap_sce.so.25 /tmp/oscap_${openscap_version}/usr/lib

mkdir -p /tmp/oscap_${openscap_version}/usr/include/openscap
cp -r /usr/include/openscap/ /tmp/oscap_${openscap_version}/usr/include/

mkdir -p /tmp/oscap_${openscap_version}/usr/share/openscap
cp -r /usr/share/openscap/ /tmp/oscap_${openscap_version}/usr/share/

mkdir -p /tmp/oscap_${openscap_version}/usr/share/man/man8/
cp /usr/share/man/man8/oscap.8 /tmp/oscap_${openscap_version}/usr/share/man/man8/

dpkg-deb --build /tmp/oscap_${openscap_version}