--Exercitiul 2
--Cretu Marius-Valentin
--grupa A5
set serveroutput on;
DECLARE 
   CURSOR update_lab2 IS
      SELECT * FROM LAB_2 FOR UPDATE OF B NOWAIT;
    v_limita integer := 21;
    v_nr2 integer;
    v_nr1 integer;
    v_nr0 integer;
    --
    v_iteratorFib integer;
    --
    type fibonacci IS VARRAY(21) OF integer;
    fibo_array fibonacci := fibonacci();
    --
    l_idx NUMBER;
    --
    c_ok integer;
    --
    v_linie update_lab2%ROWTYPE;
    --
    v_count_update int := 0;
BEGIN
   fibo_array := fibonacci(1,1);
   
   for v_iteratorFib in 3..v_limita LOOP
    fibo_array.extend;
    fibo_array(fibo_array.last) := fibo_array(v_iteratorFib - 2) + fibo_array(v_iteratorFib - 1);
    --v_counter := v_counter + 1;
   END LOOP;
   --
--      l_idx := fibo_array.FIRST;
--   << display_loop >>
--   WHILE l_idx IS NOT NULL LOOP
--   DBMS_OUTPUT.PUT_LINE('The number ' || fibo_array(l_idx));
--   l_idx := fibo_array.NEXT(l_idx);
--   END LOOP display_loop;
   --
   
   FOR v_linie IN update_lab2 LOOP
   --
   c_ok := 0;
   --
   l_idx := fibo_array.FIRST;
   << search_loop >>
   WHILE l_idx IS NOT NULL LOOP
   if(v_linie.A = fibo_array(l_idx)) 
   then c_ok := 1; 
   end IF;
   --DBMS_OUTPUT.PUT_LINE(v_linie.A || 'The number ' || fibo_array(l_idx));
   l_idx := fibo_array.NEXT(l_idx);
   END LOOP search_loop;
  -- DBMS_OUTPUT.PUT_LiNE(c_ok);
   
   
   
       CASE(c_ok)
           WHEN 1 THEN
           if(v_linie.B = 0) then
           v_count_update := v_count_update + 1;
           DBMS_OUTPUT.PUT_LINE('number: ' || v_linie.A || ' ' || v_linie.B || ' -> ' || '1');
           UPDATE LAB_2 SET B=1 WHERE CURRENT OF update_lab2;
           end if;
           --
           WHEN 0 THEN IF(v_linie.B = 1) 
            then DBMS_OUTPUT.PUT_LINE('number: ' || v_linie.A || ' ' || v_linie.B || ' -> ' || '0'); 
            v_count_update := v_count_update + 1;
           UPDATE LAB_2 SET B=0 WHERE CURRENT OF update_lab2;
           END IF;
           --
           ELSE DBMS_OUTPUT.PUT_LINE('Nothing to be done!');
      END CASE;
   END LOOP;
   --
   DBMS_OUTPUT.PUT_LINE(v_count_update);
END;
