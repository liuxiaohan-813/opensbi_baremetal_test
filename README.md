# quik_start

## 1 qemu env

upload the latest qemu：

```
https://www.qemu.org
```

After decompression, install and compile.

```
tar xvf qemu-5.2.0.tar.xz
./configure --target-list=riscv64-softmmu
make
sudo make install
```

## 2 Cross-compilation toolchain

### 2.1 Download the corresponding cross-compilation toolchain from the official website of Xinlai Technology

```
https://nucleisys.com/download.php
```

### 2.2 Prepare the cross-compilation toolchain

```
PATH=$PATH:$HOME/toolchain/gcc/bin:$HOME/toolchain/qemu/bin
```

## 3 compile

### 3.1 compile opensbi

update submodule before compile:
``` bash
git submodule update --init --recursive
```

and then:

``` makefile
make opensbi
```

### 3.2 compile baremetal test case

``` makefile
make firmware
```
## 4 run with qemu

``` bash
$ make run_qemu
qemu-system-riscv64 -M virt -m 256M -nographic -bios opensbi/build/platform/generic/firmware/fw_jump.elf -kernel helloworld/helloworld.elf

OpenSBI v1.6-123-g13abda5
   ____                    _____ ____ _____
  / __ \                  / ____|  _ \_   _|
 | |  | |_ __   ___ _ __ | (___ | |_) || |
 | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
 | |__| | |_) |  __/ | | |____) | |_) || |_
  \____/| .__/ \___|_| |_|_____/|____/_____|
        | |
        |_|

Platform Name               : riscv-virtio,qemu
Platform Features           : medeleg
Platform HART Count         : 1
Platform IPI Device         : aclint-mswi
Platform Timer Device       : aclint-mtimer @ 10000000Hz
Platform Console Device     : uart8250
Platform HSM Device         : ---
Platform PMU Device         : ---
Platform Reboot Device      : syscon-reboot
Platform Shutdown Device    : syscon-poweroff
Platform Suspend Device     : ---
Platform CPPC Device        : ---
Firmware Base               : 0x80000000
Firmware Size               : 317 KB
Firmware RW Offset          : 0x40000
Firmware RW Size            : 61 KB
Firmware Heap Offset        : 0x46000
Firmware Heap Size          : 37 KB (total), 2 KB (reserved), 11 KB (used), 23 KB (free)
Firmware Scratch Size       : 4096 B (total), 1400 B (used), 2696 B (free)
Runtime SBI Version         : 3.0
Standard SBI Extensions     : ipi,pmu,srst,sse,hsm,rfnc,fwft,time,base,legacy,dbcn,dbtr
Experimental SBI Extensions : none

Domain0 Name                : root
Domain0 Boot HART           : 0
Domain0 HARTs               : 0*
Domain0 Region00            : 0x0000000000100000-0x0000000000100fff M: (I,R,W) S/U: (R,W)
Domain0 Region01            : 0x0000000010000000-0x0000000010000fff M: (I,R,W) S/U: (R,W)
Domain0 Region02            : 0x0000000002000000-0x000000000200ffff M: (I,R,W) S/U: ()
Domain0 Region03            : 0x0000000080040000-0x000000008004ffff M: (R,W) S/U: ()
Domain0 Region04            : 0x0000000080000000-0x000000008003ffff M: (R,X) S/U: ()
Domain0 Region05            : 0x000000000c400000-0x000000000c5fffff M: (I,R,W) S/U: (R,W)
Domain0 Region06            : 0x000000000c000000-0x000000000c3fffff M: (I,R,W) S/U: (R,W)
Domain0 Region07            : 0x0000000000000000-0xffffffffffffffff M: () S/U: (R,W,X)
Domain0 Next Address        : 0x0000000080200000
Domain0 Next Arg1           : 0x0000000082200000
Domain0 Next Mode           : S-mode
Domain0 SysReset            : yes
Domain0 SysSuspend          : yes

Boot HART ID                : 0
Boot HART Domain            : root
Boot HART Priv Version      : v1.12
Boot HART Base ISA          : rv64imafdc
Boot HART ISA Extensions    : zicntr,zihpm,smcntrpmf,zicboz,zicbom,sdtrig,svadu
Boot HART PMP Count         : 16
Boot HART PMP Granularity   : 2 bits
Boot HART PMP Address Bits  : 54
Boot HART MHPM Info         : 29 (0xfffffff8)
Boot HART Debug Triggers    : 2 triggers
Boot HART MIDELEG           : 0x0000000000000222
Boot HART MEDELEG           : 0x000000000000b109

RISCV
hello world
```