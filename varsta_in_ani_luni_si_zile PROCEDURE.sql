select sysdate,
  data_nastere,
  trunc(months_between(sysdate,data_nastere) / 12) as years,
  trunc(months_between(sysdate,data_nastere) -
    (trunc(months_between(sysdate,data_nastere) / 12) * 12)) as months,
  trunc(sysdate)
    - add_months(data_nastere, trunc(months_between(sysdate,data_nastere))) as days
from STUDENTI;