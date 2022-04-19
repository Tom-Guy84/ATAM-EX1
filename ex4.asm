.global _start

.section .text

_start:
    movq %rsp, %rbp #for correct debugging
#%rbx:=root
#%rax:=new_node
#%rcx:=curr_node adress
#%rdx:=holds our data for new_node
#your code here
leaq (root), %rbx
leaq (new_node), %rax
movq (%rax),%rdx
cmpq $0x0, (%rbx)
je new_node_is_root_HW1
movq  (%rbx), %rcx # moves head adress to curr_node
jmp find_node_HW1
#here we search
new_node_is_root_HW1:
movq $(new_node), (%rbx)
jmp exit_HW1

find_node_HW1:
#now rdx holds our new_node_data, and we want %r8 to hold our data for current_node
#rcx already holds it, but we want a desginated one
movq (%rcx),%r8
cmp %r8,%rdx
je exit_HW1 #new_node value already exist.
jg right_son_HW1

left_son_HW1:
movq 8(%rcx), %r9 #r9:=left son pointer,%r10:=left son value
testq %r9, %r9
jz insert_left_and_exit_HW1
movq %r9, %rcx
jmp find_node_HW1

right_son_HW1:
movq 16(%rcx),%r9
testq %r9,%r9
jz insert_right_and_exit_HW1
movq %r9,%rcx
jmp find_node_HW1

insert_right_and_exit_HW1:
leaq 16(%rcx),%r9
movq $(new_node),(%r9)
jmp exit_HW1

insert_left_and_exit_HW1:
leaq 8(%rcx),%r9
movq $(new_node),(%r9)
jmp exit_HW1

exit_HW1:
xor %rax,%rax


