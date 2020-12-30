#Name: --
#Final Project 
#11.24.2019
.data
prompt0: .asciiz "Please, choose the operation below:\n"
prompt1: .asciiz "1.Find sum of diagonal\n"
prompt2: .asciiz "2.Find sum of row x\n"
prompt3: .asciiz "3.Find sum of column x\n"
prompt4: .asciiz "4.Reverse x row\n"
prompt5: .asciiz "5.Reverse x column\n"
prompt6: .asciiz "6.Add rows x and y\n"
prompt7: .asciiz "7.Mutliply row x by y \n"
prompt8: .asciiz "8.Exit the program\n"
prompt9r: .asciiz "Please, enter a row:"
prompt9c: .asciiz "Please, enter a column:"
prompt10: .asciiz "Multiplier:"
newline: .asciiz "\n"
table:  .word 10,20,30,40,50
	.word 50,40,30,20,10
	.word 30,40,20,10,50
	.word 20,30,40,50,10
	.word 40,10,50,30,20
.text

main:
la $t0,table
li $t1,5 #max col
li $t2,4 #data size
li $v0,4
la $a0,prompt0
syscall
la $a0,prompt1
syscall
la $a0,prompt2
syscall
la $a0,prompt3
syscall
la $a0,prompt4
syscall
la $a0,prompt5
syscall
la $a0,prompt6
syscall
la $a0,prompt7
syscall
la $a0,prompt8
syscall

li $v0,5
syscall
beq $v0,1,diagonal
beq $v0,2,srow
beq $v0,3,scol
beq $v0,4,reverser
beq $v0,5,reversec
beq $v0,6,addr
beq $v0,7,mulrb
beq $v0,8,exit

diagonal:
li $s0,0 #row num
li $s1,0 #sum will be here
li $s2,0 #address
j diagonalsum

diagonalsum:
mul $s2,$s0,$t1 #row * max col
add $s2,$s0,$s2 #r*mc+c
mul $s2,$s2,$t2 #* ds
addu $s2,$t0,$s2 #address
lw $t3,($s2)
add $s1,$s1,$t3
addi $s0,$s0,1
blt $s0,$t1,diagonalsum
li $v0,1
move $a0,$s1
syscall
li $v0,4
la $a0,newline
syscall
j main

srow:
li $v0,4
la $a0,prompt9r
syscall
li $v0,5
syscall
move $s0,$v0 #row
subi $s0,$s0,1
li $a1,0 #col
li $s2,0 #address
li $s3,0 #sum

addrow:
mul $s2,$s0,$t1 #row * max col
add $s2,$s2,$a1 #r*mc+c
mul $s2,$s2,$t2 #*ds
add $s2,$t0,$s2 #address
lw $t3,($s2)
add $s3,$s3,$t3
addi $a1,$a1,1
blt $a1,$t1,addrow
li $v0,1
move $a0,$s3
syscall
li $v0,4
la $a0,newline
syscall
j main

scol:
li $v0,4
la $a0,prompt9c
syscall
li $v0,5
syscall
move $s0,$v0 #col
subi $s0,$s0,1
li $a1,0 #row
li $s2,0 #address
li $s3,0 #sum

addcol:
mul $s2,$a1,$t1 #row * max col
add $s2,$s2,$s0 #r*mc+c
mul $s2,$s2,$t2 #*ds
add $s2,$t0,$s2 #address
lw $t3,($s2)
add $s3,$s3,$t3
addi $a1,$a1,1
blt $a1,$t1,addcol
li $v0,1
move $a0,$s3
syscall
li $v0,4
la $a0,newline
syscall
j main

reverser:
li $v0,4
la $a0,prompt9r
syscall
li $v0,5
syscall
move $s0,$v0 #row
subi $s0,$s0,1
li $a1,0 #col
li $s2,0 #address
li $t3,0 #temp

reverserpush:
mul $s2,$s0,$t1 #row * max col
add $s2,$s2,$a1 #r*mc+c
mul $s2,$s2,$t2 #*ds
add $s2,$t0,$s2 #address
lw $t3,($s2)
subi $sp,$sp,4
sw $t3,($sp)
addi $a1,$a1,1
blt $a1,5,reverserpush

li $a1,0

reverserpop:
mul $s2,$s0,$t1 #row * max col
add $s2,$s2,$a1 #r*mc+c
mul $s2,$s2,$t2 #*ds
add $s2,$t0,$s2 #address
lw $t3,($sp)
sw $t3,($s2)
addi $sp,$sp,4
addi $a1,$a1,1
blt $a1,5,reverserpop

li $a1,0

