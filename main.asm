.data
	filename_in: .asciiz "/Users/khoi.lenguyenkim/Desktop/BTL KTMT/input_matrix.txt"
	filename_out: .asciiz "/Users/khoi.lenguyenkim/Desktop/BTL KTMT/output_matrix.txt"

	N: .word 0         # Image matrix size
	M: .word 0         # Kernel matrix size
	p: .word 0         # Padding
	s: .word 0         # Stride


	image: .word 0:49       
	padded_image: .word 0:225 
	kernel: .word 0:20      
	out: .word 0:144        
	error_announce: .asciiz "Error: size not match"

	buffer: .space 1024  
	flt_0: .float 0.0
	flt_005: .float 0.05
	flt_1: .float 1.0
	flt_10: .float 10.0
	flt_half: .float 0.5
	flt_0000001: .float 0.000001 

.text

main:
    #Open the input file for reading
    	li $v0, 13                
    	la $a0, filename_in       
    	li $a1, 0                 
    	li $a2, 0                
    	syscall
    	move $s0, $v0            

    #Read and parse parameters (N, M, p, s)
    	li $v0, 14               
    	move $a0, $s0
    	la $a1, buffer            
    	li $a2, 1024                
    	syscall
    	
    	li $v0, 16               
    	move $a0, $s0
   	syscall                  
	 
	la $t0, buffer
	lb $v0, 0($t0)             
    	subi $v0, $v0, 48          
    	sw $v0, N 
	
	addi $t0, $t0, 4
	lb $v0, 0($t0)             
    	subi $v0, $v0, 48          
    	sw $v0, M 

	addi $t0, $t0, 4
	lb $v0, 0($t0)             
    	subi $v0, $v0, 48         
    	sw $v0, p 
	
	lw $s1, N
	lw $s2, M
	lw $s3, p
	add $s1, $s1, $s3
	add $s1, $s1, $s3
	bgt $s2, $s1, errorsize
	
	###### xet loi error ngay day
	
	
	addi $t0, $t0, 4
	lb $v0, 0($t0)             
    	subi $v0, $v0, 48    
    	sw $v0, s 
	
	addi $t0, $t0, 4
	la $a1, image
	
	j take_in_image
loop_img: 	
	addi $t0, $t0, 1
take_in_image:
	lb $s6, 0($t0)
	li $s0, 45
	li $v0, 0
	beq $s6, $s0, negative_img_tackle
	j pass_negative_img_tackle
negative_img_tackle:
	addi $t0, $t0, 1
	li $s0, 0
pass_negative_img_tackle:
	lb $s6, 0($t0)
	li $s7, 46
	beq $s6, $s7, end_integral_img
	li $s5, 10
	mul $v0, $v0, $s5
	add $v0, $v0, $s6
	subi $v0, $v0, 48
	addi $t0, $t0, 1
	j pass_negative_img_tackle
end_integral_img:	
	addi $t0, $t0, 1
	lb $v1, 0($t0)
	subi $v1, $v1, 48
	
	
	li $t1, 10####t1 hien la 10
	mul $v0, $v0, $t1          # v0 = v0 * 10
    	add $v0, $v0, $v1         # v0 = v0 + v1 
    	
    	mtc1 $v0, $f0 
    	cvt.s.w $f0, $f0
    	
    	mtc1 $t1, $f1
    	cvt.s.w $f1,$f1
    	div.s $f0, $f0, $f1##bo t1
    	beq $s0, $0, implement_neg_img
    	j end_implement_neg_img
implement_neg_img:
	neg.s $f0, $f0
end_implement_neg_img:
    	
    	s.s $f0, 0($a1) ####a1: image
    	addi $a1, $a1, 4
    	
    	addi $t0, $t0, 1
    	lb $t1, 0($t0)
    	li $t3, 32
    	beq $t1, $t3, loop_img
    	 
    	
	addi $t0, $t0, 1 ##newone
	la $a1, kernel  ####a1: kernel
	j take_in_kernel
loop_kernel: 	
	addi $t0, $t0, 1
take_in_kernel:
	lb $s6, 0($t0)
	li $s0, 45
	li $v0, 0
	beq $s6, $s0, negative_kernel_tackle
	j pass_negative_kernel_tackle
