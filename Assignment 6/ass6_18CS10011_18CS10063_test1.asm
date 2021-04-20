	.file	"output.s"

.STR0:	.string "Enter first number:"
.STR1:	.string "Enter second number:"
.STR2:	.string "Enter third number:"
.STR3:	.string "Min:"
.STR4:	.string "\nMax:"
.STR5:	.string "\nSum:"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$156, %rsp
# 0:
	movq	$.STR0,	%rdi
# 1:res = t000 
	pushq %rbp
	call	prints
	movl	%eax, -32(%rbp)
	addq $8 , %rsp
# 2:res = t001 arg1 = scan 
	leaq	-16(%rbp), %rax
	movq	%rax, -40(%rbp)
# 3:res = t001 
# 4:res = t002 
	pushq %rbp
	movq	-40(%rbp), %rdi
	call	readi
	movl	%eax, -44(%rbp)
	addq $0 , %rsp
# 5:res = a arg1 = t002 
	movl	-44(%rbp), %eax
	movl	%eax, -4(%rbp)
# 6:res = t003 arg1 = t002 
	movl	-44(%rbp), %eax
	movl	%eax, -48(%rbp)
# 7:
	movq	$.STR1,	%rdi
# 8:res = t004 
	pushq %rbp
	call	prints
	movl	%eax, -52(%rbp)
	addq $8 , %rsp
# 9:res = t005 arg1 = scan 
	leaq	-16(%rbp), %rax
	movq	%rax, -60(%rbp)
# 10:res = t005 
# 11:res = t006 
	pushq %rbp
	movq	-60(%rbp), %rdi
	call	readi
	movl	%eax, -64(%rbp)
	addq $0 , %rsp
# 12:res = b arg1 = t006 
	movl	-64(%rbp), %eax
	movl	%eax, -8(%rbp)
# 13:res = t007 arg1 = t006 
	movl	-64(%rbp), %eax
	movl	%eax, -68(%rbp)
# 14:
	movq	$.STR2,	%rdi
# 15:res = t008 
	pushq %rbp
	call	prints
	movl	%eax, -72(%rbp)
	addq $8 , %rsp
# 16:res = t009 arg1 = scan 
	leaq	-16(%rbp), %rax
	movq	%rax, -80(%rbp)
# 17:res = t009 
# 18:res = t010 
	pushq %rbp
	movq	-80(%rbp), %rdi
	call	readi
	movl	%eax, -84(%rbp)
	addq $0 , %rsp
# 19:res = c arg1 = t010 
	movl	-84(%rbp), %eax
	movl	%eax, -12(%rbp)
# 20:res = t011 arg1 = t010 
	movl	-84(%rbp), %eax
	movl	%eax, -88(%rbp)
# 21:arg1 = a arg2 = b 
	movl	-4(%rbp), %eax
	movl	-8(%rbp), %edx
	cmpl	%edx, %eax
	jl .L1
# 22:
	jmp .L2
# 23:
	jmp .L3
# 24:arg1 = a arg2 = c 
.L1:
	movl	-4(%rbp), %eax
	movl	-12(%rbp), %edx
	cmpl	%edx, %eax
	jl .L4
# 25:
	jmp .L5
# 26:
	jmp .L6
# 27:res = min arg1 = a 
.L4:
	movl	-4(%rbp), %eax
	movl	%eax, -20(%rbp)
# 28:res = t012 arg1 = a 
	movl	-4(%rbp), %eax
	movl	%eax, -92(%rbp)
# 29:
	jmp .L3
# 30:res = min arg1 = c 
.L5:
	movl	-12(%rbp), %eax
	movl	%eax, -20(%rbp)
# 31:res = t013 arg1 = c 
	movl	-12(%rbp), %eax
	movl	%eax, -96(%rbp)
# 32:
	jmp .L3
# 33:
.L6:
	jmp .L3
# 34:arg1 = b arg2 = c 
.L2:
	movl	-8(%rbp), %eax
	movl	-12(%rbp), %edx
	cmpl	%edx, %eax
	jl .L7
# 35:
	jmp .L8
# 36:
	jmp .L9
# 37:res = min arg1 = b 
.L7:
	movl	-8(%rbp), %eax
	movl	%eax, -20(%rbp)
# 38:res = t014 arg1 = b 
	movl	-8(%rbp), %eax
	movl	%eax, -100(%rbp)
