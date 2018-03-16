DECLARE 
--   CURSOR update_lab2 IS
--      SELECT * FROM LAB_2_new FOR UPDATE OF B NOWAIT;
    v_limita integer := 20;
    v_nr2 integer;
    v_nr1 integer;
    v_nr0 integer;
    --
    v_iteratorFib integer;
    --
    type fibonacci IS VARRAY(20) OF integer;
    fibo_array fibonacci := fibonacci();
    --
    l_idx NUMBER;
BEGIN
   fibo_array := fibonacci(1,1);
   
   for v_iteratorFib in 3..v_limita LOOP
    fibo_array.extend;
    fibo_array(fibo_array.last) := fibo_array(v_iteratorFib - 2) + fibo_array(v_iteratorFib - 1);
    --v_counter := v_counter + 1;
   END LOOP;
   
   l_idx := fibo_array(1);
   for v_iteratorFib in 1..v_limita loop
   DBMS_OUTPUT.PUT_LINE('The number ' || fibo_array(v_iteratorFib));
   
   END LOOP;
END;