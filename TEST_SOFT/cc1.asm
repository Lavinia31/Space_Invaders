
;CodeVisionAVR C Compiler V3.51 
;(C) Copyright 1998-2023 Pavel Haiduc, HP InfoTech S.R.L.
;http://www.hpinfotech.ro

;Build configuration    : Release
;Chip type              : ATmega164A
;Program type           : Application
;Clock frequency        : 20.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': No
;'char' is unsigned     : No
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Mode 1
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega164A
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU SPMCSR=0x37
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIOR0=0x1E
	.EQU GPIOR1=0x2A
	.EQU GPIOR2=0x2B

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x04FF
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.EQU __FLASH_PAGE_SIZE=0x40
	.EQU __EEPROM_PAGE_SIZE=0x04

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETW1P
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETD1P_INC
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X+
	.ENDM

	.MACRO __GETD1P_DEC
	LD   R23,-X
	LD   R22,-X
	LD   R31,-X
	LD   R30,-X
	.ENDM

	.MACRO __PUTDP1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTDP1_DEC
	ST   -X,R23
	ST   -X,R22
	ST   -X,R31
	ST   -X,R30
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __CPD10
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	.ENDM

	.MACRO __CPD20
	SBIW R26,0
	SBCI R24,0
	SBCI R25,0
	.ENDM

	.MACRO __ADDD12
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	ADC  R23,R25
	.ENDM

	.MACRO __ADDD21
	ADD  R26,R30
	ADC  R27,R31
	ADC  R24,R22
	ADC  R25,R23
	.ENDM

	.MACRO __SUBD12
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	SBC  R23,R25
	.ENDM

	.MACRO __SUBD21
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R25,R23
	.ENDM

	.MACRO __ANDD12
	AND  R30,R26
	AND  R31,R27
	AND  R22,R24
	AND  R23,R25
	.ENDM

	.MACRO __ORD12
	OR   R30,R26
	OR   R31,R27
	OR   R22,R24
	OR   R23,R25
	.ENDM

	.MACRO __XORD12
	EOR  R30,R26
	EOR  R31,R27
	EOR  R22,R24
	EOR  R23,R25
	.ENDM

	.MACRO __XORD21
	EOR  R26,R30
	EOR  R27,R31
	EOR  R24,R22
	EOR  R25,R23
	.ENDM

	.MACRO __COMD1
	COM  R30
	COM  R31
	COM  R22
	COM  R23
	.ENDM

	.MACRO __MULD2_2
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	.ENDM

	.MACRO __LSRD1
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	.ENDM

	.MACRO __LSLD1
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	.ENDM

	.MACRO __ASRB4
	ASR  R30
	ASR  R30
	ASR  R30
	ASR  R30
	.ENDM

	.MACRO __ASRW8
	MOV  R30,R31
	CLR  R31
	SBRC R30,7
	SER  R31
	.ENDM

	.MACRO __LSRD16
	MOV  R30,R22
	MOV  R31,R23
	LDI  R22,0
	LDI  R23,0
	.ENDM

	.MACRO __LSLD16
	MOV  R22,R30
	MOV  R23,R31
	LDI  R30,0
	LDI  R31,0
	.ENDM

	.MACRO __CWD1
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	.ENDM

	.MACRO __CWD2
	MOV  R24,R27
	ADD  R24,R24
	SBC  R24,R24
	MOV  R25,R24
	.ENDM

	.MACRO __SETMSD1
	SER  R31
	SER  R22
	SER  R23
	.ENDM

	.MACRO __ADDW1R15
	CLR  R0
	ADD  R30,R15
	ADC  R31,R0
	.ENDM

	.MACRO __ADDW2R15
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	.ENDM

	.MACRO __EQB12
	CP   R30,R26
	LDI  R30,1
	BREQ PC+2
	CLR  R30
	.ENDM

	.MACRO __NEB12
	CP   R30,R26
	LDI  R30,1
	BRNE PC+2
	CLR  R30
	.ENDM

	.MACRO __LEB12
	CP   R30,R26
	LDI  R30,1
	BRGE PC+2
	CLR  R30
	.ENDM

	.MACRO __GEB12
	CP   R26,R30
	LDI  R30,1
	BRGE PC+2
	CLR  R30
	.ENDM

	.MACRO __LTB12
	CP   R26,R30
	LDI  R30,1
	BRLT PC+2
	CLR  R30
	.ENDM

	.MACRO __GTB12
	CP   R30,R26
	LDI  R30,1
	BRLT PC+2
	CLR  R30
	.ENDM

	.MACRO __LEB12U
	CP   R30,R26
	LDI  R30,1
	BRSH PC+2
	CLR  R30
	.ENDM

	.MACRO __GEB12U
	CP   R26,R30
	LDI  R30,1
	BRSH PC+2
	CLR  R30
	.ENDM

	.MACRO __LTB12U
	CP   R26,R30
	LDI  R30,1
	BRLO PC+2
	CLR  R30
	.ENDM

	.MACRO __GTB12U
	CP   R30,R26
	LDI  R30,1
	BRLO PC+2
	CLR  R30
	.ENDM

	.MACRO __CPW01
	CLR  R0
	CP   R0,R30
	CPC  R0,R31
	.ENDM

	.MACRO __CPW02
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	.ENDM

	.MACRO __CPD12
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	CPC  R23,R25
	.ENDM

	.MACRO __CPD21
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R25,R23
	.ENDM

	.MACRO __BSTB1
	CLT
	TST  R30
	BREQ PC+2
	SET
	.ENDM

	.MACRO __LNEGB1
	TST  R30
	LDI  R30,1
	BREQ PC+2
	CLR  R30
	.ENDM

	.MACRO __LNEGW1
	OR   R30,R31
	LDI  R30,1
	BREQ PC+2
	LDI  R30,0
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CALL __GETW1Z
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CALL __GETD1Z
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __GETW2X
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __GETD2X
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _rx_wr_index0=R3
	.DEF _rx_rd_index0=R2
	.DEF _rx_counter0=R5
	.DEF _tx_wr_index0=R4
	.DEF _tx_rd_index0=R7
	.DEF _tx_counter0=R6
	.DEF __lcd_x=R9
	.DEF __lcd_y=R8
	.DEF __lcd_maxx=R11

