################################################################################
#
# meson
#
################################################################################

MESON_VERSION = 0.37.0
MESON_SITE = $(call github,mesonbuild,meson,$(MESON_VERSION))
MESON_LICENSE = Apache-2.0
MESON_LICENSE_FILES = COPYING
MESON_SETUP_TYPE = setuptools

HOST_MESON_DEPENDENCIES = host-ninja
HOST_MESON_NEEDS_HOST_PYTHON = python3

HOST_MESON_TARGET_ENDIAN = $(shell echo $(BR2_ENDIAN) | tr 'A-Z' 'a-z')

define HOST_MESON_INSTALL_CROSS_CONF
	$(INSTALL) -d $(HOST_DIR)/etc/meson
	sed -e 's;@TARGET_CROSS@;$(TARGET_CROSS);g' \
		-e 's;@TARGET_ARCH@;$(ARCH);g' \
		-e 's;@TARGET_ENDIAN@;$(HOST_MESON_TARGET_ENDIAN);g' \
		-e 's;@HOST_DIR@;$(HOST_DIR);g' \
		$(BR2_EXTERNAL_ELEBIHAN_PATH)/package/meson/cross-compilation.conf.in > \
		$(HOST_DIR)/etc/meson/cross-compilation.conf
endef

HOST_MESON_POST_INSTALL_HOOKS += HOST_MESON_INSTALL_CROSS_CONF

$(eval $(host-python-package))
