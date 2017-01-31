#!/bin/sh
# Set CPU to full performance on NVIDIA Jetson TK1 Development Kit
if [ $(id -u) != 0 ]; then
   echo "This script requires root permissions"
   echo "$ sudo "$0""
   exit
fi
 
# To obtain full performance on the CPU (eg: for performance measurements or benchmarking or when you don't care about power draw), you can disable CPU scaling and force the 4 main CPU cores to always run at max performance until reboot:

cd /sys/devices/system/cpu
grep -H . cpuquiet/tegra_cpuquiet/enable
grep . cpu?/online
grep . cpu?/cpufreq/scaling_governor

echo 0 >cpuquiet/tegra_cpuquiet/enable
for i in cpu?; do
  read online <$i/online
  [ "$online" = 1 ] && continue
  echo 1 >$i/online
done
for i in cpu?; do
  echo performance >$i/cpufreq/scaling_governor
done

grep -H . cpuquiet/tegra_cpuquiet/enable
grep . cpu?/online
grep . cpu?/cpufreq/scaling_governor
