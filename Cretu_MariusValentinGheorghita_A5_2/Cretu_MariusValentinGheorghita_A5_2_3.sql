-- Exercitiul 3
-- Cretu Marius-Valentin
-- grupa A5


set serveroutput on;
DECLARE
   CURSOR lista_studenti  IS
       SELECT ID, nume, prenume, an FROM studenti;
   --
   CURSOR lista_note_student (s_id studenti.id%type) IS
        SELECT valoare FROM note WHERE note.id_student = s_id;
   --
   CURSOR best_student (s_id studenti.id%type) IS
        SELECT id_curs,valoare FROM note WHERE note.id_student = s_id;
   --
        
   v_note_linie lista_note_student%ROWTYPE;
   v_note_student lista_note_student%ROWTYPE;
   v_note_best_student best_student%ROWTYPE;
   --
   v_MAX float := 0.0;
   v_note_count integer;
   v_sum float;
   v_avg float;
   v_avg_2 float;
   --
   type studenti_array IS VARRAY(10) OF integer;
    array_stud studenti_array := studenti_array();
    --
    type studenti_an_array IS VARRAY(10) OF integer;
    array_an_stud studenti_an_array := studenti_an_array();
    --
    type studenti_nume_array IS VARRAY(10) OF VARCHAR2(10);
    array_nume_stud studenti_nume_array := studenti_nume_array();
   l_idx NUMBER;
   --
   v_temp_id integer;
   v_temp_an integer;
   v_temp_name varchar2(10);
   --
   copie integer;
   --
   v_titlu_curs cursuri.titlu_curs%TYPE;
BEGIN

FOR v_stud_linie IN lista_studenti LOOP -- parcurgem inregistrarile din tabela studenti
    OPEN lista_note_student (v_stud_linie.id);
    --
    v_note_count := 0;
    v_sum := 0.0;
    v_avg := 0;
    --
    LOOP
        FETCH lista_note_student INTO v_note_linie;
        
        EXIT WHEN lista_note_student%NOTFOUND;
        v_sum := v_sum + v_note_linie.valoare;
        v_note_count := v_note_count + 1;
        
    END LOOP;
    CLOSE lista_note_student;
    v_avg := v_sum / v_note_count;
    --
    if(v_avg >= v_MAX and v_note_count >= 3) then 
    --s_id := v_stud_linie.ID; 
    v_MAX := v_avg;
    
    end if;
    --
    --DBMS_OUTPUT.PUT_LINE(v_stud_linie.ID||'  '||v_avg||'  '||v_note_count);
    -- DBMS_OUTPUT.PUT_LINE('suma: ' || v_sum ||'  '||v_note_count);
END LOOP;
--DBMS_OUTPUT.PUT_LINE('s_id: ' || v_max ||'  '||v_note_count);
--




FOR v_stud_linie IN lista_studenti LOOP -- parcurgem inregistrarile din tabela studenti
    OPEN lista_note_student (v_stud_linie.id);
    --
    v_note_count := 0;
    v_sum := 0.0;
    v_avg_2 := 0;
    LOOP
        FETCH lista_note_student INTO v_note_student;
        
        EXIT WHEN lista_note_student%NOTFOUND;
        v_sum := v_sum + v_note_student.valoare;
        v_note_count := v_note_count + 1;
        --DBMS_OUTPUT.PUT_LINE('s_id: ' || v_stud_linie.id || v_note_student.valoare);
        
    END LOOP;
    CLOSE lista_note_student;
    v_avg_2 := v_sum / v_note_count;
    -- se verifica daca media studentului este egala cu cea mai mare medie din tabelta note
    -- se verifica daca studentul are un minim de 3 note
    if(v_avg_2 = v_max and v_note_count >= 3) then 
    --DBMS_OUTPUT.PUT_LINE('s_id: ' || v_stud_linie.id ||  ' cu media: ' || v_max || ' in anul: ' ||v_stud_linie.an);
    --
    array_nume_stud.extend;
    array_nume_stud(array_nume_stud.last) := v_stud_linie.nume;
    array_stud.extend;
    array_stud(array_stud.last) := v_stud_linie.id;
    array_an_stud.extend;
    array_an_stud(array_an_stud.last) := v_stud_linie.an;
    
    OPEN lista_note_student (v_stud_linie.id);
    LOOP
        FETCH lista_note_student INTO v_note_student;
        
        EXIT WHEN lista_note_student%NOTFOUND;
        
        --DBMS_OUTPUT.PUT_LINE(v_note_student.valoare || ' ');
        
    END LOOP;
    CLOSE lista_note_student;
    
    end if;
END LOOP;

--   l_idx := array_stud.FIRST;
--   << display_loop >> --eticheta
--   WHILE l_idx IS NOT NULL LOOP
--   DBMS_OUTPUT.PUT_LINE('Student with id_student: ' || array_stud(l_idx));
--   DBMS_OUTPUT.PUT_LINE('and name: ' || array_nume_stud(l_idx));
--   DBMS_OUTPUT.PUT_LINE('is in year: ' || array_an_stud(l_idx));
--   l_idx := array_stud.NEXT(l_idx);
--   END LOOP display_loop;

   l_idx := array_stud.FIRST;
   DBMS_OUTPUT.PUT_LINE('Student with id_student: ' || array_stud(l_idx));
   DBMS_OUTPUT.PUT_LINE('and name: ' || array_nume_stud(l_idx));
   DBMS_OUTPUT.PUT_LINE('is in year: ' || array_an_stud(l_idx));
   OPEN best_student(array_stud(l_idx));
   LOOP
        FETCH best_student INTO v_note_best_student;
    
        EXIT WHEN best_student%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE(v_note_best_student.valoare);
        --DBMS_OUTPUT.PUT_LINE('la cursul: ' || v_note_best_student.id_curs);
        select titlu_curs into v_titlu_curs from cursuri
        where cursuri.id like v_note_best_student.id_curs;
        DBMS_OUTPUT.PUT_LINE('la cursul: ' || v_titlu_curs);
    END LOOP;
    CLOSE best_student;

END;
