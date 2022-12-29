#!/bin/bash

# Based on https://christitus.com/laptop-power-management/

cpupower -c all frequency-set -g performance

# Disable Turbo
# Turbo will draw more power and reduce battery life while increasing CPU temperature.
# Run the following from a root user:
echo 0 > /sys/devices/system/cpu/intel_pstate/no_turbo

# Turn off CPU Cores
# The more CPU cores that your laptop uses, the power it will draw. On higher end laptops you can see as big as a 75% savings and extend the battery life x3.
# Taking a CPU core offline (Note: you can’t offline cpu0)
# for ((i=4;i<$(nproc);i++)); do echo 0 > /sys/devices/system/cpu/cpu$i/online; done

