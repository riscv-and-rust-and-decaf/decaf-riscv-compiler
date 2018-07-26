          .text                         
          .globl main                   

          .data                         
          .align 2                      
_Main:                                  # virtual table
          .word 0                       # parent
          .word _STRING0                # class name



          .section .text                
# intrinsic library
_PrintInt:                              
          lw    a0, 4(sp)               
          tail  _wrjlibc__PrintInt      
          jr    ra                      
_PrintString:                           
          lw    a0, 4(sp)               
          tail  _wrjlibc__PrintString   
          jr    ra                      
_PrintBool:                             
          lw    a0, 4(sp)               
          tail  _wrjlibc__PrintBool     
          jr    ra                      
_Alloc:                                 
          lw    a0, 4(sp)               
          tail  _wrjlibc__Alloc         
          jr    ra                      
_Halt:                                  
          tail  _wrjlibc__Halt          
          jr    ra                      
_Main_New:                              # function entry
# prolog
          sw s0, 0(sp)                  
          sw ra, -4(sp)                 
          move s0, sp                   
          addi sp, sp, -16              
# end prolog
_L32:                                   
          li    s2, 4                   
          sw    s2, 4(sp)               
          call  _Alloc                  
          move  s2, a0                  
          la    s3, _Main               
          sw    s3, 0(s2)               
          mv    a0, s2                  
          move  sp, s0                  
          lw    ra, -4(s0)              
          lw    s0, 0(s0)               
          jr    ra                      

main:                                   # function entry
# prolog
          sw s0, 0(sp)                  
          sw ra, -4(sp)                 
          move s0, sp                   
          addi sp, sp, -92              
# end prolog
_L33:                                   
          la    s2, _STRING1            
          sw    s2, 4(sp)               
          call  _PrintString            
          li    s2, 5                   
          sw    s2, 4(sp)               
          call  _PrintInt               
          li    s2, 1                   
          neg   s3, s2                  
          sw    s3, 4(sp)               
          call  _PrintInt               
          li    s2, 0                   
          sw    s2, 4(sp)               
          call  _PrintInt               
          li    s2, 1                   
          sw    s2, 4(sp)               
          call  _PrintBool              
          li    s2, 0                   
          sw    s2, 4(sp)               
          call  _PrintBool              
          li    s2, 2                   
          li    s3, 0                   
          slt   s4, s2, s3              
          sw    s2, -8(s0)              
          beqz  s4, _L35                
_L34:                                   
          la    s2, _STRING2            
          sw    s2, 4(sp)               
          call  _PrintString            
          call  _Halt                   
_L35:                                   
          li    s2, 4                   
          lw    s3, -8(s0)              
          mul   s4, s2, s3              
          add   s5, s2, s4              
          sw    s5, 4(sp)               
          sw    s5, -12(s0)             
          sw    s3, -8(s0)              
          sw    s2, -16(s0)             
          call  _Alloc                  
          move  s4, a0                  
          lw    s5, -12(s0)             
          lw    s3, -8(s0)              
          lw    s2, -16(s0)             
          sw    s3, 0(s4)               
          li    s3, 0                   
          add   s4, s4, s5              
          sw    s5, -12(s0)             
          sw    s4, -20(s0)             
          sw    s3, -24(s0)             
          sw    s2, -16(s0)             
_L36:                                   
          lw    s2, -12(s0)             
          lw    s3, -16(s0)             
          sub   s2, s2, s3              
          sw    s2, -12(s0)             
          sw    s3, -16(s0)             
          beqz  s2, _L38                
_L37:                                   
          lw    s2, -20(s0)             
          lw    s3, -16(s0)             
          sub   s2, s2, s3              
          lw    s4, -24(s0)             
          sw    s4, 0(s2)               
          sw    s2, -20(s0)             
          sw    s4, -24(s0)             
          sw    s3, -16(s0)             
          j     _L36                    
_L38:                                   
          lw    s2, -20(s0)             
          mv    s3, s2                  
          li    s2, 0                   
          lw    s4, -4(s3)              
          slt   s5, s2, s4              
          sw    s2, -32(s0)             
          sw    s3, -28(s0)             
          beqz  s5, _L40                
_L39:                                   
          li    s2, 0                   
          lw    s3, -32(s0)             
          slt   s4, s3, s2              
          sw    s3, -32(s0)             
          beqz  s4, _L41                
_L40:                                   
          la    s2, _STRING3            
          sw    s2, 4(sp)               
          call  _PrintString            
          call  _Halt                   
