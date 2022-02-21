--2. 날짜 함수 -- 숫자로 받아들임 , 사용할 땐 DATA 타입
SELECT SYSDATE FROM DUAL;
SELECT * FROM PROFESSORS; 
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS')FROM DUAL;

SELECT SYSDATE +5 FROM DUAL;			--> DATE
SELECT SYSDATE - SYSDATE FROM DUAL; 	--> 숫자


--오늘 날짜를 기준으로 생일이 지난 교수
SELECT TO_DATE(BIRTH),TO_DATE(BIRTH)+5 FROM PROFESSORS; 


-- 날짜 함수 
--1. TO_DATE : 다른 데이터타입을 날짜 타입으로 변환
SELECT TO_DATE('1998*03*10', 'YYYY-MM-DD') FROM DUAL;

--2. 날짜를 빼고 더할 때
SELECT '19980310' +5 FROM DUAL; 			-->잘못된
SELECT TO_NUMBER('19980310') +5 FROM DUAL;  -->알맞은 >> 19980310 + 5>>
SELECT TO_DATE('19980310') +5 FROM DUAL;			-->> 1998년 03월 10일로부터 5일 뒤가 언제냐?

-- 19250708 생이 19500625에 몇일이나 살았니 
SELECT 19500625 - 19250708 FROM DUAL;
SELECT TO_DATE(19500625, 'YYYY-MM-DD') - TO_DATE(19250708, 'YYYY-MM-DD') FROM DUAL;


--1.3 ADD_MONTHS()
SELECT BIRTH, ADD_MONTHS(TO_DATE(BIRTH, 'YYYY-MM-DD'), 3) FROM PROFESSORS; -- 3개월 뒤를 구해달라
SELECT BIRTH, ADD_MONTHS(TO_DATE(BIRTH, 'YYYY-MM-DD'), -7) FROM PROFESSORS; -- 7개월 전을 구해달라


--1.4 CURRENT_DATE()
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS'),
	   TO_CHAR(CURRENT_DATE, 'YYYY-MM-DD HH:MI:SS')
FROM DUAL; 
--> ??

--1.5 LAST_DAY() -주어진 값에 해당달의 마지막 날을 보여줍니다.
SELECT BIRTH, LAST_DAY(TO_DATE(BIRTH, 'YYYY-MM-DD')) FROM PROFESSORS;
SELECT BIRTH, LAST_DAY(BIRTH) FROM PROFESSORS;

--1.6 MONTHS_BETWEEN
SELECT MONTHS_BETWEEN('20210221','20210105' )FROM DUAL;


--1.7 TRUNC - 예제가 필요



-- TO_CHAR
SELECT TO_CHAR(SYSDATE) FROM DUAL; -- 데이터 타입 변환
SELECT TO_CHAR(SYSDATE, 'YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MM') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'HH') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'HH24') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MI') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'HH MI SS') FROM DUAL; -- HH:MI:SS

SELECT * FROM PROFESSORS;
---교수 나이를 구해보자
SELECT BIRTH, SUBSTR(BIRTH, 1, 4)AS BIRTHYEAR, SUBSTR(SYSDATE,1,4) NOWYEAR,
TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'YYYY') - SUBSTR(BIRTH, 1, 4) +1 AS PAGE
FROM PROFESSORS;


-- 1.  10대~ 
SELECT BIRTH, SUBSTR(TRIM(BIRTH),1,4) AS BIRTHYEAR,
		TO_CHAR(TO_DATE(BIRTH,'YYYYMMDD'), 'YYYY') AS BIRTHYEAR2,
		TO_CHAR(SYSDATE, 'YYYY') NOWYEAR,
		TO_CHAR(SYSDATE, 'YYYY') -   TO_CHAR(TO_DATE(BIRTH,'YYYYMMDD'), 'YYYY') AS AGE,
		TRUNC(TO_CHAR(SYSDATE, 'YYYY') -   TO_CHAR(TO_DATE(BIRTH,'YYYYMMDD'), 'YYYY'), -1)
FROM PROFESSORS;

-- 나이별 사람 수 
SELECT TRUNC(TO_CHAR(SYSDATE, 'YYYY') -   TO_CHAR(TO_DATE(BIRTH,'YYYYMMDD'), 'YYYY'), -1)AS 나잇대, COUNT(*)
FROM PROFESSORS
GROUP BY TRUNC(TO_CHAR(SYSDATE, 'YYYY') -   TO_CHAR(TO_DATE(BIRTH,'YYYYMMDD'), 'YYYY'), -1) 
ORDER BY TRUNC(TO_CHAR(SYSDATE, 'YYYY') -   TO_CHAR(TO_DATE(BIRTH,'YYYYMMDD'), 'YYYY'), -1) ASC;


/*
	1910 ~ 1919
	1920 ~ 1929
	1930 ~ 1939 ... 
*/
SELECT SUBSTR(BIRTH, 1, 3) || '0 ~ ' || SUBSTR(BIRTH, 1, 3) || '9', COUNT(*) FROM PROFESSORS
GROUP BY SUBSTR(BIRTH, 1, 3) || '0 ~ ' || SUBSTR(BIRTH, 1, 3) || '9';


SELECT LEVEL 
FROM DUAL
CONNECT BY LEVEL<10;


SELECT A.BASICYEAR, NVL(B.CNT,0) AS CNT FROM 
(
	SELECT 190 + LEVEL || '0' BASICYEAR
	FROM DUAL
	CONNECT BY LEVEL <=12
)A,
(
	SELECT SUBSTR(TRIM(BIRTH),1,3) ||'0' BIRTHYEAR, COUNT(*) AS CNT
	FROM PROFESSORS
	GROUP BY SUBSTR(TRIM(BIRTH),1,3)||'0'
)B
WHERE A.BASICYEAR = B.BIRTHYEAR(+)
ORDER BY A.BASICYEAR ASC
;






