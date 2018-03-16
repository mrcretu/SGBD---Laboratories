-- Cretu Marius Valentin
-- grupa A5
-- Afisare informatii despre un student

CREATE OR REPLACE PROCEDURE student_info (p_id IN studenti.id%TYPE) AS
        
v_info_student studenti%ROWTYPE;
--
v_media float;
BEGIN
    select * into v_info_student from studenti where id like p_id;
    --
    select avg(valoare) into v_media from note where id_student like p_id;
    --
    DBMS_OUTPUT.PUT_LINE('Informatii despre studentul cu ID-ul: ' || p_id);
    DBMS_OUTPUT.PUT_LINE('Numar matricol: ' || v_info_student.nr_matricol);
    --
    DBMS_OUTPUT.PUT_LINE(CHR(10) || CHR(9)||'Foaie matricola: ');
    DBMS_OUTPUT.PUT_LINE('Nume: ' || v_info_student.nume );
    DBMS_OUTPUT.PUT_LINE('Prenume: ' || v_info_student.prenume);
    DBMS_OUTPUT.PUT_LINE('An: ' || v_info_student.an || ', grupa: ' || v_info_student.grupa);
    DBMS_OUTPUT.PUT_LINE('Bursa: ' || nvl(v_info_student.bursa,0));
    --
    DBMS_OUTPUT.PUT_LINE('Media studentului: ' || v_media);
    DBMS_OUTPUT.PUT_LINE(calculeaza_varsta(p_id));
END;
--
--
BEGIN
    student_info(8);
END;

