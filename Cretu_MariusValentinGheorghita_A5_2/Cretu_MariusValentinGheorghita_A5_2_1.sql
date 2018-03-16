--Exercitiul 1
--Cretu Marius-Valentin
--grupa A5

set serveroutput on;
clear screen;
DROP TABLE lab_2;
CREATE TABLE lab_2(A integer, B integer); -- creare tabel necesar stocarii datelor de la ex_1 
DECLARE
   const_number NUMBER(5) := 5; -- constanta declarata la inceputul scriptului
   v_contor integer := 0; --contor pentru parcurgere numere in intervalul 0 - 10_000
   v_digSum integer;
   v_copie integer;
   v_uc integer;
   --
   v_divCount integer; --contor pentru numarul de divizori gasiti
   v_divIt integer; --iterator pentru verificare primalitate
BEGIN   
   LOOP
    v_contor := v_contor + 1; -- incrementare v_contor
    --
    v_copie := v_contor; -- se creaza o copie a contorului pentru a putea calcula suma cifrelor fara a corupe contorul
    
    v_digSum := 0; -- resetare suma cifrelor inainte de a calcula o noua suma pentru urmatorul contor
    WHILE(v_copie > 0) LOOP
        v_uc := v_copie MOD 10; --se preia ultima cifra in variabila v_uc
        v_digSum := v_digSum + v_uc; --se aduna la suma cifrelor fiecare cifra
        v_copie := floor(v_copie / 10); -- floor folosit in cazul in care avem rezultate de tip 0,5 \ 1,5 etc.
    END LOOP;
    --DBMS_OUTPUT.PUT_LINE('digSum: ' || v_digSum);
    --DBMS_OUTPUT.PUT_LINE('it:' || v_contor);
    IF(v_digSum MOD 9 = const_number) -- daca suma cifrelor modulo 9 este egala cu 7 in cazul nostru(constanta)
    THEN    --atunci
     --DBMS_OUTPUT.PUT_LINE(v_digSum MOD 9);
     --
     v_divCount := 0; -- se reseteaza numarul de divizori ai fiecarui contor ce verifica conditia precedenta
     FOR v_divIt in 1..v_contor LOOP
        if(v_contor mod v_divIt = 0) then v_divCount := v_divCount + 1; --daca se imparte exact se incrementeaza nr de divizori
        end if;
     END LOOP;
     --
    if(v_divCount = 2) then insert into LAB_2 (A,B) values (v_contor,1); -- daca sunt exact 2 divizori (1, si numarul in sine) se insereaza in tabela LAB_2
    else insert into LAB_2 (A,B) values (v_contor,0); --daca nu sunt exact 2 divizori se considera ca numarul este impar si se insereaza in tabela LAB_2
    end if;
    END IF;
    --
    EXIT WHEN v_contor = 10000;
   END LOOP;
END;