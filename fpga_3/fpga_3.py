from pynq import Overlay
from pynq import MMIO
import numpy as np

# Program bitstream to FPGA
overlay = Overlay('/home/ubuntu/fpga_3.bit')

# Access to memory map of the AXI GPIO 0
GPIO0_ADDR_BASE = 0xA0000000
GPIO0_ADDR_RANGE = 0x10000
gpio0_obj = MMIO(GPIO0_ADDR_BASE, GPIO0_ADDR_RANGE)

# Access to memory map of the BRAM 0
BRAM0_ADDR_BASE = 0xA0010000
BRAM0_ADDR_RANGE = 0x2000
bram0_obj = MMIO(BRAM0_ADDR_BASE, BRAM0_ADDR_RANGE)

# Access to memory map of the BRAM 1
BRAM1_ADDR_BASE = 0xA0012000
BRAM1_ADDR_RANGE = 0x2000
bram1_obj = MMIO(BRAM1_ADDR_BASE, BRAM1_ADDR_RANGE)

# Input array
input_data = np.zeros((8,), dtype=np.uint32)

# Write input to array
for i in range(8):
    a = i + 1
    b = 8 - i
    y = i + 1
    input_data[i] = (y << 16) | (b << 8) | a
    
# Write array to BRAM 0
j = 0;
for i in range(0,8*4,4):
    bram0_obj.write(i, int(input_data[j]))
    j += 1

# Check BRAM 0
for i in range(0,8*4,4):
    print("0x%08X" % (bram0_obj.read(i)))
    
# Start and wait
gpio0_obj.write(0, 1)
gpio0_obj.write(0, 0)
while (gpio0_obj.read(8) == 0):
    pass
    
# Output array
output_data = np.zeros((8,), dtype=np.uint32)

# Read BRAM 1 to array
j = 0;
for i in range(0,8*4,4):
    output_data[j] = bram1_obj.read(i)
    j += 1
    
# Check output array
for i in range(8):
    print("%d" % output_data[i])
