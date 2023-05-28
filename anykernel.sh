### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers
# Edited by DawfukFR

### AnyKernel setup
# begin properties
properties() { '
kernel.string=Stellaris Kernel
do.devicecheck=0
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
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

# FUSE Passthrough
ui_print " ";
ui_print "Remount /system for write to /system/build.prop";
BBOX="$home/tools/busybox"
$BBOX mount -o rw,remount /system
ui_print " ";
ui_print "Patching system's build prop for FUSE Passthrough..." 
patch_prop /system/build.prop "persist.sys.fuse.passthrough.enable" "true" 

case "$ZIPFILE" in
    *ksu*)
    ui_print " • Using KSU variant";
    rm Image;
    mv ksu/Image $home/Image;
    ;;
    *)
    ui_print " • Using normal variant";
    ;;
esac

# boot install
dump_boot; # use split_boot to skip ramdisk unpack, e.g. for devices with init_boot ramdisk

vbmeta_disable_verification;

write_boot; # use flash_boot to skip ramdisk repack, e.g. for devices with init_boot ramdisk
## end boot install
