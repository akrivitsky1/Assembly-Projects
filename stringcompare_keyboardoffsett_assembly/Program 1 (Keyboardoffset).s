.text
.align 2

main:
readloop: lb $t1, 0xffff0000($0) #receives input with receiver control
nop #after every jump we need a delay slot
andi $t1, $t1, 1 #loading into t1 register, takes value of t1 and adds 1 and stores it in t1
bgtz $t1, breakreadloop  # jump if it is greater than 0
nop #delay slot
b readloop # jumping back to beginning of readloop
nop #delay slot

breakreadloop:
lb $t2, 0xffff0004($0) #receives data from keyboard and loads into register t2
nop #delay slot
addi $t2, $t2, 1 #adds 1 to register t2

writeloop: lb $t1, 0xffff0008($0) #loading transmitter control into t1 register
nop #delay slot
andi $t1, $t1, 1 #adds 1 to t1 register
bgtz $t1, breakwriteloop  # if t1 > 0, jump to breakwriteloop
nop #delay slot
b writeloop #jumps to beginning of write loop
nop #delays slot

breakwriteloop:
sb $t2, 0xffff000c($0) #stores transmitter data in t2 register
nop # delay slot

jr $31 #Return
