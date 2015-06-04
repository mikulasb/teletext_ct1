# Skript na stažení zadané stránky teletextu

## Použití

$ ./teletext_ct.sh --help
Skript na stažení zadané stránky teletextu ČT1.
Stránka se zadá jako parametr z rozsahu 100-999[A-H].
Např.: ./teletext_ct.sh 171
Podstránky se zadávají písmenem. Např.: 391A, 391B,...
(Písmeno není nutné zadávat u 1. podstránky z několika.)
Čísla podstránek jsou vypsána na posledním řádku.

$ ./teletext_ct.sh 171
                                        
 POČASÍ                 Předpověď pro ČR
                                        
                            na 4. a 5.6.
                                        
 Dnes bude polojasno, během dne postupně
 skoro jasno až jasno.                  
 Denní teploty 23 až 27°C, na JV až 30°C
 v 1000 m kolem 16°C, na Šumavě 19°C    
 Sv. až s. vítr 2-6 m/s                 
                                        
                                        
 V noci a zítra bude jasno nebo skoro   
 jasno.                                 
 Noční teploty 14 až 10°C               
 Denní teploty 26 až 30°C               
 Východní vítr 2-5 m/s                  
                                        
                                        
 Tlaková tendence: slabý pokles         
                                        
   -kv-        4.6. v 5.00              
                                        

Stránka 171
$

## Zajímavosti bash scriptu:
- parsování HTML stránky
- použití ramdisku /dev/shm,
- výpočet počtu znaků vyhovující ragulárnímu výrazu
- změna IFS 
- sed
