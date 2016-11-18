################################################################################
#
# python-scapy
#
################################################################################

PYTHON_SCAPY_VERSION = 2.3.3
PYTHON_SCAPY_SOURCE = v$(PYTHON_SCAPY_VERSION).tar.gz
PYTHON_SCAPY_SITE = https://github.com/secdev/scapy/archive
PYTHON_SCAPY_LICENSE = GPLv2
PYTHON_SCAPY_LICENSE_FILES = LICENSE
PYTHON_SCAPY_SETUP_TYPE = distutils

$(eval $(python-package))
