@
@ Assembler program to flash three LEDs connected to the
@ Raspberry Pi Pico GPIO port using the Pico SDK.
@

	.EQU	SEG_A, 0
	.EQU	SEG_B, 1
	.EQU	SEG_C, 2
	.EQU	SEG_D, 3
	.EQU	SEG_E, 4
	.EQU	SEG_F, 5
	.EQU	SEG_G, 6
	
	.EQU	GPIO_OUT, 1
	.EQU	sleep_time, 500

.thumb_func	@ Necessary because sdk uses BLX
.global main    @ Provide program starting address

main:
	MOV	R0, #SEG_A
	BL	gpio_init
	MOV	R0, #SEG_A
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	MOV	R0, #SEG_B
	BL	gpio_init
	MOV	R0, #SEG_B
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	MOV	R0, #SEG_C
	BL	gpio_init
	MOV	R0, #SEG_C
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	MOV	R0, #SEG_D
	BL	gpio_init
	MOV	R0, #SEG_D
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	MOV	R0, #SEG_E
	BL	gpio_init
	MOV	R0, #SEG_E
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	MOV	R0, #SEG_F
	BL	gpio_init
	MOV	R0, #SEG_F
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	MOV	R0, #SEG_G
	BL	gpio_init
	MOV	R0, #SEG_G
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir

	LDR R6, =led_patterns
	MOV R5, #5 @Max value of counter
	
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
	B loop

.data
.align 4
led_patterns: .word 0b0111111, 0b0000110, 0b1011011, 0b1001111, 0b1100110