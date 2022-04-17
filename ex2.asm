.global _start
.section .text
_start:
movl (num),%eax
cmp $0x0,%eax
je end_hw1
cmp $0x0,%eax
js Dest_To_source_hw1
leaq (source),%rcx
leaq (destination),%rdx
jmp overlap_hw1
Dest_To_source_hw1:
# our number is negative
cdqe
not %rax
inc %rax
# our number is positive now.
leaq (destination),%rcx
leaq (source),%rdx
#if "source" is before "destination"
overlap_hw1:
cmp %rdx,%rcx # we want to check if adress of source is before address of destination
jb give_offset_hw1
jmp move_bytes_regular_hw1
give_offset_hw1:
add %rax,%rcx
add %rax,%rdx
decq %rcx
decq %rdx
jmp move_bytes_opposite_hw1
move_bytes_regular_hw1:
cmp $0x0,%rax
je end_hw1
movb (%rcx),%r8b
movb %r8b,(%rdx)
inc %rcx
inc %rdx
decq %rax
jmp move_bytes_regular_hw1
move_bytes_opposite_hw1:
cmp $0x0,%rax
je end_hw1
movb (%rcx),%r8b
movb %r8b,(%rdx)
decq %rcx
decq %rdx
decq %rax
jmp move_bytes_opposite_hw1
end_hw1:
