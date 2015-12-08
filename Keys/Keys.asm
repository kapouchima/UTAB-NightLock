
_KeysSystem_EPOCH:

;Keys.c,8 :: 		void KeysSystem_EPOCH()
;Keys.c,10 :: 		if(DebouncingCounter>0) DebouncingCounter=DebouncingCounter-1;
	MOVF        _DebouncingCounter+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_KeysSystem_EPOCH0
	DECF        _DebouncingCounter+0, 1 
L_KeysSystem_EPOCH0:
;Keys.c,11 :: 		if(RepeatCounter>0) RepeatCounter=RepeatCounter-1;
	MOVF        _RepeatCounter+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_KeysSystem_EPOCH1
	DECF        _RepeatCounter+0, 1 
L_KeysSystem_EPOCH1:
;Keys.c,12 :: 		}
L_end_KeysSystem_EPOCH:
	RETURN      0
; end of _KeysSystem_EPOCH

_KeysSystem_Task:

;Keys.c,18 :: 		char KeysSystem_Task()
;Keys.c,20 :: 		char val=0,res=0;
	CLRF        KeysSystem_Task_val_L0+0 
	CLRF        KeysSystem_Task_res_L0+0 
;Keys.c,22 :: 		val.b0=Key1;
	BTFSC       PORTD+0, 1 
	GOTO        L__KeysSystem_Task62
	BSF         KeysSystem_Task_val_L0+0, 0 
	GOTO        L__KeysSystem_Task63
L__KeysSystem_Task62:
	BCF         KeysSystem_Task_val_L0+0, 0 
L__KeysSystem_Task63:
;Keys.c,26 :: 		val.b1=Key2;
	BTFSC       PORTD+0, 6 
	GOTO        L__KeysSystem_Task64
	BSF         KeysSystem_Task_val_L0+0, 1 
	GOTO        L__KeysSystem_Task65
L__KeysSystem_Task64:
	BCF         KeysSystem_Task_val_L0+0, 1 
L__KeysSystem_Task65:
;Keys.c,30 :: 		val.b2=Key3;
	BTFSC       PORTC+0, 6 
	GOTO        L__KeysSystem_Task66
	BSF         KeysSystem_Task_val_L0+0, 2 
	GOTO        L__KeysSystem_Task67
L__KeysSystem_Task66:
	BCF         KeysSystem_Task_val_L0+0, 2 
L__KeysSystem_Task67:
;Keys.c,34 :: 		val.b3=Key4;
	BTFSC       PORTD+0, 4 
	GOTO        L__KeysSystem_Task68
	BSF         KeysSystem_Task_val_L0+0, 3 
	GOTO        L__KeysSystem_Task69
L__KeysSystem_Task68:
	BCF         KeysSystem_Task_val_L0+0, 3 
L__KeysSystem_Task69:
;Keys.c,38 :: 		val.b4=Key5;
	BTFSC       PORTD+0, 5 
	GOTO        L__KeysSystem_Task70
	BSF         KeysSystem_Task_val_L0+0, 4 
	GOTO        L__KeysSystem_Task71
L__KeysSystem_Task70:
	BCF         KeysSystem_Task_val_L0+0, 4 
L__KeysSystem_Task71:
;Keys.c,54 :: 		switch(SystemState)
	GOTO        L_KeysSystem_Task2
;Keys.c,56 :: 		case 0:
L_KeysSystem_Task4:
;Keys.c,57 :: 		if((val!=0) && (DebouncingCounter==0)){res=val;DebouncingCounter=DebouncingCycles;RepeatCounter=StartRepeatCycles;SystemState=1;PrevVal=val;}
	MOVF        KeysSystem_Task_val_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_KeysSystem_Task7
	MOVF        _DebouncingCounter+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_KeysSystem_Task7
L__KeysSystem_Task59:
	MOVF        KeysSystem_Task_val_L0+0, 0 
	MOVWF       KeysSystem_Task_res_L0+0 
	MOVLW       10
	MOVWF       _DebouncingCounter+0 
	MOVLW       250
	MOVWF       _RepeatCounter+0 
	MOVLW       1
	MOVWF       _SystemState+0 
	MOVF        KeysSystem_Task_val_L0+0, 0 
	MOVWF       _PrevVal+0 
