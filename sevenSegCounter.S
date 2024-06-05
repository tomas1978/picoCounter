@
@ Assembler program to show a counter in a 7-seg display.
@ Segments A, B, C, ... are connected to
@ GP0, GP1, GP2, ... respectively
@ C functions are used to initialize the pins.
@
@

#include "hardware/regs/addressmap.h"
#include "hardware/regs/sio.h"


.EQU GPIO_OUT, 1
.EQU sleep_time, 200	@ Used with the sleep_ms function

.thumb_func
.global main	        @ Provide program starting address

.align  4			@ necessary alignment

main:
@ Init each of the 7 pins on GP7-GP0 and set them to output
	MOV R5, #7	//Used as counter for GPIO number
	initLoop:
		MOV	R0, R5	
		bl gpio_init
		MOV	R0, R5	
		MOV R1, #GPIO_OUT	
		BL	link_gpio_set_dir
		SUB R5, #1
		BGE initLoop


	

loop:
@ Turn each pin on, sleep and then turn the pin off
	LDR	R5, gpiobase	//Load address of SIO base

	mov r6, #0b01111111		//Used to set bits for pins 0-6
	str r6,[r5, #SIO_GPIO_OUT_SET_OFFSET]	//Set pins to high

	
    B       loop	@ loop forever


.align  4	@ necessary alignment
gpiobase:	.word	SIO_BASE     @ base of the GPIO registers
