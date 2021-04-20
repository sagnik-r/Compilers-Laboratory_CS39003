	.file	"ass1b.c"
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"\nGCD of %d %d %d and %d is: %d"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	pushq	%rbp						/*Push the base pointer onto stack*/
	movq	%rsp, %rbp					/*Copy contents of rsp to rbp*/
	subq	$32, %rsp					/*Allocate stack space of 32 bits to store variables*/
	movl	$45, -20(%rbp)				/*Store the value of 45 in a (Mem[rbp - 20]) corr to line a = 45*/
	movl	$99, -16(%rbp)				/*Store the value of 99 in b (Mem[rbp - 16]) corr to line b = 99*/
	movl	$18, -12(%rbp)				/*Store the value of 18 in c (Mem[rbp - 12]) corr to line c = 18*/
	movl	$180, -8(%rbp)				/*Store the value of 180 in d (Mem[rbp - 8]) corr to line d = 180*/
	movl	-8(%rbp), %ecx				/*Copy the value of variable d (Mem[rbp - 8]) to ecx (4th argument to function)*/
	movl	-12(%rbp), %edx				/*Copy the value of variable c (Mem[rbp - 12]) to edx (3rd argument to function)*/
	movl	-16(%rbp), %esi				/*Copy the value of variable b (Mem[rbp - 16]) to esi (2nd argument to function)*/
	movl	-20(%rbp), %eax				/*Copy the value of variable a (Mem[rbp - 20]) to eax (default return register)*/
	movl	%eax, %edi					/*Copy the contents of a (in eax) to edi (1st argument to function)*/
	call	GCD4 						/*call to the function GCD4 with arguments (a(edi), b(esi), c(edx), d(ecx))*/
	movl	%eax, -4(%rbp)				/*The value returned by GCD4, stored in eax, is copied to result (Mem[rbp - 4])*/
	movl	-4(%rbp), %edi				/*Copy the value of result (Mem[rbp - 4]) to edi*/
	movl	-8(%rbp), %esi				/*Copy the value of d (Mem[rbp - 8]) to esi*/
	movl	-12(%rbp), %ecx				/*Copy the value of c (Mem[rbp - 12]) to ecx*/
	movl	-16(%rbp), %edx 			/*Copy the value of b (Mem[rbp - 16]) to edx*/
	movl	-20(%rbp), %eax				/*Copy the value of a (Mem[rbp - 20]) to eax*/
	movl	%edi, %r9d					/*Copy the value of edi (result) to r9d for printf function argument*/
	movl	%esi, %r8d					/*Copy the value of esi (d) to r8d for printf function argument*/
	movl	%eax, %esi					/*Copy the value of eax (a) to esi for printf function argument*/
	leaq	.LC0(%rip), %rdi			/*Loads the address of display string to rdi*/
	movl	$0, %eax					/*Makes value of eax to 0 corresponding to return 0 in main*/
	call	printf@PLT					/*Calls printf*/
	movl	$10, %edi 					/*Store the value of 10 in edi*/
	call	putchar@PLT					/*Call to printf("\n")*/
	movl	$0, %eax					/*Makes value of eax to 0 corresponding to return 0 in main*/
	leave								/*Sets rsp to rbp, then pops rbp*/
	ret 								/*Exits main*/
	.size	main, .-main
	.globl	GCD4
	.type	GCD4, @function
