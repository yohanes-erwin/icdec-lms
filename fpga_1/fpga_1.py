from pynq import Overlay
from pynq import MMIO

# Program bitstream to FPGA
overlay = Overlay('/home/ubuntu/fpga_1.bit')

# Access to memory map of the AXI GPIO
ADDR_BASE = 0xA0000000
ADDR_RANGE = 0x10000
gpio_obj = MMIO(ADDR_BASE, ADDR_RANGE)

# Write data to AXI GPIO input A
gpio_obj.write(0x0, 9)

# Read data from AXI GPIO output Y
gpio_obj.read(0x8)