;GPIOR0-GPIOR2 INITIALIZATION VALUES
	.EQU __GPIOR0_INIT=0x00
	.EQU __GPIOR1_INIT=0x00
	.EQU __GPIOR2_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer1_compa_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _usart0_rx_isr
	JMP  0x00
	JMP  _usart0_tx_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_racheta:
	.DB  0x4,0x4,0x4,0x15,0xE,0x1F,0x0,0x0
	.DB  0x0,0x0
_monstru:
	.DB  0x15,0xE,0x1F,0x4,0x1F,0x4,0x4,0x4
	.DB  0x0,0x0
_clear:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0
_b0:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x4
_b1:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x4,0x4
_b2:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x4
	.DB  0x4,0x0
_b3:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x4,0x4
	.DB  0x0,0x0
_b4:
	.DB  0x0,0x0,0x0,0x0,0x0,0x4,0x4,0x0
	.DB  0x0,0x0
_b5:
	.DB  0x0,0x0,0x0,0x0,0x4,0x4,0x0,0x0
	.DB  0x0,0x0
_b6:
	.DB  0x0,0x0,0x0,0x4,0x4,0x0,0x0,0x0
	.DB  0x0,0x0
_b7:
	.DB  0x0,0x0,0x4,0x4,0x0,0x0,0x0,0x0
	.DB  0x0,0x0
_b8:
	.DB  0x0,0x4,0x4,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0
_b9:
	.DB  0x4,0x4,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0
_b10:
	.DB  0x4,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0

_0x1B:
	.DB  LOW(_b0*2),HIGH(_b0*2),LOW(_b1*2),HIGH(_b1*2),LOW(_b2*2),HIGH(_b2*2),LOW(_b3*2),HIGH(_b3*2)
	.DB  LOW(_b4*2),HIGH(_b4*2),LOW(_b5*2),HIGH(_b5*2),LOW(_b6*2),HIGH(_b6*2),LOW(_b7*2),HIGH(_b7*2)
	.DB  LOW(_b8*2),HIGH(_b8*2),LOW(_b9*2),HIGH(_b9*2),LOW(_b10*2),HIGH(_b10*2)
_0x1E:
	.DB  0x2,0x0,0x1,0x0,0x0,0x0,0x10,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x3,0x0
_0x0:
	.DB  0x53,0x54,0x41,0x52,0x54,0x20,0x47,0x41
	.DB  0x4D,0x45,0x21,0x0,0x47,0x41,0x4D,0x45
	.DB  0x20,0x4F,0x56,0x45,0x52,0x21,0x0,0x43
	.DB  0x6F,0x6E,0x67,0x72,0x61,0x74,0x75,0x6C
	.DB  0x61,0x74,0x69,0x6F,0x6E,0x73,0x21,0x59
	.DB  0x4F,0x55,0x27,0x52,0x45,0x20,0x54,0x48
	.DB  0x45,0x20,0x42,0x45,0x53,0x54,0x21,0x0
_0x2040060:
	.DB  0x1
_0x2040000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0
_0x2060003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x16
	.DW  _vector
	.DW  _0x1B*2

	.DW  0x01
	.DW  __seed_G102
	.DW  _0x2040060*2

	.DW  0x02
	.DW  __base_y_G103
	.DW  _0x2060003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	WDR
	IN   R26,MCUSR
	CBR  R26,8
	OUT  MCUSR,R26
	STS  WDTCSR,R31
	STS  WDTCSR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;GPIOR0-GPIOR2 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30
	;__GPIOR1_INIT = __GPIOR0_INIT
	OUT  GPIOR1,R30
	;__GPIOR2_INIT = __GPIOR0_INIT
	OUT  GPIOR2,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0x01

	.DSEG
	.ORG 0x200

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif
        .equ __lcd_port = 0x15 ;PORTC
; 0000 0016         #endasm
;interrupt [21] void usart0_rx_isr(void)
; 0000 0051 {

	.CSEG
_usart0_rx_isr:
; .FSTART _usart0_rx_isr
	RCALL SUBOPT_0x0
; 0000 0052 char status,data;
; 0000 0053 status=UCSR0A;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R17
;	data -> R16
	LDS  R17,192
; 0000 0054 data=UDR0;
	LDS  R16,198
; 0000 0055 if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x3
; 0000 0056 {
; 0000 0057 rx_buffer0[rx_wr_index0++]=data;
	MOV  R30,R3
	INC  R3
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer0)
	SBCI R31,HIGH(-_rx_buffer0)
	ST   Z,R16
; 0000 0058 #if RX_BUFFER_SIZE0 == 256
; 0000 0059 // special case for receiver buffer size=256
; 0000 005A if (++rx_counter0 == 0) rx_buffer_overflow0=1;
; 0000 005B #else
; 0000 005C if (rx_wr_index0 == RX_BUFFER_SIZE0) rx_wr_index0=0;
	LDI  R30,LOW(8)
	CP   R30,R3
	BRNE _0x4
	CLR  R3
; 0000 005D if (++rx_counter0 == RX_BUFFER_SIZE0)
_0x4:
	INC  R5
	LDI  R30,LOW(8)
	CP   R30,R5
	BRNE _0x5
; 0000 005E {
; 0000 005F rx_counter0=0;
	CLR  R5
; 0000 0060 rx_buffer_overflow0=1;
	SBI  0x1E,0
; 0000 0061 }
; 0000 0062 #endif
; 0000 0063 }
_0x5:
; 0000 0064 }
_0x3:
	LD   R16,Y+
	LD   R17,Y+
	RJMP _0x68
