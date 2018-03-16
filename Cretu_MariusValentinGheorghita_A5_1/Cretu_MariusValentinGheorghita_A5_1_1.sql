set serveroutput on;
DECLARE
  v_nume_de_familie varchar2(20) := '&i'; 
  v_nume_student studenti.nume%TYPE;
  nr_nume_student int;
  
  v_id STUDENTI.ID%TYPE;
  v_prenume_student STUDENTI.PRENUME%TYPE;
  
  v_min_nota NOTE.VALOARE%TYPE;
  v_max_nota NOTE.VALOARE%TYPE;
  
  v_contor1 INTEGER;
  BEGIN
     
     SELECT count(*) INTO nr_nume_student FROM studenti WHERE nume = v_nume_de_familie;
     IF (nr_nume_student = 0)
        THEN 
            DBMS_OUTPUT.PUT_LINE('Total: ' || nr_nume_student || '.');
            DBMS_OUTPUT.PUT_LINE('Nu exista studenti cu numele ' || v_nume_de_familie || '.');
     
     ELSE
     select count(nume) into nr_nume_student from studenti 
     where nume like v_nume_de_familie;
     DBMS_OUTPUT.PUT_LINE('1) Numarul de studenti avand numele de familie '|| v_nume_de_familie || ' este ' || nr_nume_student);
     
     select ID, PRENUME into v_id, v_prenume_student from(
     select ID, PRENUME  from studenti
     where nume like v_nume_de_familie
     order by prenume)
     where rownum = 1;
     DBMS_OUTPUT.PUT_LINE('2) ID-ul: ' || v_id || ' si prenumele: ' || v_prenume_student);

     select min(note.valoare), max(note.valoare) into v_min_nota, v_max_nota from NOTE
     where ID_STUDENT = 1010;
     DBMS_OUTPUT.PUT_LINE('3) Nota minima: ' || v_min_nota || ' si Nota maxima: ' || v_max_nota || ' a studentului cu id-ul '|| v_id || ' si prenumele ' || v_prenume_student || '!');
     
     DBMS_OUTPUT.PUT_LINE('4) Cea mai mare nota la puterea reprezentata de nota cea mai mica este: ' || power(v_max_nota, v_min_nota));
     END IF;
  END; 
