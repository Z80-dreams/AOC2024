//AOC2402A JOB (EGEN),'AOC2402A',CLASS=A,MSGCLASS=Q,                            
//     NOTIFY=&SYSUID,MSGLEVEL=(1,1),REGION=0M                                  
//*---------------------------------------------------------------------        
//* PARSE THE LIST SO THAT EACH 'REPORT' APPEAR IN A FIXED COLUMN.              
//*---------------------------------------------------------------------        
//PARSE    EXEC PGM=SORT                                                        
//SORTOUT  DD DSN=&&PARSED,                                                     
//         DISP=(,PASS,DELETE),DATACLAS=PXL                                     
//SORTIN   DD DSN=USERID.AOC24INP(DAY02),DISP=SHR                               
//SYSOUT   DD SYSOUT=*                                                          
//SYSIN    DD *                                                                 
  OPTION COPY                                                                   
  INREC  PARSE=(%1=(ENDBEFR=BLANKS,FIXLEN=3),                                   
                %2=(ENDBEFR=BLANKS,FIXLEN=3),                                   
                %3=(ENDBEFR=BLANKS,FIXLEN=3),                                   
                %4=(ENDBEFR=BLANKS,FIXLEN=3),                                   
                %5=(ENDBEFR=BLANKS,FIXLEN=3),                                   
                %6=(ENDBEFR=BLANKS,FIXLEN=3),                                   
                %7=(ENDBEFR=BLANKS,FIXLEN=3),                                   
                %8=(ENDBEFR=BLANKS,FIXLEN=3)),                                  
         BUILD=(1:%1,UFF,TO=ZD,LENGTH=2,                                        
                4:%2,UFF,TO=ZD,LENGTH=2,                                        
                7:%3,UFF,TO=ZD,LENGTH=2,                                        
               10:%4,UFF,TO=ZD,LENGTH=2,                                        
               13:%5,UFF,TO=ZD,LENGTH=2,                                        
               16:%6,UFF,TO=ZD,LENGTH=2,                                        
               19:%7,UFF,TO=ZD,LENGTH=2,                                        
               22:%8,UFF,TO=ZD,LENGTH=2)                                        