L_KeysSystem_Task7:
;Keys.c,58 :: 		break;
	GOTO        L_KeysSystem_Task3
;Keys.c,60 :: 		case 1:
L_KeysSystem_Task8:
;Keys.c,61 :: 		if((DebouncingCounter==0) && (val == 0)){res=0;PrevVal=0;DebouncingCounter=DebouncingCycles;SystemState=0;}
	MOVF        _DebouncingCounter+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_KeysSystem_Task11
	MOVF        KeysSystem_Task_val_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_KeysSystem_Task11
L__KeysSystem_Task58:
	CLRF        KeysSystem_Task_res_L0+0 
	CLRF        _PrevVal+0 
	MOVLW       10
	MOVWF       _DebouncingCounter+0 
	CLRF        _SystemState+0 
L_KeysSystem_Task11:
;Keys.c,62 :: 		if((DebouncingCounter==0) && (val == PrevVal) && (RepeatCounter == 0)){res=val,SystemState=2;RepeatCounter=SlowRepeatCycles;RepeatNoCounter=SlowRepeatCount;}
	MOVF        _DebouncingCounter+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_KeysSystem_Task14
	MOVF        KeysSystem_Task_val_L0+0, 0 
	XORWF       _PrevVal+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_KeysSystem_Task14
	MOVF        _RepeatCounter+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_KeysSystem_Task14
L__KeysSystem_Task57:
	MOVF        KeysSystem_Task_val_L0+0, 0 
	MOVWF       KeysSystem_Task_res_L0+0 
	MOVLW       2
	MOVWF       _SystemState+0 
	MOVLW       50
	MOVWF       _RepeatCounter+0 
	MOVLW       50
	MOVWF       _RepeatNoCounter+0 
L_KeysSystem_Task14:
;Keys.c,63 :: 		if((DebouncingCounter==0) && (val != PrevVal) && (val != 0)){res=val;PrevVal=val;DebouncingCounter=DebouncingCycles;}
	MOVF        _DebouncingCounter+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_KeysSystem_Task17
	MOVF        KeysSystem_Task_val_L0+0, 0 
	XORWF       _PrevVal+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_KeysSystem_Task17
	MOVF        KeysSystem_Task_val_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_KeysSystem_Task17
L__KeysSystem_Task56:
	MOVF        KeysSystem_Task_val_L0+0, 0 
	MOVWF       KeysSystem_Task_res_L0+0 
	MOVF        KeysSystem_Task_val_L0+0, 0 
	MOVWF       _PrevVal+0 
	MOVLW       10
	MOVWF       _DebouncingCounter+0 
L_KeysSystem_Task17:
;Keys.c,64 :: 		break;
	GOTO        L_KeysSystem_Task3
;Keys.c,66 :: 		case 2:
L_KeysSystem_Task18:
;Keys.c,67 :: 		if((val == PrevVal) && (RepeatCounter == 0) && (RepeatNoCounter > 0)){res=val;RepeatCounter=SlowRepeatCycles;RepeatNoCounter=RepeatNoCounter-1;}
	MOVF        KeysSystem_Task_val_L0+0, 0 
	XORWF       _PrevVal+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_KeysSystem_Task21
	MOVF        _RepeatCounter+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_KeysSystem_Task21
	MOVF        _RepeatNoCounter+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_KeysSystem_Task21
L__KeysSystem_Task55:
	MOVF        KeysSystem_Task_val_L0+0, 0 
	MOVWF       KeysSystem_Task_res_L0+0 
	MOVLW       50
	MOVWF       _RepeatCounter+0 
	DECF        _RepeatNoCounter+0, 1 
L_KeysSystem_Task21:
;Keys.c,68 :: 		if((val == PrevVal) && (RepeatCounter == 0) && (RepeatNoCounter == 0)){res=val;RepeatCounter=MidRepeatCycles;RepeatNoCounter=MidRepeatCount;SystemState=3;}
	MOVF        KeysSystem_Task_val_L0+0, 0 
	XORWF       _PrevVal+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_KeysSystem_Task24
	MOVF        _RepeatCounter+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_KeysSystem_Task24
	MOVF        _RepeatNoCounter+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_KeysSystem_Task24
