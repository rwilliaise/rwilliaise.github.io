
	.global main
	.text

message:
	.string "Hello, world!"

main:
	lea 	message(%rip), %rdi 	# use RIP relative addressing to put the message into rdi
	call 	puts			# call puts
	xor 	%rax, %rax		# set rax to zero (for exit)
	ret				# return

	
