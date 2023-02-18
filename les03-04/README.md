Реализация через 3 скрипта с перезагрузками между ними.
Выполнение перезагрузок и скриптов 2 и 3 закоментированы и не проверены.
При выполнении скрипта 1 не происходит перенос root на временный раздел (видим в выводе последней команды скрипта lsblk).
Вот что видим при выполнении vagrant up:


==> lvm: Running provisioner: shell...
    lvm: Running: /tmp/vagrant-shell20230122-70373-2eo1d7.sh
    lvm:   Physical volume "/dev/sdb" successfully created.
    lvm:   Volume group "vg_root" successfully created
    lvm:   Logical volume "lv_root" created.
    lvm: meta-data=/dev/vg_root/lv_root   isize=512    agcount=4, agsize=655104 blks
    lvm:          =                       sectsz=512   attr=2, projid32bit=1
    lvm:          =                       crc=1        finobt=0, sparse=0
    lvm: data     =                       bsize=4096   blocks=2620416, imaxpct=25
    lvm:          =                       sunit=0      swidth=0 blks
    lvm: naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
    lvm: log      =internal log           bsize=4096   blocks=2560, version=2
    lvm:          =                       sectsz=512   sunit=0 blks, lazy-count=1
    lvm: realtime =none                   extsz=4096   blocks=0, rtextents=0
    lvm: xfsrestore: using file dump (drive_simple) strategy
    lvm: xfsrestore: version 3.1.7 (dump format 3.0)
    lvm: /dev/tty: No such device or address
    lvm: xfsdump: using file dump (drive_simple) strategy
    lvm: xfsdump: version 3.1.7 (dump format 3.0)
    lvm: xfsdump: level 0 dump of lvm:/
    lvm: xfsdump: dump date: Sun Jan 22 06:06:07 2023
    lvm: xfsdump: session id: 57bb516f-4627-4018-b419-c650705a4bff
    lvm: xfsdump: session label: ""
    lvm: xfsrestore: searching media for dump
    lvm: xfsdump: ino map phase 1: constructing initial dump list
    lvm: xfsdump: ino map phase 2: skipping (no pruning necessary)
    lvm: xfsdump: ino map phase 3: skipping (only one dump stream)
    lvm: xfsdump: ino map construction complete
    lvm: xfsdump: estimated dump size: 846133184 bytes
    lvm: xfsdump: creating dump session media file 0 (media 0, file 0)
    lvm: xfsdump: dumping ino map
    lvm: xfsdump: dumping directories
    lvm: xfsrestore: examining media file 0
    lvm: xfsrestore: dump description:
    lvm: xfsrestore: hostname: lvm
    lvm: xfsrestore: mount point: /
    lvm: xfsrestore: volume: /dev/mapper/VolGroup00-LogVol00
    lvm: xfsrestore: session time: Sun Jan 22 06:06:07 2023
    lvm: xfsrestore: level: 0
    lvm: xfsrestore: session label: ""
    lvm: xfsrestore: media label: ""
    lvm: xfsrestore: file system id: b60e9498-0baa-4d9f-90aa-069048217fee
    lvm: xfsrestore: session id: 57bb516f-4627-4018-b419-c650705a4bff
    lvm: xfsrestore: media id: 07d24561-b455-4573-9bc5-1aa1e1842a24
    lvm: xfsrestore: searching media for directory dump
    lvm: xfsrestore: reading directories
    lvm: xfsdump: dumping non-directory files
    lvm: xfsrestore: 2700 directories and 23650 entries processed
    lvm: xfsrestore: directory post-processing
    lvm: xfsrestore: restoring non-directory files
    lvm: xfsdump: ending media file
    lvm: xfsdump: media file size 823093712 bytes
    lvm: xfsdump: dump size (non-dir files) : 809911968 bytes
    lvm: xfsdump: dump complete: 8 seconds elapsed
    lvm: xfsdump: Dump Status: SUCCESS
    lvm: xfsrestore: restore complete: 8 seconds elapsed
    lvm: xfsrestore: Restore Status: SUCCESS
    lvm: bash: no job control in this shell
    lvm: [root@lvm /]# exit
    lvm: Generating grub configuration file ...
    lvm: Found linux image: /boot/vmlinuz-3.10.0-862.2.3.el7.x86_64
    lvm: Found initrd image: /boot/initramfs-3.10.0-862.2.3.el7.x86_64.img
    lvm: Found CentOS Linux release 7.5.1804 (Core)  on /dev/mapper/vg_root-lv_root
    lvm: done
    lvm: Executing: /sbin/dracut -v initramfs-3.10.0-862.2.3.el7.x86_64.img 3.10.0-862.2.3.el7.x86_64 --force
    lvm: dracut module 'busybox' will not be installed, because command 'busybox' could not be found!
    lvm: dracut module 'crypt' will not be installed, because command 'cryptsetup' could not be found!
    lvm: dracut module 'dmraid' will not be installed, because command 'dmraid' could not be found!
    lvm: dracut module 'dmsquash-live-ntfs' will not be installed, because command 'ntfs-3g' could not be found!
    lvm: dracut module 'multipath' will not be installed, because command 'multipath' could not be found!
    lvm: dracut module 'busybox' will not be installed, because command 'busybox' could not be found!
    lvm: dracut module 'crypt' will not be installed, because command 'cryptsetup' could not be found!
    lvm: dracut module 'dmraid' will not be installed, because command 'dmraid' could not be found!
    lvm: dracut module 'dmsquash-live-ntfs' will not be installed, because command 'ntfs-3g' could not be found!
    lvm: dracut module 'multipath' will not be installed, because command 'multipath' could not be found!
    lvm: *** Including module: bash ***
    lvm: *** Including module: nss-softokn ***
    lvm: *** Including module: i18n ***
    lvm: *** Including module: drm ***
    lvm: *** Including module: plymouth ***
    lvm: *** Including module: dm ***
    lvm: Skipping udev rule: 64-device-mapper.rules
    lvm: Skipping udev rule: 60-persistent-storage-dm.rules
    lvm: Skipping udev rule: 55-dm.rules
    lvm: *** Including module: kernel-modules ***
    lvm: Omitting driver floppy
    lvm: *** Including module: lvm ***
    lvm: Skipping udev rule: 64-device-mapper.rules
    lvm: Skipping udev rule: 56-lvm.rules
    lvm: Skipping udev rule: 60-persistent-storage-lvm.rules
    lvm: *** Including module: qemu ***
    lvm: *** Including module: resume ***
    lvm: *** Including module: rootfs-block ***
    lvm: *** Including module: terminfo ***
    lvm: *** Including module: udev-rules ***
    lvm: Skipping udev rule: 40-redhat-cpu-hotplug.rules
    lvm: Skipping udev rule: 91-permissions.rules
    lvm: *** Including module: biosdevname ***
    lvm: *** Including module: systemd ***
    lvm: *** Including module: usrmount ***
    lvm: *** Including module: base ***
    lvm: *** Including module: fs-lib ***
    lvm: *** Including module: shutdown ***
    lvm: *** Including modules done ***
    lvm: *** Installing kernel module dependencies and firmware ***
    lvm: *** Installing kernel module dependencies and firmware done ***
    lvm: *** Resolving executable dependencies ***
    lvm: *** Resolving executable dependencies done***
    lvm: *** Hardlinking files ***
    lvm: *** Hardlinking files done ***
    lvm: *** Stripping files ***
    lvm: *** Stripping files done ***
    lvm: *** Generating early-microcode cpio image contents ***
    lvm: *** No early-microcode cpio image needed ***
    lvm: *** Store current command line parameters ***
    lvm: *** Creating image file ***
    lvm: *** Creating image file done ***
    lvm: *** Creating initramfs image file '/boot/initramfs-3.10.0-862.2.3.el7.x86_64.img' done ***
    lvm: NAME                    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
    lvm: sda                       8:0    0   40G  0 disk
    lvm: ├─sda1                    8:1    0    1M  0 part
    lvm: ├─sda2                    8:2    0    1G  0 part /mnt/root/boot
    lvm: └─sda3                    8:3    0   39G  0 part
    lvm:   ├─VolGroup00-LogVol00 253:0    0 37.5G  0 lvm  /
    lvm:   └─VolGroup00-LogVol01 253:1    0  1.5G  0 lvm  [SWAP]
    lvm: sdb                       8:16   0   10G  0 disk
    lvm: └─vg_root-lv_root       253:2    0   10G  0 lvm  /mnt/root
    lvm: sdc                       8:32   0    2G  0 disk
    lvm: sdd                       8:48   0    1G  0 disk
    lvm: sde                       8:64   0    1G  0 disk

