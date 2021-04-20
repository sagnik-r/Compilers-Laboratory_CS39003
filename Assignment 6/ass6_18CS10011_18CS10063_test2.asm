	.file	"output.s"

.STR0:	.string "Enter first number:"
.STR1:	.string "Enter second number:"
.STR2:	.string "Quotient:"
.STR3:	.string "\nRemainder:"
.STR4:	.string "Can't divide by zero"
.STR5:	.string "\nEnter number:"
.STR6:	.string "Factorial:"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$168, %rsp
# 0:res = t000 
	movl	$1, -32(%rbp)
# 1:res = fac arg1 = t000 
	movl	-32(%rbp), %eax
	movl	%eax, -28(%rbp)
# 2:res = t001 arg1 = t000 
	movl	-32(%rbp), %eax
	movl	%eax, -36(%rbp)
# 3:
	movq	$.STR0,	%rdi
# 4:res = t002 
	pushq %rbp
	call	prints
	movl	%eax, -40(%rbp)
	addq $8 , %rsp
# 5:res = t003 arg1 = scan 
	leaq	-16(%rbp), %rax
	movq	%rax, -48(%rbp)
# 6:res = t003 
# 7:res = t004 
	pushq %rbp
	movq	-48(%rbp), %rdi
	call	readi
	movl	%eax, -52(%rbp)
	addq $0 , %rsp
# 8:res = x arg1 = t004 
	movl	-52(%rbp), %eax
	movl	%eax, -4(%rbp)
# 9:res = t005 arg1 = t004 
	movl	-52(%rbp), %eax
	movl	%eax, -56(%rbp)
# 10:
	movq	$.STR1,	%rdi
# 11:res = t006 
	pushq %rbp
	call	prints
	movl	%eax, -60(%rbp)
	addq $8 , %rsp
# 12:res = t007 arg1 = scan 
	leaq	-16(%rbp), %rax
	movq	%rax, -68(%rbp)
# 13:res = t007 
# 14:res = t008 
	pushq %rbp
	movq	-68(%rbp), %rdi
	call	readi
	movl	%eax, -72(%rbp)
	addq $0 , %rsp
# 15:res = y arg1 = t008 
	movl	-72(%rbp), %eax
	movl	%eax, -8(%rbp)
# 16:res = t009 arg1 = t008 
	movl	-72(%rbp), %eax
	movl	%eax, -76(%rbp)
# 17:res = t010 
	movl	$0, -80(%rbp)
# 18:arg1 = y arg2 = t010 
	movl	-8(%rbp), %eax
	movl	-80(%rbp), %edx
	cmpl	%edx, %eax
	jne .L1
# 19:
	jmp .L2
# 20:
	jmp .L3
# 21:res = t011 arg1 = x arg2 = y 
.L1:
	movl	-4(%rbp), %eax
	cltd
	idivl	-8(%rbp), %eax
	movl	%eax, -84(%rbp)
# 22:res = quo arg1 = t011 
	movl	-84(%rbp), %eax
	movl	%eax, -20(%rbp)
# 23:res = t012 arg1 = t011 
	movl	-84(%rbp), %eax
	movl	%eax, -88(%rbp)
# 24:res = t013 arg1 = x arg2 = y 
	movl	-4(%rbp), %eax
	cltd
	idivl	-8(%rbp), %eax
	movl	%edx, -92(%rbp)
# 25:res = rem arg1 = t013 
	movl	-92(%rbp), %eax
	movl	%eax, -24(%rbp)
# 26:res = t014 arg1 = t013 
	movl	-92(%rbp), %eax
	movl	%eax, -96(%rbp)
# 27:
	movq	$.STR2,	%rdi
# 28:res = t015 
	pushq %rbp
	call	prints
	movl	%eax, -100(%rbp)
	addq $8 , %rsp
# 29:res = quo 
# 30:res = t016 
	pushq %rbp
	movl	-20(%rbp) , %edi
	call	printi
	movl	%eax, -104(%rbp)
	addq $0 , %rsp
# 31:
	movq	$.STR3,	%rdi
# 32:res = t017 
	pushq %rbp
	call	prints
	movl	%eax, -108(%rbp)
	addq $8 , %rsp
# 33:res = rem 
# 34:res = t018 
	pushq %rbp
	movl	-24(%rbp) , %edi
	call	printi
	movl	%eax, -112(%rbp)
	addq $0 , %rsp
# 35:
	jmp .L3
# 36:
.L2:
	movq	$.STR4,	%rdi
# 37:res = t019 
	pushq %rbp
	call	prints
	movl	%eax, -116(%rbp)
	addq $8 , %rsp
# 38:
	jmp .L3
# 39:
.L3:
	movq	$.STR5,	%rdi
# 40:res = t020 
	pushq %rbp
	call	prints
	movl	%eax, -124(%rbp)
	addq $8 , %rsp
# 41:res = t021 arg1 = scan 
	leaq	-16(%rbp), %rax
	movq	%rax, -132(%rbp)
# 42:res = t021 
# 43:res = t022 
	pushq %rbp
	movq	-132(%rbp), %rdi
	call	readi
	movl	%eax, -136(%rbp)
	addq $0 , %rsp
# 44:res = n arg1 = t022 
	movl	-136(%rbp), %eax
	movl	%eax, -12(%rbp)
# 45:res = t023 arg1 = t022 
	movl	-136(%rbp), %eax
	movl	%eax, -140(%rbp)
# 46:res = t024 
	movl	$1, -144(%rbp)
# 47:res = i arg1 = t024 
	movl	-144(%rbp), %eax
	movl	%eax, -120(%rbp)
# 48:res = t025 arg1 = t024 
	movl	-144(%rbp), %eax
	movl	%eax, -148(%rbp)
# 49:arg1 = i arg2 = n 
.L6:
	movl	-120(%rbp), %eax
	movl	-12(%rbp), %edx
	cmpl	%edx, %eax
	jle .L4
# 50:
	jmp .L5
# 51:
	jmp .L5
# 52:res = t026 arg1 = i 
.L7:
	movl	-120(%rbp), %eax
	movl	%eax, -152(%rbp)
# 53:res = i arg1 = i 
	movl	-120(%rbp), %eax
	movl	$1, %edx
	addl	%edx, %eax
	movl	%eax, -120(%rbp)
# 54:
	jmp .L6
# 55:res = t027 arg1 = fac arg2 = i 
.L4:
	movl	-28(%rbp), %eax
	imull	-120(%rbp), %eax
	movl	%eax, -156(%rbp)
# 56:res = fac arg1 = t027 
	movl	-156(%rbp), %eax
	movl	%eax, -28(%rbp)
# 57:res = t028 arg1 = t027 
	movl	-156(%rbp), %eax
	movl	%eax, -160(%rbp)
# 58:
	jmp .L7
# 59:
.L5:
	movq	$.STR6,	%rdi
# 60:res = t029 
	pushq %rbp
	call	prints
	movl	%eax, -164(%rbp)
	addq $8 , %rsp
# 61:res = fac 
# 62:res = t030 
	pushq %rbp
	movl	-28(%rbp) , %edi
	call	printi
	movl	%eax, -168(%rbp)
	addq $0 , %rsp
.LRT0:
	addq	$-168, %rsp
	movq	%rbp, %rsp
	popq	%rbp
	ret
.LFE0:
	.size	main, .-main
