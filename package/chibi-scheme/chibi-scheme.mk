################################################################################
#
# chibi-scheme
#
################################################################################

CHIBI_SCHEME_VERSION = 0.7.3
CHIBI_SCHEME_SITE = $(call github,ashinn,chibi-scheme,$(CHIBI_SCHEME_VERSION))
CHIBI_SCHEME_LICENSE = BSD-3c
CHIBI_SCHEME_LICENSE_FILES = COPYING
CHIBI_SCHEME_INSTALL_STAGING = YES

CHIBI_SCHEME_DEPENDENCIES = host-chibi-scheme
HOST_CHIBI_SCHEME_DEPENDENCIES = host-patchelf

CHIBI_SCHEME_TOOLS = chibi-doc chibi-ffi snow-chibi

ifneq ($(BR2_PACKAGE_CHIBI_SCHEME_REPL),y)
CHIBI_SCHEME_TOOLS += chibi-scheme
endif

define CHIBI_SCHEME_REMOVE_TOOLS
	for tool in $(CHIBI_SCHEME_TOOLS); do \
		rm -f $(TARGET_DIR)/usr/bin/$$tool; \
	done
endef

CHIBI_SCHEME_POST_INSTALL_TARGET_HOOKS += CHIBI_SCHEME_REMOVE_TOOLS

define CHIBI_SCHEME_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
		PREFIX="/usr" \
		CC="$(TARGET_CC)" \
		CHIBI="$(HOST_DIR)/usr/bin/chibi-scheme"
endef

define CHIBI_SCHEME_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) PREFIX="$(TARGET_DIR)/usr" install
endef

define CHIBI_SCHEME_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) PREFIX="$(STAGING_DIR)/usr" install
endef

define HOST_CHIBI_SCHEME_BUILD_CMDS
	$(MAKE) -C $(@D)
endef

define HOST_CHIBI_SCHEME_INSTALL_CMDS
	$(MAKE) -C $(@D) PREFIX="$(HOST_DIR)/usr" install
endef

define HOST_CHIBI_SCHEME_FIX_RPATH
	$(HOST_DIR)/usr/bin/patchelf \
		--set-rpath $(HOST_DIR)/usr/lib \
		$(HOST_DIR)/usr/bin/chibi-scheme
endef

HOST_CHIBI_SCHEME_POST_INSTALL_HOOKS += HOST_CHIBI_SCHEME_FIX_RPATH

$(eval $(generic-package))
$(eval $(host-generic-package))