L__KeysSystem_Task54:
	MOVF        KeysSystem_Task_val_L0+0, 0 
	MOVWF       KeysSystem_Task_res_L0+0 
	MOVLW       50
	MOVWF       _RepeatCounter+0 
	MOVLW       50
	MOVWF       _RepeatNoCounter+0 
	MOVLW       3
	MOVWF       _SystemState+0 
L_KeysSystem_Task24:
;Keys.c,69 :: 		if((val != PrevVal) && (val != 0)){res=val;PrevVal=val;DebouncingCounter=DebouncingCycles;RepeatCounter=StartRepeatCycles;SystemState=1;}
	MOVF        KeysSystem_Task_val_L0+0, 0 
	XORWF       _PrevVal+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_KeysSystem_Task27
	MOVF        KeysSystem_Task_val_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_KeysSystem_Task27
L__KeysSystem_Task53:
	MOVF        KeysSystem_Task_val_L0+0, 0 
	MOVWF       KeysSystem_Task_res_L0+0 
	MOVF        KeysSystem_Task_val_L0+0, 0 
	MOVWF       _PrevVal+0 
	MOVLW       10
	MOVWF       _DebouncingCounter+0 
	MOVLW       250
	MOVWF       _RepeatCounter+0 
	MOVLW       1
	MOVWF       _SystemState+0 
L_KeysSystem_Task27:
;Keys.c,70 :: 		if(val == 0){res=0;PrevVal=0;DebouncingCounter=DebouncingCycles;SystemState=0;}
	MOVF        KeysSystem_Task_val_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_KeysSystem_Task28
	CLRF        KeysSystem_Task_res_L0+0 
	CLRF        _PrevVal+0 
	MOVLW       10
	MOVWF       _DebouncingCounter+0 
	CLRF        _SystemState+0 
L_KeysSystem_Task28:
;Keys.c,71 :: 		break;
	GOTO        L_KeysSystem_Task3
;Keys.c,73 :: 		case 3:
L_KeysSystem_Task29:
;Keys.c,74 :: 		if((val == PrevVal) && (RepeatCounter == 0) && (RepeatNoCounter > 0)){res=val;RepeatCounter=MidRepeatCycles;RepeatNoCounter=RepeatNoCounter-1;}
	MOVF        KeysSystem_Task_val_L0+0, 0 
	XORWF       _PrevVal+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_KeysSystem_Task32
	MOVF        _RepeatCounter+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_KeysSystem_Task32
	MOVF        _RepeatNoCounter+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_KeysSystem_Task32
L__KeysSystem_Task52:
	MOVF        KeysSystem_Task_val_L0+0, 0 
	MOVWF       KeysSystem_Task_res_L0+0 
	MOVLW       50
	MOVWF       _RepeatCounter+0 
	DECF        _RepeatNoCounter+0, 1 
L_KeysSystem_Task32:
;Keys.c,75 :: 		if((val == PrevVal) && (RepeatCounter == 0) && (RepeatNoCounter == 0)){res=val;RepeatCounter=FastRepeatCycles;SystemState=4;}
	MOVF        KeysSystem_Task_val_L0+0, 0 
	XORWF       _PrevVal+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_KeysSystem_Task35
	MOVF        _RepeatCounter+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_KeysSystem_Task35
	MOVF        _RepeatNoCounter+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_KeysSystem_Task35
L__KeysSystem_Task51:
	MOVF        KeysSystem_Task_val_L0+0, 0 
	MOVWF       KeysSystem_Task_res_L0+0 
	MOVLW       50
	MOVWF       _RepeatCounter+0 
	MOVLW       4
	MOVWF       _SystemState+0 
L_KeysSystem_Task35:
;Keys.c,76 :: 		if((val != PrevVal) && (val != 0)){res=val;PrevVal=val;DebouncingCounter=DebouncingCycles;RepeatCounter=StartRepeatCycles;SystemState=1;}
	MOVF        KeysSystem_Task_val_L0+0, 0 
	XORWF       _PrevVal+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_KeysSystem_Task38
	MOVF        KeysSystem_Task_val_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_KeysSystem_Task38
