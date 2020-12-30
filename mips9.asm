#Name: --
#Assignment 7
#11.09.2019
.data
input: .asciiz "pls etner a string:"
userinput: .space 20
last: .asciiz "good bye"
.text
main:
li $v0,4
la $a0,input
syscall
li $v0,8
la $a0,userinput
li $a1,20
syscall
li $v0,4
la $a0,userinput
syscall
li $v0,4
la $a0,last
syscall
li $v0,10
syscall
