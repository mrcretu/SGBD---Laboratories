set serveroutput on;
DECLARE
c_date_of_birth VARCHAR(30) := '01-01-2000';
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Numarul de zile total: ' || (to_date(SYSDATE,'dd/mm/yyyy') - to_date(c_date_of_birth,'dd/mm/yyyy')));
     
    DBMS_OUTPUT.PUT_LINE('Numarul de luni: ' || (trunc(MONTHS_BETWEEN (TO_DATE (SYSDATE, 'dd/mm/yyyy'), TO_DATE (c_date_of_birth, 'dd/mm/yyyy')) ,0)));
    --DBMS_OUTPUT.PUT_LINE('Trunc -> c_date si SYSDATE: ' || (trunc( months_between(c_date_of_birth,SYSDATE) ) * (-1)));
    DBMS_OUTPUT.PUT_LINE('Zile ramase: ' || trunc(SYSDATE - add_months( c_date_of_birth, (trunc( months_between(c_date_of_birth, SYSDATE) * (-1) ) ))) );
    DBMS_OUTPUT.PUT_LINE('Ziua in care a cazut: ' || to_char(to_date(c_date_of_birth,'dd/mm/yyyy'),'day'));
  END;