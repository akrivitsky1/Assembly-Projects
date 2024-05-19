.data #all arrays and variables
  match1:	.asciiz "\nThe string is a match " #String prompts
  match2:	.asciiz "\nThe string is not a match "
  arr1: .space 40 #array1
  arr2: .space 40 #array2
.text
.align 2
main:
# get the strings (input)
la $a0, arr1		# address of buffer to put result
li $a1, 40		# number of characters to get
li $v0, 8		# syscall for reading string
syscall			# get number from keyboard, put in buffer
move $t5, $ra	#puts t5 register to return register
la $a0, arr2		# address of buffer to put result
li $a1, 40		# number of characters to get
li $v0, 8		# syscall for reading string
syscall			# get number from keyboard, put in buffer

la $a0, arr1 #Destination register is equal to address
la $a1, arr2 #Destination register is equal to address
jal strcmp #jump to string compare
nop #delay slot

bnez $v0, stringsneq #jump if not equal to 0
nop #delay slot
#prints msg saying string do match
la $a0,match1		# address of "matching" string
li $v0,4		# syscall for print string
syscall			# print string
j end #jump to end
nop #delay slot

stringsneq:
#prints msg saying not matching
la $a0,match2		# address of "not matching" string
	li $v0,4		# syscall for print string
	syscall			# print string
end:
move $ra, $t5 #moving t5 to address register
jr $ra  #return

# function start
strcmp:
add $t0, $a0, 0 #add string from register a0 to t0
add $t4, $a1, 0 #add string from register a1 to t4
stringloop:
lb $t1, 0($t0) #load byte to t1 from t0
lb $t2, 0($t4) #load byte to t2 from t4
nop  #delay slot
sub $t3, $t2, $t1 #t2-t1 and stores it in t3
bnez $t3, diffstring #jump if not equal to 0
nop #delay slot
beqz $t1, samestring  #checks if one is strings is equal to 0, means both are
nop #delay slot
addi $t0, $t0, 1 #add 1 to t0 register
addi $t4, $t4, 1 #add 1 to t4 register
b stringloop #jump to string loop beginning
nop #delay slot

diffstring:
bltz $t3, stronesmaller #jump if less than 0
nop #delay slot
#stronebigger below
li $v0, 1 #loads immediate 1 into v0 register
b endfunc #jumps to endfunc
nop #delay slot

stronesmaller:
li $v0,-1 #loads immediate -1 to v0 register
b endfunc #jumps to endfunc
nop #delay slot

samestring:
li $v0, 0 #loads in 0 if same string

endfunc:
jr $ra  # return from function