L__KeysSystem_Task50:
	MOVF        KeysSystem_Task_val_L0+0, 0 
	MOVWF       KeysSystem_Task_res_L0+0 
	MOVF        KeysSystem_Task_val_L0+0, 0 
	MOVWF       _PrevVal+0 
	MOVLW       10
	MOVWF       _DebouncingCounter+0 
	MOVLW       250
	MOVWF       _RepeatCounter+0 
	MOVLW       1
	MOVWF       _SystemState+0 
L_KeysSystem_Task38:
;Keys.c,77 :: 		if(val == 0){res=0;PrevVal=0;DebouncingCounter=DebouncingCycles;SystemState=0;}
	MOVF        KeysSystem_Task_val_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_KeysSystem_Task39
	CLRF        KeysSystem_Task_res_L0+0 
	CLRF        _PrevVal+0 
	MOVLW       10
	MOVWF       _DebouncingCounter+0 
	CLRF        _SystemState+0 
L_KeysSystem_Task39:
;Keys.c,78 :: 		break;
	GOTO        L_KeysSystem_Task3
;Keys.c,80 :: 		case 4:
L_KeysSystem_Task40:
;Keys.c,81 :: 		if((val == PrevVal) && (RepeatCounter == 0)){res=val;RepeatCounter=FastRepeatCycles;}
	MOVF        KeysSystem_Task_val_L0+0, 0 
	XORWF       _PrevVal+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_KeysSystem_Task43
	MOVF        _RepeatCounter+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_KeysSystem_Task43
L__KeysSystem_Task49:
	MOVF        KeysSystem_Task_val_L0+0, 0 
	MOVWF       KeysSystem_Task_res_L0+0 
	MOVLW       50
	MOVWF       _RepeatCounter+0 
L_KeysSystem_Task43:
;Keys.c,82 :: 		if((val != PrevVal) && (val != 0)){res=val;PrevVal=val;DebouncingCounter=DebouncingCycles;RepeatCounter=StartRepeatCycles;SystemState=1;}
	MOVF        KeysSystem_Task_val_L0+0, 0 
	XORWF       _PrevVal+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_KeysSystem_Task46
	MOVF        KeysSystem_Task_val_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_KeysSystem_Task46
L__KeysSystem_Task48:
	MOVF        KeysSystem_Task_val_L0+0, 0 
	MOVWF       KeysSystem_Task_res_L0+0 
	MOVF        KeysSystem_Task_val_L0+0, 0 
	MOVWF       _PrevVal+0 
	MOVLW       10
	MOVWF       _DebouncingCounter+0 
	MOVLW       250
	MOVWF       _RepeatCounter+0 
	MOVLW       1
	MOVWF       _SystemState+0 
L_KeysSystem_Task46:
;Keys.c,83 :: 		if(val == 0){res=0;PrevVal=0;DebouncingCounter=DebouncingCycles;SystemState=0;}
	MOVF        KeysSystem_Task_val_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_KeysSystem_Task47
	CLRF        KeysSystem_Task_res_L0+0 
	CLRF        _PrevVal+0 
	MOVLW       10
	MOVWF       _DebouncingCounter+0 
	CLRF        _SystemState+0 
L_KeysSystem_Task47:
;Keys.c,84 :: 		break;
	GOTO        L_KeysSystem_Task3
;Keys.c,85 :: 		}
L_KeysSystem_Task2:
	MOVF        _SystemState+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_KeysSystem_Task4
	MOVF        _SystemState+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_KeysSystem_Task8
	MOVF        _SystemState+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_KeysSystem_Task18
	MOVF        _SystemState+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_KeysSystem_Task29
	MOVF        _SystemState+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_KeysSystem_Task40
L_KeysSystem_Task3:
;Keys.c,87 :: 		return res;
	MOVF        KeysSystem_Task_res_L0+0, 0 
	MOVWF       R0 
;Keys.c,88 :: 		}
L_end_KeysSystem_Task:
	RETURN      0
; end of _KeysSystem_Task
