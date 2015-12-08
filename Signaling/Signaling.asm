
_SignalingSystem_CheckSignal:

;Signaling.c,5 :: 		char SignalingSystem_CheckSignal(SignalingSystem *sys,char sigcode)
;Signaling.c,7 :: 		char i=0,result=0;
	CLRF        SignalingSystem_CheckSignal_i_L0+0 
	CLRF        SignalingSystem_CheckSignal_result_L0+0 
;Signaling.c,8 :: 		for(i=0;i<SignalQueueElements;i++)
	CLRF        SignalingSystem_CheckSignal_i_L0+0 
L_SignalingSystem_CheckSignal0:
	MOVLW       10
	SUBWF       SignalingSystem_CheckSignal_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SignalingSystem_CheckSignal1
;Signaling.c,9 :: 		if((sys->SignalQueue[i].Expired==0)&&(sys->SignalQueue[i].Fired==1)&&(sys->SignalQueue[i].SignalCode==sigcode))
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_CheckSignal_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FARG_SignalingSystem_CheckSignal_sys+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_SignalingSystem_CheckSignal_sys+1, 0 
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SignalingSystem_CheckSignal5
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_CheckSignal_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FARG_SignalingSystem_CheckSignal_sys+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_SignalingSystem_CheckSignal_sys+1, 0 
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SignalingSystem_CheckSignal5
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_CheckSignal_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_SignalingSystem_CheckSignal_sys+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      FARG_SignalingSystem_CheckSignal_sys+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORWF       FARG_SignalingSystem_CheckSignal_sigcode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_SignalingSystem_CheckSignal5
L__SignalingSystem_CheckSignal33:
;Signaling.c,10 :: 		{sys->SignalQueue[i].Expired=1;result=1;break;}
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_CheckSignal_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FARG_SignalingSystem_CheckSignal_sys+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_SignalingSystem_CheckSignal_sys+1, 0 
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVLW       1
	MOVWF       SignalingSystem_CheckSignal_result_L0+0 
	GOTO        L_SignalingSystem_CheckSignal1
L_SignalingSystem_CheckSignal5:
;Signaling.c,8 :: 		for(i=0;i<SignalQueueElements;i++)
	INCF        SignalingSystem_CheckSignal_i_L0+0, 1 
;Signaling.c,10 :: 		{sys->SignalQueue[i].Expired=1;result=1;break;}
	GOTO        L_SignalingSystem_CheckSignal0
L_SignalingSystem_CheckSignal1:
;Signaling.c,11 :: 		return result;
	MOVF        SignalingSystem_CheckSignal_result_L0+0, 0 
	MOVWF       R0 
;Signaling.c,12 :: 		}
L_end_SignalingSystem_CheckSignal:
	RETURN      0
; end of _SignalingSystem_CheckSignal

_SignalingSystem_Task:

;Signaling.c,17 :: 		void SignalingSystem_Task(SignalingSystem *sys)
;Signaling.c,19 :: 		char i=0;
	CLRF        SignalingSystem_Task_i_L0+0 
;Signaling.c,20 :: 		for(i=0;i<SignalQueueElements;i++)
	CLRF        SignalingSystem_Task_i_L0+0 
L_SignalingSystem_Task6:
	MOVLW       10
	SUBWF       SignalingSystem_Task_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SignalingSystem_Task7
;Signaling.c,21 :: 		if((sys->SignalQueue[i].Expired==0)&&(sys->SignalQueue[i].Time==sys->SystemEPOCH)&&(sys->SignalQueue[i].Fired==0))
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_Task_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FARG_SignalingSystem_Task_sys+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_SignalingSystem_Task_sys+1, 0 
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SignalingSystem_Task11
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_Task_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FARG_SignalingSystem_Task_sys+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_SignalingSystem_Task_sys+1, 0 
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R5 
	MOVF        POSTINC0+0, 0 
	MOVWF       R6 
	MOVF        POSTINC0+0, 0 
	MOVWF       R7 
	MOVF        POSTINC0+0, 0 
	MOVWF       R8 
	MOVLW       70
	ADDWF       FARG_SignalingSystem_Task_sys+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_SignalingSystem_Task_sys+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVF        POSTINC2+0, 0 
	MOVWF       R3 
	MOVF        POSTINC2+0, 0 
	MOVWF       R4 
	MOVF        R8, 0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SignalingSystem_Task39
	MOVF        R7, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SignalingSystem_Task39
	MOVF        R6, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SignalingSystem_Task39
	MOVF        R5, 0 
	XORWF       R1, 0 
