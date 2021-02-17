                section         .text

                global          _start

_start:
                xor             rbx, rbx
                movdqa          xmm0, oword [new_line_mask]
                pxor            xmm3, xmm3

.read_again:
                xor             rax, rax
                xor             rdi, rdi
                mov             rsi, buf
                mov             rdx, buf_size * 16
                syscall

                cmp             rax, 0
                jz              exit
                jl              read_fail

                mov             rsi, buf
                mov             rcx, rax
                shr             rcx, 4
                or              rcx, rcx
                jz              .skip_by_oword
                xorpd           xmm2, xmm2

.next_oword:
                movdqa          xmm1, oword [rsi]
                add             rsi, 16
                pcmpeqb         xmm1, xmm0
                pmovmskb        edx, xmm1
                popcnt          edx, edx
                add             rbx, rdx
                dec             rcx
                jnz             .next_oword

.skip_by_oword:
                and             rax, 15
                jz              .read_again

.next_byte:
                mov             dl, byte [rsi]
                cmp             dl, 10
                jne             .not_eof
                inc             rbx
.not_eof:
                inc             rsi
                dec             rax
                jnz             .next_byte

                jmp             .read_again

exit:
                mov             rax, rbx
                call            write_number

                mov             rax, 60
                xor             rdi, rdi
                syscall

; rax -- number to print
write_number:
                mov             rbp, rsp
                mov             rdi, rsp
                sub             rsp, 24

                or              rax, rax
                jz              .write_zero

                mov             ebx, 10
.loop:
                xor             edx, edx
                div             rbx

                add             edx, '0'
                dec             rdi
                mov             byte [rdi], dl

                or              rax, rax
                jnz             .loop
                jmp             .print

.write_zero:
                dec             rdi
                mov             byte [rdi], '0'

.print:
                mov             eax, 1
                mov             rsi, rdi
                mov             rdx, rbp
                sub             rdx, rdi
                mov             edi, eax
                syscall

                mov             rsp, rbp
                ret

read_fail:
write_fail:
                ud2

                section         .bss

buf_size:       equ             1024 * 16 / 16
buf:            reso            buf_size

                section         .rodata

                align 16, db 0
new_line_mask:  times 16 db     10
