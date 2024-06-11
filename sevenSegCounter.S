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
.EQU sleep_time, 1000	@ Used with the sleep_ms function

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

	mov r6, #0b00000110		//Bit pattern for digit '1'
	str r6,[r5, #SIO_GPIO_OUT_SET_OFFSET]	//Set pins to high

	ldr r0, =sleep_time
	bl sleep_ms

	str r6,[r5, #SIO_GPIO_OUT_CLR_OFFSET]	//Set pins to 0

	mov r6, #0b01011011		//Bit pattern for digit '2'
	str r6,[r5, #SIO_GPIO_OUT_SET_OFFSET]	//Set pins to high

	ldr r0, =sleep_time
	bl sleep_ms

	str r6,[r5, #SIO_GPIO_OUT_CLR_OFFSET]	//Set pins to 0

	mov r6, #0b11001111		//Bit pattern for digit '3'
	str r6,[r5, #SIO_GPIO_OUT_SET_OFFSET]	//Set pins to high

	ldr r0, =sleep_time
	bl sleep_ms

	str r6,[r5, #SIO_GPIO_OUT_CLR_OFFSET]	//Set pins to 0

	mov r6, #0b01100110		//Bit pattern for digit '4'
	str r6,[r5, #SIO_GPIO_OUT_SET_OFFSET]	//Set pins to high

	ldr r0, =sleep_time
	bl sleep_ms

	str r6,[r5, #SIO_GPIO_OUT_CLR_OFFSET]	//Set pins to 0

	mov r6, #0b01101101		//Bit pattern for digit '5'
	str r6,[r5, #SIO_GPIO_OUT_SET_OFFSET]	//Set pins to high

	ldr r0, =sleep_time
	bl sleep_ms

	str r6,[r5, #SIO_GPIO_OUT_CLR_OFFSET]	//Set pins to 0

	mov r6, #0b01111101		//Bit pattern for digit '6'
	str r6,[r5, #SIO_GPIO_OUT_SET_OFFSET]	//Set pins to high

	ldr r0, =sleep_time
	bl sleep_ms

	str r6,[r5, #SIO_GPIO_OUT_CLR_OFFSET]	//Set pins to 0

	mov r6, #0b00000111		//Bit pattern for digit '7'
	str r6,[r5, #SIO_GPIO_OUT_SET_OFFSET]	//Set pins to high

	ldr r0, =sleep_time
	bl sleep_ms

	str r6,[r5, #SIO_GPIO_OUT_CLR_OFFSET]	//Set pins to 0

	mov r6, #0b11111111		//Bit pattern for digit '7'
	str r6,[r5, #SIO_GPIO_OUT_SET_OFFSET]	//Set pins to high

	ldr r0, =sleep_time
	bl sleep_ms

	str r6,[r5, #SIO_GPIO_OUT_CLR_OFFSET]	//Set pins to 0


    B       loop	@ loop forever


.align  4	@ necessary alignment
gpiobase:	.word	SIO_BASE     @ base of the GPIO registers