L__SignalingSystem_Task39:
	BTFSS       STATUS+0, 2 
	GOTO        L_SignalingSystem_Task11
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_Task_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FARG_SignalingSystem_Task_sys+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_SignalingSystem_Task_sys+1, 0 
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SignalingSystem_Task11
L__SignalingSystem_Task34:
;Signaling.c,22 :: 		sys->SignalQueue[i].Fired=1;
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_Task_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FARG_SignalingSystem_Task_sys+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_SignalingSystem_Task_sys+1, 0 
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
L_SignalingSystem_Task11:
;Signaling.c,20 :: 		for(i=0;i<SignalQueueElements;i++)
	INCF        SignalingSystem_Task_i_L0+0, 1 
;Signaling.c,22 :: 		sys->SignalQueue[i].Fired=1;
	GOTO        L_SignalingSystem_Task6
L_SignalingSystem_Task7:
;Signaling.c,23 :: 		}
L_end_SignalingSystem_Task:
	RETURN      0
; end of _SignalingSystem_Task

_SignalingSystem_SystemEPOCH:

;Signaling.c,27 :: 		void SignalingSystem_SystemEPOCH(SignalingSystem *sys)
;Signaling.c,29 :: 		if(sys->SystemEPOCH!=0xFFFFFFFF)
	MOVLW       70
	ADDWF       FARG_SignalingSystem_SystemEPOCH_sys+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SignalingSystem_SystemEPOCH_sys+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R4, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L__SignalingSystem_SystemEPOCH41
	MOVF        R3, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L__SignalingSystem_SystemEPOCH41
	MOVF        R2, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L__SignalingSystem_SystemEPOCH41
	MOVF        R1, 0 
	XORLW       255
L__SignalingSystem_SystemEPOCH41:
	BTFSC       STATUS+0, 2 
	GOTO        L_SignalingSystem_SystemEPOCH12
;Signaling.c,30 :: 		sys->SystemEPOCH=(sys->SystemEPOCH)+1;
	MOVLW       70
	ADDWF       FARG_SignalingSystem_SystemEPOCH_sys+0, 0 
	MOVWF       R4 
	MOVLW       0
	ADDWFC      FARG_SignalingSystem_SystemEPOCH_sys+1, 0 
	MOVWF       R5 
	MOVFF       R4, FSR0
	MOVFF       R5, FSR0H
	MOVLW       1
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R3 
	MOVFF       R4, FSR1
	MOVFF       R5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
	GOTO        L_SignalingSystem_SystemEPOCH13
L_SignalingSystem_SystemEPOCH12:
;Signaling.c,32 :: 		sys->SystemEPOCH=0;
	MOVLW       70
	ADDWF       FARG_SignalingSystem_SystemEPOCH_sys+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_SignalingSystem_SystemEPOCH_sys+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
L_SignalingSystem_SystemEPOCH13:
;Signaling.c,33 :: 		}
L_end_SignalingSystem_SystemEPOCH:
	RETURN      0
; end of _SignalingSystem_SystemEPOCH

_SignalingSystem_AddSignal:

;Signaling.c,37 :: 		void SignalingSystem_AddSignal(SignalingSystem *sys,unsigned long sigtime,char sigcode)
;Signaling.c,39 :: 		unsigned long signaltime=0;
	CLRF        SignalingSystem_AddSignal_signaltime_L0+0 
	CLRF        SignalingSystem_AddSignal_signaltime_L0+1 
	CLRF        SignalingSystem_AddSignal_signaltime_L0+2 
	CLRF        SignalingSystem_AddSignal_signaltime_L0+3 
;Signaling.c,41 :: 		signaltime=sys->SystemEPOCH+sigtime;
	MOVLW       70
	ADDWF       FARG_SignalingSystem_AddSignal_sys+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SignalingSystem_AddSignal_sys+1, 0 
	MOVWF       FSR0H 
	MOVF        FARG_SignalingSystem_AddSignal_sigtime+0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       SignalingSystem_AddSignal_signaltime_L0+0 
	MOVF        FARG_SignalingSystem_AddSignal_sigtime+1, 0 
	ADDWFC      POSTINC0+0, 0 
	MOVWF       SignalingSystem_AddSignal_signaltime_L0+1 
	MOVF        FARG_SignalingSystem_AddSignal_sigtime+2, 0 
	ADDWFC      POSTINC0+0, 0 
	MOVWF       SignalingSystem_AddSignal_signaltime_L0+2 
	MOVF        FARG_SignalingSystem_AddSignal_sigtime+3, 0 
	ADDWFC      POSTINC0+0, 0 
	MOVWF       SignalingSystem_AddSignal_signaltime_L0+3 