GCD4:
	endbr64								
	pushq	%rbp						/*Push the base pointer onto stack*/						
	movq	%rsp, %rbp					/*Copy contents of rsp to rbp*/		
	subq	$32, %rsp					/*Allocate stack space of 32 bits to store variables*/
	movl	%edi, -20(%rbp)				/*Copy n1 (edi) to Mem[rbp - 20]*/
	movl	%esi, -24(%rbp)				/*Copy n2 (esi) to Mem[rbp - 24]*/
	movl	%edx, -28(%rbp)				/*Copy n3 (edx) to Mem[rbp - 28]*/
	movl	%ecx, -32(%rbp)				/*Copy n4 (ecx) to Mem[rbp - 32]*/
	movl	-24(%rbp), %edx				/*Copy Mem[rbp - 24] which stores value of n2 to edx*/
	movl	-20(%rbp), %eax				/*Copy Mem[rbp - 20] which stores value of n1 to eax*/
	movl	%edx, %esi					/*Copy the value of edx (n2) to esi, the 2nd argument of the function*/
	movl	%eax, %edi					/*Copy the value of eax (n1) to edi, the 2nd argument of the function*/
	call	GCD 						/*Call to the function GCD with arguments (n1(edi), n2(esi))*/
	movl	%eax, -12(%rbp)				/*Copy the value returned by GCD(n1, n2) stored in eax to t1 (Mem[rbp - 12]) corr to the line t1 = GCD(n1, n2)*/
	movl	-32(%rbp), %edx				/*Copy Mem[rbp - 32] which stores value of n4 to edx*/
	movl	-28(%rbp), %eax				/*Copy Mem[rbp - 28] which stores value of n3 to eax*/
	movl	%edx, %esi					/*Copy the value of edx (n4) to esi, the 2nd argument of the function*/
	movl	%eax, %edi					/*Copy the value of eax (n3) to edi, the 1st argument of the function*/
	call	GCD 						/*Call to the function GCD with arguments (n3(edi), n4(esi))*/
	movl	%eax, -8(%rbp)				/*Copy the value returned by GCD(n3, n4) stored in eax to t2 (Mem[rbp - 8]) corr to the line t2 = GCD(n3, n4)*/
	movl	-8(%rbp), %edx				/*Copy the value of t2 (Mem[rbp - 8]) to edx*/
	movl	-12(%rbp), %eax				/*Copy the value of t1 (Mem[rbp - 12]) to eax*/
	movl	%edx, %esi					/*Copy the value of edx (t2) to esi, the 2nd argument of the function*/
	movl	%eax, %edi					/*Copy the value of eax (t1) to edi, the 1st argument of the function*/
	call	GCD 						/*Call to the function GCD with arguments (t1(edi), t2(esi))*/
	movl	%eax, -4(%rbp)				/*Copy the value returned by GCD(t1, t2) stored in eax to t3 (Mem[rbp - 4]) corr to the line t3 = GCD(t1, t2)*/
	movl	-4(%rbp), %eax				/*Copy the value of t3 (Mem[rbp - 4]) to eax corresponding to return t3 in GCD4*/
	leave								/*Set ​%rsp​ to ​%rbp​, then pop top of stack into ​%rbp*/
	ret 								/*Pop return address from stack and jump there*/
	.size	GCD4, .-GCD4
	.globl	GCD
	.type	GCD, @function
GCD:
	endbr64
	pushq	%rbp						/*Push the base pointer onto stack*/
	movq	%rsp, %rbp					/*Copy the contents of rsp to rbp*/
	movl	%edi, -20(%rbp)				/*Copy num1 (edi) to Mem[rbp - 20]*/
	movl	%esi, -24(%rbp)				/*Copy num2 (esi) to Mem[rbp - 24]*/
	jmp	.L6								/*Jump to L6 (while loop checking condition)*/
.L7:
	movl	-20(%rbp), %eax				/*Copy num1 (Mem[rbp - 20]) to eax*/
	cltd								/*converts the signed long in eax to a signed double long in edx:eax by extending the 
										most-significant bit (sign bit) of eax into all bits of edx*/
	idivl	-24(%rbp)					/*Signed divide eax by num2 (Mem[rbp - 24])
										Quotient: eax Remainder: edx*/
	movl	%edx, -4(%rbp)				/*Copy the remainder of the division (edx) to temp (Mem[rbp - 4])*/
	movl	-24(%rbp), %eax				/*Copy num2 (Mem[rbp - 24]) to eax*/
	movl	%eax, -20(%rbp)				/*Copy eax to num1 (Mem[rbp - 20]), this and the last line together implements 
										num1 = num2 in the while loop*/
	movl	-4(%rbp), %eax				/*Copy the value of temp (Mem[rbp - 4]) to eax*/
	movl	%eax, -24(%rbp)				/*Copy eax to num2 (Mem[rbp - 24]), this and the last line together implements 
										num2 = temp in the while loop*/
.L6:
	movl	-20(%rbp), %eax				/*Copy the value of num1 (Mem[rbp - 20]) to eax*/
	cltd								/*converts the signed long in eax to a signed double long in edx:eax by extending the 
										most-significant bit (sign bit) of eax into all bits of edx*/
	idivl	-24(%rbp)					/*Signed divide eax by num2 (Mem[rbp - 24])
										Quotient: eax Remainder: edx*/
	movl	%edx, %eax					/*Copy the Remainder of the division in last step, stored in edx to eax*/
	testl	%eax, %eax					/*Set condition according to eax & eax*/
	jne	.L7 							/*If the condition in previous step is not equal to zero corresponding to the while
										loop condition, jump to L7, the body of the loop*/
	movl	-24(%rbp), %eax
	popq	%rbp
	ret
	.size	GCD, .-GCD
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
