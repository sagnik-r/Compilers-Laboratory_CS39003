	.file	"output.s"

.STR0:	.string "Enter number of elements in array(should be less than 100):"
.STR1:	.string "Enter Element:"
.STR2:	.string "Maximum element of array:"
	.text
	.globl	max
	.type	max, @function
max:
.LFB0:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$92, %rsp
	movl	%edi, -4(%rbp)
	movq	%rsi, -12(%rbp)
# 0:res = t000 
	movl	$0, -24(%rbp)
# 1:res = t001 
	movl	$0, -28(%rbp)
# 2:res = t003 arg1 = t001 
	movl	-28(%rbp), %eax
	movl	$4, %ecx
	imull	%ecx, %eax
	movl	%eax, -36(%rbp)
# 3:res = t002 arg1 = t000 arg2 = t003 
	movl	-24(%rbp), %eax
	movl	-36(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -32(%rbp)
# 4:res = t004 arg1 = a arg2 = t002 
	movq	-12(%rbp), %rdx
	movslq	-32(%rbp), %rax
	addq	%rax, %rdx
	movl	(%rdx), %eax
	movl	%eax, -40(%rbp)
# 5:res = max arg1 = t004 
	movl	-40(%rbp), %eax
	movl	%eax, -20(%rbp)
# 6:res = t005 arg1 = t004 
	movl	-40(%rbp), %eax
	movl	%eax, -44(%rbp)
# 7:res = t006 
	movl	$1, -48(%rbp)
# 8:res = i arg1 = t006 
	movl	-48(%rbp), %eax
	movl	%eax, -16(%rbp)
# 9:res = t007 arg1 = t006 
	movl	-48(%rbp), %eax
	movl	%eax, -52(%rbp)
# 10:arg1 = i arg2 = n 
.L3:
	movl	-16(%rbp), %eax
	movl	-4(%rbp), %edx
	cmpl	%edx, %eax
	jl .L1
# 11:
	jmp .L2
# 12:
	jmp .L2
# 13:res = t008 arg1 = i 
.L5:
	movl	-16(%rbp), %eax
	movl	%eax, -56(%rbp)
# 14:res = i arg1 = i 
	movl	-16(%rbp), %eax
	movl	$1, %edx
	addl	%edx, %eax
	movl	%eax, -16(%rbp)
# 15:
	jmp .L3
# 16:res = t009 
.L1:
	movl	$0, -60(%rbp)
# 17:res = t011 arg1 = i 
	movl	-16(%rbp), %eax
	movl	$4, %ecx
	imull	%ecx, %eax
	movl	%eax, -68(%rbp)
# 18:res = t010 arg1 = t009 arg2 = t011 
	movl	-60(%rbp), %eax
	movl	-68(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -64(%rbp)
# 19:res = t012 arg1 = a arg2 = t010 
	movq	-12(%rbp), %rdx
	movslq	-64(%rbp), %rax
	addq	%rax, %rdx
	movl	(%rdx), %eax
	movl	%eax, -72(%rbp)
# 20:arg1 = max arg2 = t012 
	movl	-20(%rbp), %eax
	movl	-72(%rbp), %edx
	cmpl	%edx, %eax
	jl .L4
# 21:
	jmp .L5
# 22:
	jmp .L6
# 23:res = t013 
.L4:
	movl	$0, -76(%rbp)
# 24:res = t015 arg1 = i 
	movl	-16(%rbp), %eax
	movl	$4, %ecx
	imull	%ecx, %eax
	movl	%eax, -84(%rbp)
# 25:res = t014 arg1 = t013 arg2 = t015 
	movl	-76(%rbp), %eax
	movl	-84(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -80(%rbp)
# 26:res = t016 arg1 = a arg2 = t014 
	movq	-12(%rbp), %rdx
	movslq	-80(%rbp), %rax
	addq	%rax, %rdx
	movl	(%rdx), %eax
	movl	%eax, -88(%rbp)
# 27:res = max arg1 = t016 
	movl	-88(%rbp), %eax
	movl	%eax, -20(%rbp)
# 28:res = t017 arg1 = t016 
	movl	-88(%rbp), %eax
	movl	%eax, -92(%rbp)
# 29:
	jmp .L5
# 30:
.L6:
	jmp .L5
# 31:res = max 
.L2:
	movl	-20(%rbp), %eax
	jmp	.LRT0
.LRT0:
	addq	$-92, %rsp
	movq	%rbp, %rsp
	popq	%rbp
	ret
.LFE0:
	.size	max, .-max
	.globl	main
	.type	main, @function
main:
.LFB1:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$496, %rsp
# 32:res = t018 
	movl	$100, -404(%rbp)
# 33:
	movq	$.STR0,	%rdi
# 34:res = t019 
	pushq %rbp
	call	prints
	movl	%eax, -420(%rbp)
	addq $8 , %rsp
# 35:res = t020 arg1 = scan 
	leaq	-416(%rbp), %rax
	movq	%rax, -428(%rbp)
# 36:res = t020 
# 37:res = t021 
	pushq %rbp
	movq	-428(%rbp), %rdi
	call	readi
	movl	%eax, -432(%rbp)
	addq $0 , %rsp
# 38:res = n arg1 = t021 
	movl	-432(%rbp), %eax
	movl	%eax, -412(%rbp)
# 39:res = t022 arg1 = t021 
	movl	-432(%rbp), %eax
	movl	%eax, -436(%rbp)
# 40:res = t023 
	movl	$0, -440(%rbp)
# 41:res = i arg1 = t023 
	movl	-440(%rbp), %eax
	movl	%eax, -408(%rbp)
# 42:res = t024 arg1 = t023 
	movl	-440(%rbp), %eax
	movl	%eax, -444(%rbp)
# 43:arg1 = i arg2 = n 
.L9:
	movl	-408(%rbp), %eax
	movl	-412(%rbp), %edx
	cmpl	%edx, %eax
	jl .L7
# 44:
	jmp .L8
# 45:
	jmp .L8
# 46:res = t025 arg1 = i 
.L10:
	movl	-408(%rbp), %eax
	movl	%eax, -448(%rbp)
# 47:res = i arg1 = i 
	movl	-408(%rbp), %eax
	movl	$1, %edx
	addl	%edx, %eax
	movl	%eax, -408(%rbp)
# 48:
	jmp .L9
# 49:
.L7:
	movq	$.STR1,	%rdi
# 50:res = t026 
	pushq %rbp
	call	prints
	movl	%eax, -452(%rbp)
	addq $8 , %rsp
# 51:res = t027 
	movl	$0, -456(%rbp)
# 52:res = t029 arg1 = i 
	movl	-408(%rbp), %eax
	movl	$4, %ecx
	imull	%ecx, %eax
	movl	%eax, -464(%rbp)
# 53:res = t028 arg1 = t027 arg2 = t029 
	movl	-456(%rbp), %eax
	movl	-464(%rbp), %edx
	addl	%edx, %eax
	movl	%eax, -460(%rbp)
# 54:res = t030 arg1 = scan 
	leaq	-416(%rbp), %rax
	movq	%rax, -472(%rbp)
# 55:res = t030 
# 56:res = t031 
	pushq %rbp
	movq	-472(%rbp), %rdi
	call	readi
	movl	%eax, -476(%rbp)
	addq $0 , %rsp
# 57:res = a arg1 = t028 arg2 = t031 
	leaq	-400(%rbp), %rdx
	movslq	-460(%rbp), %rax
	addq	%rax, %rdx
	movl	-476(%rbp), %eax
	movl	%eax, (%rdx)
# 58:res = t032 arg1 = t031 
	movl	-476(%rbp), %eax
	movl	%eax, -480(%rbp)
# 59:
	jmp .L10
# 60:
.L8:
	movq	$.STR2,	%rdi
# 61:res = t033 
	pushq %rbp
	call	prints
	movl	%eax, -484(%rbp)
	addq $8 , %rsp
# 62:res = t034 
	movl	$0, -488(%rbp)
# 63:res = a 
# 64:res = n 
# 65:res = t035 
	pushq %rbp
	movl	-412(%rbp) , %edi
	leaq	-400(%rbp), %rsi
	call	max
	movl	%eax, -492(%rbp)
	addq $0 , %rsp
# 66:res = t035 
# 67:res = t036 
	pushq %rbp
	movl	-492(%rbp) , %edi
	call	printi
	movl	%eax, -496(%rbp)
	addq $0 , %rsp
.LRT1:
	addq	$-496, %rsp
	movq	%rbp, %rsp
	popq	%rbp
	ret
.LFE1:
	.size	main, .-main
