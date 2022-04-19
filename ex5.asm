.global _start
.section .text
_start:
movq $0, %r11 #r11 = &src
movq $0, %r12 #r12 = &dst
movq $0, %r13 #r13 = src->prev
movq $0, %r14 #r14 = dst->prev
movq $0, %r15 #r15 = current->next
movq $0, %r8 #r8 is a flag to identify witch switch need to be made
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
movq $1, %r8
jmp whileLoop_HW1

dstEqHead_HW1:
lea (head), %r14
movq %r10, %r12
movq $2, %r8
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
jz exit_HW1
testq %r12, %r12
jz exit_HW1

movq 8(%r11), %rdi #rdi = src->next
cmpq %rdi, %r12
movq 8(%r12), %rsi #rsi = dst->next
je srcIsPrevForDest_HW1
cmpq %rsi, %r11
je dstIsPrevForDest_HW1
leaq 8(%r11), %r9 #starting to switch src->next with dst->next
movq %rsi, (%r9)
leaq 8(%r12), %r9
movq %rdi, (%r9)
cmp $1, %r8
je firstCaseSwitch_HW1
cmp $2, %r8
je secondCaseSwitch_HW1

#here both sorce and dst are not in the first node
leaq 8(%r13), %r13 #starting to switch src->prev->next with dst->prev->next
movq %r12, (%r13)
leaq 8(%r14), %r14
movq %r11, (%r14)
jmp exit_HW1

firstCaseSwitch_HW1: #here if src is in the first node
movq %r12, (%r13)
cmpq %r14, %r11
je exit_HW1
leaq 8(%r14), %r9
movq %r11, (%r9)
jmp exit_HW1

secondCaseSwitch_HW1: #here if dst is in the first node
movq %r11, (%r14)
cmpq %r12, %r13
je exit_HW1
leaq 8(%r13), %r9
movq %r12, (%r9)
jmp exit_HW1

srcIsPrevForDest_HW1:
leaq 8(%r11), %r9
movq %rsi, (%r9)
leaq 8(%r12), %r9
movq %r11, (%r9)
cmp $1, %r8
je firstCaseSwitch_HW1
cmp $2, %r8
je secondCaseSwitch_HW1
leaq 8(%r13), %r13
movq %r12, (%r13)
jmp exit_HW1


dstIsPrevForDest_HW1:
leaq 8(%r12), %r9
movq %rdi, (%r9)
leaq 8(%r11), %r9
movq %r12, (%r9)
cmp $1, %r8
je firstCaseSwitch_HW1
cmp $2, %r8
je secondCaseSwitch_HW1
leaq 8(%r14), %r14
movq %r11, (%r14)
jmp exit_HW1


exit_HW1:
