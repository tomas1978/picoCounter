@
@ Assembler program to flash three LEDs connected to the
@ Raspberry Pi Pico GPIO port using the Pico SDK.
@
	.EQU	START_PIN, 0
	.EQU 	END_PIN, 7
	.EQU	GPIO_OUT, 1
	.EQU	sleep_time, 1000

.thumb_func	@ Necessary because sdk uses BLX
.global main    @ Provide program starting address

main:
	MOV R4, #START_PIN
	init_loop:	@Init all pins from 0 up to END_PIN 
		MOV R0, R4
		BL	gpio_init
		MOV	R0, R4
		MOV	R1, #GPIO_OUT
		BL	link_gpio_set_dir
		MOV R0, #END_PIN
		ADD R4, #1
		CMP R4, R0
		BLE init_loop

loop:   
	MOV R5, #1	@Starting value for counter
	MOV R6, #0	@Memory offset for bit pattern array
	counter_loop:
		LDR R4, =counterPatterns
		LDR R0, [R4, R6]
		BL link_gpio_put_all

		LDR R0, =sleep_time
		BL sleep_ms

		ADD R6, #4
		CMP R6, #3
		BLT counter_loop 
	B loop

.data
counterPatterns: .word 0b00000110, 0b01011011, 0b01001111, 0b01100110