negative_kernel_tackle:
	addi $t0, $t0, 1
	li $s0, 0
pass_negative_kernel_tackle:
	lb $s6, 0($t0)
	li $s7, 46
	beq $s6, $s7, end_integral_kernel
	li $s5, 10
	mul $v0, $v0, $s5
	add $v0, $v0, $s6
	subi $v0, $v0, 48
	addi $t0, $t0, 1
	j pass_negative_kernel_tackle
end_integral_kernel:	
	addi $t0, $t0, 1
	lb $v1, 0($t0)
	subi $v1, $v1, 48


	li $t1, 10####t1 hien la 10
	mul $v0, $v0, $t1          # v0 = v0 * 10
    	add $v0, $v0, $v1         # v0 = v0 + v1 
    	
    	mtc1 $v0, $f0 
    	cvt.s.w $f0, $f0
    	
    	mtc1 $t1, $f1
    	cvt.s.w $f1,$f1
    	div.s $f0, $f0, $f1##bo t1
    	
	beq $s0, $0, implement_neg_kernel
    	j end_implement_neg_kernel
implement_neg_kernel:
	neg.s $f0, $f0
end_implement_neg_kernel:
    	
    	s.s $f0, 0($a1) ####a1: image
    	addi $a1, $a1, 4
    	
    	addi $t0, $t0, 1
    	lb $t1, 0($t0)
    	li $t3, 32
    	beq $t1, $t3, loop_kernel
	
################################### lay du lieu xong   	
   	
    	lw $t0, N                
    	lw $t1, p                
    	add $t0, $t0, $t1         # t0 = N + p
    	add $t0, $t0, $t1         # t2 = N + 2 * p
    	mul $t0, $t0, $t0
    
    	la $t7, flt_0
    	lwc1 $f0, 0($t7)  # $f0 = 0.0
    # Initialize padded_image to zeros
    	la $a3, padded_image
    	#li $t4, 900               # Maximum size for padded_image (15x15)
init_padded:
    	beq $t0, 0, init_padded_end
    	
    	la $t7, flt_0
    	lwc1 $f0, 0($t7)  # $f0 = 0.0
    	
    	swc1 $f0, 0($a3)          # Store zero in padded_image
    	
    	
    	addi $a3, $a3, 4
    	subi $t0, $t0, 1
    	j init_padded
init_padded_end:




######### finish setup padded to 0.0
	lw $t0, N                 # Load N
    	lw $t1, p                 # Load padding value
    	add $t0, $t0, $t1         # t0 = N + p
    	add $t0, $t0, $t1         # t0 = N + 2 * p
	
	la $a3, padded_image
	
passing_0:
	beq $t1, $0, end_passing
	add $t3, $t0, $0
in_loop_0:	
	addi $a3, $a3, 4
	subi $t3, $t3, 1
	bne $t3, $0, in_loop_0
	

	subi $t1, $t1, 1
	j passing_0
end_passing:


#### 
	la $a2, image
	lw $t6, N
	mul $t6, $t6, $t6
insert_mem:
	beq $t6, $0, end_insert 
	lw $t3, p
	begin_0:
		beq $t3, $0, ebegin_0
		addi $a3, $a3, 4
		subi $t3, $t3, 1
		j begin_0
	ebegin_0:
	lw $t7, N
	insert:
		lwc1 $f1, 0($a2)     
    		swc1 $f1, 0($a3)
    		addi $a2, $a2, 4
    		addi $a3, $a3, 4
    		subi $t7, $t7, 1
    		subi $t6, $t6, 1
    		bne $t7, $0, insert
    		
    	lw $t3, p
	end_0:
		beq $t3, $0, eend_0
		addi $a3, $a3, 4
		subi $t3, $t3, 1
		j end_0
	eend_0:
	j insert_mem

end_insert:
	
##################################################

    	la $t0, padded_image  
    	la $t1, kernel  
    	lw $t2, s  
    	lw $t3, N
    	lw $t4, p
    	add $t3, $t3, $t4
    	add $t3, $t3, $t4
    	add $t4, $0, $t3 ### N+2p----> dung de chay kernel
    
    
    	lw $t5, M  
    	la $t7, out 
    	sub $t3, $t3, $t5 #### n+ 2p - s----> gioi han
    	addi $t3, $t3, 1
  
    	li $t8, 0  # y 
    	li $t9, 0  # x 

