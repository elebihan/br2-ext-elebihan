################################################################################
#
# bearssl
#
################################################################################

BEARSSL_VERSION = 0.5
BEARSSL_SITE = https://www.bearssl.org
BEARSSL_LICENSE = MIT
BEARSSL_LICENSE_FILES = LICENSE.txt
BEARSSL_INSTALL_STAGING = YES

BEARSSL_MAKE_OPTS = CONF=Buildroot

define BEARSSL_CONFIGURE_CMDS
	echo "include conf/Unix.mk" > $(@D)/conf/Buildroot.mk
	echo "CC=$(TARGET_CC)" >> $(@D)/conf/Buildroot.mk
	echo "LD=$(TARGET_CC)" >> $(@D)/conf/Buildroot.mk
	echo "LDDLL=$(TARGET_CC)" >> $(@D)/conf/Buildroot.mk
	echo "AR=$(TARGET_AR)" >> $(@D)/conf/Buildroot.mk
	echo "CFLAGS=$(TARGET_CFLAGS)" >> $(@D)/conf/Buildroot.mk
	echo "LDFLAGS=$(TARGET_LDFLAGS)" >> $(@D)/conf/Buildroot.mk
endef

ifeq ($(BR2_PACKAGE_BEARSSL_BIN),y)
define BEARSSL_INSTALL_BIN
	$(INSTALL) -D -m 0755 $(@D)/build/brssl $(TARGET_DIR)/usr/bin/brssl
endef
endif

define BEARSSL_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(BEARSSL_MAKE_OPTS) -C $(@D)
endef

define BEARSSL_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0644 $(@D)/build/libbearssl.a \
		$(STAGING_DIR)/usr/lib/libbearssl.a
	$(INSTALL) -d $(STAGING_DIR)/usr/include/bearssl
	$(INSTALL) -m 0644 $(@D)/inc/*.h $(STAGING_DIR)/usr/include/bearssl
endef

define BEARSSL_INSTALL_TARGET_CMDS
	$(BEARSSL_INSTALL_BIN)
endef

$(eval $(generic-package))