;Signaling.c,43 :: 		for(i=0;i<SignalQueueElements;i++)
	CLRF        SignalingSystem_AddSignal_i_L0+0 
L_SignalingSystem_AddSignal14:
	MOVLW       10
	SUBWF       SignalingSystem_AddSignal_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SignalingSystem_AddSignal15
;Signaling.c,44 :: 		if(sys->SignalQueue[i].Expired==1)
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_AddSignal_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FARG_SignalingSystem_AddSignal_sys+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_SignalingSystem_AddSignal_sys+1, 0 
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SignalingSystem_AddSignal17
;Signaling.c,46 :: 		sys->SignalQueue[i].SignalCode=sigcode;
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_AddSignal_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_SignalingSystem_AddSignal_sys+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      FARG_SignalingSystem_AddSignal_sys+1, 0 
	MOVWF       FSR1H 
	MOVF        FARG_SignalingSystem_AddSignal_sigcode+0, 0 
	MOVWF       POSTINC1+0 
;Signaling.c,47 :: 		sys->SignalQueue[i].Time=signaltime;
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_AddSignal_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FARG_SignalingSystem_AddSignal_sys+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_SignalingSystem_AddSignal_sys+1, 0 
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        SignalingSystem_AddSignal_signaltime_L0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        SignalingSystem_AddSignal_signaltime_L0+1, 0 
	MOVWF       POSTINC1+0 
	MOVF        SignalingSystem_AddSignal_signaltime_L0+2, 0 
	MOVWF       POSTINC1+0 
	MOVF        SignalingSystem_AddSignal_signaltime_L0+3, 0 
	MOVWF       POSTINC1+0 
;Signaling.c,48 :: 		sys->SignalQueue[i].Expired=0;
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_AddSignal_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FARG_SignalingSystem_AddSignal_sys+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_SignalingSystem_AddSignal_sys+1, 0 
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;Signaling.c,49 :: 		sys->SignalQueue[i].Fired=0;
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_AddSignal_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FARG_SignalingSystem_AddSignal_sys+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_SignalingSystem_AddSignal_sys+1, 0 
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;Signaling.c,50 :: 		break;
	GOTO        L_SignalingSystem_AddSignal15
;Signaling.c,51 :: 		}
L_SignalingSystem_AddSignal17:
;Signaling.c,43 :: 		for(i=0;i<SignalQueueElements;i++)
	INCF        SignalingSystem_AddSignal_i_L0+0, 1 
;Signaling.c,51 :: 		}
	GOTO        L_SignalingSystem_AddSignal14
L_SignalingSystem_AddSignal15:
;Signaling.c,52 :: 		}
L_end_SignalingSystem_AddSignal:
	RETURN      0
; end of _SignalingSystem_AddSignal

_SignalingSystem_ClearAllSignals:

;Signaling.c,58 :: 		void SignalingSystem_ClearAllSignals(SignalingSystem *sys,char sigcode)
;Signaling.c,61 :: 		for(i=0;i<SignalQueueElements;i++)
	CLRF        SignalingSystem_ClearAllSignals_i_L0+0 
L_SignalingSystem_ClearAllSignals18:
	MOVLW       10
	SUBWF       SignalingSystem_ClearAllSignals_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SignalingSystem_ClearAllSignals19
;Signaling.c,62 :: 		if((sys->SignalQueue[i].Expired==0)&&(sys->SignalQueue[i].SignalCode!=sigcode))
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_ClearAllSignals_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FARG_SignalingSystem_ClearAllSignals_sys+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_SignalingSystem_ClearAllSignals_sys+1, 0 
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SignalingSystem_ClearAllSignals23
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_ClearAllSignals_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_SignalingSystem_ClearAllSignals_sys+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      FARG_SignalingSystem_ClearAllSignals_sys+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORWF       FARG_SignalingSystem_ClearAllSignals_sigcode+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_SignalingSystem_ClearAllSignals23
L__SignalingSystem_ClearAllSignals35:
;Signaling.c,63 :: 		sys->SignalQueue[i].Expired=1;
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_ClearAllSignals_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FARG_SignalingSystem_ClearAllSignals_sys+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_SignalingSystem_ClearAllSignals_sys+1, 0 
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
L_SignalingSystem_ClearAllSignals23:
;Signaling.c,61 :: 		for(i=0;i<SignalQueueElements;i++)
	INCF        SignalingSystem_ClearAllSignals_i_L0+0, 1 
