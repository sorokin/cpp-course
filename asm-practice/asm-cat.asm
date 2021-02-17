sys_exit:       equ             60

                section         .text
                global          _start

buf_size:       equ             8192
_start:
                sub             rsp, buf_size
                mov             rsi, rsp

read_again:
                xor             eax, eax
                xor             edi, edi
                mov             rdx, buf_size
                syscall

                test            rax, rax
                jz              quit
                js              read_error

                mov             rdx, rax
                
                mov             rax, 1
                mov             rdi, 1
                syscall
                jmp             read_again

quit:
                mov             rax, sys_exit
                xor             rdi, rdi
                syscall

read_error:
                mov             eax, 1
                mov             edi, 2
                mov             rsi, read_error_msg
                mov             rdx, read_error_len
                syscall

                mov             rax, sys_exit
                mov             edi, 1
                syscall

                section         .rodata

read_error_msg: db              "read failure", 0x0a
read_error_len: equ             $ - read_error_msg
