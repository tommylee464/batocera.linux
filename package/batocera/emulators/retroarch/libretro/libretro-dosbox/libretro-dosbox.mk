################################################################################
#
# DOSBOX
#
################################################################################
# Version.: Commits on Jan 15, 2020
LIBRETRO_DOSBOX_VERSION = 86c16df88d72a520ca454129899ed3f30646fb6f
LIBRETRO_DOSBOX_SITE = https://github.com/libretro/dosbox-svn.git
LIBRETRO_DOSBOX_SITE_METHOD=git
LIBRETRO_DOSBOX_GIT_SUBMODULES=YES
LIBRETRO_DOSBOX_DEPENDENCIES = sdl sdl_net
LIBRETRO_DOSBOX_LICENSE = GPLv2

# x86
ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_X86),y)
	LIBRETRO_DOSBOX_EXTRA_ARGS = target=x86 WITH_EMBEDDED_SDL=0
endif

# x86_64
ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_X86_64),y)
	LIBRETRO_DOSBOX_EXTRA_ARGS = target=x86_64 WITH_EMBEDDED_SDL=0
endif

ifeq ($(BR2_arm),y)
	LIBRETRO_DOSBOX_EXTRA_ARGS = target=arm WITH_EMBEDDED_SDL=0
endif

define LIBRETRO_DOSBOX_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" \
		-C $(@D)/libretro -f Makefile.libretro platform=$(BATOCERA_SYSTEM) $(LIBRETRO_DOSBOX_EXTRA_ARGS)
endef

define LIBRETRO_DOSBOX_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/libretro/dosbox_svn_libretro.so \
	  $(TARGET_DIR)/usr/lib/libretro/dosbox_libretro.so
endef

$(eval $(generic-package))
