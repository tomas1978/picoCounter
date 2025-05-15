@
@ Assembler program to make a counter showing numbers 0,..,9
@ on a 7-segment display using the Pico SDK.
@ Counts from 0 up to 9, then counts back to 0, and repeats
@
	
	.EQU	GPIO_OUT, 1
	.EQU	sleep_time, 500

.thumb_func		@ Necessary because sdk uses BLX
.global main    @ Provide program starting address

main:
	MOV	R4, #0 	@First GPIO pin number
	MOV R5, #6 	@Last GPIO pin number
init_loop:	
	MOV R0, R4 	@Move GPIO number to paramter 1
	BL	gpio_init
	MOV	R0, R4  @Move GPIO number to paramter 1
	MOV	R1, #GPIO_OUT @Second parameter: Direction Output=1	
	BL	link_gpio_set_dir
	ADD R4, #1
	CMP R4, R5
	BLE init_loop
	
	LDR R6, =led_patterns
	MOV R5, #10 @Max value of counter
	
loop: 
	MOV R4, #0 @Loop counter
	MOV R7, #0 @Offset for array address
counter_loop:
	LDR R0, [R6,R7] 
	BL	link_gpio_put_all
	LDR	R0, =sleep_time
	BL	sleep_ms
	ADD R7, #4
	ADD R4, #1
	CMP R4, R5
	BLT counter_loop
	
	MOV R4, #0
reverse_count_loop:
	SUB R7, #4
	LDR R0, [R6,R7] 
	BL	link_gpio_put_all
	LDR	R0, =sleep_time
	BL	sleep_ms
	ADD R4, #1
	CMP R4, R5
	BLT reverse_count_loop
	
	B loop

.data
.align 4
led_patterns: 	.word 0b00111111	@0
				.word 0b00000110 	@1
				.word 0b01011011 	@2
				.word 0b01001111 	@3
				.word 0b01100110	@4
				.word 0b01101101 	@5
				.word 0b01111101	@6
				.word 0b00000111 	@7
				.word 0b01111111	@8
				.word 0b01101111	@9