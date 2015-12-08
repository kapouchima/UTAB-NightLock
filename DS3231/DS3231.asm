
_SetTime:

;DS3231.c,6 :: 		void SetTime(Time *t)
;DS3231.c,9 :: 		i2c1_start();
	CALL        _I2C1_Start+0, 0
;DS3231.c,10 :: 		i2c1_wr(0xD0);
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,11 :: 		i2c1_wr(0x00);
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,12 :: 		i2c1_wr(t->SecondBCD);
	MOVFF       FARG_SetTime_t+0, FSR0
	MOVFF       FARG_SetTime_t+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,13 :: 		i2c1_wr(t->MinuteBCD);
	MOVLW       1
	ADDWF       FARG_SetTime_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SetTime_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,14 :: 		i2c1_wr(t->HourBCD);
	MOVLW       2
	ADDWF       FARG_SetTime_t+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SetTime_t+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,15 :: 		i2c1_stop();
	CALL        _I2C1_Stop+0, 0
;DS3231.c,17 :: 		}
L_end_SetTime:
	RETURN      0
; end of _SetTime

_GetTime:

;DS3231.c,36 :: 		void GetTime(Time *t)
;DS3231.c,39 :: 		i2c1_start();
	CALL        _I2C1_Start+0, 0
;DS3231.c,40 :: 		i2c1_wr(0xD0);
	MOVLW       208
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,41 :: 		i2c1_wr(0x00);
	CLRF        FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,42 :: 		I2C1_Repeated_Start();
	CALL        _I2C1_Repeated_Start+0, 0
;DS3231.c,43 :: 		i2c1_wr(0xD1);
	MOVLW       209
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;DS3231.c,44 :: 		t->SecondBCD=i2c1_rd(1);
	MOVF        FARG_GetTime_t+0, 0 
	MOVWF       FLOC__GetTime+0 
	MOVF        FARG_GetTime_t+1, 0 
	MOVWF       FLOC__GetTime+1 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVFF       FLOC__GetTime+0, FSR1
	MOVFF       FLOC__GetTime+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;DS3231.c,45 :: 		t->MinuteBCD=i2c1_rd(1);
	MOVLW       1
	ADDWF       FARG_GetTime_t+0, 0 
	MOVWF       FLOC__GetTime+0 
	MOVLW       0
	ADDWFC      FARG_GetTime_t+1, 0 
	MOVWF       FLOC__GetTime+1 
	MOVLW       1
	MOVWF       FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVFF       FLOC__GetTime+0, FSR1
	MOVFF       FLOC__GetTime+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;DS3231.c,46 :: 		t->HourBCD=i2c1_rd(0);
	MOVLW       2
	ADDWF       FARG_GetTime_t+0, 0 
	MOVWF       FLOC__GetTime+0 
	MOVLW       0
	ADDWFC      FARG_GetTime_t+1, 0 
	MOVWF       FLOC__GetTime+1 
	CLRF        FARG_I2C1_Rd_ack+0 
	CALL        _I2C1_Rd+0, 0
	MOVFF       FLOC__GetTime+0, FSR1
	MOVFF       FLOC__GetTime+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;DS3231.c,47 :: 		i2c1_stop();
	CALL        _I2C1_Stop+0, 0
;DS3231.c,49 :: 		}
L_end_GetTime:
	RETURN      0
; end of _GetTime
