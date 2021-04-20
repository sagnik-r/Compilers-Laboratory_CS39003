	.file	"output.s"

.STR0:	.string "\n"
.STR1:	.string "Printing elements in array:"
.STR2:	.string "\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$176, %rsp
# 0:res = t000 
	movl	$1, -16(%rbp)
# 1:res = a arg1 = t000 
	movl	-16(%rbp), %eax
	movl	%eax, -12(%rbp)
# 2:res = t001 arg1 = a 
	leaq	-12(%rbp), %rax
	movq	%rax, -24(%rbp)
# 3:res = b arg1 = t001 
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
# 4:res = t002 arg1 = t001 
	movq	-24(%rbp), %rax
	movq	%rax, -32(%rbp)
# 5:res = t003 arg1 = b 
	movq	-8(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -36(%rbp)
# 6:res = t004 
	movl	$100, -40(%rbp)
# 7:res = t005 arg1 = t003 arg2 = t004 
	movl	-36(%rbp), %eax
	movl	-40(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -44(%rbp)
# 8:res = b arg1 = t005 
	movq	-8(%rbp), %rax
	movl	-44(%rbp), %edx
	movl	%edx, (%rax)
# 9:res = t006 arg1 = t005 
	movl	-44(%rbp), %eax
	movl	%eax, -48(%rbp)
# 10:res = a 
# 11:res = t007 
	pushq %rbp
	movl	-12(%rbp) , %edi
	call	printi
	movl	%eax, -52(%rbp)
	addq $0 , %rsp
# 12:
	movq	$.STR0,	%rdi
# 13:res = t008 
	pushq %rbp
	call	prints
	movl	%eax, -56(%rbp)
	addq $8 , %rsp
# 14:res = t009 
	movl	$10, -100(%rbp)
# 15:res = t010 
	movl	$0, -104(%rbp)
# 16:res = i arg1 = t010 
	movl	-104(%rbp), %eax
	movl	%eax, -100(%rbp)
# 17:res = t011 arg1 = t010 
	movl	-104(%rbp), %eax
	movl	%eax, -108(%rbp)
# 18:res = t012 
.L3:
	movl	$10, -112(%rbp)
# 19:arg1 = i arg2 = t012 
	movl	-100(%rbp), %eax
	movl	-112(%rbp), %edx
	cmpl	%edx, %eax
	jl .L1
# 20:
	jmp .L2
# 21:
	jmp .L2
# 22:res = t013 arg1 = i 
.L4:
	movl	-100(%rbp), %eax
	movl	%eax, -112(%rbp)
# 23:res = i arg1 = i 
	movl	-100(%rbp), %eax
	movl	$1, %edx
	addl	%edx, %eax
	movl	%eax, -100(%rbp)
# 24:
	jmp .L3
# 25:res = t014 
.L1:
	movl	$0, -116(%rbp)
# 26:res = t016 arg1 = i 
	movl	-100(%rbp), %eax
	movl	$4, %ecx
	imull	%ecx, %eax
	movl	%eax, -124(%rbp)
# 27:res = t015 arg1 = t014 arg2 = t016 
	movl	-116(%rbp), %eax
	movl	-124(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -120(%rbp)
# 28:res = t017 
	movl	$10, -128(%rbp)
# 29:res = t018 arg1 = i arg2 = t017 
	movl	-100(%rbp), %eax
	imull	-128(%rbp), %eax
	movl	%eax, -132(%rbp)
# 30:res = c arg1 = t015 arg2 = t018 
	leaq	-96(%rbp), %rdx
	movslq	-120(%rbp), %rax
	addq	%rax, %rdx
	movl	-132(%rbp), %eax
	movl	%eax, (%rdx)
# 31:res = t019 arg1 = t018 
	movl	-132(%rbp), %eax
	movl	%eax, -136(%rbp)
# 32:
	jmp .L4
# 33:
.L2:
	movq	$.STR1,	%rdi
# 34:res = t020 
	pushq %rbp
	call	prints
	movl	%eax, -140(%rbp)
	addq $8 , %rsp
# 35:res = t021 
	movl	$0, -144(%rbp)
# 36:res = i arg1 = t021 
	movl	-144(%rbp), %eax
	movl	%eax, -100(%rbp)
# 37:res = t022 arg1 = t021 
	movl	-144(%rbp), %eax
	movl	%eax, -148(%rbp)
# 38:res = t023 
.L7:
	movl	$10, -152(%rbp)
# 39:arg1 = i arg2 = t023 
	movl	-100(%rbp), %eax
	movl	-152(%rbp), %edx
	cmpl	%edx, %eax
	jl .L5
# 40:
	jmp	.LRT0
# 41:
	jmp	.LRT0
# 42:res = t024 arg1 = i 
.L8:
	movl	-100(%rbp), %eax
	movl	%eax, -152(%rbp)
# 43:res = i arg1 = i 
	movl	-100(%rbp), %eax
	movl	$1, %edx
	addl	%edx, %eax
	movl	%eax, -100(%rbp)
# 44:
	jmp .L7
# 45:
.L5:
	movq	$.STR2,	%rdi
# 46:res = t025 
	pushq %rbp
	call	prints
	movl	%eax, -156(%rbp)
	addq $8 , %rsp
# 47:res = t026 
	movl	$0, -160(%rbp)
# 48:res = t028 arg1 = i 
	movl	-100(%rbp), %eax
	movl	$4, %ecx
	imull	%ecx, %eax
	movl	%eax, -168(%rbp)
# 49:res = t027 arg1 = t026 arg2 = t028 
	movl	-160(%rbp), %eax
	movl	-168(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -164(%rbp)
# 50:res = t029 arg1 = c arg2 = t027 
	leaq	-96(%rbp), %rdx
	movslq	-164(%rbp), %rax
	addq	%rax, %rdx
	movl	(%rdx), %eax
	movl	%eax, -172(%rbp)
# 51:res = t029 
# 52:res = t030 
	pushq %rbp
	movl	-172(%rbp) , %edi
	call	printi
	movl	%eax, -176(%rbp)
	addq $0 , %rsp
# 53:
	jmp .L8
.LRT0:
	addq	$-176, %rsp
	movq	%rbp, %rsp
	popq	%rbp
	ret
.LFE0:
	.size	main, .-main