# 39:
	jmp .L3
# 40:res = min arg1 = c 
.L8:
	movl	-12(%rbp), %eax
	movl	%eax, -20(%rbp)
# 41:res = t015 arg1 = c 
	movl	-12(%rbp), %eax
	movl	%eax, -104(%rbp)
# 42:
	jmp .L3
# 43:
.L9:
	jmp .L3
# 44:arg1 = a arg2 = b 
.L3:
	movl	-4(%rbp), %eax
	movl	-8(%rbp), %edx
	cmpl	%edx, %eax
	jg .L10
# 45:
	jmp .L11
# 46:
	jmp .L12
# 47:arg1 = a arg2 = c 
.L10:
	movl	-4(%rbp), %eax
	movl	-12(%rbp), %edx
	cmpl	%edx, %eax
	jg .L13
# 48:
	jmp .L14
# 49:
	jmp .L15
# 50:res = max arg1 = a 
.L13:
	movl	-4(%rbp), %eax
	movl	%eax, -24(%rbp)
# 51:res = t016 arg1 = a 
	movl	-4(%rbp), %eax
	movl	%eax, -108(%rbp)
# 52:
	jmp .L12
# 53:res = max arg1 = c 
.L14:
	movl	-12(%rbp), %eax
	movl	%eax, -24(%rbp)
# 54:res = t017 arg1 = c 
	movl	-12(%rbp), %eax
	movl	%eax, -112(%rbp)
# 55:
	jmp .L12
# 56:
.L15:
	jmp .L12
# 57:arg1 = b arg2 = c 
.L11:
	movl	-8(%rbp), %eax
	movl	-12(%rbp), %edx
	cmpl	%edx, %eax
	jg .L16
# 58:
	jmp .L17
# 59:
	jmp .L18
# 60:res = max arg1 = b 
.L16:
	movl	-8(%rbp), %eax
	movl	%eax, -24(%rbp)
# 61:res = t018 arg1 = b 
	movl	-8(%rbp), %eax
	movl	%eax, -116(%rbp)
# 62:
	jmp .L12
# 63:res = max arg1 = c 
.L17:
	movl	-12(%rbp), %eax
	movl	%eax, -24(%rbp)
# 64:res = t019 arg1 = c 
	movl	-12(%rbp), %eax
	movl	%eax, -120(%rbp)
# 65:
	jmp .L12
# 66:
.L18:
	jmp .L12
# 67:res = t020 arg1 = a arg2 = b 
.L12:
	movl	-4(%rbp), %eax
	movl	-8(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -124(%rbp)
# 68:res = t021 arg1 = t020 arg2 = c 
	movl	-124(%rbp), %eax
	movl	-12(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -128(%rbp)
# 69:res = sum arg1 = t021 
	movl	-128(%rbp), %eax
	movl	%eax, -28(%rbp)
# 70:res = t022 arg1 = t021 
	movl	-128(%rbp), %eax
	movl	%eax, -132(%rbp)
# 71:
	movq	$.STR3,	%rdi
# 72:res = t023 
	pushq %rbp
	call	prints
	movl	%eax, -136(%rbp)
	addq $8 , %rsp
# 73:res = min 
# 74:res = t024 
	pushq %rbp
	movl	-20(%rbp) , %edi
	call	printi
	movl	%eax, -140(%rbp)
	addq $0 , %rsp
# 75:
	movq	$.STR4,	%rdi
# 76:res = t025 
	pushq %rbp
	call	prints
	movl	%eax, -144(%rbp)
	addq $8 , %rsp
# 77:res = max 
# 78:res = t026 
	pushq %rbp
	movl	-24(%rbp) , %edi
	call	printi
	movl	%eax, -148(%rbp)
	addq $0 , %rsp
# 79:
	movq	$.STR5,	%rdi
# 80:res = t027 
	pushq %rbp
	call	prints
	movl	%eax, -152(%rbp)
	addq $8 , %rsp
# 81:res = sum 
# 82:res = t028 
	pushq %rbp
	movl	-28(%rbp) , %edi
	call	printi
	movl	%eax, -156(%rbp)
	addq $0 , %rsp
.LRT0:
	addq	$-156, %rsp
	movq	%rbp, %rsp
	popq	%rbp
	ret
.LFE0:
	.size	main, .-main
