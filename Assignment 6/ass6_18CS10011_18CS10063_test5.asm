	.file	"output.s"

	.text
	.globl	fib
	.type	fib, @function
fib:
.LFB0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$36, %rsp
	movl	%edi, -4(%rbp)
# 0:res = t000 
	movl	$1, -8(%rbp)
# 1:arg1 = n arg2 = t000 
	movl	-4(%rbp), %eax
	movl	-8(%rbp), %edx
	cmpl	%edx, %eax
	jle .L1
# 2:
	jmp .L2
# 3:
	jmp .L2
# 4:res = n 
.L1:
	movl	-4(%rbp), %eax
	jmp	.LRT0
# 5:
	jmp .L2
# 6:res = t001 
.L2:
	movl	$1, -12(%rbp)
# 7:res = t002 arg1 = n arg2 = t001 
	movl	-4(%rbp), %eax
	movl	-12(%rbp), %edx
	subl	%edx, %eax
	movl	%eax, -16(%rbp)
# 8:res = t002 
# 9:res = t003 
	pushq %rbp
	movl	-16(%rbp) , %edi
	call	fib
	movl	%eax, -20(%rbp)
	addq $0 , %rsp
# 10:res = t004 
	movl	$2, -24(%rbp)
# 11:res = t005 arg1 = n arg2 = t004 
	movl	-4(%rbp), %eax
	movl	-24(%rbp), %edx
	subl	%edx, %eax
	movl	%eax, -28(%rbp)
# 12:res = t005 
# 13:res = t006 
	pushq %rbp
	movl	-28(%rbp) , %edi
	call	fib
	movl	%eax, -32(%rbp)
	addq $0 , %rsp
# 14:res = t007 arg1 = t003 arg2 = t006 
	movl	-20(%rbp), %eax
	movl	-32(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -36(%rbp)
# 15:res = t007 
	movl	-36(%rbp), %eax
	jmp	.LRT0
.LRT0:
	addq	$-36, %rsp
	movq	%rbp, %rsp
	popq	%rbp
	ret
.LFE0:
	.size	fib, .-fib
	.globl	main
	.type	main, @function
main:
.LFB1:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$20, %rsp
# 16:res = t008 
	movl	$9, -8(%rbp)
# 17:res = n arg1 = t008 
	movl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
# 18:res = n 
# 19:res = t009 
	pushq %rbp
	movl	-4(%rbp) , %edi
	call	fib
	movl	%eax, -12(%rbp)
	addq $0 , %rsp
# 20:res = t009 
# 21:res = t010 
	pushq %rbp
	movl	-12(%rbp) , %edi
	call	printi
	movl	%eax, -16(%rbp)
	addq $0 , %rsp
# 22:res = t011 
	movl	$0, -20(%rbp)
# 23:res = t011 
	movl	-20(%rbp), %eax
	jmp	.LRT1
.LRT1:
	addq	$-20, %rsp
	movq	%rbp, %rsp
	popq	%rbp
	ret
.LFE1:
	.size	main, .-main
