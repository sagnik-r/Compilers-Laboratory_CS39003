	.file	"ass1a.c"
	.text
	.section	.rodata
.LC0:
	.string	"\nThe greater number is: %d"		/*Preparing string for displaying through printf*/
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	pushq	%rbp					/*Push the base pointer onto stack*/
	movq	%rsp, %rbp				/*Copy contents of rsp to rbp*/
	subq	$16, %rsp				/*Allocate stack space of 16 bits to store variables*/	
	movl	$45, -8(%rbp)			/*Store the value 45 in num1 (Mem[rbp - 8]) corr to line num1 = 45 in program*/
	movl	$68, -4(%rbp)			/*Store the value 68 in num2 (Mem[rbp - 4]) corr to line num2 = 68 in program*/
	movl	-8(%rbp), %eax			/*Copy the contents of num1 (Mem[rbp - 8]) to eax*/
	cmpl	-4(%rbp), %eax			/*Subtract the content of num2 (Mem[rbp - 4]) from eax, which stores num1, that is set condition 
										codes according to value of num1 - num2 for if statement*/
	jle	.L2							/*If the condition code generated in previous step <=0 jump to .L2
										effectively if(num1-num2<=0) jump to L2*/
	movl	-8(%rbp), %eax			/*Copies the value of variable num1 (Mem[rbp - 8]) to eax*/
	movl	%eax, -12(%rbp)			/*Copies the value of eax (num1) to variable greater (Mem[rbp - 12])*/
	jmp	.L3							/*Jump to .L3*/
.L2:
	movl	-4(%rbp), %eax			/*Copies the value of variable num2 (Mem[rbp - 4]) to eax*/
	movl	%eax, -12(%rbp)			/*Copies the value of eax (num2) to variable greater (Mem[rbp - 12])*/
.L3:
	movl	-12(%rbp), %eax			/*Copies the value of variable greater (Mem[rbp - 12]) to eax*/
	movl	%eax, %esi				/*Moves eax to esi*/
	leaq	.LC0(%rip), %rdi		/*Loads the address of display string to rdi*/
	movl	$0, %eax				/*Makes value of eax to 0 corresponding to return 0 in main*/
	call	printf@PLT				/*Calls printf*/
	movl	$0, %eax				/*Makes value of eax to 0 corresponding to return 0 in main*/
	leave							/*Sets rsp to rbp, then pops rbp*/
	ret 							/*Exit from main*/
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu2) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
