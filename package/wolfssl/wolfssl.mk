################################################################################
#
# wolfssl
#
################################################################################

WOLFSSL_VERSION = 3.11.0
WOLFSSL_SITE = $(call github,wolfSSL,wolfssl,v$(WOLFSSL_VERSION)-stable)
WOLFSSL_LICENSE = GPLv2 or COMMERCIAL
WOLFSSL_LICENSE_FILES = COPYING
WOLFSSL_INSTALL_STAGING = YES
WOLFSSL_AUTORECONF = YES

WOLFSSL_CONF_OPTS = \
	--disable-jobserver \
	--disable-examples \
	--disable-crypttests

ifeq ($(BR2_arm)$(BR2_aarch64),y)
WOLFSSL_CONF_OPTS += --enable-armasm
endif

define WOLFSSL_REMOVE_CONFIG_TOOL_HOOK
	rm $(TARGET_DIR)/usr/bin/wolfssl-config
endef

WOLFSSL_POST_INSTALL_TARGET_HOOKS += WOLFSSL_REMOVE_CONFIG_TOOL_HOOK

$(eval $(autotools-package))
