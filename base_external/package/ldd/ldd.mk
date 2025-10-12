################################################################################
#
# ldd
#
################################################################################

LDD_VERSION = 87cc39d561a7e97843e2a21691b567446d6c66fe
# Use your GitHub SSH repo (so it works with Buildroot automation)
LDD_SITE = git@github.com:cu-ecen-aeld/assignment-7-VrushabhGadaCU.git
LDD_SITE_METHOD = git

LDD_GIT_SUBMODULES = YES
LDD_MODULE_SUBDIRS = misc-modules scull

# Build
define LDD_BUILD_CMDS
	$(MAKE) -C $(LINUX_DIR) M=$(@D)/misc-modules $(LINUX_MAKE_FLAGS) EXTRA_CFLAGS="-I$(@D)/include" modules
	$(MAKE) -C $(LINUX_DIR) M=$(@D)/scull $(LINUX_MAKE_FLAGS) EXTRA_CFLAGS="-I$(@D)/include" modules
endef

# Install 
define LDD_INSTALL_TARGET_CMDS
    mkdir -p $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra
	$(INSTALL) -m 0755 $(@D)/misc-modules/*.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra
	$(INSTALL) -m 0755 $(@D)/scull/*.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra
	mkdir -p $(TARGET_DIR)/etc/init.d
	$(INSTALL) -m 0755 $(@D)/init/S99ldd $(TARGET_DIR)/etc/init.d/
endef

$(eval $(kernel-module))
$(eval $(generic-package))