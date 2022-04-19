.global _start


.section .text

_start:
#_HW1
    movq %rsp, %rbp #for correct debugging
#your code here
#%rax:=array1 address,%rbx:=array2,%rcx:=mergedArray,%r10:=index1,%r9:=index2,%r11d:= curr_num_arr1
leaq (array1),%rax
leaq (array2),%rbx
leaq (mergedArray),%rcx
xor %r10,%r10
xor %r9,%r9
xor %r8,%r8

find_last_instance_num_array1_HW1:
movl (%rax,%r10,4),%r11d
cmpl $0x0,%r11d
je fill_array2_HW1
movl 4(%rax,%r10,4),%r12d
cmp %r11d,%r12d
jne find_last_instance_num_array2_HW1
incq %r10
jmp find_last_instance_num_array1_HW1

find_last_instance_num_array2_HW1:
movl (%rbx,%r9,4),%r13d
cmp $0x0,%r13d
je fill_array1_HW1
movl 4(%rbx,%r9,4),%r14d
cmpl %r13d,%r14d
jne compare_and_insert_to_mergedarray_HW1
incq %r9
jmp find_last_instance_num_array2_HW1

compare_and_insert_to_mergedarray_HW1:
cmp %r11d,%r13d
je equal_num_HW1
ja insert_array2_num_HW1

insert_array1_num_HW1:
movl %r11d,(%rcx,%r8,4)
incq %r8 #makes array become 
incq %r10
jmp find_last_instance_num_array1_HW1

insert_array2_num_HW1:
movl %r13d,(%rcx,%r8,4)
incq %r8
incq %r9
jmp find_last_instance_num_array2_HW1
equal_num_HW1:
movl %r11d,(%rcx,%r8,4)
incq %r8
incq %r9
incq %r10
jmp find_last_instance_num_array1_HW1

fill_array1_HW1:
xor %r13d,%r13d
movl (%rax,%r10,4),%r11d
cmp $0x0,%r11d
je end_HW1
movl 4(%rax,%r10,4),%r15d
cmpl %r15d,%r11d
jne insert_array1_num_HW1
incq %r10
jmp fill_array1_HW1

fill_array2_HW1:
xor %r11d,%r11d
movl (%rbx,%r9,4),%r13d
cmp $0x0,%r13d
je end_HW1
movl 4(%rbx,%r9,4),%r15d
cmpl %r15d,%r13d
jne insert_array2_num_HW1
incq %r9
jmp fill_array2_HW1

end_HW1:
#maybe mov 0 to last array
movl $0,(%rcx,%r8,4) 
xor %rax,%rax
