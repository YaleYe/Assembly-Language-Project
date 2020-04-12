TITLE VacationPackage
INCLUDE Irvine32.inc
;this program help to calculate cost of four vacation package for thrill-seeking customers
;will apply discount if number of people are more than five, cost differented by the differernt selection

.data
choice dword ?
peopleNum dword ?
rentalTime dword ?
instruction dword ?
day dword ?
singleCost dword 0
totalCost dword 0
temp dword ?
deposit dword ?
ten dword 10
sixty dword 60
hundred dword 100
EightFiveO dword 850
TwoFiveOO dword 2500
SixOO dword 600
EightFive dword 85
OneFourO dword 140
Four dword 4
OneOFiveO dword 1050
Eighty dword 80

Mess1 byte "Enter your package selection: ",0dh,0ah,0          ;input message
Mess2 byte "Enter 1 for climbing, Enter 2 for Scuba, Enter 3 for skydive, Enter 4 for Spelunk :",0dh,0ah,0      
Mess3 byte "Your choice is unavaliable, exit now",0dh,0ah,0
days byte "Enter how many days you want to stay : ",0dh,0ah,0
total byte "Your total cost is :",0
depositDue byte "You have to put done a deposit of :",0
people byte "How many people in your group?",0dh,0ah,0



climbInstruction byte "Do you want add climb instruction? Enter 1 for yes, others for no",0dh,0ah,0
climbEquiement byte "How many days you want to rent equipment ?",0dh,0ah,0


scubeInstructionMessage byte "Do you want to add Scuba Instruction? Enter 1 for yes, others for no",0dh,0ah,0

skydiveLodgeMessage byte "Enter 1 if you want to lodge at Wilderness Lodge, others for Luxcury Inn  : ",0dh,0ah,0

spelunkRentalMessage byte "Enter how many days you want to rental equiement:",0dh,0ah,0

Mess4 byte "  ",0

.code
main proc  

lea edx,Mess1       ;output message
call writestring    ;output

lea edx,Mess2       ;output message
call writestring    ;output

call readdec        ;option
mov choice,eax      ;store infomation into choice

cmp eax,1           ;compare choice to 1
je climb            ;if choice is 1, calculate total cost of climb using climb proc
jne f2              ;if selection is not 1 ,try 2

f2:                 ;f2 function
cmp eax,2           ;compare choice to 2
je scube            ;if choice is 2, calculate total cost of scube using scube proc
jne f3              ;if choice is not 2, try 3

f3:                 ;f3 function
cmp eax,3           ;compare choice to 3
je skydive          ;if choice is 3, calculate total cost of skydive using skydive proc
jne f4              ;if choice is not 3, try 4

f4:                ;f4 function
cmp eax,4          ;compare choice to 4
je spelunk         ;if choice is 4, calculate total cost of spelunk using spelunk proc
jne f5             ;if choice is not 1,2,3,4

f5:                ;f5 fucntion
lea edx,Mess3      ;store message into edx
call writestring   ;output message of wrong input
exit               ;exit the program





	invoke exitprocess,0
main ENDP

climb proc                    ;start climb calculation program
lea edx,climbEquiement        ;ask for Equipment rental time
call writestring              ;output message
call readdec                  ;input number of days
mov rentalTime,eax            ;move data into rentalTime
mov eax,rentalTime            ;add into cost if they need to rent equipment
mul sixty                     ;multiply how many days to rent
add singleCost,eax            ;add into singlecost( Equiement Part done)
lea edx,climbInstruction      ;ask for adding instruction into package
call writestring              ;output message
call readdec                  ;input if people need to add instruction 
cmp eax,1                     ;compare
je f1                         ;if add
jne f2                        ;if not add
f1:                           ;f1 for add
mov eax,singleCost            ;mov into eax for addition
add eax,hundred               ;add 100
mov singleCost,eax            ;move back to singleCost
jmp f2                        ;jmp into f2 functon (Instruction Part done)

f2:
lea edx,people                ;message 
call writestring              ;input num of people
mov eax,0                     ;init eax
call readdec                  ;enter how many people in the group
mov peopleNum,eax             ;move people number into eax
cmp eax,4                     ;compare for discount avalibility
jg costForLargeGroup          ;if discount applies
jng totalCostForClimbing      ;if discount not apply

costForLargeGroup:            ;discount function
mov eax,singleCost            ;move singlecost into eax
sub eax,ten                   ;substract 10
mov singleCost,eax            ;stored into singlecost
jmp totalCostForClimbing      ;jump into next function

totalCostForClimbing:         ;calculate cost
mov eax,singleCost            ;move singlecost into eax
add eax,EightFiveO            ;add singlecost 850
mov singleCost,eax            ;store back into singlecost
mov eax,peopleNum             ;mov peoplenum into eax for multiplication
mul singleCost                ;multiplication
mov totalCost,eax             ;store total cost into totalcost
lea edx,total                 ;output message of total cost
call writestring              ;output
call writedec                 ;output number of cost
call crlf                     ;empty line
lea edx,depositDue            ;output message of deposit message
call writestring              ;output
mov ebx,2                     ;division
mov edx,0                     ;init edx
div ebx                       ;division
call writedec                 ;output message of deposit amount
exit                          ;exit
climb  endp                   ;end of program

scube proc                    ;start of scube program
lea edx,scubeInstructionMessage;output message
call writestring              ;output
call readdec                  ;tell user to select Instruction
cmp eax,1                     ;to decide add extra fee or not
je InstructionForScube        ;add instruction fee
jne totalCostForScube         ;not add instruction, jump to calculate single person cost
InstructionForScube:
mov eax,singleCost            ;mov into eax for addition
add eax,hundred               ;add 100
mov singleCost,eax            ;move back to singleCost
jmp singleCostForScube        ;jmp into singleCostForScube functon (Instruction Part done)

