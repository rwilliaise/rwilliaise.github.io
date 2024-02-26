
	.global main
	.text

title:
	.string "GLFW from ASM: Why Not"

main:
	push 	%rbx		# since we are already using rbx below, ensure stack alignment
	call 	glfwInit
	cmp 	$1, %rax
	jne 	init_fail	# jump straight to end on failure (return code)

	# glfwCreateWindow(int width, int height, char *title, void *monitor, void *share)
	mov 	$640, %edi
	mov 	$480, %esi
	lea 	title(%rip), %rdx
	xor	%ecx, %ecx
	xor 	%r8d, %r8d
	call 	glfwCreateWindow
	mov 	%rax, %rbx	# store window into rbx
	mov 	%rax, %rdi
	call 	glfwMakeContextCurrent

loop:
	# glClear(GL_COLOR_BUFFER_BIT)
	mov 	$0x00004000, %rdi
	call 	glClear
	mov	%rbx, %rdi
	call 	glfwSwapBuffers
	call 	glfwPollEvents
	# glfwWindowShouldClose(void *window)
	mov	%rbx, %rdi
	call 	glfwWindowShouldClose
	test 	%eax, %eax
	je 	loop

	xor 	%eax, %eax
init_fail:
	pop 	%rbx
	ret
	