outer_loop:
    	bge $t8, $t3, done  

inner_loop:
    	bge $t9, $t3, next_row

    	la $a0, flt_0
    	lwc1 $f0, 0($a0)
    	li $s2, 0  
    	li $s3, 0  
    kernel_loop:
        bge $s2, $t5, store_result
        li $s3, 0

    kernel_inner_loop:
        bge $s3, $t5, next_kernel_row
	add $s6, $t8, $s2
	mul $s6, $s6, $t4
	add $s6, $s6, $t9
	add $s6, $s6, $s3
	sll $s6, $s6, 2
	add $s4, $t0, $s6####pos img
	
	mul $s7, $s2, $t5
	add $s7, $s7, $s3 
	sll $s7, $s7, 2
	add $s5, $t1, $s7### pos kernel
	
	lwc1 $f1, 0($s4)
	lwc1 $f2, 0($s5)
	mul.s $f3, $f1, $f2
	add.s $f0, $f0, $f3
	
        addi $s3, $s3, 1  # increase j of kernel
        j kernel_inner_loop 

    next_kernel_row:
        addi $s2, $s2, 1 
        j kernel_loop 

store_result:
    	swc1 $f0, 0($t7)  
    	addi $t7, $t7, 4 

    	add $t9, $t9, $t2  # increase x by stride
    	j inner_loop  

next_row:
    	add $t8, $t8, $t2  # increase y by stride
    	li $t9, 0
    	j outer_loop 

done:
	
	

	#### (n+2p-m)/s  + 1
	la $t0, out
	
	lw $t1, N
	lw $t2, M
	sub $t1, $t1, $t2
	lw $t2, p
	add $t1, $t1, $t2
	add $t1, $t1, $t2
	lw $t2, s
	div $t1, $t2
	mflo $t1
	addi $t1, $t1, 1
	mul $t1, $t1, $t1
approximate:
	beq $t1, $0, out_approximate
	lwc1 $f17, 0($t0)
	
	# |f17| < 0.05
	abs.s $f2, $f17
	la $a0, flt_005       
    	lwc1 $f3, 0($a0)
    	c.lt.s $f2, $f3           
    	bc1t set_to_zero 
	
	la $a0, flt_10
    	lwc1 $f1, 0($a0) 
	mul.s $f2, $f2, $f1
	
    	trunc.w.s $f3, $f2         
    	cvt.s.w $f3, $f3          
    	sub.s $f4, $f2, $f3
    # floating point check
    	la $a0, flt_half
    	lwc1 $f5, 0($a0)
    	c.lt.s $f4, $f5           
    	bc1f round_up             
    	j apply_sign               

round_up:
	la $a0, flt_1
    	lwc1 $f1, 0($a0) 
    	add.s $f3, $f3, $f1       

apply_sign:
    	la $a0, flt_1
    	lwc1 $f5, 0($a0)
    	c.le.s $f17, $f5       
    	bc1f positive_result     
    	neg.s $f3, $f3

positive_result:
	la $a0, flt_0000001  
    	lwc1 $f4, 0($a0)
    	add.s $f3, $f3, $f4
 	
    	la $a0, flt_10
    	lwc1 $f31, 0($a0)         
    	div.s $f17, $f3, $f31      # $f0 = $f3 / 10.0
    	
    	
    	la $a0, flt_0
	lwc1 $f5, 0($a0)
	c.eq.s $f17, $f5
	bc1t set_to_zero
    	
    	swc1 $f17, 0($t0)
	j continue_approx
	
set_to_zero:
	la $a0, flt_0
    	lwc1 $f5, 0($a0)
    	mov.s $f17, $f5  
    	abs.s $f17, $f17 
    	swc1 $f17, 0($t0)  
continue_approx:
	addi $t0, $t0, 4
	subi $t1, $t1, 1
	j approximate
