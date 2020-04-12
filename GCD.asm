TITLE find GCD
INCLUDE Irvine32.inc
;this program help to find GCD

.data
num1 dword ?
num2 dword ?
gcd dword ?
temp dword ?
k dword ?

Mess1 byte "Enter first number: ",0dh,0ah,0          ;input message
Mess2 byte "Enter second number:  ",0dh,0ah,0        
Mess3 byte "Your greatest GCD is: ",0				
Mess4 byte "  ",0

.code
main proc  

lea edx,Mess1
call writestring       ;tell user to input number
call readdec           ;input number
mov num1,eax           ;save number into x

lea edx,mess2
call writestring
call readdec

mov num2,eax

cmp num1,eax
jb swap                ;if num1 is less than num2,swap position
jnb noswap


swap:
mov ebx,num1
mov num1,eax
mov num2,ebx

noswap:
mov eax,num1            ;if no swap






mov eax,num1  
mov edx,0             ;init the division
mov ebx,2			  ;divided by two to find maximum looping cycle
div ebx				  ;division
mov k,eax			  ;save k for loop purpose


mov ecx,k
target:                ;start the loop
	

	mov ebx,k        ;division
	mov eax,num1
	mov edx,0
	div ebx          ;ebx == k  12/6=2   6==ebx
					 ;to find all the factorial number, factorial number saved in ebx
	lea edx,Mess4
	call writestring
	cmp edx,0          
	je testIfWorksForSecondNum              ;if second number can be divided by ebx, return the value
	   

	testIfWorksForSecondNum:
	mov edx,0
	mov ebx,num2
	div ebx                              
	cmp edx,0
	je findGCD




	findGCD:
		lea edx,Mess3          
		call writestring
		mov gcd,ebx
		mov eax,gcd
		call writedec  ;print out the gcd
		exit           ;once found gcd, exit the loop


	
loop target         ;loop is over



	invoke exitprocess,0
main ENDP

END main