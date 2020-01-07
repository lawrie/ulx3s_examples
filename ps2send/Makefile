VERILOG = uart_to_ps2.v ps2_send.v PushButton_Debouncer.v async_receiver.v BaudTickGen.v

include ../ulx3s.mk

tb: tb.v $(VERILOG)
	iverilog -o tb tb.v ps2_send.v

sim: tb
	./tb