printrow:
mul $s2,$s0,$t1 #row * max col
add $s2,$s2,$a1 #r*mc+c
mul $s2,$s2,$t2 #*ds
add $s2,$t0,$s2 #address
lw $t3,($s2)
move $a0,$t3
li $v0,1
syscall
li $v0,4
la $a0,newline
syscall
addi $a1,$a1,1
blt $a1,5,printrow
j main

reversec:
li $v0,4
la $a0,prompt9c
syscall
li $v0,5
syscall
move $s0,$v0 #col
subi $s0,$s0,1
li $a1,0 #row
li $s2,0 #address
li $t3,0 #temp

reversecpush:
mul $s2,$a1,$t1 #row * max col
add $s2,$s2,$s0 #r*mc+c
mul $s2,$s2,$t2 #*ds
add $s2,$t0,$s2 #address
lw $t3,($s2)
subi $sp,$sp,4
sw $t3,($sp)
addi $a1,$a1,1
blt $a1,5,reversecpush

li $a1,0

reversecpop:
mul $s2,$a1,$t1 #row * max col
add $s2,$s2,$s0 #r*mc+c
mul $s2,$s2,$t2 #*ds
add $s2,$t0,$s2 #address
lw $t3,($sp)
sw $t3,($s2)
addi $sp,$sp,4
addi $a1,$a1,1
blt $a1,5,reversecpop

li $a1,0

printcol:
mul $s2,$a1,$t1 #row * max col
add $s2,$s2,$s0 #r*mc+c
mul $s2,$s2,$t2 #*ds
add $s2,$t0,$s2 #address
lw $t3,($s2)
move $a0,$t3
li $v0,1
syscall
li $v0,4
la $a0,newline
syscall
addi $a1,$a1,1
blt $a1,5,printcol
j main


addr:
li $v0,4
la $a0,prompt9r
syscall
li $v0,5
syscall
move $s0,$v0 #row 1
subi $s0,$s0,1
li $v0,4
la $a0,prompt9r
syscall
li $v0,5
syscall
move $s1,$v0 #row 2
subi $s1,$s1,1
move $s4,$zero #temp for r1 + temp sum of 2
move $s5,$zero #temp for r2
move $a1,$zero #col
move $s6,$zero #address 1
move $s7,$zero #address 2
move $a2,$zero #sum

addre:
mul $s6,$s0,$t1 #row * max col
mul $s7,$s1,$t1 #row * max col 2
add $s6,$s6,$a1 #r*mc+c
add $s7,$s7,$a1 #r*mc+c 2
mul $s6,$s6,$t2 #*ds
mul $s7,$s7,$t2 #*ds 2
add $s6,$t0,$s6 #address
add $s7,$t0,$s7 #address 2

lw $s4,($s6)
lw $s5,($s7)
add $s4,$s4,$s5
add $a2,$a2,$s4
subi $sp,$sp,4
sw $s4,($sp)

addi $a1,$a1,1
blt $a1,5,addre

li $v0,1
move $a0,$a2
syscall
li $v0,4
la $a0,newline
syscall

addrestore:
mul $s2,$s0,$t1 #row * max col
add $s2,$s2,$a1 #r*mc+c
mul $s2,$s2,$t2 #*ds
add $s2,$t0,$s2 #address
lw $s4,($sp)
sub $s2,$s2,4
sw $s4,($s2)
addi $sp,$sp,4
subi $a1,$a1,1
bgt $a1,0,addrestore

j printrow


mulrb:
li $v0,4
la $a0,prompt9r
syscall
li $v0,5
syscall
move $s0,$v0 #row
subi $s0,$s0,1
li $v0,4
la $a0,prompt10
syscall
li $v0,5
syscall
move $a3, $v0 #multiplier
move $a1,$zero #col
move $s3,$zero #multiplied

mulrbpush:
mul $s2,$s0,$t1 #row * max col
add $s2,$s2,$a1 #r*mc+c
mul $s2,$s2,$t2 #*ds
add $s2,$t0,$s2 #address
lw $s3,($s2)
mul $s3,$s3,$a3
subi $sp,$sp,4
sw $s3,($sp)
addi $a1,$a1,1
blt $a1,5,mulrbpush

mulrbpop:
mul $s2,$s0,$t1 #row * max col
add $s2,$s2,$a1 #r*mc+c
mul $s2,$s2,$t2 #*ds
add $s2,$t0,$s2 #address
lw $s3,($sp)
sub $s2,$s2,4
sw $s3,($s2)
addi $sp,$sp,4
subi $a1,$a1,1
bgt $a1,0,mulrbpop

j printrow

exit:
li $v0,10
syscall
