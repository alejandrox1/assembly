#PURPOSE: 	This program finds the maximum value for a set of data items.
#

#VARIABLES:	The registers have the following uses:
#	
# %edi - Holds the index of the data item being examined.
# %ebx - Largest data item found.
# %eax - Current data item.
#
# The following memory locations are used:
#
# data_items - Containes the item data. A 0 is used to terminate the data.
#

.section .data

data_items:
.long 3,67,34,223,45,75,54,34,44,33,22,11,66,0


.section .text

.globl _start
_start:
movl $0, %edi					# move 0 into the index register
movl data_items(,%edi,4), %eax 	# load the first byte of data
movl %eax, %ebx					# since %eax is now the first item, %ebx will 
								# hold it

start_loop:
 cmpl $0, %eax					# check whether we hit the end of the sequence
 je loop_exit

 incl %edi						# Increase data_items index
 movl data_items(,%edi,4), %eax
 
 cmpl %ebx, %eax				# COmpare largest against current value
 jle start_loop					# jump to loop beginning if new value isn't 
 movl %eax, %ebx				# update largest value
 jmp start_loop

loop_exit:
 # %ebx is the status code for the exit system call and it already has the
 # maximum value
 movl $1, %eax					# exit() syscall
 int $0x80
