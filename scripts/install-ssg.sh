# Install SCAP Security Guide dependencies
apt-get update
apt-get install -y curl bzip2 cmake python3-pip libxml2-utils ninja-build xsltproc # libopenscap8
pip install jinja2 pyyaml pytest pytest-cov json2html yamlpath mypy openpyxl pandas cmakelint sphinx sphinxcontrib-jinjadomain sphinx_rtd_theme myst_parser

# Download SCAP Security Guide source code
ssg_version=$(curl --silent "https://api.github.com/repos/ComplianceAsCode/content/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
ssg_url="https://github.com/ComplianceAsCode/content/releases/download/v$ssg_version/scap-security-guide-$ssg_version.tar.bz2"
curl -so /tmp/scap-security-guide-$ssg_version.tar.bz2 -L "$ssg_url"
tar -xjf /tmp/scap-security-guide-$ssg_version.tar.bz2 -C /tmp

# Build SCAP Security Guide
mkdir -p /tmp/scap-security-guide-$ssg_version/build
cmake -S /tmp/scap-security-guide-$ssg_version -B /tmp/scap-security-guide-$ssg_version/build
# make -C /tmp/scap-security-guide-$ssg_version/build -j4 debian11
# # make -C /tmp/scap-security-guide-$ssg_version/build install