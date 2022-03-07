-- TRG_MEMPOINT

create or replace TRIGGER TRG_MEMPOINT 
AFTER INSERT ON FINISH_DRIVE_TBL
FOR EACH ROW 
DECLARE
	V_R_TEL 	VARCHAR2(20);
BEGIN

	IF (:NEW.F_GUBUN = 2) THEN
		SELECT R_TEL
		INTO V_R_TEL
		FROM RESERVATION_TBL
		WHERE R_ID = :NEW.R_ID;
		
		UPDATE DR_MEMBER_TBL
		SET MEM_POINT = MEM_POINT / 100 * 90
		WHERE R_TEL = V_R_TEL
		;
	END IF;
END;