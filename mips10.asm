#Name: --
#Assignment 10
#11.13.2019
.data
table:  .word 10,20,30,40,50
	.word 4,5,6,7,8
	.word -1,-10,-20,-30,-40
	.word 5,6,7,8,9
line:	.asciiz "\n"
warning: .asciiz "out of bounds, exiting"
start:  .asciiz "start:"
.text
main:
la $a0,start
li $v0,4
syscall
la $a0,table 
li $t3,5 #total columns
li $t2,4 #data size
li $v0,1
syscall
la $a0,line
li $v0,4
syscall
la $a0,table

calculate:
li $v0,5
syscall
move $t0,$v0 #rows
li $v0,5
syscall
move $t1,$v0 #columns
mult $t0,$t3
mflo $t4
add $t4,$t4,$t1
mult $t4,$t2
mflo $t4
add $t4,$t4,$a0
li $v0,1
move $a0,$t4
syscall #prints address of the item of the table
la $a0,line
li $v0,4
syscall # \n for readability
bgt $t0,3,exit #exit if wrong number of rows requested
bgt $t1,4,exit #exit if wrong number of columns requested
j main #repeat to test for another item

exit:
li $v0,4
la $a0,warning #to make exit more apparent
syscall
li $v0,10
syscall
