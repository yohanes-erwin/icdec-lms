from pynq import Overlay
from pynq import MMIO
from pynq import allocate
import numpy as np

# Program bitstream to FPGA
overlay = Overlay('/home/ubuntu/fpga_2.bit')

# Access to AXI DMA
dma = overlay.axi_dma_0
dma_send = overlay.axi_dma_0.sendchannel
dma_recv = overlay.axi_dma_0.recvchannel

# Allocate physical memory
input_buffer = allocate(shape=(8,), dtype=np.uint32)
output_buffer = allocate(shape=(8,), dtype=np.uint32)

# Write input
for i in range(8):
    a = i + 1
    b = 8 - i
    y = i + 1
    input_buffer[i] = (y << 16) | (b << 8) | a
    
# Check the written data
for i in range(8):
    print("0x%08X" % (input_buffer[i]))
    
# Do AXI DMA MM2S transfer
dma_send.transfer(input_buffer)
# Do AXI DMA S2MM transfer
dma_recv.transfer(output_buffer)

# Check the memory content after DMA transfer
for i in range(8):
    print("%d" % (output_buffer[i]))
    
# Delete buffer to prevent memory leak
del input_buffer, output_buffer