_L41:                                   
          li    s2, 4                   
          lw    s3, -32(s0)             
          mul   s4, s3, s2              
          lw    s2, -28(s0)             
          add   s5, s2, s4              
          lw    s4, 0(s5)               
          li    s4, 15                  
          li    s5, 4                   
          mul   s6, s3, s5              
          add   s3, s2, s6              
          sw    s4, 0(s3)               
          li    s3, 1                   
          lw    s4, -4(s2)              
          slt   s5, s3, s4              
          sw    s3, -36(s0)             
          sw    s2, -28(s0)             
          beqz  s5, _L43                
_L42:                                   
          li    s2, 0                   
          lw    s3, -36(s0)             
          slt   s4, s3, s2              
          sw    s3, -36(s0)             
          beqz  s4, _L44                
_L43:                                   
          la    s2, _STRING3            
          sw    s2, 4(sp)               
          call  _PrintString            
          call  _Halt                   
_L44:                                   
          li    s2, 4                   
          lw    s3, -36(s0)             
          mul   s4, s3, s2              
          lw    s2, -28(s0)             
          add   s5, s2, s4              
          lw    s4, 0(s5)               
          li    s4, 37                  
          li    s5, 4                   
          mul   s6, s3, s5              
          add   s3, s2, s6              
          sw    s4, 0(s3)               
          li    s3, 0                   
          lw    s4, -4(s2)              
          slt   s5, s3, s4              
          sw    s3, -40(s0)             
          sw    s2, -28(s0)             
          beqz  s5, _L46                
_L45:                                   
          li    s2, 0                   
          lw    s3, -40(s0)             
          slt   s4, s3, s2              
          sw    s3, -40(s0)             
          beqz  s4, _L47                
_L46:                                   
          la    s2, _STRING3            
          sw    s2, 4(sp)               
          call  _PrintString            
          call  _Halt                   
_L47:                                   
          li    s2, 4                   
          lw    s3, -40(s0)             
          mul   s4, s3, s2              
          lw    s2, -28(s0)             
          add   s3, s2, s4              
          lw    s4, 0(s3)               
          sw    s4, 4(sp)               
          sw    s2, -28(s0)             
          call  _PrintInt               
          lw    s2, -28(s0)             
          li    s3, 1                   
          lw    s4, -4(s2)              
          slt   s5, s3, s4              
          sw    s2, -28(s0)             
          sw    s3, -44(s0)             
          beqz  s5, _L49                
_L48:                                   
          li    s2, 0                   
          lw    s3, -44(s0)             
          slt   s4, s3, s2              
          sw    s3, -44(s0)             
          beqz  s4, _L50                
_L49:                                   
          la    s2, _STRING3            
          sw    s2, 4(sp)               
          call  _PrintString            
          call  _Halt                   
_L50:                                   
          li    s2, 4                   
          lw    s3, -44(s0)             
          mul   s4, s3, s2              
          lw    s2, -28(s0)             
          add   s3, s2, s4              
          lw    s2, 0(s3)               
          sw    s2, 4(sp)               
          call  _PrintInt               
          li    s2, 2                   
          li    s3, 0                   
          slt   s4, s2, s3              
          sw    s2, -48(s0)             
          beqz  s4, _L52                
_L51:                                   
          la    s2, _STRING2            
          sw    s2, 4(sp)               
          call  _PrintString            
          call  _Halt                   
_L52:                                   
          li    s2, 4                   
          lw    s3, -48(s0)             
          mul   s4, s2, s3              
          add   s5, s2, s4              
          sw    s5, 4(sp)               
          sw    s3, -48(s0)             
          sw    s2, -52(s0)             
          sw    s5, -56(s0)             
          call  _Alloc                  
          move  s4, a0                  
          lw    s3, -48(s0)             
          lw    s2, -52(s0)             
          lw    s5, -56(s0)             
          sw    s3, 0(s4)               
          li    s3, 0                   
          add   s4, s4, s5              
          sw    s2, -52(s0)             
          sw    s5, -56(s0)             
          sw    s4, -60(s0)             
          sw    s3, -64(s0)             
_L53:                                   
          lw    s2, -56(s0)             
          lw    s3, -52(s0)             
          sub   s2, s2, s3              
          sw    s3, -52(s0)             
          sw    s2, -56(s0)             
          beqz  s2, _L55                
