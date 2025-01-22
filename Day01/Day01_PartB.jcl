//AOC2401B JOB (EGEN),'AOC2401B',CLASS=A,MSGCLASS=Q,                            
//     NOTIFY=&SYSUID,MSGLEVEL=(1,1),REGION=0M                                  
//*---------------------------------------------------------------------        
//* SPLIT THE LISTS OCH SORT EACH LIST SEPARATELY.                              
//*---------------------------------------------------------------------        
//SPLIT    EXEC PGM=ICETOOL                                                     
//TOOLMSG  DD SYSOUT=*                                                          
//DFSMSG   DD SYSOUT=*                                                          
//IN       DD DSN=USERID.AOC24INP(DAY01),DISP=SHR                               
//OUT1     DD DSN=&&TMP01,                                                      
//         DISP=(,PASS,DELETE),DATACLAS=PXL                                     
//OUT2     DD DSN=&&TMP02,                                                      
//         DISP=(,PASS,DELETE),DATACLAS=PXL                                     
//TOOLIN   DD *                                                                 
  COPY FROM(IN) TO(OUT1) USING(SRT1)                                            
  COPY FROM(IN) TO(OUT2) USING(SRT2)                                            
/*                                                                              
//SRT1CNTL DD *                                                                 
  INREC  PARSE=(%1=(ENDBEFR=BLANKS,FIXLEN=40)),                                 
         BUILD=(8:%1)                                                           
  OUTREC OVERLAY=(1:SEQNUM,6,ZD)                                                
  SORT FIELDS=(8,40,ZD,A)                                                       
/*                                                                              
//SRT2CNTL DD *                                                                 
  INREC PARSE=(%1=(STARTAFT=BLANKS,FIXLEN=40)),                                 
         BUILD=(8:%1)                                                           
  OUTREC OVERLAY=(1:SEQNUM,6,ZD)                                                
  SORT FIELDS=(8,40,ZD,A)                                                       
/*                                                                              
//*---------------------------------------------------------------------        
//* MARGE THE LISTS AGAIN BUT ONLY FOR MATCHING NUMBERS.                        
//*---------------------------------------------------------------------        
//MERGE    EXEC PGM=SORT                                                        
//SORTOUT  DD DSN=&&MERGE,                                                      
//         DISP=(,PASS,DELETE),DATACLAS=PXL                                     
//SORTJNF1 DD DSN=&&TMP01,DISP=(SHR,PASS)                                       
//SORTJNF2 DD DSN=&&TMP02,DISP=(SHR,PASS)                                       
//SYSOUT   DD SYSOUT=*                                                          
//SYSIN    DD *                                                                 
  OPTION COPY                                                                   
  JOINKEYS FILES=F1,FIELDS=(8,5,A)                                              
  JOINKEYS FILES=F2,FIELDS=(8,5,A)                                              
  REFORMAT FIELDS=(F1:1,40)                                                     
/*                                                                              
//*---------------------------------------------------------------------        
//* CALCULATE THE TOTAL SUM.                                                    
//*---------------------------------------------------------------------        
//DIFF     EXEC PGM=SORT                                                        
//SORTOUT  DD SYSOUT=*                                                          
//SORTIN   DD DSN=&&MERGE,DISP=(SHR,PASS)                                       
//SYSOUT   DD SYSOUT=*                                                          
//SYSIN    DD *                                                                 
  OPTION COPY                                                                   
  OUTFIL REMOVECC,                                                              
         TRAILER1=(1:'Total: ',8:TOT=(8,5,ZD))                                  
                                                                                
/*                                                                              
