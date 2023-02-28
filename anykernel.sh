### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers
# Edited by DawfukFR

### AnyKernel setup
# begin properties
properties() { '
kernel.string=Stellaris Kernel
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=instantnoodle
device.name2=instantnoodlep
device.name3=opkona
device.name4=kebab
device.name5=OnePlus8
device.name6=OnePlus8Pro
device.name7=OnePlus8T
device.name8=lemonades
device.name9=OnePlus9R
supported.versions=
supported.patchlevels=
'; } # end properties

### AnyKernel install
# begin attributes
attributes() {
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;
} # end attributes

## boot shell variables
block=boot;
is_slot_device=1;
ramdisk_compression=auto;
patch_vbmeta_flag=auto;

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh && attributes;

# boot install
dump_boot; # use split_boot to skip ramdisk unpack, e.g. for devices with init_boot ramdisk

vbmeta_disable_verification;

write_boot; # use flash_boot to skip ramdisk repack, e.g. for devices with init_boot ramdisk
## end boot install