; .FEND
;char getchar(void)
; 0000 006B {
; 0000 006C char data;
; 0000 006D while (rx_counter0==0);
;	data -> R17
; 0000 006E data=rx_buffer0[rx_rd_index0++];
; 0000 006F #if RX_BUFFER_SIZE0 != 256
; 0000 0070 if (rx_rd_index0 == RX_BUFFER_SIZE0) rx_rd_index0=0;
; 0000 0071 #endif
; 0000 0072 #asm("cli")
; 0000 0073 --rx_counter0;
; 0000 0074 #asm("sei")
; 0000 0075 return data;
; 0000 0076 }
;interrupt [23] void usart0_tx_isr(void)
; 0000 0086 {
_usart0_tx_isr:
; .FSTART _usart0_tx_isr
	RCALL SUBOPT_0x0
; 0000 0087 if (tx_counter0)
	TST  R6
	BREQ _0xC
; 0000 0088 {
; 0000 0089 --tx_counter0;
	DEC  R6
; 0000 008A UDR0=tx_buffer0[tx_rd_index0++];
	MOV  R30,R7
	INC  R7
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer0)
	SBCI R31,HIGH(-_tx_buffer0)
	LD   R30,Z
	STS  198,R30
; 0000 008B #if TX_BUFFER_SIZE0 != 256
; 0000 008C if (tx_rd_index0 == TX_BUFFER_SIZE0) tx_rd_index0=0;
	LDI  R30,LOW(8)
	CP   R30,R7
	BRNE _0xD
	CLR  R7
; 0000 008D #endif
; 0000 008E }
_0xD:
; 0000 008F }
_0xC:
_0x68:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
; .FEND
;void putchar(char c)
; 0000 0096 {
; 0000 0097 while (tx_counter0 == TX_BUFFER_SIZE0);
;	c -> Y+0
; 0000 0098 #asm("cli")
; 0000 0099 if (tx_counter0 || ((UCSR0A & DATA_REGISTER_EMPTY)==0))
; 0000 009A {
; 0000 009B tx_buffer0[tx_wr_index0++]=c;
; 0000 009C #if TX_BUFFER_SIZE0 != 256
; 0000 009D if (tx_wr_index0 == TX_BUFFER_SIZE0) tx_wr_index0=0;
; 0000 009E #endif
; 0000 009F ++tx_counter0;
; 0000 00A0 }
; 0000 00A1 else
; 0000 00A2 UDR0=c;
; 0000 00A3 #asm("sei")
; 0000 00A4 }
;interrupt [14] void timer1_compa_isr(void)
; 0000 00B1 {
_timer1_compa_isr:
; .FSTART _timer1_compa_isr
; 0000 00B2 //LED1 = ~LED1; // invert LED
; 0000 00B3 }
	RETI
