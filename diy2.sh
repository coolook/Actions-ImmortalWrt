#!/bin/sh
echo '

define KernelPackage/xdp-sockets-diag
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=PF_XDP sockets monitoring interface support for ss utility
  KCONFIG:= \
	CONFIG_XDP_SOCKETS=y \
	CONFIG_XDP_SOCKETS_DIAG
  FILES:=$(LINUX_DIR)/net/xdp/xsk_diag.ko
  AUTOLOAD:=$(call AutoLoad,31,xsk_diag)
endef

define KernelPackage/xdp-sockets-diag/description
 Support for PF_XDP sockets monitoring interface used by the ss tool
endef

$(eval $(call KernelPackage,xdp-sockets-diag))
' >> package/kernel/linux/modules/netsupport.mk


echo '
CONFIG_DEVEL=y
CONFIG_BPF_TOOLCHAIN_HOST=y
# CONFIG_BPF_TOOLCHAIN_NONE is not set
CONFIG_KERNEL_BPF_EVENTS=y
CONFIG_KERNEL_CGROUP_BPF=y
CONFIG_KERNEL_DEBUG_INFO=y
CONFIG_KERNEL_DEBUG_INFO_BTF=y
# CONFIG_KERNEL_DEBUG_INFO_REDUCED is not set

CONFIG_PACKAGE_kmod-xdp-sockets-diag=y
' >> .config
