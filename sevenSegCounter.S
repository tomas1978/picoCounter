@
@ Assembler program to show a counter in a 7-seg display.
@ Segments A, B, C, ... are connected to
@ GP0, GP1, GP2, ... respectively
@ C functions are used to initialize the pins.
@
@
	.EQU SEG_A, 0
	.EQU SEG_B, 1
	.EQU SEG_C, 2
	.EQU SEG_D, 3
	.EQU SEG_E, 4
	.EQU SEG_F, 5
	.EQU SEG_G, 6
	
	.EQU GPIO_OUT, 1

	.EQU sleep_time,	200

.thumb_func
.global main	        @ Provide program starting address

.align  4			@ necessary alignment

main:
@ Init each of the four pins and set them to output
	MOV	R0, #SEG_A	
	bl gpio_init
	MOV	R0, #SEG_A	
	MOV R1, #GPIO_OUT	
	BL	link_gpio_set_dir

	MOV	R0, #SEG_B	
	bl gpio_init
	MOV	R0, #SEG_B	
	MOV R1, #GPIO_OUT	
	BL	link_gpio_set_dir

	MOV	R0, #SEG_C	
	bl gpio_init
	MOV	R0, #SEG_C	
	MOV R1, #GPIO_OUT	
	BL	link_gpio_set_dir

	MOV	R0, #SEG_D	
	bl gpio_init
	MOV	R0, #SEG_D	
	MOV R1, #GPIO_OUT	
	BL	link_gpio_set_dir

	MOV	R0, #SEG_E	
	bl gpio_init
	MOV	R0, #SEG_E	
	MOV R1, #GPIO_OUT	
	BL	link_gpio_set_dir

	MOV	R0, #SEG_F	
	bl gpio_init
	MOV	R0, #SEG_F	
	MOV R1, #GPIO_OUT	
	BL	link_gpio_set_dir

	MOV	R0, #SEG_G	
	bl gpio_init
	MOV	R0, #SEG_G	
	MOV R1, #GPIO_OUT	
	BL	link_gpio_set_dir

	

loop:
@ Turn each pin on, sleep and then turn the pin off
	mov R5, #0xd0		//Put number 0x000000d0
	lsl r5, #24			//SIO base address 0xd0000000 in r2

	mov r6, #0b01111111		//Used to set bits for pins 0-6
	str r6,[r5, #0x14]		//Offset address for SIO_OUT_SET is 0x14

	
    B       loop	@ loop forever