/*                                                                              
//*---------------------------------------------------------------------        
//* SPLIT OUT ALL STRICTLY INCREASING OR STRICLY DECRASING.                     
//* CALCULATE THE DIFFERANCE BETWEEN EACH REPORT.                               
//*---------------------------------------------------------------------        
//SPLIT    EXEC PGM=ICETOOL                                                     
//TOOLMSG  DD SYSOUT=*                                                          
//DFSMSG   DD SYSOUT=*                                                          
//IN       DD DSN=&&PARSED,DISP=(SHR,PASS)                                      
//OUTINC   DD DSN=&&INCR,                                                       
//         DISP=(,PASS,DELETE),DATACLAS=PXL                                     
//OUTDEC   DD DSN=&&DECR,                                                       
//         DISP=(,PASS,DELETE),DATACLAS=PXL                                     
//TOOLIN   DD *                                                                 
  COPY FROM(IN) TO(OUTINC) USING(INCR)                                          
  COPY FROM(IN) TO(OUTDEC) USING(DECR)                                          
/*                                                                              
//INCRCNTL DD *                                                                 
  INCLUDE COND=(1,2,ZD,LT,4,2,ZD,AND,                                           
                4,2,ZD,LT,7,2,ZD,AND,                                           
                7,2,ZD,LT,10,2,ZD,AND,                                          
               10,2,ZD,LT,13,2,ZD,AND,                                          
              (13,2,ZD,LT,16,2,ZD,OR,16,2,CH,EQ,C'00'),AND,                     
              (16,2,ZD,LT,19,2,ZD,OR,19,2,CH,EQ,C'00'),AND,                     
              (19,2,ZD,LT,22,2,ZD,OR,22,2,CH,EQ,C'00'))                         
  OUTREC OVERLAY=(31:(4,2,ZD,SUB,1,2,ZD),TO=ZD,LENGTH=2,                        
                  34:(7,2,ZD,SUB,4,2,ZD),TO=ZD,LENGTH=2,                        
                  37:(10,2,ZD,SUB,7,2,ZD),TO=ZD,LENGTH=2,                       
                  40:(13,2,ZD,SUB,10,2,ZD),TO=ZD,LENGTH=2,                      
                  43:(16,2,ZD,SUB,13,2,ZD),TO=ZD,LENGTH=2,                      
                  46:(19,2,ZD,SUB,16,2,ZD),TO=ZD,LENGTH=2,                      
                  49:(22,2,ZD,SUB,19,2,ZD),TO=ZD,LENGTH=2)                      
/*                                                                              
//DECRCNTL DD *                                                                 
  INCLUDE COND=(1,2,ZD,GT,4,2,ZD,AND,                                           
                4,2,ZD,GT,7,2,ZD,AND,                                           
                7,2,ZD,GT,10,2,ZD,AND,                                          
               10,2,ZD,GT,13,2,ZD,AND,                                          
              (13,2,ZD,GT,16,2,ZD,OR,16,2,CH,EQ,C'00'),AND,                     
              (16,2,ZD,GT,19,2,ZD,OR,19,2,CH,EQ,C'00'),AND,                     
              (19,2,ZD,GT,22,2,ZD,OR,22,2,CH,EQ,C'00'))                         
  OUTREC OVERLAY=(31:(1,2,ZD,SUB,4,2,ZD),TO=ZD,LENGTH=2,                        
                  34:(4,2,ZD,SUB,7,2,ZD),TO=ZD,LENGTH=2,                        
                  37:(7,2,ZD,SUB,10,2,ZD),TO=ZD,LENGTH=2,                       
                  40:(10,2,ZD,SUB,13,2,ZD),TO=ZD,LENGTH=2,                      
                  43:(13,2,ZD,SUB,16,2,ZD),TO=ZD,LENGTH=2,                      
                  46:(16,2,ZD,SUB,19,2,ZD),TO=ZD,LENGTH=2,                      
                  49:(19,2,ZD,SUB,22,2,ZD),TO=ZD,LENGTH=2)                      
/*                                                                              
//*---------------------------------------------------------------------        
//* INCLUDE ONLY THOSE WHERE THE DIFFERANCE IS > 0 AND < 4.                     
//* COUNT THE NUMBER OF RECORDS.                                                
//*---------------------------------------------------------------------        
//COUNT    EXEC PGM=SORT                                                        
//SORTOUT  DD SYSOUT=*                                                          
//SORTIN   DD DSN=&&INCR,DISP=(SHR,PASS)                                        
//         DD DSN=&&DECR,DISP=(SHR,PASS)                                        
//SYSOUT   DD SYSOUT=*                                                          
//SYSIN    DD *                                                                 
  OPTION COPY                                                                   
  INCLUDE COND=(31,2,CH,GT,C'00',AND,31,2,CH,LT,C'04',AND,                      
                34,2,CH,GT,C'00',AND,34,2,CH,LT,C'04',AND,                      
                37,2,CH,GT,C'00',AND,37,2,CH,LT,C'04',AND,                      
                40,2,CH,GT,C'00',AND,40,2,CH,LT,C'04',AND,                      
              ((43,2,CH,GT,C'00',AND,43,2,CH,LT,C'04'),OR,                      
                (16,2,CH,EQ,C'00')),AND,                                        
              ((46,2,CH,GT,C'00',AND,46,2,CH,LT,C'04'),OR,                      
                (19,2,CH,EQ,C'00')),AND,                                        
              ((49,2,CH,GT,C'00',AND,49,2,CH,LT,C'04'),OR,                      
                (22,2,CH,EQ,C'00')))                                            
                                                                                
 OUTFIL REMOVECC,                                                               
        TRAILER1=(C'Total: ',COUNT=(LENGTH=4)),                                 
        OUTREC=(1,24,80:X)                                                      
/*                                                                              
