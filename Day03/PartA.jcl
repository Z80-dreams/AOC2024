//AOC2403A JOB (EGEN),'AOC2403A',CLASS=A,MSGCLASS=Q,                            
//     NOTIFY=&SYSUID,MSGLEVEL=(1,1),REGION=0M                                  
//*---------------------------------------------------------------------        
//* MAKE ALL CHARACTERS UPPER CASE AND PUT THEM ON SEPARATE RECORDS             
//*---------------------------------------------------------------------        
//LTOU     EXEC PGM=ICETOOL                                                     
//OUT      DD DSN=&&TMP01,                                                      
//         DISP=(,PASS,DELETE),DATACLAS=PXL                                     
//IN       DD DSN=USERID.AOC24INP(DAY03),DISP=SHR                               
//TOOLMSG  DD SYSOUT=*                                                          
//DFSMSG   DD SYSOUT=*                                                          
//TOOLIN   DD *                                                                 
  RESIZE FROM(IN) TO(OUT) TOLEN(1) USING(SRT1)                                  
/*                                                                              
//SRT1CNTL DD *                                                                 
  INREC FIELDS=(1,80,TRAN=LTOU)                                                 
/*                                                                              
//*---------------------------------------------------------------------        
//* ONLY KEEP GROUP THAT BEGINS WITH M AND ENDS WITH )                          
//*---------------------------------------------------------------------        
//GROUPTAG EXEC PGM=SORT                                                        
//SORTOUT  DD DSN=&&TMP02,                                                      
//         DISP=(,PASS,DELETE),DATACLAS=PXL                                     
//SORTIN   DD DSN=&&TMP01,DISP=(SHR,PASS)                                       
//SYSOUT   DD SYSOUT=*                                                          
//SYSIN    DD *                                                                 
  OPTION COPY                                                                   
  INREC IFTHEN=(WHEN=GROUP,                                                     
                BEGIN=(1,1,CH,EQ,C'M'),                                         
                END=(1,1,CH,EQ,C')'),                                           
                PUSH=(3:ID=5,9:SEQ=2))                                          
/*                                                                              
//*---------------------------------------------------------------------        
//* MOVE THE CHARACTERS AROUND SO THAT THEY CAN BE MERGED                       
//*---------------------------------------------------------------------        
//GROUPSHI EXEC PGM=SORT                                                        
//SORTOUT  DD DSN=&&TMP03,                                                      
//         DISP=(,PASS,DELETE),DATACLAS=PXL                                     
//SORTIN   DD DSN=&&TMP02,DISP=(SHR,PASS)                                       
//SYSOUT   DD SYSOUT=*                                                          
//SYSIN    DD *                                                                 
  SORT FIELDS=(1,5,CH,A)                                                        
  OMIT COND=(3,1,CH,EQ,C' ')                                                    
  INREC IFTHEN=(WHEN=(9,2,CH,EQ,C'01'),                                         
                BUILD=(1:3,5,7:X'000000',10:1,1)),                              
        IFTHEN=(WHEN=(9,2,CH,EQ,C'02'),                                         
                BUILD=(1:3,5,12:X'000000',15:1,1)),                             
        IFTHEN=(WHEN=(9,2,CH,EQ,C'03'),                                         
                BUILD=(1:3,5,17:X'000000',20:1,1)),                             
        IFTHEN=(WHEN=(9,2,CH,EQ,C'04'),                                         
                BUILD=(1:3,5,22:X'000000',25:1,1)),                             
        IFTHEN=(WHEN=(9,2,CH,EQ,C'05'),                                         
                BUILD=(1:3,5,27:X'000000',30:1,1)),                             
        IFTHEN=(WHEN=(9,2,CH,EQ,C'06'),                                         
                BUILD=(1:3,5,32:X'000000',35:1,1)),                             
        IFTHEN=(WHEN=(9,2,CH,EQ,C'07'),                                         
                BUILD=(1:3,5,37:X'000000',40:1,1)),                             
        IFTHEN=(WHEN=(9,2,CH,EQ,C'08'),                                         
                BUILD=(1:3,5,42:X'000000',45:1,1)),                             
        IFTHEN=(WHEN=(9,2,CH,EQ,C'09'),                                         
                BUILD=(1:3,5,47:X'000000',50:1,1)),                             
        IFTHEN=(WHEN=(9,2,CH,EQ,C'10'),                                         
                BUILD=(1:3,5,52:X'000000',55:1,1)),                             
        IFTHEN=(WHEN=(9,2,CH,EQ,C'11'),                                         
                BUILD=(1:3,5,57:X'000000',60:1,1)),                             
        IFTHEN=(WHEN=(9,2,CH,EQ,C'12'),                                         
                BUILD=(1:3,5,62:X'000000',65:1,1)),                             
        IFTHEN=(WHEN=(9,2,CH,EQ,C'13'),                                         
                BUILD=(1:3,5,67:X'000000',70:1,1)),                             
        IFTHEN=(WHEN=(9,2,CH,EQ,C'14'),                                         
                BUILD=(1:3,5,72:X'000000',75:1,1)),                             
        IFTHEN=(WHEN=(9,2,CH,EQ,C'15'),                                         
                BUILD=(1:3,5,77:X'000000',80:1,1)),                             
        IFTHEN=(WHEN=(9,2,CH,EQ,C'16'),                                         
                BUILD=(1:3,5,82:X'000000',85:1,1)),                             
        IFTHEN=(WHEN=(9,2,CH,EQ,C'17'),                                         
                BUILD=(1:3,5,87:X'000000',90:1,1)),                             
        IFTHEN=(WHEN=(9,2,CH,EQ,C'18'),                                         
                BUILD=(1:3,5,92:X'000000',95:1,1)),                             
        IFTHEN=(WHEN=(9,2,CH,EQ,C'19'),                                         
                BUILD=(1:3,5,97:X'000000',100:1,1)),                            
        IFTHEN=(WHEN=(9,2,CH,EQ,C'20'),                                         
                BUILD=(1:3,5,102:X'000000',105:1,1)),                           
        IFTHEN=(WHEN=(9,2,CH,EQ,C'21'),                                         
                BUILD=(1:3,5,107:X'000000',110:1,1)),                           
        IFTHEN=(WHEN=(9,2,CH,EQ,C'22'),                                         
                BUILD=(1:3,5,112:X'000000',115:1,1)),                           
        IFTHEN=(WHEN=(9,2,CH,EQ,C'23'),                                         
                BUILD=(1:3,5,117:X'000000',120:1,1)),                           
        IFTHEN=(WHEN=(9,2,CH,EQ,C'24'),                                         
                BUILD=(1:3,5,122:X'000000',125:1,1)),                           
        IFTHEN=(WHEN=(9,2,CH,EQ,C'25'),                                         
                BUILD=(1:3,5,127:X'000000',130:1,1)),                           
        IFTHEN=(WHEN=(9,2,CH,EQ,C'26'),                                         
                BUILD=(1:3,5,132:X'000000',135:1,1)),                           
        IFTHEN=(WHEN=(9,2,CH,EQ,C'27'),                                         
                BUILD=(1:3,5,137:X'000000',140:1,1)),                           
        IFTHEN=(WHEN=(9,2,CH,EQ,C'28'),                                         
                BUILD=(1:3,5,142:X'000000',145:1,1)),                           
        IFTHEN=(WHEN=(9,2,CH,EQ,C'29'),                                         
                BUILD=(1:3,5,147:X'000000',150:1,1)),                           
        IFTHEN=(WHEN=(9,2,CH,EQ,C'30'),                                         
                BUILD=(1:3,5,152:X'000000',155:1,1))                            
/*                                                                              
//*---------------------------------------------------------------------        
//* MERGE ALL CHARACTERS TO ONE ROW                                             
//*---------------------------------------------------------------------        
//GROUPADD EXEC PGM=SORT                                                        
//SORTOUT  DD DSN=&&TMP04,                                                      
//         DISP=(,PASS,DELETE),DATACLAS=PXL                                     
//SORTIN   DD DSN=&&TMP03,DISP=(SHR,PASS)                                       
//SYSOUT   DD SYSOUT=*                                                          
//SYSIN    DD *                                                                 
  SORT FIELDS=(1,5,CH,A)                                                        
  ALTSEQ CODE=(4000)                                                            
  INREC FIELDS=(1,155,TRAN=ALTSEQ)                                              
  SUM FIELDS=(7,4,                                                              
             12,4,                                                              
             17,4,                                                              
             22,4,                                                              
             27,4,                                                              
             32,4,                                                              
             37,4,                                                              
             42,4,                                                              
             47,4,                                                              
             52,4,                                                              
             57,4,                                                              
             62,4,                                                              
             67,4,                                                              
             72,4,                                                              
             77,4,                                                              
             82,4,                                                              
             87,4,                                                              
             92,4,                                                              
             97,4,                                                              
            102,4,                                                              
            107,4,                                                              
            112,4,                                                              
            117,4,                                                              
            122,4,                                                              
            127,4,                                                              
            132,4,                                                              
            137,4,                                                              
            142,4,                                                              
            147,4,                                                              
            152,4),                                                             
            FORMAT=BI                                                           
/*                                                                              
//*---------------------------------------------------------------------        
//* SQUEEZE AND PARSE EACH MUL(X,Y)                                             
//*---------------------------------------------------------------------        
//SQUEEZE  EXEC PGM=SORT                                                        
//SORTOUT  DD DSN=&&TMP05,                                                      
//         DISP=(,PASS,DELETE),DATACLAS=PXL                                     
//SORTIN   DD DSN=&&TMP04,DISP=(SHR,PASS)                                       
//SYSOUT   DD SYSOUT=*                                                          
//SYSIN    DD *                                                                 
  OPTION COPY                                                                   
  INREC FIELDS=(1,9,10,145,SQZ=(SHIFT=LEFT,PREBLANK=X'00'))                     
  OUTREC PARSE=(%1=(STARTAT=C'MUL(',ENDBEFR=C',',FIXLEN=10),                    
                %2=(SUBPOS=1,FIXLEN=1),                                         
                %3=(ENDAT=C')',FIXLEN=10)),                                     
       OVERLAY=(50:%1,78:%2,80:%3,SQZ=(SHIFT=RIGHT))                            
/*                                                                              
//*---------------------------------------------------------------------        
//* MAKE INTO ZONED DECIMAL, BY SHIFTING, SO THAT CHARS CAN BE OMITTED          
//*---------------------------------------------------------------------        
//TOZD     EXEC PGM=SORT                                                        
//SORTOUT  DD DSN=&&TMP06,                                                      
//         DISP=(,PASS,DELETE),DATACLAS=PXL                                     
//SORTIN   DD DSN=&&TMP05,DISP=(SHR,PASS)                                       
//SYSOUT   DD SYSOUT=*                                                          
//SYSIN    DD *                                                                 
  OPTION COPY                                                                   
  INCLUDE COND=(50,4,CH,EQ,C'MUL(',AND,                                         
                78,1,CH,EQ,C',',AND,                                            
                89,1,CH,EQ,C')')                                                
  INREC OVERLAY=(100:54,10,SQZ=(SHIFT=RIGHT,LEAD=C'0000000000'),                
                 120:79,10,SQZ=(SHIFT=RIGHT,LEAD=C'0000000000'))                
  OUTREC BUILD=(1:10,30,                                                        
               40:100,10,                                                       
               60:120,10,                                                       
               80:X)                                                            
/*                                                                              
//*---------------------------------------------------------------------        
//* MAKE INTO ZONED DECIMAL, BY SHIFTING, SO THAT CHARS CAN BE OMITTED          
//*---------------------------------------------------------------------        
//MULTIPLY EXEC PGM=SORT                                                        
//SORTOUT  DD SYSOUT=*                                                          
//SORTIN   DD DSN=&&TMP06,DISP=(SHR,PASS)                                       
//SYSOUT   DD SYSOUT=*                                                          
//SYSIN    DD *                                                                 
  OPTION COPY                                                                   
  INCLUDE COND=(40,10,FS,EQ,NUM,AND,                                            
                60,10,FS,EQ,NUM)                                                
  INREC OVERLAY=(80:40,10,ZD,MUL,60,10,ZD,TO=ZD,LENGTH=20)                      
  OUTFIL REMOVECC,                                                              
         TRAILER1=(C'TOTAL: ',TOT=(80,20,ZD)),                                  
         OUTREC=(1,30,80:X)                                                     
/*                                                                              