out_approximate:





	lw $t1, N
	lw $t2, M
	sub $t1, $t1, $t2
	lw $t2, p
	add $t1, $t1, $t2
	add $t1, $t1, $t2
	lw $t2, s
	div $t1, $t2
	mflo $t1
	addi $t1, $t1, 1
	mul $t1, $t1, $t1
	la $s0, buffer
    	li $t2, 0  # t2 for array
    	li $t3, 0  # t3 for buffer
    	li $s2, 0  # s2 for col
    	la $s1, out

buffer_loop:
    	beq $t2, $t1, end_buffer_loop
    	l.s $f0, 0($s1)  
    	
    	abs.s $f2, $f0       
    	la $a0, flt_005
    	lwc1 $f6, 0($a0)
    	c.lt.s $f2, $f6       
    	bc1t set_zero_buffer
    	trunc.w.s $f1, $f0  
    	mfc1 $t4, $f1

    	li $t5, 10
    	li $t6, 0
    	move $t9, $t4
    	blt $0, $t4, buffer_integer
    	li $t7, 45  
    	sb $t7, 0($s0)
    	addi $s0, $s0, 1
    	neg.s $f0, $f0
    	sub $t4, $0, $t4
    	sub $t9, $0, $t9
	
buffer_integer:  #### stack de xu ly doan lay cac so nguyen
	div $t4, $t5
    	mfhi $t7  
    	addi $sp, $sp, -1
    	addi $t7, $t7, 48  
    	sb $t7, 0($sp)  
    	addi $t6, $t6, 1
    	mflo $t4  
    	beq $t4, $0, convert_int_to_str
    	j buffer_integer

convert_int_to_str:
    	beq $t6, $0, add_dot 
    	lb $t7, 0($sp) 
    	sb $t7, 0($s0)
    	addi $s0, $s0, 1
    	addi $sp, $sp, 1
    	addi $t6, $t6, -1
    	j convert_int_to_str
	
add_dot:##### them dau cham va them phan thap phan va tiep tuc vong lap
    	li $t8, 46
    	sb $t8, 0($s0)
    	addi $s0, $s0, 1
    	li $t8, 10
   	mul $t9, $t8, $t9
    	mtc1 $t8, $f8
    	cvt.s.w $f8, $f8
    	mul.s $f0, $f0, $f8
    	trunc.w.s $f0, $f0
    	mfc1 $t5, $f0
    	sub $t5, $t5, $t9
    	addi $t5, $t5, 48
    	sb $t5, 0($s0)

	addi $t2, $t2, 1
    	addi $s0, $s0, 1
    	addi $s1, $s1, 4  
    	addi $s2, $s2, 1
    	li $t8, 32 
    	sb $t8, 0($s0)
    	addi $s0, $s0, 1
    	j buffer_loop
    	
set_zero_buffer:
    	li $t5, 48  # '0'
    	sb $t5, 0($s0)
    	addi $s0, $s0, 1
    	li $t5, 46  # '.'
    	sb $t5, 0($s0)
    	addi $s0, $s0, 1
    	li $t5, 48  # '0'
    	sb $t5, 0($s0)
    	addi $s0, $s0, 1
    	li $t8, 32  
    	sb $t8, 0($s0)
    	addi $t2, $t2, 1  
    	addi $s1, $s1, 4 
    	addi $s0, $s0, 1
    	j buffer_loop  

end_buffer_loop:
    	sb $0, 0($s0)
    	la $s1, buffer
    	sub $s2, $s0, $s1

    	li $v0, 13
    	la $a0, filename_out
    	li $a1, 1
    	li $a2, 0
    	syscall

    	add $t0, $v0, $0
    	li $v0, 15
    	add $a0, $t0, $0
    	la $a1, buffer
    	move $a2, $s2
    	syscall

    	li $v0, 16
    	add $a0, $t0, $0
    	syscall
	
	j ending
	

errorsize:
	li $v0, 13
    	la $a0, filename_out
    	li $a1, 1 
    	li $a2, 0
   	syscall	
   	move $t0, $v0

    # write buffer to file
    	li $v0, 15                  
    	move $a0, $t0                
    	la $a1, error_announce    
    	li $a2, 21                  
    	syscall
	
    # close file
    	li $v0, 16                  
    	move $a0, $t0                
    	syscall

	 
ending:
    # Clean up and end the program
    	li $v0, 10                # Exit syscall
    	syscall