_L54:                                   
          lw    s2, -60(s0)             
          lw    s3, -52(s0)             
          sub   s2, s2, s3              
          lw    s4, -64(s0)             
          sw    s4, 0(s2)               
          sw    s3, -52(s0)             
          sw    s2, -60(s0)             
          sw    s4, -64(s0)             
          j     _L53                    
_L55:                                   
          lw    s2, -60(s0)             
          mv    s3, s2                  
          li    s2, 0                   
          lw    s4, -4(s3)              
          slt   s5, s2, s4              
          sw    s3, -28(s0)             
          sw    s2, -68(s0)             
          beqz  s5, _L57                
_L56:                                   
          li    s2, 0                   
          lw    s3, -68(s0)             
          slt   s4, s3, s2              
          sw    s3, -68(s0)             
          beqz  s4, _L58                
_L57:                                   
          la    s2, _STRING3            
          sw    s2, 4(sp)               
          call  _PrintString            
          call  _Halt                   
_L58:                                   
          li    s2, 4                   
          lw    s3, -68(s0)             
          mul   s4, s3, s2              
          lw    s2, -28(s0)             
          add   s5, s2, s4              
          lw    s4, 0(s5)               
          li    s4, 51                  
          li    s5, 4                   
          mul   s6, s3, s5              
          add   s3, s2, s6              
          sw    s4, 0(s3)               
          li    s3, 1                   
          lw    s4, -4(s2)              
          slt   s5, s3, s4              
          sw    s2, -28(s0)             
          sw    s3, -72(s0)             
          beqz  s5, _L60                
_L59:                                   
          li    s2, 0                   
          lw    s3, -72(s0)             
          slt   s4, s3, s2              
          sw    s3, -72(s0)             
          beqz  s4, _L61                
_L60:                                   
          la    s2, _STRING3            
          sw    s2, 4(sp)               
          call  _PrintString            
          call  _Halt                   
_L61:                                   
          li    s2, 4                   
          lw    s3, -72(s0)             
          mul   s4, s3, s2              
          lw    s2, -28(s0)             
          add   s5, s2, s4              
          lw    s4, 0(s5)               
          li    s4, 73                  
          li    s5, 4                   
          mul   s6, s3, s5              
          add   s3, s2, s6              
          sw    s4, 0(s3)               
          li    s3, 0                   
          lw    s4, -4(s2)              
          slt   s5, s3, s4              
          sw    s3, -76(s0)             
          sw    s2, -28(s0)             
          beqz  s5, _L63                
_L62:                                   
          li    s2, 0                   
          lw    s3, -76(s0)             
          slt   s4, s3, s2              
          sw    s3, -76(s0)             
          beqz  s4, _L64                
_L63:                                   
          la    s2, _STRING3            
          sw    s2, 4(sp)               
          call  _PrintString            
          call  _Halt                   
_L64:                                   
          li    s2, 4                   
          lw    s3, -76(s0)             
          mul   s4, s3, s2              
          lw    s2, -28(s0)             
          add   s3, s2, s4              
          lw    s4, 0(s3)               
          sw    s4, 4(sp)               
          sw    s2, -28(s0)             
          call  _PrintInt               
          lw    s2, -28(s0)             
          li    s3, 1                   
          lw    s4, -4(s2)              
          slt   s5, s3, s4              
          sw    s3, -80(s0)             
          sw    s2, -28(s0)             
          beqz  s5, _L66                
_L65:                                   
          li    s2, 0                   
          lw    s3, -80(s0)             
          slt   s4, s3, s2              
          sw    s3, -80(s0)             
          beqz  s4, _L67                
_L66:                                   
          la    s2, _STRING3            
          sw    s2, 4(sp)               
          call  _PrintString            
          call  _Halt                   
_L67:                                   
          li    s2, 4                   
          lw    s3, -80(s0)             
          mul   s4, s3, s2              
          lw    s2, -28(s0)             
          add   s3, s2, s4              
          lw    s2, 0(s3)               
          sw    s2, 4(sp)               
          call  _PrintInt               
          move  sp, s0                  
          lw    ra, -4(s0)              
          lw    s0, 0(s0)               
          jr    ra                      

# string table
          .section .rodata              
_STRING1:
          .string "Hello World!"        
_STRING2:
          .string "Decaf runtime error: Cannot create negative-sized array\n"
_STRING0:
          .string "Main"                
_STRING3:
          .string "Decaf runtime error: Array subscript out of bounds\n"
# end string table
