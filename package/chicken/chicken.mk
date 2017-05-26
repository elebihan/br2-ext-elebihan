################################################################################
#
# chicken
#
################################################################################

CHICKEN_VERSION = 4.12.0
CHICKEN_SITE = https://code.call-cc.org/releases/$(CHICKEN_VERSION)
CHICKEN_SOURCE = chicken-$(CHICKEN_VERSION).tar.gz
CHICKEN_LICENSE = BSD-3c
CHICKEN_LICENSE_FILES = LICENSE
CHICKEN_DEPENDENCIES = host-chicken
CHICKEN_INSTALL_STAGING = YES

CHICKEN_TARGET_SYSTEM = $(shell basename $(TARGET_CROSS) | sed 's/.$$//')

CHICKEN_TOOLS = \
	chicken \
	chicken-bug \
	chicken-install \
	chicken-profile \
	chicken-status \
	chicken-uninstall \
	csc \
	feathers

ifneq ($(BR2_PACKAGE_CHICKEN_REPL),y)
CHICKEN_TOOLS += csi
endif

CHICKEN_MAKE_OPTS = \
	ARCH= \
	HOSTSYSTEM="$(CHICKEN_TARGET_SYSTEM)" \
	TARGET_FEATURES="-no-feature-x86 -feature $(ARCH)" \
	PREFIX="/usr" \
	PLATFORM=linux

define CHICKEN_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE1) -C $(@D) $(CHICKEN_MAKE_OPTS)
endef

define CHICKEN_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE1) -C $(@D) $(CHICKEN_MAKE_OPTS) \
		DESTDIR="$(TARGET_DIR)" install
	for file in $(CHICKEN_TOOLS); do \
		rm -f $(TARGET_DIR)/usr/bin/$${file}; \
	done
	rm -rf $(TARGET_DIR)/usr/share/chicken
endef

define CHICKEN_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE1) -C $(@D) $(CHICKEN_MAKE_OPTS) \
		DESTDIR="$(STAGING_DIR)" install
endef

HOST_CHICKEN_DEPENDENCIES = toolchain

HOST_CHICKEN_MAKE_OPTS = \
	PREFIX="$(HOST_DIR)/usr" \
	TARGETSYSTEM="$(CHICKEN_TARGET_SYSTEM)" \
	PROGRAM_PREFIX="$(CHICKEN_TARGET_SYSTEM)-" \
	TARGET_PREFIX="$(TARGET_DIR)/usr" \
	TARGET_RUN_PREFIX="/usr" \
	PLATFORM=linux

define HOST_CHICKEN_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE1) $(HOST_CHICKEN_MAKE_OPTS) -C $(@D)
endef

define HOST_CHICKEN_INSTALL_CMDS
	$(TARGET_MAKE_ENV) $(MAKE1) $(HOST_CHICKEN_MAKE_OPTS) -C $(@D) install
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
