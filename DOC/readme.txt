#Lab4

#System Top system (top.vhd)
Inputs:
 -Signal X and Y with n bits long.
 - control signal ALUFN with 5 bits long, where the first two bits (from the left) choose the type of operation i.e.'00' for PWM Generator, '01' for arithmetic, '10' for shifting and '11' for logic ('00' will perform nothing).
  The last 3 bits of ALUFN (ALFN[2-4]) will spcify the operation after selecting the Type of the operation.
  -ENA
  -CLK
  -RST
  - Outputs
  - 4 flags: 'C' will rise to 1 if the operation produced a carry, 'Z' will rise if the result is zero, 'N' will rise if the result is negative and 'V' will rise if there overflow.
  - Output of the operation selected by ALUFN with n bits long.
  - PWM signal

## Adder/Subtractor module (AdderSub.vhd)
Will be selected if ALUFN[0:1]='01'. and will be performing 5 operations as follows:

1.Addition X+Y if ALUFN='01000'
2.Substraction Y-X if ALUFN='01001'
3.N(X) -X when ALUFN='01010'
4.Increment Y by 1 when ALUFN='01011'
5.Decrement Y by 1 when ALUFN='01100'


## Shifter Module (Shifter.vhd)
Will be selected if ALUFN[0:1]='10'. and will be performing 2 shifting operations as follows:

1. Shift Y from the right q times by adding zeros from the right when q is the decimal value of the k first bits of X from the left. Will nbe selected if ALUFN='01000'
2. Shift Y from the left q times by adding zeros from the left when q is the decimal value of the k first bits of X from the left. Will nbe selected if ALUFN='01001'


## Logic Module (Logic.vhd)
Will be selected if ALUFN[0:1]='11'. and will be performing 7 logical operations as follows:

1. not(Y) if ALUFN='11000'
2. Y or X if ALUFN='11001'
3. Y and X if ALUFN='11010'
4. Y xor X if ALUFN='11011'
5. Y nor X if ALUFN='11011'
6. Y nand X if ALUFN='11101'
7. Y xnor X if ALUFN='11111'


## Full Adder Module (FA.vhd) 
Perform addition on two single bits inputs and produce carry when needed.  

## Timer (Timer.vhd)
A counter that counts from zero to Y periodically.

## PWM Unit (PWM.vhd)
A unit that generates a PWM signal according to the ALUFN as follows:
 1.When ALUFN="00000" as PWM mode is Set/Reset.
 2.When ALUFN="00001" as PWM mode is Reset/Set.
 3.When ALUFN="00010" as PWM mode is Toggle.

## TopIO_Interface (IO_InterfaceLAB4.vhd)
Digital system with I/O interface for the hardware test case

## Package (aux_package.vhd)
A file that reuses components that needed frequently in the development of new components.



Studunts: Ahseen & Aram
Instructor: Hanan Reboh


