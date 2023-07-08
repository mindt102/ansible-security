# # Install SCAP Security Guide dependencies
apt-get update
apt-get install libxml2-utils # ninja-build xsltproc libopenscap8 

# # Download SCAP Security Guide source code
# ssg_version=$(curl --silent "https://api.github.com/repos/ComplianceAsCode/content/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
# ssg_url="https://github.com/ComplianceAsCode/content/releases/download/$ssg_version/scap-security-guide-$ssg_version.tar.bz2"
# wget -qO /tmp/scap-security-guide-$ssg_version.tar.bz2 "$ssg_url"
# tar -xjf /tmp/scap-security-guide-$ssg_version.tar.bz2 -C /tmp

# # Build SCAP Security Guide
# mkdir -p /tmp/scap-security-guide-$ssg_version/build
# cmake -S /tmp/scap-security-guide-$ssg_version -B /tmp/scap-security-guide-$ssg_version/build
# make -C /tmp/scap-security-guide-$ssg_version/build -j4 debian11
# # make -C /tmp/scap-security-guide-$ssg_version/build install