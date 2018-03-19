################################################################################
#
# python-pykcs11
#
################################################################################

PYTHON_PYKCS11_VERSION = 1.4.4
PYTHON_PYKCS11_SOURCE = PyKCS11-$(PYTHON_PYKCS11_VERSION).tar.gz
PYTHON_PYKCS11_SITE = http://downloads.sourceforge.net/project/pkcs11wrap/pykcs11/pykcs11-$(PYTHON_PYKCS11_VERSION)
PYTHON_PYKCS11_LICENSE = GPLv2
PYTHON_PYKCS11_LICENSE_FILES = COPYING
PYTHON_PYKCS11_SETUP_TYPE = setuptools
HOST_PYTHON_PYKCS11_DEPENDENCIES = host-swig

$(eval $(host-python-package))
