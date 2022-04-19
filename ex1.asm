.global _start#change to _start

.section .text
_start: #change to _start before hagasha
#your code here
movl $64,%ecx # for looping 
movq (num),%rax # we will rotate rax
movl $0x0,%edx #rdx is our count.

hw1_loop:
cmp $0x0,%ecx
jz end
dec %ecx #count --
shl %rax# rotate one time through carry left 
jnc hw1_loop # if carry isn't one, our lsb isn't one,meaning we dont need to do anything
incl %edx
jmp hw1_loop

end:
movl %edx,(CountBits)
