	.global main

	.section .rodata
.title: .string "HELLO, WORLD"

.F0: .string "GLFW error (0x%.08x): %s\n"

.ONE: .float 1.0
.TRI: .float -0.5, -0.5, 0.0
      .float  0.5, -0.5, 0.0
      .float  0.0,  0.5, 0.0
TRI_SIZE = . - .TRI

	.text

# glfw_error(int, char *)
glfw_error:
	push	%rbp
	mov	%rsp, %rbp

	mov 	%rsi, %rdx
	mov 	%edi, %esi
	lea 	.F0(%rip), %rdi
	xor	%al, %al
	call 	printf

	leave
	ret

glfw_resize:
	push 	%rbp
	mov	%rsp, %rbp

	mov	%edx, %ecx
	mov	%esi, %edx
	xor	%esi, %esi
	xor	%edi, %edi
	call	glViewport

	leave
	ret

main:
	push	%rbx
	sub	$16, %rsp
	
	lea	glfw_error(%rip), %rdi
	call	glfwSetErrorCallback

	call 	glfwInit
	cmp	$1, %eax
	jne 	exit

	# glfwCreateWindow(int, int, char *, void *, void *)
	mov	$640, %edi # 1st argument (width)
	mov	$480, %esi # 2nd argument (height)
	lea	.title(%rip), %rdx # 3rd argument
	xor	%ecx, %ecx # 4th
	xor	%r8d, %r8d # 5th
	call	glfwCreateWindow
	mov	%rax, %rbx

	mov	%rbx, %rdi
	call	glfwMakeContextCurrent
	mov	%rbx, %rdi
	lea	glfw_resize(%rip), %rsi
	call	glfwSetFramebufferSizeCallback

	# glViewport(0, 0, 640, 480)
	xor	%edi, %edi
	xor	%esi, %esi
	mov	$640, %edx
	mov	$480, %ecx
	call	glViewport

	# glClearColor(1.0, 0.0, 0.0, 1.0)
	movss	.ONE(%rip), %xmm0
	pxor	%xmm1, %xmm1
	pxor	%xmm2, %xmm2
	movss	.ONE(%rip), %xmm3
	call	glClearColor

	# glGenVertexArrays(1, &VAO)
	mov	$1, %edi
	lea	4(%rsp), %rsi
	call	glGenVertexArrays
	
	# glGenBuffers(1, &VBO_POS)
	mov	$1, %edi
	lea	8(%rsp), %rsi
	call	glGenBuffers

	# glBindVertexArray(VAO)
	mov	4(%rsp), %esi
	call	glBindVertexArray

	# glBindBuffer(GL_ARRAY_BUFFER, VBO_POS)
	mov	$0x8892, %edi
	mov	8(%rsp), %esi
	call	glBindBuffer

	# glBufferData(GL_ARRAY_BUFFER, sizeof(.TRI), .TRI, GL_STATIC_DRAW)
	mov	$0x8892, %edi
	mov	$TRI_SIZE, %esi
	lea	.TRI(%rip), %rdx
	mov	$0x88E4, %ecx
	call	glBufferData

	# glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 12, 0)
	xor	%edi, %edi
	mov	$3, %esi
	mov	$0x1406, %edx
	xor	%ecx, %ecx
	mov	$12, %r8d
	xor	%r9d, %r9d
	call	glVertexAttribPointer

	# glEnableVertexAttribArray(0)
	xor	%edi, %edi
	call	glEnableVertexAttribArray
	
	# glBindBuffer(GL_ARRAY_BUFFER, 0)
	mov	$0x8892, %edi
	xor	%esi, %esi
	call	glBindBuffer

loop:
	# glClear(GL_COLOR_BUFFER_BIT)
	mov	$0x4000, %edi
	call	glClear

	# glDrawArrays(GL_TRIANGLES, 0, 3)
	mov	$0x0004, %edi
	xor	%esi, %esi
	mov	$3, %edx
	call	glDrawArrays

	mov	%rbx, %rdi
	call	glfwSwapBuffers
	call	glfwPollEvents
	mov	%rbx, %rdi
	call	glfwWindowShouldClose
	test	%al, %al
	je	loop

	xor 	%al, %al
exit:
	add	$16, %rsp
	pop	%rbx
	ret
