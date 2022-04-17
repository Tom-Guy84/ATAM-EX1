.global _start
.section .text
_start:
movq $0, %r11 #r11 = &src
movq $0, %r12 #r12 = &dst
movq $0, %r13 #r13 = src->prev
movq $0, %r14 #r14 = dst->prev
movq $0, %r15 #r15 = current->next
movq $0, %rdi #rdi is a flag to identify witch switch need to be made
movq (src), %rdx
movq (dst), %rax
cmp %rdx, %rax
je exit_HW1 #jump to exit if src==dst
mov head(%rip), %r10 #r10 = *head=first node adress
mov (%r10), %r9
cmp %r9, %rdx #deels with the case that src or dst are in the first node
je  srcEqHead_HW1
cmp %r9, %rax
je dstEqHead_HW1

whileLoop_HW1:
movq 8(%r10), %r15
testq %r15, %r15
jz switch_HW1
movq (%r15), %r9 #r9 is the temp value
cmp %r9, %rdx
je tmpEqSrc_HW1
tmpNotEqSrc_HW1: #here if found src node for the first time or tmp and src are not equal 
cmp %rax, %r9
je tmpEqDst_HW1
tmpNotEqDst_HW1: #here if found dst node for the first time or
                 # tmp and dst are not equal
movq %r15, %r10 #r10 <-- (r10-->next)
movq 8(%r10), %r15
jmp whileLoop_HW1

srcEqHead_HW1:
lea (head), %r13
movq %r10, %r11
movq $1, %rdi
jmp whileLoop_HW1

dstEqHead_HW1:
lea (head), %r14
movq %r10, %r12
movq $2, %rdi
jmp whileLoop_HW1

tmpEqSrc_HW1:
testq %r11, %r11
jnz exit_HW1 #if equal there are two nodes with src value
movq %r15, %r11
movq %r10, %r13
jmp tmpNotEqSrc_HW1

tmpEqDst_HW1:
testq %r12, %r12
jnz exit_HW1 #if equal there are two nodes with dst value
movq %r15, %r12
movq %r10, %r14
jmp tmpNotEqDst_HW1

switch_HW1:
testq %r11, %r11 #if r11 or r12 are null, exit.
jmp exit_HW1
testq %r12, %r12
jmp exit_HW1

movq 8(%r11), %rdi #rdi = src->next
movq 8(%r12), %rsi #rsi = dst->next
addq $8, %r11 #starting to switch src->next with dst->next
movq %rsi, (%r11)
lea 8(%r13), %r11
addq $8, %r12
movq %rdi, (%r12)
lea 8(%r14), %r12
cmp $1, %rdi
je firstCaseSwitch_HW1
cmp $2, %rdi
je secondCaseSwitch_HW1

#here both sorce and dst are not in the first node
addq $8, %r13 #starting to switch src->prev->next with dst->prev->next
movq %r12, (%r13)
addq $8, %r14
movq %r11, (%r14)
jmp exit_HW1

firstCaseSwitch_HW1: #here if src is in the first node
movq %r12, (%r13)
addq $8, %r14
movq %r11, (%r14)
jmp exit_HW1

secondCaseSwitch_HW1: #here if dst is in the first node
movq %r11, (%r14)
addq $8, %r13
movq %r12, (%r13)

exit_HW1:
ret