singleCostForScube:
lea edx,people                ;message 
call writestring              ;input num of people
mov eax,0                     ;init eax
call readdec                  ;enter how many people in the group
mov peopleNum,eax             ;move people number into eax
cmp eax,4                     ;compare for discount avalibility
jg costForLargeGroup          ;if discount applies
jng totalCostForScube         ;if discount not apply

costForLargeGroup:            ;discount function
mov eax,singleCost            ;move singlecost into eax
sub eax,ten                   ;substract 10
mov singleCost,eax            ;stored into singlecost
jmp totalCostForScube         ;jump into next function

totalCostForScube:
mov eax,singleCost            ;move singlecost into eax
add eax,TwoFiveOO             ;add singlecost 2500
mov singleCost,eax            ;store back into singlecost
mov eax,peopleNum             ;mov peoplenum into eax for multiplication
mul singleCost                ;multiplication
mov totalCost,eax             ;store total cost into totalcost
lea edx,total                 ;output message of total cost
call writestring              ;output
call writedec                 ;output number of cost
call crlf                     ;empty line
lea edx,depositDue            ;output message of deposit message
call writestring              ;output
mov ebx,2                     ;division
mov edx,0                     ;init edx
div ebx                       ;division
call writedec                 ;output message of deposit amount
exit                          ;exit
scube endp                    ;end of program

skydive proc                  ;start of skydive program
lea edx,skydiveLodgeMessage   ;output question
call writestring              ;output
call readdec                  ;tell user to input number
cmp eax,1                     ;decide what hotel going to stay
je singleCostForWildnessLodge ;stay in wildnesslodge
jne singleCostForLuxturyInn   ;stay in luctury inn

singleCostForWildnessLodge:   ;calculate single cost living in Wildness Lodge
mov eax,singleCost            ;mov singlecost into eax
add eax,EightFive             ;add 85 into singlecost
mul Four                      ;total of four days
mov singleCost,eax            ;move single cost into eax
jmp SingleCostForSkyDive      ;jmp into singlecostTotal 

singleCostForLuxturyInn:      ;calculate single cost living in luxtury INN
mov eax,singleCost            ;mov singlecost into eax
add eax,OneFourO              ;add 140 into single cost
mul Four                      ;total of 4 days
mov singleCost,eax            ;move living cost into single cost
jmp SingleCostForSkyDive      ;jmp into singlecostTotal

SingleCostForSkyDive:
lea edx,people                ;message 
call writestring              ;input num of people
mov eax,0                     ;init eax
call readdec                  ;enter how many people in the group
mov peopleNum,eax             ;move people number into eax
cmp eax,4                     ;compare for discount avalibility
jg costForLargeGroup          ;if discount applies
jng totalCostForSkyDive       ;if discount not apply

costForLargeGroup:            ;discount function
mov eax,singleCost            ;move singlecost into eax
sub eax,ten                   ;substract 10
mov singleCost,eax            ;stored into singlecost
jmp totalCostForSkyDive       ;jump into next function

totalCostForSkyDive:
mov eax,singleCost            ;move singlecost into eax
add eax,SixOO                 ;add singlecost 600
mov singleCost,eax            ;store back into singlecost
mov eax,peopleNum             ;mov people num into eax for multiplication
mul singleCost                ;multiplication
mov totalCost,eax             ;store total cost into totalcost
lea edx,total                 ;output message of total cost
call writestring              ;output
call writedec                 ;output number of cost
call crlf
lea edx,depositDue            ;output message of deposit message
call writestring              ;output
mov ebx,2                     ;division
mov edx,0                     ;init edx
div ebx                       ;division
call writedec                 ;output message of deposit amount
exit                          ;exit
skydive endp                  ;end of skydive program

spelunk proc                  ;start of program
lea edx,spelunkRentalMessage  ;output question
call writestring              ;ouput
call readdec                  ;user input number of renting
mul Eighty                    ;multiply by 80
mov singleCost,eax            ;store data into singleCost
lea edx,people                ;message 
call writestring              ;input num of people
mov eax,0                     ;init eax
call readdec                  ;enter how many people in the group
mov peopleNum,eax             ;move people number into eax
cmp eax,4                     ;compare for discount avalibility
jg costForLargeGroup          ;if discount applies
jng totalCostForBarronCliff   ;if discount not apply

costForLargeGroup:            ;discount function
mov eax,singleCost            ;move singlecost into eax
sub eax,ten                   ;substract 10
mov singleCost,eax            ;stored into singlecost
jmp totalCostForBarronCliff   ;jump into next function

totalCostForBarronCliff:
mov eax,singleCost            ;move singlecost into eax
add eax,OneOFiveO             ;add singlecost 1050
mov singleCost,eax            ;store back into singlecost
mov eax,peopleNum             ;mov people num into eax for multiplication
mul singleCost                ;multiplication
mov totalCost,eax             ;store total cost into totalcost
lea edx,total                 ;output message of total cost
call writestring              ;output
call writedec                 ;output number of cost
call crlf                     ;empty line
lea edx,depositDue            ;output message of deposit message
call writestring              ;output
mov ebx,2                     ;division
mov edx,0                     ;init edx
div ebx                       ;division
call writedec                 ;output message of deposit amount
exit                          ;exit
spelunk endp                  ;end of spelunk program

END main
