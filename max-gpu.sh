#!/bin/sh
# Set CPU to full performance on NVIDIA Jetson TK1 Development Kit
if [ $(id -u) != 0 ]; then
   echo "This script requires root permissions"
   echo "$ sudo "$0""
   exit
fi

# If X11 isn't started, deviceQuery must be run to load GPU drivers
# /home/ubuntu/NVIDIA_CUDA-6.5_Samples/1_Utilities/deviceQuery/deviceQuery >/dev/null 2>&1

cd /sys/kernel/debug/clock

for clock in gbus emc; do
  grep -H . $clock/rate
  read rates <$clock/possible_rates
  for rate in $rates; do
    [ "$rate" = '(kHz)' ] && break
    max_rate=$rate
  done
  echo ${max_rate}000 >override.$clock/rate
  echo 1 >override.$clock/state
  grep . override.$clock/rate override.$clock/state
done