; .FEND
;void define_char(byte flash *pc, byte char_code)
; 0000 016D {
_define_char:
; .FSTART _define_char
; 0000 016E byte i, a;
; 0000 016F a = (char_code<<3) | 0x40;
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
;	*pc -> Y+3
;	char_code -> Y+2
;	i -> R17
;	a -> R16
	LDD  R30,Y+2
	LSL  R30
	LSL  R30
	LSL  R30
	ORI  R30,0x40
	MOV  R16,R30
; 0000 0170 for(i=0;i<10;i++) lcd_write_byte(a++, *pc++);
	LDI  R17,LOW(0)
_0x17:
	CPI  R17,10
	BRSH _0x18
	ST   -Y,R16
	INC  R16
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ADIW R30,1
	STD  Y+4,R30
	STD  Y+4+1,R31
	SBIW R30,1
	LPM  R26,Z
	RCALL _lcd_write_byte
	SUBI R17,-1
	RJMP _0x17
_0x18:
; 0000 0171 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	RET
; .FEND
;void right(int c){
; 0000 0173 void right(int c){
_right:
; .FSTART _right
; 0000 0174 if(c<31){
	RCALL SUBOPT_0x1
;	c -> Y+0
	SBIW R26,31
	BRGE _0x19
; 0000 0175 define_char(racheta,1);
	RCALL SUBOPT_0x2
; 0000 0176 lcd_gotoxy(c+1,1);
	SUBI R30,-LOW(1)
	RCALL SUBOPT_0x3
; 0000 0177 lcd_putchar(1);
; 0000 0178 define_char(clear,2);
; 0000 0179 lcd_gotoxy(c,1);
; 0000 017A lcd_putchar(2);
; 0000 017B delay_ms(150);
	LDI  R26,LOW(150)
	LDI  R27,0
	RCALL _delay_ms
; 0000 017C 
; 0000 017D }
; 0000 017E }
_0x19:
	JMP  _0x20C0002
; .FEND
;void left(int c){
; 0000 0180 void left(int c){
_left:
; .FSTART _left
; 0000 0181 if(c>16){
	RCALL SUBOPT_0x1
;	c -> Y+0
	SBIW R26,17
	BRLT _0x1A
; 0000 0182 define_char(racheta,1);
	RCALL SUBOPT_0x2
; 0000 0183 lcd_gotoxy(c-1,1);
	SUBI R30,LOW(1)
	RCALL SUBOPT_0x3
; 0000 0184 lcd_putchar(1);
; 0000 0185 define_char(clear,2);
; 0000 0186 lcd_gotoxy(c,1);
; 0000 0187 lcd_putchar(2);
; 0000 0188 delay_ms(250);
	LDI  R26,LOW(250)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0189 }
; 0000 018A }
_0x1A:
	JMP  _0x20C0002
; .FEND

	.DSEG
;void afisare(int b,int c, int r, int idx, int v){
; 0000 018D void afisare(int b,int c, int r, int idx, int v){

	.CSEG
_afisare:
; .FSTART _afisare
; 0000 018E if(v==2){
	RCALL SUBOPT_0x1
;	b -> Y+8
;	c -> Y+6
;	r -> Y+4
;	idx -> Y+2
;	v -> Y+0
	SBIW R26,2
	BRNE _0x1C
; 0000 018F define_char(vector[b],3);
	RCALL SUBOPT_0x4
; 0000 0190 define_char(vector[11-b],4);
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(11)
	LDI  R31,HIGH(11)
	SUB  R30,R26
	SBC  R31,R27
	LDI  R26,LOW(_vector)
	LDI  R27,HIGH(_vector)
	RCALL SUBOPT_0x5
	LD   R30,X+
	LD   R31,X+
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(4)
	RCALL _define_char
; 0000 0191 lcd_gotoxy(c,r);
	RCALL SUBOPT_0x6
; 0000 0192 lcd_putchar(3);
; 0000 0193 lcd_gotoxy(idx,r);
	LDD  R30,Y+2
	ST   -Y,R30
	LDD  R26,Y+5
	RCALL _lcd_gotoxy
; 0000 0194 lcd_putchar(4);
	LDI  R26,LOW(4)
	RCALL SUBOPT_0x7
; 0000 0195 delay_ms(30);
; 0000 0196 }
; 0000 0197 if(v==0){
_0x1C:
	LD   R30,Y
	LDD  R31,Y+1
	SBIW R30,0
	BRNE _0x1D
; 0000 0198 define_char(vector[b],3);
	RCALL SUBOPT_0x4
; 0000 0199 lcd_gotoxy(c,r);
	RCALL SUBOPT_0x6
; 0000 019A lcd_putchar(3);
; 0000 019B delay_ms(30);}
	LDI  R26,LOW(30)
	LDI  R27,0
	RCALL _delay_ms
; 0000 019C }
_0x1D:
	ADIW R28,10
	RET
; .FEND
;void cl(int c, int r){
; 0000 019D void cl(int c, int r){
_cl:
; .FSTART _cl
; 0000 019E define_char(clear,2);
	ST   -Y,R27
	ST   -Y,R26
;	c -> Y+2
;	r -> Y+0
	LDI  R30,LOW(_clear*2)
	LDI  R31,HIGH(_clear*2)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(2)
	RCALL _define_char
; 0000 019F lcd_gotoxy(c,r);
	LDD  R30,Y+2
	ST   -Y,R30
	LDD  R26,Y+1
	RCALL _lcd_gotoxy
; 0000 01A0 lcd_putchar(2);
	LDI  R26,LOW(2)
	RCALL SUBOPT_0x7
; 0000 01A1 delay_ms(30);
; 0000 01A2 }
	ADIW R28,4
	RET
; .FEND
;void main (void)
; 0000 01A4 {   int col=23, rand=1;
_main:
; .FSTART _main
; 0000 01A5 int k,j;
; 0000 01A6 int i=3;
; 0000 01A7 int matr[2][16]={0};
; 0000 01A8 int nr=0;
; 0000 01A9 int index=16;
; 0000 01AA int verif=0;
; 0000 01AB int nr1=1;
; 0000 01AC int nr2=2;
; 0000 01AD 
; 0000 01AE 
; 0000 01AF LED1 = 0;
	SBIW R28,63
	SBIW R28,15
	LDI  R24,76
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x1E*2)
	LDI  R31,HIGH(_0x1E*2)
	RCALL __INITLOCB
;	col -> R16,R17
;	rand -> R18,R19
;	k -> R20,R21
;	j -> Y+76
;	i -> Y+74
;	matr -> Y+10
;	nr -> Y+8
;	index -> Y+6
;	verif -> Y+4
;	nr1 -> Y+2
;	nr2 -> Y+0
	__GETWRN 16,17,23
	__GETWRN 18,19,1
	CBI  0xB,6
; 0000 01B0 lcd_init(416);
	LDI  R26,LOW(160)
	RCALL _lcd_init
; 0000 01B1 lcd_gotoxy(0,0);
	RCALL SUBOPT_0x8
; 0000 01B2 lcd_putsf("START GAME!");
	__POINTW2FN _0x0,0
	RCALL _lcd_putsf
; 0000 01B3 delay_ms(3000);
	LDI  R26,LOW(3000)
	LDI  R27,HIGH(3000)
	RCALL _delay_ms
; 0000 01B4 lcd_init(416);
	LDI  R26,LOW(160)
	RCALL _lcd_init
; 0000 01B5 for(j=0;j<2;j++)
	LDI  R30,LOW(0)
	__CLRW1SX 76
_0x22:
	__GETW2SX 76
	SBIW R26,2
	BRGE _0x23
; 0000 01B6 for(k=0;k<16;k++){
	__GETWRN 20,21,0
_0x25:
	__CPWRN 20,21,16
	BRGE _0x26
; 0000 01B7 define_char(monstru,0);
	LDI  R30,LOW(_monstru*2)
	LDI  R31,HIGH(_monstru*2)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _define_char
; 0000 01B8 lcd_gotoxy(k,j);
	ST   -Y,R20
	__GETB2SX 77
	RCALL _lcd_gotoxy
; 0000 01B9 lcd_putchar(0);
	LDI  R26,LOW(0)
	RCALL _lcd_putchar
; 0000 01BA }
	__ADDWRN 20,21,1
	RJMP _0x25
_0x26:
	MOVW R26,R28
	SUBI R26,LOW(-(76))
	SBCI R27,HIGH(-(76))
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RJMP _0x22
_0x23:
; 0000 01BB 
; 0000 01BC define_char(racheta,1);
	LDI  R30,LOW(_racheta*2)
	LDI  R31,HIGH(_racheta*2)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _define_char
; 0000 01BD lcd_gotoxy(col,rand);
	ST   -Y,R16
	MOV  R26,R18
	RCALL _lcd_gotoxy
; 0000 01BE lcd_putchar(1);
	LDI  R26,LOW(1)
	RCALL _lcd_putchar
; 0000 01BF while(1){
_0x27:
; 0000 01C0 if(RIGHT==0){
	SBIC 0x3,1
	RJMP _0x2A
; 0000 01C1 right(col);
	RCALL SUBOPT_0x9
; 0000 01C2 col++;
; 0000 01C3 }
; 0000 01C4 
; 0000 01C5 if(LEFT==0){
_0x2A:
	SBIC 0x3,0
	RJMP _0x2B
; 0000 01C6 left(col);
	RCALL SUBOPT_0xA
; 0000 01C7 col--;
; 0000 01C8 }
; 0000 01C9 
; 0000 01CA if(BULLET==0){
_0x2B:
	SBIC 0x3,2
	RJMP _0x2C
; 0000 01CB if(matr[1][col-16]==0){
	RCALL SUBOPT_0xB
	RCALL SUBOPT_0xC
	BREQ PC+2
	RJMP _0x2D
; 0000 01CC j=col;
	RCALL SUBOPT_0xD
; 0000 01CD if(index%4==0&&matr[1][index-16]==0)
	RCALL SUBOPT_0xE
	BRNE _0x2F
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	RCALL SUBOPT_0xF
	RCALL SUBOPT_0xC
	BREQ _0x30
_0x2F:
	RJMP _0x2E
_0x30:
; 0000 01CE verif=nr2;
	LD   R30,Y
	LDD  R31,Y+1
	STD  Y+4,R30
	STD  Y+4+1,R31
; 0000 01CF else
	RJMP _0x31
_0x2E:
; 0000 01D0 verif=0;
	LDI  R30,LOW(0)
	STD  Y+4,R30
	STD  Y+4+1,R30
; 0000 01D1 for (k = 0; k < 11; k++){
_0x31:
	__GETWRN 20,21,0
_0x33:
	__CPWRN 20,21,11
	BRGE _0x34
; 0000 01D2 afisare(k,j, 0,index, verif);
	RCALL SUBOPT_0x10
; 0000 01D3 if(RIGHT==0){
	SBIC 0x3,1
	RJMP _0x35
; 0000 01D4 right(col);
	RCALL SUBOPT_0x9
; 0000 01D5 col++;
; 0000 01D6 }
; 0000 01D7 
; 0000 01D8 if(LEFT==0){
_0x35:
	SBIC 0x3,0
	RJMP _0x36
; 0000 01D9 left(col);
	RCALL SUBOPT_0xA
; 0000 01DA col--;
; 0000 01DB }
; 0000 01DC }
_0x36:
	__ADDWRN 20,21,1
	RJMP _0x33
_0x34:
; 0000 01DD if(verif==2)
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	SBIW R26,2
	BRNE _0x37
; 0000 01DE cl(index,0);
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	RCALL SUBOPT_0x11
; 0000 01DF 
; 0000 01E0 cl(j,0);
_0x37:
	RCALL SUBOPT_0x12
	RCALL SUBOPT_0x11
; 0000 01E1 matr[1][j-16]=2;
	RCALL SUBOPT_0x12
	RCALL SUBOPT_0xF
	RCALL SUBOPT_0x13
; 0000 01E2 nr++;
; 0000 01E3 if(index==col&&verif==2){
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CP   R16,R26
	CPC  R17,R27
	BRNE _0x39
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	SBIW R26,2
	BREQ _0x3A
_0x39:
	RJMP _0x38
_0x3A:
; 0000 01E4 lcd_init(416);
	RCALL SUBOPT_0x14
; 0000 01E5 lcd_clear();
; 0000 01E6 lcd_gotoxy(0,0);
; 0000 01E7 lcd_putsf("GAME OVER!");
	__POINTW2FN _0x0,12
	RCALL _lcd_putsf
; 0000 01E8 }
; 0000 01E9 else{
	RJMP _0x3B
_0x38:
; 0000 01EA if(index%4==0&&verif==2){
	RCALL SUBOPT_0xE
	BRNE _0x3D
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	SBIW R26,2
	BREQ _0x3E
_0x3D:
	RJMP _0x3C
_0x3E:
; 0000 01EB cl(j-16,1);
	RCALL SUBOPT_0x15
; 0000 01EC for (k = 10; k >=0; k--)
	__GETWRN 20,21,10
_0x40:
	TST  R21
	BRMI _0x41
; 0000 01ED afisare(k,index, 1,index,0);
	ST   -Y,R21
	ST   -Y,R20
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	RCALL SUBOPT_0x16
	LDI  R26,LOW(0)
	LDI  R27,0
	RCALL _afisare
	__SUBWRN 20,21,1
	RJMP _0x40
_0x41:
; 0000 01EE cl(index,1);
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	RJMP _0x66
; 0000 01EF 
; 0000 01F0 }
; 0000 01F1 else cl(j-16,1);
_0x3C:
	RCALL SUBOPT_0x12
	SBIW R30,16
_0x66:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _cl
; 0000 01F2 
; 0000 01F3 
; 0000 01F4 }
_0x3B:
; 0000 01F5 
; 0000 01F6 if(index>=32)
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SBIW R26,32
	BRLT _0x43
; 0000 01F7 index=16;
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	RJMP _0x67
; 0000 01F8 else
_0x43:
; 0000 01F9 index=index+2; }
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
_0x67:
	STD  Y+6,R30
	STD  Y+6+1,R31
; 0000 01FA 
; 0000 01FB else
	RJMP _0x45
_0x2D:
; 0000 01FC if(matr[1][col-16]==2&&matr[0][col-16]==0){
	RCALL SUBOPT_0xB
	__GETW1P
	SBIW R30,2
	BRNE _0x47
	RCALL SUBOPT_0x17
	RCALL SUBOPT_0xC
	BREQ _0x48
_0x47:
	RJMP _0x46
_0x48:
; 0000 01FD verif=0;
	RCALL SUBOPT_0x18
; 0000 01FE j=col;
; 0000 01FF for (k = 0; k < 11; k++) {
	__GETWRN 20,21,0
_0x4A:
	__CPWRN 20,21,11
	BRGE _0x4B
; 0000 0200 afisare(k,j, 0,index,verif);
	RCALL SUBOPT_0x10
; 0000 0201 if(RIGHT==0){
	SBIC 0x3,1
	RJMP _0x4C
; 0000 0202 right(col);
	RCALL SUBOPT_0x9
; 0000 0203 col++;
; 0000 0204 }
; 0000 0205 
; 0000 0206 if(LEFT==0){
_0x4C:
	SBIC 0x3,0
	RJMP _0x4D
; 0000 0207 left(col);
	RCALL SUBOPT_0xA
; 0000 0208 col--;
; 0000 0209 }
; 0000 020A }
_0x4D:
	__ADDWRN 20,21,1
	RJMP _0x4A
_0x4B:
; 0000 020B cl(j,0);
	RCALL SUBOPT_0x12
	RCALL SUBOPT_0x11
; 0000 020C 
; 0000 020D for (k = 0; k < 11; k++) {
	__GETWRN 20,21,0
_0x4F:
	__CPWRN 20,21,11
	BRGE _0x50
; 0000 020E afisare(k,j-16, 1,index,verif);
	RCALL SUBOPT_0x19
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	RCALL _afisare
; 0000 020F if(RIGHT==0){
	SBIC 0x3,1
	RJMP _0x51
; 0000 0210 right(col);
	RCALL SUBOPT_0x9
; 0000 0211 col++;
; 0000 0212 }
; 0000 0213 
; 0000 0214 if(LEFT==0){
_0x51:
	SBIC 0x3,0
	RJMP _0x52
; 0000 0215 left(col);
	RCALL SUBOPT_0xA
; 0000 0216 col--;
; 0000 0217 }
; 0000 0218 }
_0x52:
	__ADDWRN 20,21,1
	RJMP _0x4F
_0x50:
; 0000 0219 
; 0000 021A cl(j-16,1);
	RCALL SUBOPT_0x15
; 0000 021B cl(j-16,0);
	RCALL SUBOPT_0x12
	SBIW R30,16
	RCALL SUBOPT_0x11
; 0000 021C matr[0][j-16]=2;
	RCALL SUBOPT_0x12
	SBIW R30,16
	MOVW R26,R28
	ADIW R26,10
	RCALL SUBOPT_0x5
	RCALL SUBOPT_0x13
; 0000 021D nr++;
; 0000 021E 
; 0000 021F 
; 0000 0220 }
; 0000 0221 else if(matr[0][col-16]==2){
	RJMP _0x53
_0x46:
	RCALL SUBOPT_0x17
	LD   R30,X+
	LD   R31,X+
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0x54
; 0000 0222 verif=0;
	RCALL SUBOPT_0x18
; 0000 0223 j=col;
; 0000 0224 for (k = 0; k < 11; k++) {
	__GETWRN 20,21,0
_0x56:
	__CPWRN 20,21,11
	BRGE _0x57
; 0000 0225 afisare(k,j, 0,index, verif);
	RCALL SUBOPT_0x10
; 0000 0226 if(RIGHT==0){
	SBIC 0x3,1
	RJMP _0x58
; 0000 0227 right(col);
	RCALL SUBOPT_0x9
; 0000 0228 col++;
; 0000 0229 }
; 0000 022A 
; 0000 022B if(LEFT==0){
_0x58:
	SBIC 0x3,0
	RJMP _0x59
; 0000 022C left(col);
	RCALL SUBOPT_0xA
; 0000 022D col--;
; 0000 022E }
; 0000 022F }
_0x59:
	__ADDWRN 20,21,1
	RJMP _0x56
_0x57:
; 0000 0230 cl(j,0);
	RCALL SUBOPT_0x12
	RCALL SUBOPT_0x11
; 0000 0231 for (k = 0; k < 11; k++) {
	__GETWRN 20,21,0
_0x5B:
	__CPWRN 20,21,11
	BRGE _0x5C
; 0000 0232 afisare(k,j-16, 1, index, verif);
	RCALL SUBOPT_0x19
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	RCALL _afisare
; 0000 0233 if(RIGHT==0){
	SBIC 0x3,1
	RJMP _0x5D
; 0000 0234 right(col);
	RCALL SUBOPT_0x9
; 0000 0235 col++;
; 0000 0236 }
; 0000 0237 
; 0000 0238 if(LEFT==0){
_0x5D:
	SBIC 0x3,0
	RJMP _0x5E
; 0000 0239 left(col);
	RCALL SUBOPT_0xA
; 0000 023A col--;
; 0000 023B }
; 0000 023C }
_0x5E:
	__ADDWRN 20,21,1
	RJMP _0x5B
_0x5C:
; 0000 023D cl(j-16,1);
	RCALL SUBOPT_0x15
; 0000 023E for (k = 0; k < 11; k++) {
	__GETWRN 20,21,0
_0x60:
	__CPWRN 20,21,11
	BRGE _0x61
; 0000 023F afisare(k,j-16, 0, index, verif);
	ST   -Y,R21
	ST   -Y,R20
	__GETW1SX 78
	SBIW R30,16
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+12
	LDD  R31,Y+12+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	RCALL _afisare
; 0000 0240 if(RIGHT==0){
	SBIC 0x3,1
	RJMP _0x62
; 0000 0241 right(col);
	RCALL SUBOPT_0x9
; 0000 0242 col++;
; 0000 0243 }
; 0000 0244 
; 0000 0245 if(LEFT==0){
_0x62:
	SBIC 0x3,0
	RJMP _0x63
; 0000 0246 left(col);
	RCALL SUBOPT_0xA
; 0000 0247 col--;
; 0000 0248 }
; 0000 0249 }
_0x63:
	__ADDWRN 20,21,1
	RJMP _0x60
_0x61:
; 0000 024A cl(j-16,0);
	RCALL SUBOPT_0x12
	SBIW R30,16
	RCALL SUBOPT_0x11
; 0000 024B 
; 0000 024C }
; 0000 024D index=index+2;
_0x54:
_0x53:
_0x45:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
; 0000 024E }
; 0000 024F if(nr==32){
_0x2C:
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,32
	BRNE _0x64
; 0000 0250 lcd_init(416);
	RCALL SUBOPT_0x14
; 0000 0251 lcd_clear();
; 0000 0252 lcd_gotoxy(0,0);
; 0000 0253 lcd_putsf("Congratulations!YOU'RE THE BEST!");
	__POINTW2FN _0x0,23
	RCALL _lcd_putsf
; 0000 0254 }
; 0000 0255 }
_0x64:
	RJMP _0x27
; 0000 0256 
; 0000 0257 }
_0x65:
	RJMP _0x65
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif
;void Init_initController(void)
; 0001 000B {

	.CSEG
; 0001 000C // Crystal Oscillator division factor: 1
; 0001 000D #pragma optsize-
; 0001 000E CLKPR=0x80;
; 0001 000F CLKPR=0x00;
; 0001 0010 #ifdef OPTIMIZE_SIZE
; 0001 0011 #pragma optsize+
; 0001 0012 #endif
; 0001 0013 
; 0001 0014 // Input/Output Ports initialization
; 0001 0015 // Port A initialization
; 0001 0016 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0001 0017 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0001 0018 PORTA=0x00;
; 0001 0019 DDRA=0x00;
; 0001 001A 
; 0001 001B // Port B initialization
; 0001 001C PORTB=0x00;
; 0001 001D DDRB=0x00;
; 0001 001E 
; 0001 001F // Port C initialization
; 0001 0020 PORTC=0x00;
; 0001 0021 DDRC=0b11110000;
; 0001 0022 
; 0001 0023 // Port D initialization
; 0001 0024 PORTD=0b00100000; // D.5 needs pull-up resistor
; 0001 0025 DDRD= 0b01010000; // D.6 is LED, D.4 is test output
; 0001 0026 
; 0001 0027 // Timer/Counter 0 initialization
; 0001 0028 // Clock source: System Clock
; 0001 0029 // Clock value: Timer 0 Stopped
; 0001 002A // Mode: Normal top=FFh
; 0001 002B // OC0 output: Disconnected
; 0001 002C TCCR0A=0x00;
; 0001 002D TCCR0B=0x00;
; 0001 002E TCNT0=0x00;
; 0001 002F OCR0A=0x00;
; 0001 0030 OCR0B=0x00;
; 0001 0031 
; 0001 0032 // Timer/Counter 1 initialization
; 0001 0033 // Clock source: System Clock
; 0001 0034 // Clock value: 19.531 kHz = CLOCK/256
; 0001 0035 // Mode: CTC top=OCR1A
; 0001 0036 // OC1A output: Discon.
; 0001 0037 // OC1B output: Discon.
; 0001 0038 // Noise Canceler: Off
; 0001 0039 // Input Capture on Falling Edge
; 0001 003A // Timer 1 Overflow Interrupt: Off
; 0001 003B // Input Capture Interrupt: Off
; 0001 003C // Compare A Match Interrupt: On
; 0001 003D // Compare B Match Interrupt: Off
; 0001 003E 
; 0001 003F TCCR1A=0x00;
; 0001 0040 TCCR1B=0x0D;
; 0001 0041 TCNT1H=0x00;
; 0001 0042 TCNT1L=0x00;
; 0001 0043 ICR1H=0x00;
; 0001 0044 ICR1L=0x00;
; 0001 0045 
; 0001 0046 // 1 sec = 19531 counts = 4C41H counts, from 0 to 4C40
; 0001 0047 // 4C40H = 4CH (MSB) and 40H (LSB)
; 0001 0048 OCR1AH=0x4C;
; 0001 0049 OCR1AL=0x40;
; 0001 004A 
; 0001 004B OCR1BH=0x00;
; 0001 004C OCR1BL=0x00;
; 0001 004D 
; 0001 004E // Timer/Counter 2 initialization
; 0001 004F // Clock source: System Clock
; 0001 0050 // Clock value: Timer2 Stopped
; 0001 0051 // Mode: Normal top=0xFF
; 0001 0052 // OC2A output: Disconnected
; 0001 0053 // OC2B output: Disconnected
; 0001 0054 ASSR=0x00;
; 0001 0055 TCCR2A=0x00;
; 0001 0056 TCCR2B=0x00;
; 0001 0057 TCNT2=0x00;
; 0001 0058 OCR2A=0x00;
; 0001 0059 OCR2B=0x00;
; 0001 005A 
; 0001 005B // External Interrupt(s) initialization
; 0001 005C // INT0: Off
; 0001 005D // INT1: Off
; 0001 005E // INT2: Off
; 0001 005F // Interrupt on any change on pins PCINT0-7: Off
; 0001 0060 // Interrupt on any change on pins PCINT8-15: Off
; 0001 0061 // Interrupt on any change on pins PCINT16-23: Off
; 0001 0062 // Interrupt on any change on pins PCINT24-31: Off
; 0001 0063 EICRA=0x00;
; 0001 0064 EIMSK=0x00;
; 0001 0065 PCICR=0x00;
; 0001 0066 
; 0001 0067 // Timer/Counter 0,1,2 Interrupt(s) initialization
; 0001 0068 TIMSK0=0x00;
; 0001 0069 TIMSK1=0x02;
; 0001 006A TIMSK2=0x00;
; 0001 006B 
; 0001 006C // USART0 initialization
; 0001 006D // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0001 006E // USART0 Receiver: On
; 0001 006F // USART0 Transmitter: On
; 0001 0070 // USART0 Mode: Asynchronous
; 0001 0071 // USART0 Baud rate: 9600
; 0001 0072 UCSR0A=0x00;
; 0001 0073 UCSR0B=0xD8;
; 0001 0074 UCSR0C=0x06;
; 0001 0075 UBRR0H=0x00;
; 0001 0076 UBRR0L=0x81;
; 0001 0077 
; 0001 0078 // USART1 initialization
; 0001 0079 // USART1 disabled
; 0001 007A UCSR1B=0x00;
; 0001 007B 
; 0001 007C 
; 0001 007D // Analog Comparator initialization
; 0001 007E // Analog Comparator: Off
; 0001 007F // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0001 0080 ACSR=0x80;
; 0001 0081 ADCSRB=0x00;
; 0001 0082 DIDR1=0x00;
; 0001 0083 
; 0001 0084 // Watchdog Timer initialization
; 0001 0085 // Watchdog Timer Prescaler: OSC/2048
; 0001 0086 #pragma optsize-
; 0001 0087 #asm("wdr")
; 0001 0088 // Write 2 consecutive values to enable watchdog
; 0001 0089 // this is NOT a mistake !
; 0001 008A WDTCSR=0x18;
; 0001 008B WDTCSR=0x08;
; 0001 008C #ifdef OPTIMIZE_SIZE
; 0001 008D #pragma optsize+
; 0001 008E #endif
; 0001 008F 
; 0001 0090 }
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif

	.CSEG

	.CSEG

	.DSEG

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G103:
; .FSTART __lcd_write_nibble_G103
	ST   -Y,R26
	IN   R30,0x8
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x8,R30
	__DELAY_USB 33
	SBI  0x8,2
	__DELAY_USB 33
	CBI  0x8,2
	__DELAY_USB 33
	RJMP _0x20C0001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G103
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G103
	__DELAY_USW 250
	RJMP _0x20C0001
; .FEND
_lcd_write_byte:
; .FSTART _lcd_write_byte
	ST   -Y,R26
	LDD  R26,Y+1
	RCALL __lcd_write_data
	RCALL SUBOPT_0x1A
	RJMP _0x20C0002
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G103)
	SBCI R31,HIGH(-__base_y_G103)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R9,Y+1
	LDD  R8,Y+0
_0x20C0002:
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	RCALL SUBOPT_0x1B
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	RCALL SUBOPT_0x1B
	LDI  R30,LOW(0)
	MOV  R8,R30
	MOV  R9,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2060005
	CP   R9,R11
	BRLO _0x2060004
_0x2060005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	INC  R8
	MOV  R26,R8
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x20C0001
_0x2060004:
	INC  R9
	RCALL SUBOPT_0x1A
	RJMP _0x20C0001
; .FEND
_lcd_putsf:
; .FSTART _lcd_putsf
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x206000B:
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,1
	STD  Y+1,R30
	STD  Y+1+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x206000D
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x206000B
_0x206000D:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	IN   R30,0x7
	ORI  R30,LOW(0xF0)
	OUT  0x7,R30
	SBI  0x7,2
	SBI  0x7,0
	SBI  0x7,1
	CBI  0x8,2
	CBI  0x8,0
	CBI  0x8,1
	LDD  R11,Y+0
	LD   R30,Y
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G103,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G103,3
	LDI  R26,LOW(20)
	LDI  R27,0
	RCALL _delay_ms
	RCALL SUBOPT_0x1C
	RCALL SUBOPT_0x1C
	RCALL SUBOPT_0x1C
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G103
	__DELAY_USW 500
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x20C0001:
	ADIW R28,1
	RET
; .FEND

	.CSEG

	.CSEG

	.DSEG
_rx_buffer0:
	.BYTE 0x8
_tx_buffer0:
	.BYTE 0x8
_vector:
	.BYTE 0x16
__seed_G102:
	.BYTE 0x4
__base_y_G103:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1:
	ST   -Y,R27
	ST   -Y,R26
	LD   R26,Y
	LDD  R27,Y+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x2:
	LDI  R30,LOW(_racheta*2)
	LDI  R31,HIGH(_racheta*2)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _define_char
	LD   R30,Y
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0x3:
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _lcd_gotoxy
	LDI  R26,LOW(1)
	RCALL _lcd_putchar
	LDI  R30,LOW(_clear*2)
	LDI  R31,HIGH(_clear*2)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(2)
	RCALL _define_char
	LD   R30,Y
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _lcd_gotoxy
	LDI  R26,LOW(2)
	RJMP _lcd_putchar

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x4:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDI  R26,LOW(_vector)
	LDI  R27,HIGH(_vector)
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X+
	LD   R31,X+
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(3)
	RJMP _define_char

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x5:
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x6:
	LDD  R30,Y+6
	ST   -Y,R30
	LDD  R26,Y+5
	RCALL _lcd_gotoxy
	LDI  R26,LOW(3)
	RJMP _lcd_putchar

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	RCALL _lcd_putchar
	LDI  R26,LOW(30)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x8:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RJMP _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0x9:
	MOVW R26,R16
	RCALL _right
	__ADDWRN 16,17,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0xA:
	MOVW R26,R16
	RCALL _left
	__SUBWRN 16,17,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xB:
	MOVW R30,R16
	SBIW R30,16
	MOVW R26,R28
	ADIW R26,42
	RJMP SUBOPT_0x5

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xC:
	__GETW1P
	SBIW R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0xD:
	__PUTWSRX 16,17,76
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xE:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	RCALL __MODW21
	SBIW R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF:
	SBIW R30,16
	MOVW R26,R28
	ADIW R26,42
	RJMP SUBOPT_0x5

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:36 WORDS
SUBOPT_0x10:
	ST   -Y,R21
	ST   -Y,R20
	__GETW1SX 78
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+12
	LDD  R31,Y+12+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	RJMP _afisare

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x11:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	LDI  R27,0
	RJMP _cl

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:38 WORDS
SUBOPT_0x12:
	__GETW1SX 76
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x13:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	ST   X+,R30
	ST   X,R31
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ADIW R30,1
	STD  Y+8,R30
	STD  Y+8+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x14:
	LDI  R26,LOW(160)
	RCALL _lcd_init
	RCALL _lcd_clear
	RJMP SUBOPT_0x8

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x15:
	RCALL SUBOPT_0x12
	SBIW R30,16
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1)
	LDI  R27,0
	RJMP _cl

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0x16:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+12
	LDD  R31,Y+12+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x17:
	MOVW R30,R16
	SBIW R30,16
	MOVW R26,R28
	ADIW R26,10
	RJMP SUBOPT_0x5

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x18:
	LDI  R30,LOW(0)
	STD  Y+4,R30
	STD  Y+4+1,R30
	RJMP SUBOPT_0xD

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x19:
	ST   -Y,R21
	ST   -Y,R20
	__GETW1SX 78
	SBIW R30,16
	RJMP SUBOPT_0x16

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1A:
	SBI  0x8,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x8,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1B:
	RCALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x1C:
	LDI  R26,LOW(48)
	RCALL __lcd_write_nibble_G103
	__DELAY_USW 500
	RET

;RUNTIME LIBRARY

	.CSEG
__INITLOCB:
__INITLOCW:
	ADD  R26,R28
	ADC  R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	NEG  R27
	NEG  R26
	SBCI R27,0
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__GETW1Z:
	PUSH R0
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	POP  R0
	RET

__GETW2X:
	PUSH R0
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	POP  R0
	RET

_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0x1388
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