;Signaling.c,63 :: 		sys->SignalQueue[i].Expired=1;
	GOTO        L_SignalingSystem_ClearAllSignals18
L_SignalingSystem_ClearAllSignals19:
;Signaling.c,64 :: 		}
L_end_SignalingSystem_ClearAllSignals:
	RETURN      0
; end of _SignalingSystem_ClearAllSignals

_SignalingSystem_ClearSignal:

;Signaling.c,69 :: 		void SignalingSystem_ClearSignal(SignalingSystem *sys,char sigcode)
;Signaling.c,72 :: 		for(i=0;i<SignalQueueElements;i++)
	CLRF        SignalingSystem_ClearSignal_i_L0+0 
L_SignalingSystem_ClearSignal24:
	MOVLW       10
	SUBWF       SignalingSystem_ClearSignal_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SignalingSystem_ClearSignal25
;Signaling.c,73 :: 		if((sys->SignalQueue[i].Expired==0)&&(sys->SignalQueue[i].SignalCode==sigcode))
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_ClearSignal_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FARG_SignalingSystem_ClearSignal_sys+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_SignalingSystem_ClearSignal_sys+1, 0 
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SignalingSystem_ClearSignal29
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_ClearSignal_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_SignalingSystem_ClearSignal_sys+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      FARG_SignalingSystem_ClearSignal_sys+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORWF       FARG_SignalingSystem_ClearSignal_sigcode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_SignalingSystem_ClearSignal29
L__SignalingSystem_ClearSignal36:
;Signaling.c,74 :: 		sys->SignalQueue[i].Expired=1;
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_ClearSignal_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FARG_SignalingSystem_ClearSignal_sys+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_SignalingSystem_ClearSignal_sys+1, 0 
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
L_SignalingSystem_ClearSignal29:
;Signaling.c,72 :: 		for(i=0;i<SignalQueueElements;i++)
	INCF        SignalingSystem_ClearSignal_i_L0+0, 1 
;Signaling.c,74 :: 		sys->SignalQueue[i].Expired=1;
	GOTO        L_SignalingSystem_ClearSignal24
L_SignalingSystem_ClearSignal25:
;Signaling.c,75 :: 		}
L_end_SignalingSystem_ClearSignal:
	RETURN      0
; end of _SignalingSystem_ClearSignal

_SignalingSystem_Init:

;Signaling.c,80 :: 		void SignalingSystem_Init(SignalingSystem *sys)
;Signaling.c,83 :: 		for(i=0;i<SignalQueueElements;i++)
	CLRF        SignalingSystem_Init_i_L0+0 
L_SignalingSystem_Init30:
	MOVLW       10
	SUBWF       SignalingSystem_Init_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_SignalingSystem_Init31
;Signaling.c,85 :: 		sys->SignalQueue[i].SignalCode=0;
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_Init_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_SignalingSystem_Init_sys+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      FARG_SignalingSystem_Init_sys+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;Signaling.c,86 :: 		sys->SignalQueue[i].Time=0;
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_Init_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FARG_SignalingSystem_Init_sys+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_SignalingSystem_Init_sys+1, 0 
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;Signaling.c,87 :: 		sys->SignalQueue[i].Expired=1;
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_Init_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FARG_SignalingSystem_Init_sys+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_SignalingSystem_Init_sys+1, 0 
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;Signaling.c,88 :: 		sys->SignalQueue[i].Fired=0;
	MOVLW       7
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SignalingSystem_Init_i_L0+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FARG_SignalingSystem_Init_sys+0, 0 
	ADDWF       R0, 1 
	MOVF        FARG_SignalingSystem_Init_sys+1, 0 
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;Signaling.c,83 :: 		for(i=0;i<SignalQueueElements;i++)
	INCF        SignalingSystem_Init_i_L0+0, 1 
;Signaling.c,89 :: 		}
	GOTO        L_SignalingSystem_Init30
L_SignalingSystem_Init31:
;Signaling.c,91 :: 		sys->SystemEPOCH=0;
	MOVLW       70
	ADDWF       FARG_SignalingSystem_Init_sys+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_SignalingSystem_Init_sys+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;Signaling.c,92 :: 		}
L_end_SignalingSystem_Init:
	RETURN      0
; end of _SignalingSystem_Init
