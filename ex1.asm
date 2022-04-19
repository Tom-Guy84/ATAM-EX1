.global _start#change to _start

.section .text
_start: #change to _start before hagasha
#your code here
movl $64,%ecx # for looping 
movq (num),%rax # we will rotate rax
movl $0x0,%edx #rdx is our count.

loop_HW1:
cmp $0x0,%ecx
jz end_HW1
dec %ecx #count --
shl %rax# rotate one time through carry left 
jnc loop_HW1 # if carry isn't one, our lsb isn't one,meaning we dont need to do anything
incl %edx
jmp loop_HW1

end_HW1:
movl %edx,(CountBits)
