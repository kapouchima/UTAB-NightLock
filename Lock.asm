
_Init:

;Lock.c,71 :: 		void Init()
;Lock.c,74 :: 		OSCCON=0b01100000;
	MOVLW       96
	MOVWF       OSCCON+0 
;Lock.c,75 :: 		OSCTUNE.PLLEN=1;
	BSF         OSCTUNE+0, 6 
;Lock.c,77 :: 		ANCON0=0;
	CLRF        ANCON0+0 
;Lock.c,78 :: 		ANCON1=0;
	CLRF        ANCON1+0 
;Lock.c,80 :: 		porta=0;
	CLRF        PORTA+0 
;Lock.c,81 :: 		portb=0;
	CLRF        PORTB+0 
;Lock.c,82 :: 		portc=0;
	CLRF        PORTC+0 
;Lock.c,83 :: 		portd=0;
	CLRF        PORTD+0 
;Lock.c,84 :: 		porte=0;
	CLRF        PORTE+0 
;Lock.c,85 :: 		trisa=0b00111110;
	MOVLW       62
	MOVWF       TRISA+0 
;Lock.c,86 :: 		trisb=0b11110000;
	MOVLW       240
	MOVWF       TRISB+0 
;Lock.c,87 :: 		trisc=0b01100010;
	MOVLW       98
	MOVWF       TRISC+0 
;Lock.c,88 :: 		trisd=0b01110010;
	MOVLW       114
	MOVWF       TRISD+0 
;Lock.c,89 :: 		trise=0b1000;
	MOVLW       8
	MOVWF       TRISE+0 
;Lock.c,91 :: 		TMR0H=0xFC;
	MOVLW       252
	MOVWF       TMR0H+0 
;Lock.c,92 :: 		TMR0L=0x17;
	MOVLW       23
	MOVWF       TMR0L+0 
;Lock.c,93 :: 		T0CON=0b10000011;
	MOVLW       131
	MOVWF       T0CON+0 
;Lock.c,94 :: 		TMR0IE_bit=1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;Lock.c,95 :: 		TMR0IF_bit=0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;Lock.c,96 :: 		GIE_bit=1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;Lock.c,98 :: 		I2C1_Init(50000);
	MOVLW       160
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;Lock.c,100 :: 		SignalingSystem_Init(&SigSys);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_Init+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_Init+1 
	CALL        _SignalingSystem_Init+0, 0
;Lock.c,102 :: 		LoadConfig();
	CALL        _LoadConfig+0, 0
;Lock.c,104 :: 		}
L_end_Init:
	RETURN      0
; end of _Init

_interrupt:

;Lock.c,118 :: 		void interrupt()
;Lock.c,120 :: 		if(TMR0IF_bit)
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_interrupt0
;Lock.c,122 :: 		TMR0H=0xFC;
	MOVLW       252
	MOVWF       TMR0H+0 
;Lock.c,123 :: 		TMR0L=0x17;
	MOVLW       23
	MOVWF       TMR0L+0 
;Lock.c,124 :: 		Flag10ms=1;
	MOVLW       1
	MOVWF       _Flag10ms+0 
;Lock.c,125 :: 		if(Counter10ms<250)
	MOVLW       250
	SUBWF       _Counter10ms+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_interrupt1
;Lock.c,126 :: 		{Counter10ms=Counter10ms+1;}
	INCF        _Counter10ms+0, 1 
	GOTO        L_interrupt2
L_interrupt1:
;Lock.c,128 :: 		{Counter10ms=0; Flag500ms=1;}
	CLRF        _Counter10ms+0 
	MOVLW       1
	MOVWF       _Flag500ms+0 
L_interrupt2:
;Lock.c,129 :: 		TMR0IF_bit=0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;Lock.c,130 :: 		}
L_interrupt0:
;Lock.c,131 :: 		}
L_end_interrupt:
L__interrupt208:
	RETFIE      1
; end of _interrupt

_main:

;Lock.c,149 :: 		void main() {
;Lock.c,156 :: 		Init();
	CALL        _Init+0, 0
;Lock.c,161 :: 		for(i=0;i<3;i++)
	CLRF        main_i_L0+0 
L_main3:
	MOVLW       3
	SUBWF       main_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main4
;Lock.c,163 :: 		LED1=1;
	BSF         PORTD+0, 7 
;Lock.c,164 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	DECFSZ      R11, 1, 1
	BRA         L_main6
;Lock.c,165 :: 		LED1=0;
	BCF         PORTD+0, 7 
;Lock.c,166 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
	DECFSZ      R11, 1, 1
	BRA         L_main7
;Lock.c,161 :: 		for(i=0;i<3;i++)
	INCF        main_i_L0+0, 1 
;Lock.c,167 :: 		}
	GOTO        L_main3
L_main4:
;Lock.c,173 :: 		while(1)
L_main8:
;Lock.c,176 :: 		if(Flag10ms)
	MOVF        _Flag10ms+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
;Lock.c,178 :: 		KeysSystem_EPOCH();
	CALL        _KeysSystem_EPOCH+0, 0
;Lock.c,179 :: 		SevenSegmentManager_Task(&Segment);
	MOVLW       _Segment+0
	MOVWF       FARG_SevenSegmentManager_Task+0 
	MOVLW       hi_addr(_Segment+0)
	MOVWF       FARG_SevenSegmentManager_Task+1 
	CALL        _SevenSegmentManager_Task+0, 0
;Lock.c,180 :: 		Flag10ms=0;
	CLRF        _Flag10ms+0 
;Lock.c,181 :: 		}
L_main10:
;Lock.c,183 :: 		if(Flag500ms)
	MOVF        _Flag500ms+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
;Lock.c,185 :: 		if(MenuExpireCounter > 0)
	MOVF        _MenuExpireCounter+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main12
;Lock.c,186 :: 		MenuExpireCounter=MenuExpireCounter-1;
	DECF        _MenuExpireCounter+0, 1 
L_main12:
;Lock.c,187 :: 		if(State==0)
	MOVF        _State+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main13
;Lock.c,188 :: 		{CenterFlash=!CenterFlash;}
	MOVF        _CenterFlash+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _CenterFlash+0 
	GOTO        L_main14
L_main13:
;Lock.c,190 :: 		{CenterFlash=1;}
	MOVLW       1
	MOVWF       _CenterFlash+0 
L_main14:
;Lock.c,191 :: 		SignalingSystem_SystemEPOCH(&SigSys);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_SystemEPOCH+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_SystemEPOCH+1 
	CALL        _SignalingSystem_SystemEPOCH+0, 0
;Lock.c,192 :: 		SignalingSystem_Task(&SigSys);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_Task+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_Task+1 
	CALL        _SignalingSystem_Task+0, 0
;Lock.c,193 :: 		GetTime(&Now);
	MOVLW       _Now+0
	MOVWF       FARG_GetTime_t+0 
	MOVLW       hi_addr(_Now+0)
	MOVWF       FARG_GetTime_t+1 
	CALL        _GetTime+0, 0
;Lock.c,194 :: 		LED1=Now.SecondBCD%2;
	MOVLW       1
	ANDWF       _Now+0, 0 
	MOVWF       R0 
	BTFSC       R0, 0 
	GOTO        L__main210
	BCF         PORTD+0, 7 
	GOTO        L__main211
L__main210:
	BSF         PORTD+0, 7 
L__main211:
;Lock.c,195 :: 		LED2=LED1;
	BTFSC       PORTD+0, 7 
	GOTO        L__main212
	BCF         PORTC+0, 7 
	GOTO        L__main213
L__main212:
	BSF         PORTC+0, 7 
L__main213:
;Lock.c,196 :: 		Flag500ms=0;
	CLRF        _Flag500ms+0 
;Lock.c,197 :: 		}
L_main11:
;Lock.c,199 :: 		Keys=KeysSystem_Task();
	CALL        _KeysSystem_Task+0, 0
	MOVF        R0, 0 
	MOVWF       _Keys+0 
;Lock.c,200 :: 		StateManager();
	CALL        _StateManager+0, 0
;Lock.c,201 :: 		LockManager();
	CALL        _LockManager+0, 0
;Lock.c,202 :: 		MotorManager();
	CALL        _MotorManager+0, 0
;Lock.c,203 :: 		}
	GOTO        L_main8
;Lock.c,204 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_LockManager:

;Lock.c,224 :: 		void LockManager()
;Lock.c,226 :: 		if(GetDesireStatus()) //Should be locked
	CALL        _GetDesireStatus+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LockManager15
;Lock.c,227 :: 		if(StateOfNow!=1)     // Is unlocked
	MOVF        _StateOfNow+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_LockManager16
;Lock.c,229 :: 		SignalingSystem_AddSignal(&SigSys,1,2);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVLW       1
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       0
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVWF       FARG_SignalingSystem_AddSignal+2 
	MOVWF       FARG_SignalingSystem_AddSignal+3 
	MOVLW       2
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	CALL        _SignalingSystem_AddSignal+0, 0
;Lock.c,230 :: 		SignalingSystem_AddSignal(&SigSys,1+MotorActionTime,3);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVLW       5
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       0
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVWF       FARG_SignalingSystem_AddSignal+2 
	MOVWF       FARG_SignalingSystem_AddSignal+3 
	MOVLW       3
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	CALL        _SignalingSystem_AddSignal+0, 0
;Lock.c,231 :: 		StateOfNow=1;
	MOVLW       1
	MOVWF       _StateOfNow+0 
;Lock.c,232 :: 		}
L_LockManager16:
L_LockManager15:
;Lock.c,234 :: 		if(!GetDesireStatus()) //Should be unlocked
	CALL        _GetDesireStatus+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_LockManager17
;Lock.c,235 :: 		if(StateOfNow!=0)     // Is locked
	MOVF        _StateOfNow+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LockManager18
;Lock.c,237 :: 		SignalingSystem_AddSignal(&SigSys,1,1);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVLW       1
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       0
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVWF       FARG_SignalingSystem_AddSignal+2 
	MOVWF       FARG_SignalingSystem_AddSignal+3 
	MOVLW       1
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	CALL        _SignalingSystem_AddSignal+0, 0
;Lock.c,238 :: 		SignalingSystem_AddSignal(&SigSys,1+MotorActionTime,3);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVLW       5
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       0
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVWF       FARG_SignalingSystem_AddSignal+2 
	MOVWF       FARG_SignalingSystem_AddSignal+3 
	MOVLW       3
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	CALL        _SignalingSystem_AddSignal+0, 0
;Lock.c,239 :: 		StateOfNow=0;
	CLRF        _StateOfNow+0 
;Lock.c,240 :: 		}
L_LockManager18:
L_LockManager17:
;Lock.c,242 :: 		}
L_end_LockManager:
	RETURN      0
; end of _LockManager

_StateManager:

;Lock.c,267 :: 		void StateManager()
;Lock.c,270 :: 		if(MenuExpireCounter == 0)
	MOVF        _MenuExpireCounter+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_StateManager19
;Lock.c,271 :: 		{if(State!=0)LoadConfig();State=0;}
	MOVF        _State+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager20
	CALL        _LoadConfig+0, 0
L_StateManager20:
	CLRF        _State+0 
L_StateManager19:
;Lock.c,273 :: 		switch(State)
	GOTO        L_StateManager21
;Lock.c,275 :: 		case 0:
L_StateManager23:
;Lock.c,276 :: 		State0();break;
	CALL        _State0+0, 0
	GOTO        L_StateManager22
;Lock.c,278 :: 		case 1:
L_StateManager24:
;Lock.c,279 :: 		State1();break;
	CALL        _State1+0, 0
	GOTO        L_StateManager22
;Lock.c,281 :: 		case 2:
L_StateManager25:
;Lock.c,282 :: 		State2();break;
	CALL        _State2+0, 0
	GOTO        L_StateManager22
;Lock.c,284 :: 		case 3:
L_StateManager26:
;Lock.c,285 :: 		State3();break;
	CALL        _State3+0, 0
	GOTO        L_StateManager22
;Lock.c,287 :: 		case 10:
L_StateManager27:
;Lock.c,288 :: 		Menu0();break;
	CALL        _Menu0+0, 0
	GOTO        L_StateManager22
;Lock.c,290 :: 		case 11:
L_StateManager28:
;Lock.c,291 :: 		Menu1();break;
	CALL        _Menu1+0, 0
	GOTO        L_StateManager22
;Lock.c,293 :: 		}
L_StateManager21:
	MOVF        _State+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager23
	MOVF        _State+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager24
	MOVF        _State+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager25
	MOVF        _State+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager26
	MOVF        _State+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager27
	MOVF        _State+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager28
L_StateManager22:
;Lock.c,294 :: 		}
L_end_StateManager:
	RETURN      0
; end of _StateManager

_State0:

;Lock.c,308 :: 		void State0()
;Lock.c,311 :: 		Segment.Display[0]=12;Segment.Display[1]=12;Segment.Display[2]=12;Segment.Display[3]=12;
	MOVLW       12
	MOVWF       _Segment+0 
	MOVLW       12
	MOVWF       _Segment+1 
	MOVLW       12
	MOVWF       _Segment+2 
	MOVLW       12
	MOVWF       _Segment+3 
;Lock.c,312 :: 		if((CheckKey('U')) || (CheckKey('D')))
	MOVLW       85
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State0196
	MOVLW       68
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State0196
	GOTO        L_State031
L__State0196:
;Lock.c,313 :: 		{PassCounter=0;Pass[0]=0;Pass[1]=0;Pass[2]=0;Pass[3]=0;MenuExpireCounter=MenuExpire;State=1;}
	CLRF        _PassCounter+0 
	CLRF        _Pass+0 
	CLRF        _Pass+1 
	CLRF        _Pass+2 
	CLRF        _Pass+3 
	MOVLW       30
	MOVWF       _MenuExpireCounter+0 
	MOVLW       1
	MOVWF       _State+0 
L_State031:
;Lock.c,315 :: 		if((CheckKey('L')) && (CheckKey('R')))
	MOVLW       76
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State034
	MOVLW       82
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State034
L__State0195:
;Lock.c,316 :: 		{RTL.b0=!RTL.b0; EEPROM_Write(16,RTL);}
	BTG         _RTL+0, 0 
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _RTL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
L_State034:
;Lock.c,318 :: 		if(CheckKey('C'))
	MOVLW       67
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State035
;Lock.c,319 :: 		{PassCounter=0;Pass[0]=0;Pass[1]=0;Pass[2]=0;Pass[3]=0;MenuExpireCounter=MenuExpire;State=3;}
	CLRF        _PassCounter+0 
	CLRF        _Pass+0 
	CLRF        _Pass+1 
	CLRF        _Pass+2 
	CLRF        _Pass+3 
	MOVLW       30
	MOVWF       _MenuExpireCounter+0 
	MOVLW       3
	MOVWF       _State+0 
L_State035:
;Lock.c,321 :: 		}
L_end_State0:
	RETURN      0
; end of _State0

_State1:

;Lock.c,337 :: 		void State1()
;Lock.c,339 :: 		if(CheckKey('U'))
	MOVLW       85
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State136
;Lock.c,340 :: 		if(Pass[PassCounter] < 9) Pass[PassCounter]=Pass[PassCounter]+1;
	MOVLW       _Pass+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_Pass+0)
	MOVWF       FSR0H 
	MOVF        _PassCounter+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVLW       9
	SUBWF       POSTINC0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_State137
	MOVLW       _Pass+0
	MOVWF       R1 
	MOVLW       hi_addr(_Pass+0)
	MOVWF       R2 
	MOVF        _PassCounter+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_State137:
L_State136:
;Lock.c,342 :: 		if(CheckKey('D'))
	MOVLW       68
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State138
;Lock.c,343 :: 		if(Pass[PassCounter] > 0) Pass[PassCounter]=Pass[PassCounter]-1;
	MOVLW       _Pass+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_Pass+0)
	MOVWF       FSR0H 
	MOVF        _PassCounter+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_State139
	MOVLW       _Pass+0
	MOVWF       R1 
	MOVLW       hi_addr(_Pass+0)
	MOVWF       R2 
	MOVF        _PassCounter+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	DECF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_State139:
L_State138:
;Lock.c,345 :: 		if(CheckKey('L'))
	MOVLW       76
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State140
;Lock.c,346 :: 		if(PassCounter > 0) PassCounter=PassCounter-1;
	MOVF        _PassCounter+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_State141
	DECF        _PassCounter+0, 1 
L_State141:
L_State140:
;Lock.c,348 :: 		if(CheckKey('R'))
	MOVLW       82
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State142
;Lock.c,349 :: 		if(PassCounter < 3) PassCounter=PassCounter+1;
	MOVLW       3
	SUBWF       _PassCounter+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_State143
	INCF        _PassCounter+0, 1 
L_State143:
L_State142:
;Lock.c,351 :: 		if(CheckKey('C'))
	MOVLW       67
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State144
;Lock.c,352 :: 		State=2;
	MOVLW       2
	MOVWF       _State+0 
L_State144:
;Lock.c,354 :: 		Segment.Display[0]=Pass[0];Segment.Display[1]=Pass[1];Segment.Display[2]=Pass[2];Segment.Display[3]=Pass[3];
	MOVF        _Pass+0, 0 
	MOVWF       _Segment+0 
	MOVF        _Pass+1, 0 
	MOVWF       _Segment+1 
	MOVF        _Pass+2, 0 
	MOVWF       _Segment+2 
	MOVF        _Pass+3, 0 
	MOVWF       _Segment+3 
;Lock.c,356 :: 		}
L_end_State1:
	RETURN      0
; end of _State1

_State2:

;Lock.c,372 :: 		void State2()
;Lock.c,374 :: 		if((Pass[0]==OpenPass[0]) && (Pass[1]==OpenPass[1]) && (Pass[2]==OpenPass[2]) && (Pass[3]==OpenPass[3]))
	MOVF        _Pass+0, 0 
	XORWF       _OpenPass+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_State247
	MOVF        _Pass+1, 0 
	XORWF       _OpenPass+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_State247
	MOVF        _Pass+2, 0 
	XORWF       _OpenPass+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_State247
	MOVF        _Pass+3, 0 
	XORWF       _OpenPass+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_State247
L__State2197:
;Lock.c,376 :: 		if(GetDesireStatus())
	CALL        _GetDesireStatus+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State248
;Lock.c,378 :: 		SignalingSystem_AddSignal(&SigSys,1,1);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVLW       1
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       0
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVWF       FARG_SignalingSystem_AddSignal+2 
	MOVWF       FARG_SignalingSystem_AddSignal+3 
	MOVLW       1
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	CALL        _SignalingSystem_AddSignal+0, 0
;Lock.c,379 :: 		SignalingSystem_AddSignal(&SigSys,1+MotorActionTime,3);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVLW       5
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       0
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVWF       FARG_SignalingSystem_AddSignal+2 
	MOVWF       FARG_SignalingSystem_AddSignal+3 
	MOVLW       3
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	CALL        _SignalingSystem_AddSignal+0, 0
;Lock.c,380 :: 		SignalingSystem_AddSignal(&SigSys,1+PassUnlockPeriod+MotorActionTime,2);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVLW       25
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       0
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVWF       FARG_SignalingSystem_AddSignal+2 
	MOVWF       FARG_SignalingSystem_AddSignal+3 
	MOVLW       2
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	CALL        _SignalingSystem_AddSignal+0, 0
;Lock.c,381 :: 		SignalingSystem_AddSignal(&SigSys,1+MotorActionTime+PassUnlockPeriod+MotorActionTime,3);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVLW       29
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       0
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVWF       FARG_SignalingSystem_AddSignal+2 
	MOVWF       FARG_SignalingSystem_AddSignal+3 
	MOVLW       3
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	CALL        _SignalingSystem_AddSignal+0, 0
;Lock.c,382 :: 		}
	GOTO        L_State249
L_State248:
;Lock.c,385 :: 		SignalingSystem_AddSignal(&SigSys,1,1);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVLW       1
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       0
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVWF       FARG_SignalingSystem_AddSignal+2 
	MOVWF       FARG_SignalingSystem_AddSignal+3 
	MOVLW       1
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	CALL        _SignalingSystem_AddSignal+0, 0
;Lock.c,386 :: 		SignalingSystem_AddSignal(&SigSys,1+MotorActionTime,3);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVLW       5
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       0
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVWF       FARG_SignalingSystem_AddSignal+2 
	MOVWF       FARG_SignalingSystem_AddSignal+3 
	MOVLW       3
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	CALL        _SignalingSystem_AddSignal+0, 0
;Lock.c,387 :: 		}
L_State249:
;Lock.c,388 :: 		}
L_State247:
;Lock.c,389 :: 		State=0;
	CLRF        _State+0 
;Lock.c,390 :: 		}
L_end_State2:
	RETURN      0
; end of _State2

_State3:

;Lock.c,409 :: 		void State3()
;Lock.c,411 :: 		if(CheckKey('U'))
	MOVLW       85
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State350
;Lock.c,412 :: 		if(Pass[PassCounter] < 9) Pass[PassCounter]=Pass[PassCounter]+1;
	MOVLW       _Pass+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_Pass+0)
	MOVWF       FSR0H 
	MOVF        _PassCounter+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVLW       9
	SUBWF       POSTINC0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_State351
	MOVLW       _Pass+0
	MOVWF       R1 
	MOVLW       hi_addr(_Pass+0)
	MOVWF       R2 
	MOVF        _PassCounter+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_State351:
L_State350:
;Lock.c,414 :: 		if(CheckKey('D'))
	MOVLW       68
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State352
;Lock.c,415 :: 		if(Pass[PassCounter] > 0) Pass[PassCounter]=Pass[PassCounter]-1;
	MOVLW       _Pass+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_Pass+0)
	MOVWF       FSR0H 
	MOVF        _PassCounter+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_State353
	MOVLW       _Pass+0
	MOVWF       R1 
	MOVLW       hi_addr(_Pass+0)
	MOVWF       R2 
	MOVF        _PassCounter+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	DECF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_State353:
L_State352:
;Lock.c,417 :: 		if(CheckKey('L'))
	MOVLW       76
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State354
;Lock.c,418 :: 		if(PassCounter > 0) PassCounter=PassCounter-1;
	MOVF        _PassCounter+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_State355
	DECF        _PassCounter+0, 1 
L_State355:
L_State354:
;Lock.c,420 :: 		if(CheckKey('R'))
	MOVLW       82
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State356
;Lock.c,421 :: 		if(PassCounter < 3) PassCounter=PassCounter+1;
	MOVLW       3
	SUBWF       _PassCounter+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_State357
	INCF        _PassCounter+0, 1 
L_State357:
L_State356:
;Lock.c,423 :: 		if(CheckKey('C'))
	MOVLW       67
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State358
;Lock.c,425 :: 		if((Pass[0]==MenuPass[0]) && (Pass[1]==MenuPass[1]) && (Pass[2]==MenuPass[2]) && (Pass[3]==MenuPass[3]))
	MOVF        _Pass+0, 0 
	XORWF       _MenuPass+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_State361
	MOVF        _Pass+1, 0 
	XORWF       _MenuPass+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_State361
	MOVF        _Pass+2, 0 
	XORWF       _MenuPass+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_State361
	MOVF        _Pass+3, 0 
	XORWF       _MenuPass+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_State361
L__State3198:
;Lock.c,426 :: 		State=10;
	MOVLW       10
	MOVWF       _State+0 
	GOTO        L_State362
L_State361:
;Lock.c,428 :: 		State=0;
	CLRF        _State+0 
L_State362:
;Lock.c,429 :: 		}
L_State358:
;Lock.c,431 :: 		Segment.Display[0]=Pass[0];Segment.Display[1]=Pass[1];Segment.Display[2]=Pass[2];Segment.Display[3]=Pass[3];
	MOVF        _Pass+0, 0 
	MOVWF       _Segment+0 
	MOVF        _Pass+1, 0 
	MOVWF       _Segment+1 
	MOVF        _Pass+2, 0 
	MOVWF       _Segment+2 
	MOVF        _Pass+3, 0 
	MOVWF       _Segment+3 
;Lock.c,432 :: 		}
L_end_State3:
	RETURN      0
; end of _State3

_Menu0:

;Lock.c,456 :: 		void Menu0()
;Lock.c,458 :: 		Segment.Display[0]=13;Segment.Display[1]=13;Segment.Display[2]=13;Segment.Display[3]=13;
	MOVLW       13
	MOVWF       _Segment+0 
	MOVLW       13
	MOVWF       _Segment+1 
	MOVLW       13
	MOVWF       _Segment+2 
	MOVLW       13
	MOVWF       _Segment+3 
;Lock.c,460 :: 		if(CheckKey('U'))
	MOVLW       85
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu063
;Lock.c,461 :: 		{SetCounter=0;State=11;ValuePosition=0;TempLockTime[0]=LockTime[0];TempLockTime[1]=LockTime[1];TempLockTime[2]=LockTime[2];TempLockTime[3]=LockTime[3];}
	CLRF        _SetCounter+0 
	MOVLW       11
	MOVWF       _State+0 
	CLRF        _ValuePosition+0 
	MOVF        _LockTime+0, 0 
	MOVWF       _TempLockTime+0 
	MOVF        _LockTime+1, 0 
	MOVWF       _TempLockTime+1 
	MOVF        _LockTime+2, 0 
	MOVWF       _TempLockTime+2 
	MOVF        _LockTime+3, 0 
	MOVWF       _TempLockTime+3 
L_Menu063:
;Lock.c,463 :: 		if(CheckKey('D'))
	MOVLW       68
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu064
;Lock.c,464 :: 		{SetCounter=1;State=11;ValuePosition=0;TempUnlockTime[0]=UnlockTime[0];TempUnlockTime[1]=UnlockTime[1];TempUnlockTime[2]=UnlockTime[2];TempUnlockTime[3]=UnlockTime[3];}
	MOVLW       1
	MOVWF       _SetCounter+0 
	MOVLW       11
	MOVWF       _State+0 
	CLRF        _ValuePosition+0 
	MOVF        _UnlockTime+0, 0 
	MOVWF       _TempUnlockTime+0 
	MOVF        _UnlockTime+1, 0 
	MOVWF       _TempUnlockTime+1 
	MOVF        _UnlockTime+2, 0 
	MOVWF       _TempUnlockTime+2 
	MOVF        _UnlockTime+3, 0 
	MOVWF       _TempUnlockTime+3 
L_Menu064:
;Lock.c,466 :: 		if(CheckKey('L'))
	MOVLW       76
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu065
;Lock.c,467 :: 		{TimeTemp[0]=Now.HourBCD>>4;TimeTemp[1]=Now.HourBCD&0x0F;TimeTemp[2]=Now.MinuteBCD>>4;TimeTemp[3]=Now.MinuteBCD&0x0F;SetCounter=2;State=11;ValuePosition=0;}
	MOVF        _Now+2, 0 
	MOVWF       _TimeTemp+0 
	RRCF        _TimeTemp+0, 1 
	BCF         _TimeTemp+0, 7 
	RRCF        _TimeTemp+0, 1 
	BCF         _TimeTemp+0, 7 
	RRCF        _TimeTemp+0, 1 
	BCF         _TimeTemp+0, 7 
	RRCF        _TimeTemp+0, 1 
	BCF         _TimeTemp+0, 7 
	MOVLW       15
	ANDWF       _Now+2, 0 
	MOVWF       _TimeTemp+1 
	MOVF        _Now+1, 0 
	MOVWF       _TimeTemp+2 
	RRCF        _TimeTemp+2, 1 
	BCF         _TimeTemp+2, 7 
	RRCF        _TimeTemp+2, 1 
	BCF         _TimeTemp+2, 7 
	RRCF        _TimeTemp+2, 1 
	BCF         _TimeTemp+2, 7 
	RRCF        _TimeTemp+2, 1 
	BCF         _TimeTemp+2, 7 
	MOVLW       15
	ANDWF       _Now+1, 0 
	MOVWF       _TimeTemp+3 
	MOVLW       2
	MOVWF       _SetCounter+0 
	MOVLW       11
	MOVWF       _State+0 
	CLRF        _ValuePosition+0 
L_Menu065:
;Lock.c,469 :: 		if(CheckKey('R'))
	MOVLW       82
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu066
;Lock.c,470 :: 		{SetCounter=3;State=11;ValuePosition=0;}
	MOVLW       3
	MOVWF       _SetCounter+0 
	MOVLW       11
	MOVWF       _State+0 
	CLRF        _ValuePosition+0 
L_Menu066:
;Lock.c,472 :: 		if(CheckKey('C'))
	MOVLW       67
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu067
;Lock.c,473 :: 		{SetCounter=4;State=11;ValuePosition=0;}
	MOVLW       4
	MOVWF       _SetCounter+0 
	MOVLW       11
	MOVWF       _State+0 
	CLRF        _ValuePosition+0 
L_Menu067:
;Lock.c,474 :: 		}
L_end_Menu0:
	RETURN      0
; end of _Menu0

_Menu1:

;Lock.c,491 :: 		void Menu1()
;Lock.c,493 :: 		switch(SetCounter)
	GOTO        L_Menu168
;Lock.c,495 :: 		case 0:
L_Menu170:
;Lock.c,496 :: 		if(CheckKey('U'))
	MOVLW       85
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu171
;Lock.c,498 :: 		if(ValuePosition==0)if(TempLockTime[0]<2)TempLockTime[0]=TempLockTime[0]+1;
	MOVF        _ValuePosition+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu172
	MOVLW       2
	SUBWF       _TempLockTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu173
	INCF        _TempLockTime+0, 1 
L_Menu173:
L_Menu172:
;Lock.c,499 :: 		if(ValuePosition==2)if(TempLockTime[2]<5)TempLockTime[2]=TempLockTime[2]+1;
	MOVF        _ValuePosition+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu174
	MOVLW       5
	SUBWF       _TempLockTime+2, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu175
	INCF        _TempLockTime+2, 1 
L_Menu175:
L_Menu174:
;Lock.c,500 :: 		if(ValuePosition==1)if(TempLockTime[1]<9)TempLockTime[1]=TempLockTime[1]+1;
	MOVF        _ValuePosition+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu176
	MOVLW       9
	SUBWF       _TempLockTime+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu177
	INCF        _TempLockTime+1, 1 
L_Menu177:
L_Menu176:
;Lock.c,501 :: 		if(ValuePosition==3)if(TempLockTime[3]<9)LockTime[3]=TempLockTime[3]+1;
	MOVF        _ValuePosition+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu178
	MOVLW       9
	SUBWF       _TempLockTime+3, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu179
	MOVF        _TempLockTime+3, 0 
	ADDLW       1
	MOVWF       _LockTime+3 
L_Menu179:
L_Menu178:
;Lock.c,502 :: 		if((TempLockTime[0]>=2)&&(TempLockTime[1]>3))TempLockTime[1]=3;
	MOVLW       2
	SUBWF       _TempLockTime+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Menu182
	MOVF        _TempLockTime+1, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu182
L__Menu1200:
	MOVLW       3
	MOVWF       _TempLockTime+1 
L_Menu182:
;Lock.c,503 :: 		}
L_Menu171:
;Lock.c,505 :: 		if(CheckKey('D'))
	MOVLW       68
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu183
;Lock.c,506 :: 		if(TempLockTime[ValuePosition]>0)TempLockTime[ValuePosition]=TempLockTime[ValuePosition]-1;
	MOVLW       _TempLockTime+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_TempLockTime+0)
	MOVWF       FSR0H 
	MOVF        _ValuePosition+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu184
	MOVLW       _TempLockTime+0
	MOVWF       R1 
	MOVLW       hi_addr(_TempLockTime+0)
	MOVWF       R2 
	MOVF        _ValuePosition+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	DECF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_Menu184:
L_Menu183:
;Lock.c,508 :: 		if(CheckKey('R'))
	MOVLW       82
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu185
;Lock.c,509 :: 		if(ValuePosition<3)ValuePosition=ValuePosition+1;
	MOVLW       3
	SUBWF       _ValuePosition+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu186
	INCF        _ValuePosition+0, 1 
L_Menu186:
L_Menu185:
;Lock.c,511 :: 		if(CheckKey('L'))
	MOVLW       76
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu187
;Lock.c,512 :: 		if(ValuePosition>0)ValuePosition=ValuePosition-1;
	MOVF        _ValuePosition+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu188
	DECF        _ValuePosition+0, 1 
L_Menu188:
L_Menu187:
;Lock.c,514 :: 		if(CheckKey('C'))
	MOVLW       67
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu189
;Lock.c,515 :: 		{LockTime[0]=TempLockTime[0];LockTime[1]=TempLockTime[1];LockTime[2]=TempLockTime[2];LockTime[3]=TempLockTime[3];SaveConfig();State=10;CenterFlash=1;}
	MOVF        _TempLockTime+0, 0 
	MOVWF       _LockTime+0 
	MOVF        _TempLockTime+1, 0 
	MOVWF       _LockTime+1 
	MOVF        _TempLockTime+2, 0 
	MOVWF       _LockTime+2 
	MOVF        _TempLockTime+3, 0 
	MOVWF       _LockTime+3 
	CALL        _SaveConfig+0, 0
	MOVLW       10
	MOVWF       _State+0 
	MOVLW       1
	MOVWF       _CenterFlash+0 
L_Menu189:
;Lock.c,517 :: 		Segment.Display[0]=TempLockTime[0];Segment.Display[1]=TempLockTime[1];Segment.Display[2]=TempLockTime[2];Segment.Display[3]=TempLockTime[3];CenterFlash=0;
	MOVF        _TempLockTime+0, 0 
	MOVWF       _Segment+0 
	MOVF        _TempLockTime+1, 0 
	MOVWF       _Segment+1 
	MOVF        _TempLockTime+2, 0 
	MOVWF       _Segment+2 
	MOVF        _TempLockTime+3, 0 
	MOVWF       _Segment+3 
	CLRF        _CenterFlash+0 
;Lock.c,518 :: 		break;
	GOTO        L_Menu169
;Lock.c,521 :: 		case 1:
L_Menu190:
;Lock.c,522 :: 		if(CheckKey('U'))
	MOVLW       85
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu191
;Lock.c,524 :: 		if(ValuePosition==0)if(TempUnlockTime[0]<2)TempUnlockTime[0]=TempUnlockTime[0]+1;
	MOVF        _ValuePosition+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu192
	MOVLW       2
	SUBWF       _TempUnlockTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu193
	INCF        _TempUnlockTime+0, 1 
L_Menu193:
L_Menu192:
;Lock.c,525 :: 		if(ValuePosition==2)if(TempUnlockTime[0]<5)TempUnlockTime[2]=TempUnlockTime[2]+1;
	MOVF        _ValuePosition+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu194
	MOVLW       5
	SUBWF       _TempUnlockTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu195
	INCF        _TempUnlockTime+2, 1 
L_Menu195:
L_Menu194:
;Lock.c,526 :: 		if(ValuePosition==1)if(TempUnlockTime[1]<9)TempUnlockTime[1]=TempUnlockTime[1]+1;
	MOVF        _ValuePosition+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu196
	MOVLW       9
	SUBWF       _TempUnlockTime+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu197
	INCF        _TempUnlockTime+1, 1 
L_Menu197:
L_Menu196:
;Lock.c,527 :: 		if(ValuePosition==3)if(TempUnlockTime[3]<9)TempUnlockTime[3]=TempUnlockTime[3]+1;
	MOVF        _ValuePosition+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu198
	MOVLW       9
	SUBWF       _TempUnlockTime+3, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu199
	INCF        _TempUnlockTime+3, 1 
L_Menu199:
L_Menu198:
;Lock.c,528 :: 		if((TempUnlockTime[0]>=2)&&(TempUnlockTime[1]>3))TempUnlockTime[1]=3;
	MOVLW       2
	SUBWF       _TempUnlockTime+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Menu1102
	MOVF        _TempUnlockTime+1, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu1102
L__Menu1199:
	MOVLW       3
	MOVWF       _TempUnlockTime+1 
L_Menu1102:
;Lock.c,529 :: 		}
L_Menu191:
;Lock.c,531 :: 		if(CheckKey('D'))
	MOVLW       68
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu1103
;Lock.c,532 :: 		if(TempUnlockTime[ValuePosition]>0)TempUnlockTime[ValuePosition]=TempUnlockTime[ValuePosition]-1;
	MOVLW       _TempUnlockTime+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_TempUnlockTime+0)
	MOVWF       FSR0H 
	MOVF        _ValuePosition+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu1104
	MOVLW       _TempUnlockTime+0
	MOVWF       R1 
	MOVLW       hi_addr(_TempUnlockTime+0)
	MOVWF       R2 
	MOVF        _ValuePosition+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	DECF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_Menu1104:
L_Menu1103:
;Lock.c,534 :: 		if(CheckKey('R'))
	MOVLW       82
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu1105
;Lock.c,535 :: 		if(ValuePosition<3)ValuePosition=ValuePosition+1;
	MOVLW       3
	SUBWF       _ValuePosition+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu1106
	INCF        _ValuePosition+0, 1 
L_Menu1106:
L_Menu1105:
;Lock.c,537 :: 		if(CheckKey('L'))
	MOVLW       76
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu1107
;Lock.c,538 :: 		if(ValuePosition>0)ValuePosition=ValuePosition-1;
	MOVF        _ValuePosition+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu1108
	DECF        _ValuePosition+0, 1 
L_Menu1108:
L_Menu1107:
;Lock.c,540 :: 		if(CheckKey('C'))
	MOVLW       67
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu1109
;Lock.c,541 :: 		{UnlockTime[0]=TempUnlockTime[0];UnlockTime[1]=TempUnlockTime[1];UnlockTime[2]=TempUnlockTime[2];UnlockTime[3]=TempUnlockTime[3];SaveConfig();State=10;CenterFlash=1;}
	MOVF        _TempUnlockTime+0, 0 
	MOVWF       _UnlockTime+0 
	MOVF        _TempUnlockTime+1, 0 
	MOVWF       _UnlockTime+1 
	MOVF        _TempUnlockTime+2, 0 
	MOVWF       _UnlockTime+2 
	MOVF        _TempUnlockTime+3, 0 
	MOVWF       _UnlockTime+3 
	CALL        _SaveConfig+0, 0
	MOVLW       10
	MOVWF       _State+0 
	MOVLW       1
	MOVWF       _CenterFlash+0 
L_Menu1109:
;Lock.c,543 :: 		Segment.Display[0]=TempUnlockTime[0];Segment.Display[1]=TempUnlockTime[1];Segment.Display[2]=TempUnlockTime[2];Segment.Display[3]=TempUnlockTime[3];CenterFlash=0;
	MOVF        _TempUnlockTime+0, 0 
	MOVWF       _Segment+0 
	MOVF        _TempUnlockTime+1, 0 
	MOVWF       _Segment+1 
	MOVF        _TempUnlockTime+2, 0 
	MOVWF       _Segment+2 
	MOVF        _TempUnlockTime+3, 0 
	MOVWF       _Segment+3 
	CLRF        _CenterFlash+0 
;Lock.c,544 :: 		break;
	GOTO        L_Menu169
;Lock.c,547 :: 		case 2:
L_Menu1110:
;Lock.c,548 :: 		if(CheckKey('U'))
	MOVLW       85
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu1111
;Lock.c,550 :: 		if(ValuePosition==0)if(TimeTemp[0]<2)TimeTemp[0]=TimeTemp[0]+1;
	MOVF        _ValuePosition+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu1112
	MOVLW       2
	SUBWF       _TimeTemp+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu1113
	INCF        _TimeTemp+0, 1 
L_Menu1113:
L_Menu1112:
;Lock.c,551 :: 		if(ValuePosition==2)if(TimeTemp[2]<5)TimeTemp[2]=TimeTemp[2]+1;
	MOVF        _ValuePosition+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu1114
	MOVLW       5
	SUBWF       _TimeTemp+2, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu1115
	INCF        _TimeTemp+2, 1 
L_Menu1115:
L_Menu1114:
;Lock.c,552 :: 		if(ValuePosition==1)if(TimeTemp[1]<9)TimeTemp[1]=TimeTemp[1]+1;
	MOVF        _ValuePosition+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu1116
	MOVLW       9
	SUBWF       _TimeTemp+1, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu1117
	INCF        _TimeTemp+1, 1 
L_Menu1117:
L_Menu1116:
;Lock.c,553 :: 		if(ValuePosition==3)if(TimeTemp[3]<9)TimeTemp[3]=TimeTemp[3]+1;
	MOVF        _ValuePosition+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu1118
	MOVLW       9
	SUBWF       _TimeTemp+3, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu1119
	INCF        _TimeTemp+3, 1 
L_Menu1119:
L_Menu1118:
;Lock.c,554 :: 		}
L_Menu1111:
;Lock.c,556 :: 		if(CheckKey('D'))
	MOVLW       68
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu1120
;Lock.c,557 :: 		if(TimeTemp[ValuePosition]>0)TimeTemp[ValuePosition]=TimeTemp[ValuePosition]-1;
	MOVLW       _TimeTemp+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_TimeTemp+0)
	MOVWF       FSR0H 
	MOVF        _ValuePosition+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu1121
	MOVLW       _TimeTemp+0
	MOVWF       R1 
	MOVLW       hi_addr(_TimeTemp+0)
	MOVWF       R2 
	MOVF        _ValuePosition+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	DECF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_Menu1121:
L_Menu1120:
;Lock.c,559 :: 		if(CheckKey('R'))
	MOVLW       82
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu1122
;Lock.c,560 :: 		if(ValuePosition<3)ValuePosition=ValuePosition+1;
	MOVLW       3
	SUBWF       _ValuePosition+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu1123
	INCF        _ValuePosition+0, 1 
L_Menu1123:
L_Menu1122:
;Lock.c,562 :: 		if(CheckKey('L'))
	MOVLW       76
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu1124
;Lock.c,563 :: 		if(ValuePosition>0)ValuePosition=ValuePosition-1;
	MOVF        _ValuePosition+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu1125
	DECF        _ValuePosition+0, 1 
L_Menu1125:
L_Menu1124:
;Lock.c,565 :: 		if(CheckKey('C'))
	MOVLW       67
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu1126
;Lock.c,567 :: 		temp.SecondBCD=0;temp.MinuteBCD=TimeTemp[2]<<4;temp.MinuteBCD=temp.MinuteBCD|TimeTemp[3];
	CLRF        _temp+0 
	MOVF        _TimeTemp+2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       _temp+1 
	MOVF        _TimeTemp+3, 0 
	IORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _temp+1 
;Lock.c,568 :: 		temp.HourBCD=TimeTemp[0]<<4;temp.HourBCD=temp.HourBCD|TimeTemp[1];
	MOVF        _TimeTemp+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       _temp+2 
	MOVF        _TimeTemp+1, 0 
	IORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _temp+2 
;Lock.c,569 :: 		SetTime(&temp);
	MOVLW       _temp+0
	MOVWF       FARG_SetTime_t+0 
	MOVLW       hi_addr(_temp+0)
	MOVWF       FARG_SetTime_t+1 
	CALL        _SetTime+0, 0
;Lock.c,570 :: 		State=10;
	MOVLW       10
	MOVWF       _State+0 
;Lock.c,571 :: 		CenterFlash=1;
	MOVLW       1
	MOVWF       _CenterFlash+0 
;Lock.c,572 :: 		}
L_Menu1126:
;Lock.c,574 :: 		Segment.Display[0]=TimeTemp[0];Segment.Display[1]=TimeTemp[1];Segment.Display[2]=TimeTemp[2];Segment.Display[3]=TimeTemp[3];CenterFlash=0;
	MOVF        _TimeTemp+0, 0 
	MOVWF       _Segment+0 
	MOVF        _TimeTemp+1, 0 
	MOVWF       _Segment+1 
	MOVF        _TimeTemp+2, 0 
	MOVWF       _Segment+2 
	MOVF        _TimeTemp+3, 0 
	MOVWF       _Segment+3 
	CLRF        _CenterFlash+0 
;Lock.c,575 :: 		break;
	GOTO        L_Menu169
;Lock.c,577 :: 		case 3:
L_Menu1127:
;Lock.c,578 :: 		if(CheckKey('U'))
	MOVLW       85
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu1128
;Lock.c,579 :: 		if(OpenPass[ValuePosition]<9)OpenPass[ValuePosition]=OpenPass[ValuePosition]+1;
	MOVLW       _OpenPass+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_OpenPass+0)
	MOVWF       FSR0H 
	MOVF        _ValuePosition+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVLW       9
	SUBWF       POSTINC0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu1129
	MOVLW       _OpenPass+0
	MOVWF       R1 
	MOVLW       hi_addr(_OpenPass+0)
	MOVWF       R2 
	MOVF        _ValuePosition+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_Menu1129:
L_Menu1128:
;Lock.c,581 :: 		if(CheckKey('D'))
	MOVLW       68
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu1130
;Lock.c,582 :: 		if(OpenPass[ValuePosition]>0)OpenPass[ValuePosition]=OpenPass[ValuePosition]-1;
	MOVLW       _OpenPass+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_OpenPass+0)
	MOVWF       FSR0H 
	MOVF        _ValuePosition+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu1131
	MOVLW       _OpenPass+0
	MOVWF       R1 
	MOVLW       hi_addr(_OpenPass+0)
	MOVWF       R2 
	MOVF        _ValuePosition+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	DECF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_Menu1131:
L_Menu1130:
;Lock.c,584 :: 		if(CheckKey('R'))
	MOVLW       82
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu1132
;Lock.c,585 :: 		if(ValuePosition<3)ValuePosition=ValuePosition+1;
	MOVLW       3
	SUBWF       _ValuePosition+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu1133
	INCF        _ValuePosition+0, 1 
L_Menu1133:
L_Menu1132:
;Lock.c,587 :: 		if(CheckKey('L'))
	MOVLW       76
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu1134
;Lock.c,588 :: 		if(ValuePosition>0)ValuePosition=ValuePosition-1;
	MOVF        _ValuePosition+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu1135
	DECF        _ValuePosition+0, 1 
L_Menu1135:
L_Menu1134:
;Lock.c,590 :: 		if(CheckKey('C'))
	MOVLW       67
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu1136
;Lock.c,591 :: 		{SaveConfig();State=10;}
	CALL        _SaveConfig+0, 0
	MOVLW       10
	MOVWF       _State+0 
L_Menu1136:
;Lock.c,593 :: 		Segment.Display[0]=OpenPass[0];Segment.Display[1]=OpenPass[1];Segment.Display[2]=OpenPass[2];Segment.Display[3]=OpenPass[3];
	MOVF        _OpenPass+0, 0 
	MOVWF       _Segment+0 
	MOVF        _OpenPass+1, 0 
	MOVWF       _Segment+1 
	MOVF        _OpenPass+2, 0 
	MOVWF       _Segment+2 
	MOVF        _OpenPass+3, 0 
	MOVWF       _Segment+3 
;Lock.c,594 :: 		break;
	GOTO        L_Menu169
;Lock.c,597 :: 		case 4:
L_Menu1137:
;Lock.c,598 :: 		if(CheckKey('U'))
	MOVLW       85
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu1138
;Lock.c,599 :: 		if(MenuPass[ValuePosition]<9)MenuPass[ValuePosition]=MenuPass[ValuePosition]+1;
	MOVLW       _MenuPass+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_MenuPass+0)
	MOVWF       FSR0H 
	MOVF        _ValuePosition+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVLW       9
	SUBWF       POSTINC0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu1139
	MOVLW       _MenuPass+0
	MOVWF       R1 
	MOVLW       hi_addr(_MenuPass+0)
	MOVWF       R2 
	MOVF        _ValuePosition+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_Menu1139:
L_Menu1138:
;Lock.c,601 :: 		if(CheckKey('D'))
	MOVLW       68
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu1140
;Lock.c,602 :: 		if(MenuPass[ValuePosition]>0)MenuPass[ValuePosition]=MenuPass[ValuePosition]-1;
	MOVLW       _MenuPass+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_MenuPass+0)
	MOVWF       FSR0H 
	MOVF        _ValuePosition+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu1141
	MOVLW       _MenuPass+0
	MOVWF       R1 
	MOVLW       hi_addr(_MenuPass+0)
	MOVWF       R2 
	MOVF        _ValuePosition+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	DECF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_Menu1141:
L_Menu1140:
;Lock.c,604 :: 		if(CheckKey('R'))
	MOVLW       82
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu1142
;Lock.c,605 :: 		if(ValuePosition<3)ValuePosition=ValuePosition+1;
	MOVLW       3
	SUBWF       _ValuePosition+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu1143
	INCF        _ValuePosition+0, 1 
L_Menu1143:
L_Menu1142:
;Lock.c,607 :: 		if(CheckKey('L'))
	MOVLW       76
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu1144
;Lock.c,608 :: 		if(ValuePosition>0)ValuePosition=ValuePosition-1;
	MOVF        _ValuePosition+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu1145
	DECF        _ValuePosition+0, 1 
L_Menu1145:
L_Menu1144:
;Lock.c,610 :: 		if(CheckKey('C'))
	MOVLW       67
	MOVWF       FARG_CheckKey+0 
	CALL        _CheckKey+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu1146
;Lock.c,611 :: 		{SaveConfig();State=10;}
	CALL        _SaveConfig+0, 0
	MOVLW       10
	MOVWF       _State+0 
L_Menu1146:
;Lock.c,613 :: 		Segment.Display[0]=MenuPass[0];Segment.Display[1]=MenuPass[1];Segment.Display[2]=MenuPass[2];Segment.Display[3]=MenuPass[3];
	MOVF        _MenuPass+0, 0 
	MOVWF       _Segment+0 
	MOVF        _MenuPass+1, 0 
	MOVWF       _Segment+1 
	MOVF        _MenuPass+2, 0 
	MOVWF       _Segment+2 
	MOVF        _MenuPass+3, 0 
	MOVWF       _Segment+3 
;Lock.c,614 :: 		break;
	GOTO        L_Menu169
;Lock.c,616 :: 		}
L_Menu168:
	MOVF        _SetCounter+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu170
	MOVF        _SetCounter+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu190
	MOVF        _SetCounter+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu1110
	MOVF        _SetCounter+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu1127
	MOVF        _SetCounter+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu1137
L_Menu169:
;Lock.c,617 :: 		}
L_end_Menu1:
	RETURN      0
; end of _Menu1

_CheckKey:

;Lock.c,640 :: 		char CheckKey(char key)
;Lock.c,642 :: 		if(key == 'U')
	MOVF        FARG_CheckKey_key+0, 0 
	XORLW       85
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckKey147
;Lock.c,644 :: 		if(RTL==0){if(Keys & UP)  {MenuExpireCounter=MenuExpire;return 1;}}
	MOVF        _RTL+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckKey148
	BTFSS       _Keys+0, 1 
	GOTO        L_CheckKey149
	MOVLW       30
	MOVWF       _MenuExpireCounter+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CheckKey
L_CheckKey149:
	GOTO        L_CheckKey150
L_CheckKey148:
;Lock.c,645 :: 		else {if(Keys & UPI) {MenuExpireCounter=MenuExpire;return 1;}}
	BTFSS       _Keys+0, 2 
	GOTO        L_CheckKey151
	MOVLW       30
	MOVWF       _MenuExpireCounter+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CheckKey
L_CheckKey151:
L_CheckKey150:
;Lock.c,646 :: 		}
L_CheckKey147:
;Lock.c,648 :: 		if(key == 'D')
	MOVF        FARG_CheckKey_key+0, 0 
	XORLW       68
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckKey152
;Lock.c,650 :: 		if(RTL==0){if(Keys & DOWN) {MenuExpireCounter=MenuExpire;return 1;}}
	MOVF        _RTL+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckKey153
	BTFSS       _Keys+0, 2 
	GOTO        L_CheckKey154
	MOVLW       30
	MOVWF       _MenuExpireCounter+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CheckKey
L_CheckKey154:
	GOTO        L_CheckKey155
L_CheckKey153:
;Lock.c,651 :: 		else {if(Keys & DOWNI) {MenuExpireCounter=MenuExpire;return 1;}}
	BTFSS       _Keys+0, 1 
	GOTO        L_CheckKey156
	MOVLW       30
	MOVWF       _MenuExpireCounter+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CheckKey
L_CheckKey156:
L_CheckKey155:
;Lock.c,652 :: 		}
L_CheckKey152:
;Lock.c,654 :: 		if(key == 'R')
	MOVF        FARG_CheckKey_key+0, 0 
	XORLW       82
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckKey157
;Lock.c,656 :: 		if(RTL==0){if(Keys & RIGHT) {MenuExpireCounter=MenuExpire;return 1;}}
	MOVF        _RTL+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckKey158
	BTFSS       _Keys+0, 4 
	GOTO        L_CheckKey159
	MOVLW       30
	MOVWF       _MenuExpireCounter+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CheckKey
L_CheckKey159:
	GOTO        L_CheckKey160
L_CheckKey158:
;Lock.c,657 :: 		else {if(Keys & RIGHTI) {MenuExpireCounter=MenuExpire;return 1;}}
	BTFSS       _Keys+0, 0 
	GOTO        L_CheckKey161
	MOVLW       30
	MOVWF       _MenuExpireCounter+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CheckKey
L_CheckKey161:
L_CheckKey160:
;Lock.c,658 :: 		}
L_CheckKey157:
;Lock.c,660 :: 		if(key == 'L')
	MOVF        FARG_CheckKey_key+0, 0 
	XORLW       76
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckKey162
;Lock.c,662 :: 		if(RTL==0){if(Keys & LEFT) {MenuExpireCounter=MenuExpire;return 1;}}
	MOVF        _RTL+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckKey163
	BTFSS       _Keys+0, 0 
	GOTO        L_CheckKey164
	MOVLW       30
	MOVWF       _MenuExpireCounter+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CheckKey
L_CheckKey164:
	GOTO        L_CheckKey165
L_CheckKey163:
;Lock.c,663 :: 		else {if(Keys & LEFTI) {MenuExpireCounter=MenuExpire;return 1;}}
	BTFSS       _Keys+0, 4 
	GOTO        L_CheckKey166
	MOVLW       30
	MOVWF       _MenuExpireCounter+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CheckKey
L_CheckKey166:
L_CheckKey165:
;Lock.c,664 :: 		}
L_CheckKey162:
;Lock.c,666 :: 		if(key == 'C')
	MOVF        FARG_CheckKey_key+0, 0 
	XORLW       67
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckKey167
;Lock.c,668 :: 		if(RTL==0){if(Keys & CENTER) {MenuExpireCounter=MenuExpire;return 1;}}
	MOVF        _RTL+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckKey168
	BTFSS       _Keys+0, 3 
	GOTO        L_CheckKey169
	MOVLW       30
	MOVWF       _MenuExpireCounter+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CheckKey
L_CheckKey169:
	GOTO        L_CheckKey170
L_CheckKey168:
;Lock.c,669 :: 		else {if(Keys & CENTERI) {MenuExpireCounter=MenuExpire;return 1;}}
	BTFSS       _Keys+0, 3 
	GOTO        L_CheckKey171
	MOVLW       30
	MOVWF       _MenuExpireCounter+0 
	MOVLW       1
	MOVWF       R0 
	GOTO        L_end_CheckKey
L_CheckKey171:
L_CheckKey170:
;Lock.c,670 :: 		}
L_CheckKey167:
;Lock.c,672 :: 		return 0;
	CLRF        R0 
;Lock.c,674 :: 		}
L_end_CheckKey:
	RETURN      0
; end of _CheckKey

_MotorManager:

;Lock.c,695 :: 		void MotorManager()
;Lock.c,697 :: 		if(SignalingSystem_CheckSignal(&SigSys, 1))//Start to Unlock
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_CheckSignal+1 
	MOVLW       1
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	CALL        _SignalingSystem_CheckSignal+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_MotorManager172
;Lock.c,698 :: 		{Dir2=0;Dir1=1;Relay=0;}
	BCF         PORTD+0, 3 
	BSF         PORTD+0, 2 
	BCF         PORTA+0, 0 
L_MotorManager172:
;Lock.c,700 :: 		if(SignalingSystem_CheckSignal(&SigSys, 2))//Start to Lock
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_CheckSignal+1 
	MOVLW       2
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	CALL        _SignalingSystem_CheckSignal+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_MotorManager173
;Lock.c,701 :: 		{Dir1=0;Dir2=1;Relay=1;}
	BCF         PORTD+0, 2 
	BSF         PORTD+0, 3 
	BSF         PORTA+0, 0 
L_MotorManager173:
;Lock.c,703 :: 		if(SignalingSystem_CheckSignal(&SigSys, 3))//Stop
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_CheckSignal+1 
	MOVLW       3
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	CALL        _SignalingSystem_CheckSignal+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_MotorManager174
;Lock.c,704 :: 		{Dir2=0;Dir1=0;}
	BCF         PORTD+0, 3 
	BCF         PORTD+0, 2 
L_MotorManager174:
;Lock.c,705 :: 		}
L_end_MotorManager:
	RETURN      0
; end of _MotorManager

_SaveConfig:

;Lock.c,719 :: 		void SaveConfig()
;Lock.c,721 :: 		EEPROM_Write(0,LockTime[0]);
	CLRF        FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVF        _LockTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;Lock.c,722 :: 		EEPROM_Write(1,LockTime[1]);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _LockTime+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;Lock.c,723 :: 		EEPROM_Write(2,LockTime[2]);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _LockTime+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;Lock.c,724 :: 		EEPROM_Write(3,LockTime[3]);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _LockTime+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;Lock.c,726 :: 		EEPROM_Write(4,UnlockTime[0]);
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _UnlockTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;Lock.c,727 :: 		EEPROM_Write(5,UnlockTime[1]);
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _UnlockTime+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;Lock.c,728 :: 		EEPROM_Write(6,UnlockTime[2]);
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _UnlockTime+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;Lock.c,729 :: 		EEPROM_Write(7,UnlockTime[3]);
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _UnlockTime+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;Lock.c,731 :: 		EEPROM_Write(8,OpenPass[0]);
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OpenPass+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;Lock.c,732 :: 		EEPROM_Write(9,OpenPass[1]);
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OpenPass+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;Lock.c,733 :: 		EEPROM_Write(10,OpenPass[2]);
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OpenPass+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;Lock.c,734 :: 		EEPROM_Write(11,OpenPass[3]);
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _OpenPass+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;Lock.c,736 :: 		EEPROM_Write(12,MenuPass[0]);
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _MenuPass+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;Lock.c,737 :: 		EEPROM_Write(13,MenuPass[1]);
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _MenuPass+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;Lock.c,738 :: 		EEPROM_Write(14,MenuPass[2]);
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _MenuPass+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;Lock.c,739 :: 		EEPROM_Write(15,MenuPass[3]);
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _MenuPass+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;Lock.c,741 :: 		EEPROM_Write(16,RTL);
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _RTL+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;Lock.c,742 :: 		}
L_end_SaveConfig:
	RETURN      0
; end of _SaveConfig

_LoadConfig:

;Lock.c,761 :: 		void LoadConfig()
;Lock.c,763 :: 		LockTime[0]=EEPROM_Read(0);
	CLRF        FARG_EEPROM_Read_address+0 
	CLRF        FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LockTime+0 
;Lock.c,764 :: 		LockTime[1]=EEPROM_Read(1);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LockTime+1 
;Lock.c,765 :: 		LockTime[2]=EEPROM_Read(2);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LockTime+2 
;Lock.c,766 :: 		LockTime[3]=EEPROM_Read(3);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LockTime+3 
;Lock.c,768 :: 		UnlockTime[0]=EEPROM_Read(4);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _UnlockTime+0 
;Lock.c,769 :: 		UnlockTime[1]=EEPROM_Read(5);
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _UnlockTime+1 
;Lock.c,770 :: 		UnlockTime[2]=EEPROM_Read(6);
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _UnlockTime+2 
;Lock.c,771 :: 		UnlockTime[3]=EEPROM_Read(7);
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _UnlockTime+3 
;Lock.c,773 :: 		OpenPass[0]=EEPROM_Read(8);
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenPass+0 
;Lock.c,774 :: 		OpenPass[1]=EEPROM_Read(9);
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenPass+1 
;Lock.c,775 :: 		OpenPass[2]=EEPROM_Read(10);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenPass+2 
;Lock.c,776 :: 		OpenPass[3]=EEPROM_Read(11);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenPass+3 
;Lock.c,778 :: 		MenuPass[0]=EEPROM_Read(12);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _MenuPass+0 
;Lock.c,779 :: 		MenuPass[1]=EEPROM_Read(13);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _MenuPass+1 
;Lock.c,780 :: 		MenuPass[2]=EEPROM_Read(14);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _MenuPass+2 
;Lock.c,781 :: 		MenuPass[3]=EEPROM_Read(15);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _MenuPass+3 
;Lock.c,783 :: 		RTL=EEPROM_Read(16);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _RTL+0 
;Lock.c,784 :: 		}
L_end_LoadConfig:
	RETURN      0
; end of _LoadConfig

_TimeCompare:

;Lock.c,801 :: 		char TimeCompare(char *A,char *B)
;Lock.c,803 :: 		char res=0;
	CLRF        TimeCompare_res_L0+0 
;Lock.c,804 :: 		if(A[0] > B[0])
	MOVFF       FARG_TimeCompare_A+0, FSR0
	MOVFF       FARG_TimeCompare_A+1, FSR0H
	MOVFF       FARG_TimeCompare_B+0, FSR2
	MOVFF       FARG_TimeCompare_B+1, FSR2H
	MOVF        POSTINC0+0, 0 
	SUBWF       POSTINC2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_TimeCompare175
;Lock.c,805 :: 		res=1;//A is Greater
	MOVLW       1
	MOVWF       TimeCompare_res_L0+0 
L_TimeCompare175:
;Lock.c,806 :: 		if((A[0] == B[0]) && (A[1] > B[1]))
	MOVFF       FARG_TimeCompare_A+0, FSR0
	MOVFF       FARG_TimeCompare_A+1, FSR0H
	MOVFF       FARG_TimeCompare_B+0, FSR2
	MOVFF       FARG_TimeCompare_B+1, FSR2H
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_TimeCompare178
	MOVLW       1
	ADDWF       FARG_TimeCompare_A+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_TimeCompare_A+1, 0 
	MOVWF       FSR0H 
	MOVLW       1
	ADDWF       FARG_TimeCompare_B+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_TimeCompare_B+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	SUBWF       POSTINC2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_TimeCompare178
L__TimeCompare204:
;Lock.c,807 :: 		res=1;//A is Greater
	MOVLW       1
	MOVWF       TimeCompare_res_L0+0 
L_TimeCompare178:
;Lock.c,808 :: 		if((A[0] == B[0]) && (A[1] == B[1]) && (A[2] > B[2]))
	MOVFF       FARG_TimeCompare_A+0, FSR0
	MOVFF       FARG_TimeCompare_A+1, FSR0H
	MOVFF       FARG_TimeCompare_B+0, FSR2
	MOVFF       FARG_TimeCompare_B+1, FSR2H
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_TimeCompare181
	MOVLW       1
	ADDWF       FARG_TimeCompare_A+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_TimeCompare_A+1, 0 
	MOVWF       FSR0H 
	MOVLW       1
	ADDWF       FARG_TimeCompare_B+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_TimeCompare_B+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_TimeCompare181
	MOVLW       2
	ADDWF       FARG_TimeCompare_A+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_TimeCompare_A+1, 0 
	MOVWF       FSR0H 
	MOVLW       2
	ADDWF       FARG_TimeCompare_B+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_TimeCompare_B+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	SUBWF       POSTINC2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_TimeCompare181
L__TimeCompare203:
;Lock.c,809 :: 		res=1;//A is Greater
	MOVLW       1
	MOVWF       TimeCompare_res_L0+0 
L_TimeCompare181:
;Lock.c,810 :: 		if((A[0] == B[0]) && (A[1] == B[1]) && (A[2] == B[2]) && (A[3] > B[3]))
	MOVFF       FARG_TimeCompare_A+0, FSR0
	MOVFF       FARG_TimeCompare_A+1, FSR0H
	MOVFF       FARG_TimeCompare_B+0, FSR2
	MOVFF       FARG_TimeCompare_B+1, FSR2H
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_TimeCompare184
	MOVLW       1
	ADDWF       FARG_TimeCompare_A+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_TimeCompare_A+1, 0 
	MOVWF       FSR0H 
	MOVLW       1
	ADDWF       FARG_TimeCompare_B+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_TimeCompare_B+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_TimeCompare184
	MOVLW       2
	ADDWF       FARG_TimeCompare_A+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_TimeCompare_A+1, 0 
	MOVWF       FSR0H 
	MOVLW       2
	ADDWF       FARG_TimeCompare_B+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_TimeCompare_B+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_TimeCompare184
	MOVLW       3
	ADDWF       FARG_TimeCompare_A+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_TimeCompare_A+1, 0 
	MOVWF       FSR0H 
	MOVLW       3
	ADDWF       FARG_TimeCompare_B+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_TimeCompare_B+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	SUBWF       POSTINC2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_TimeCompare184
L__TimeCompare202:
;Lock.c,811 :: 		res=1;//A is Greater
	MOVLW       1
	MOVWF       TimeCompare_res_L0+0 
L_TimeCompare184:
;Lock.c,812 :: 		if((A[0] == B[0]) && (A[1] == B[1]) && (A[2] == B[2]) && (A[3] == B[3]))
	MOVFF       FARG_TimeCompare_A+0, FSR0
	MOVFF       FARG_TimeCompare_A+1, FSR0H
	MOVFF       FARG_TimeCompare_B+0, FSR2
	MOVFF       FARG_TimeCompare_B+1, FSR2H
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_TimeCompare187
	MOVLW       1
	ADDWF       FARG_TimeCompare_A+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_TimeCompare_A+1, 0 
	MOVWF       FSR0H 
	MOVLW       1
	ADDWF       FARG_TimeCompare_B+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_TimeCompare_B+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_TimeCompare187
	MOVLW       2
	ADDWF       FARG_TimeCompare_A+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_TimeCompare_A+1, 0 
	MOVWF       FSR0H 
	MOVLW       2
	ADDWF       FARG_TimeCompare_B+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_TimeCompare_B+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_TimeCompare187
	MOVLW       3
	ADDWF       FARG_TimeCompare_A+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_TimeCompare_A+1, 0 
	MOVWF       FSR0H 
	MOVLW       3
	ADDWF       FARG_TimeCompare_B+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_TimeCompare_B+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_TimeCompare187
L__TimeCompare201:
;Lock.c,813 :: 		res=2;//A and B are equal
	MOVLW       2
	MOVWF       TimeCompare_res_L0+0 
L_TimeCompare187:
;Lock.c,815 :: 		return res;
	MOVF        TimeCompare_res_L0+0, 0 
	MOVWF       R0 
;Lock.c,816 :: 		}
L_end_TimeCompare:
	RETURN      0
; end of _TimeCompare

_GetDesireStatus:

;Lock.c,834 :: 		char GetDesireStatus()
;Lock.c,836 :: 		char UnlockTimeTemp[4],NowTemp[4],NowTempAdded[4],res=0;
	CLRF        GetDesireStatus_res_L0+0 
;Lock.c,838 :: 		if(TimeCompare(LockTime,UnlockTime)==1)
	MOVLW       _LockTime+0
	MOVWF       FARG_TimeCompare_A+0 
	MOVLW       hi_addr(_LockTime+0)
	MOVWF       FARG_TimeCompare_A+1 
	MOVLW       _UnlockTime+0
	MOVWF       FARG_TimeCompare_B+0 
	MOVLW       hi_addr(_UnlockTime+0)
	MOVWF       FARG_TimeCompare_B+1 
	CALL        _TimeCompare+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetDesireStatus188
;Lock.c,840 :: 		UnlockTimeTemp[0]=UnlockTime[0];UnlockTimeTemp[1]=UnlockTime[1];
	MOVF        _UnlockTime+0, 0 
	MOVWF       GetDesireStatus_UnlockTimeTemp_L0+0 
	MOVF        _UnlockTime+1, 0 
	MOVWF       GetDesireStatus_UnlockTimeTemp_L0+1 
;Lock.c,841 :: 		UnlockTimeTemp[2]=UnlockTime[2];UnlockTimeTemp[3]=UnlockTime[3];
	MOVF        _UnlockTime+2, 0 
	MOVWF       GetDesireStatus_UnlockTimeTemp_L0+2 
	MOVF        _UnlockTime+3, 0 
	MOVWF       GetDesireStatus_UnlockTimeTemp_L0+3 
;Lock.c,842 :: 		UnlockTimeTemp[0]=(UnlockTimeTemp[0]+2)+((UnlockTimeTemp[1]+4)/10);
	MOVLW       2
	ADDWF       GetDesireStatus_UnlockTimeTemp_L0+0, 0 
	MOVWF       FLOC__GetDesireStatus+2 
	MOVLW       4
	ADDWF       GetDesireStatus_UnlockTimeTemp_L0+1, 0 
	MOVWF       FLOC__GetDesireStatus+0 
	CLRF        FLOC__GetDesireStatus+1 
	MOVLW       0
	ADDWFC      FLOC__GetDesireStatus+1, 1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__GetDesireStatus+0, 0 
	MOVWF       R0 
	MOVF        FLOC__GetDesireStatus+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        FLOC__GetDesireStatus+2, 0 
	ADDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       GetDesireStatus_UnlockTimeTemp_L0+0 
;Lock.c,843 :: 		UnlockTimeTemp[1]=(UnlockTimeTemp[1]+4)%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__GetDesireStatus+0, 0 
	MOVWF       R0 
	MOVF        FLOC__GetDesireStatus+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       GetDesireStatus_UnlockTimeTemp_L0+1 
;Lock.c,846 :: 		NowTemp[0]=Now.HourBCD>>4;
	MOVF        _Now+2, 0 
	MOVWF       GetDesireStatus_NowTemp_L0+0 
	RRCF        GetDesireStatus_NowTemp_L0+0, 1 
	BCF         GetDesireStatus_NowTemp_L0+0, 7 
	RRCF        GetDesireStatus_NowTemp_L0+0, 1 
	BCF         GetDesireStatus_NowTemp_L0+0, 7 
	RRCF        GetDesireStatus_NowTemp_L0+0, 1 
	BCF         GetDesireStatus_NowTemp_L0+0, 7 
	RRCF        GetDesireStatus_NowTemp_L0+0, 1 
	BCF         GetDesireStatus_NowTemp_L0+0, 7 
;Lock.c,847 :: 		NowTemp[1]=Now.HourBCD&0x0F;
	MOVLW       15
	ANDWF       _Now+2, 0 
	MOVWF       GetDesireStatus_NowTemp_L0+1 
;Lock.c,848 :: 		NowTemp[2]=Now.MinuteBCD>>4;
	MOVF        _Now+1, 0 
	MOVWF       GetDesireStatus_NowTemp_L0+2 
	RRCF        GetDesireStatus_NowTemp_L0+2, 1 
	BCF         GetDesireStatus_NowTemp_L0+2, 7 
	RRCF        GetDesireStatus_NowTemp_L0+2, 1 
	BCF         GetDesireStatus_NowTemp_L0+2, 7 
	RRCF        GetDesireStatus_NowTemp_L0+2, 1 
	BCF         GetDesireStatus_NowTemp_L0+2, 7 
	RRCF        GetDesireStatus_NowTemp_L0+2, 1 
	BCF         GetDesireStatus_NowTemp_L0+2, 7 
;Lock.c,849 :: 		NowTemp[3]=Now.MinuteBCD&0x0F;
	MOVLW       15
	ANDWF       _Now+1, 0 
	MOVWF       FLOC__GetDesireStatus+3 
	MOVF        FLOC__GetDesireStatus+3, 0 
	MOVWF       GetDesireStatus_NowTemp_L0+3 
;Lock.c,851 :: 		NowTempAdded[0]=(NowTemp[0]+2)+((NowTemp[1]+4)/10);
	MOVLW       2
	ADDWF       GetDesireStatus_NowTemp_L0+0, 0 
	MOVWF       FLOC__GetDesireStatus+2 
	MOVLW       4
	ADDWF       GetDesireStatus_NowTemp_L0+1, 0 
	MOVWF       FLOC__GetDesireStatus+0 
	CLRF        FLOC__GetDesireStatus+1 
	MOVLW       0
	ADDWFC      FLOC__GetDesireStatus+1, 1 
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__GetDesireStatus+0, 0 
	MOVWF       R0 
	MOVF        FLOC__GetDesireStatus+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        FLOC__GetDesireStatus+2, 0 
	ADDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       GetDesireStatus_NowTempAdded_L0+0 
;Lock.c,852 :: 		NowTempAdded[1]=(NowTemp[1]+4)%10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FLOC__GetDesireStatus+0, 0 
	MOVWF       R0 
	MOVF        FLOC__GetDesireStatus+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       GetDesireStatus_NowTempAdded_L0+1 
;Lock.c,853 :: 		NowTempAdded[2]=NowTemp[2];NowTempAdded[3]=NowTemp[3];
	MOVF        GetDesireStatus_NowTemp_L0+2, 0 
	MOVWF       GetDesireStatus_NowTempAdded_L0+2 
	MOVF        FLOC__GetDesireStatus+3, 0 
	MOVWF       GetDesireStatus_NowTempAdded_L0+3 
;Lock.c,855 :: 		if(TimeCompare(NowTemp,LockTime))
	MOVLW       GetDesireStatus_NowTemp_L0+0
	MOVWF       FARG_TimeCompare_A+0 
	MOVLW       hi_addr(GetDesireStatus_NowTemp_L0+0)
	MOVWF       FARG_TimeCompare_A+1 
	MOVLW       _LockTime+0
	MOVWF       FARG_TimeCompare_B+0 
	MOVLW       hi_addr(_LockTime+0)
	MOVWF       FARG_TimeCompare_B+1 
	CALL        _TimeCompare+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GetDesireStatus189
;Lock.c,856 :: 		res=1; // should be locked
	MOVLW       1
	MOVWF       GetDesireStatus_res_L0+0 
L_GetDesireStatus189:
;Lock.c,858 :: 		if(TimeCompare(UnlockTimeTemp,NowTempAdded))
	MOVLW       GetDesireStatus_UnlockTimeTemp_L0+0
	MOVWF       FARG_TimeCompare_A+0 
	MOVLW       hi_addr(GetDesireStatus_UnlockTimeTemp_L0+0)
	MOVWF       FARG_TimeCompare_A+1 
	MOVLW       GetDesireStatus_NowTempAdded_L0+0
	MOVWF       FARG_TimeCompare_B+0 
	MOVLW       hi_addr(GetDesireStatus_NowTempAdded_L0+0)
	MOVWF       FARG_TimeCompare_B+1 
	CALL        _TimeCompare+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GetDesireStatus190
;Lock.c,859 :: 		res=1; // should be locked
	MOVLW       1
	MOVWF       GetDesireStatus_res_L0+0 
L_GetDesireStatus190:
;Lock.c,860 :: 		}
L_GetDesireStatus188:
;Lock.c,862 :: 		if(TimeCompare(UnlockTime,LockTime)==1)
	MOVLW       _UnlockTime+0
	MOVWF       FARG_TimeCompare_A+0 
	MOVLW       hi_addr(_UnlockTime+0)
	MOVWF       FARG_TimeCompare_A+1 
	MOVLW       _LockTime+0
	MOVWF       FARG_TimeCompare_B+0 
	MOVLW       hi_addr(_LockTime+0)
	MOVWF       FARG_TimeCompare_B+1 
	CALL        _TimeCompare+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetDesireStatus191
;Lock.c,864 :: 		UnlockTimeTemp[0]=UnlockTime[0];UnlockTimeTemp[1]=UnlockTime[1];
	MOVF        _UnlockTime+0, 0 
	MOVWF       GetDesireStatus_UnlockTimeTemp_L0+0 
	MOVF        _UnlockTime+1, 0 
	MOVWF       GetDesireStatus_UnlockTimeTemp_L0+1 
;Lock.c,865 :: 		UnlockTimeTemp[2]=UnlockTime[2];UnlockTimeTemp[3]=UnlockTime[3];
	MOVF        _UnlockTime+2, 0 
	MOVWF       GetDesireStatus_UnlockTimeTemp_L0+2 
	MOVF        _UnlockTime+3, 0 
	MOVWF       GetDesireStatus_UnlockTimeTemp_L0+3 
;Lock.c,867 :: 		NowTemp[0]=Now.HourBCD>>4;
	MOVF        _Now+2, 0 
	MOVWF       GetDesireStatus_NowTemp_L0+0 
	RRCF        GetDesireStatus_NowTemp_L0+0, 1 
	BCF         GetDesireStatus_NowTemp_L0+0, 7 
	RRCF        GetDesireStatus_NowTemp_L0+0, 1 
	BCF         GetDesireStatus_NowTemp_L0+0, 7 
	RRCF        GetDesireStatus_NowTemp_L0+0, 1 
	BCF         GetDesireStatus_NowTemp_L0+0, 7 
	RRCF        GetDesireStatus_NowTemp_L0+0, 1 
	BCF         GetDesireStatus_NowTemp_L0+0, 7 
;Lock.c,868 :: 		NowTemp[1]=Now.HourBCD&0x0F;
	MOVLW       15
	ANDWF       _Now+2, 0 
	MOVWF       GetDesireStatus_NowTemp_L0+1 
;Lock.c,869 :: 		NowTemp[2]=Now.MinuteBCD>>4;
	MOVF        _Now+1, 0 
	MOVWF       GetDesireStatus_NowTemp_L0+2 
	RRCF        GetDesireStatus_NowTemp_L0+2, 1 
	BCF         GetDesireStatus_NowTemp_L0+2, 7 
	RRCF        GetDesireStatus_NowTemp_L0+2, 1 
	BCF         GetDesireStatus_NowTemp_L0+2, 7 
	RRCF        GetDesireStatus_NowTemp_L0+2, 1 
	BCF         GetDesireStatus_NowTemp_L0+2, 7 
	RRCF        GetDesireStatus_NowTemp_L0+2, 1 
	BCF         GetDesireStatus_NowTemp_L0+2, 7 
;Lock.c,870 :: 		NowTemp[3]=Now.MinuteBCD&0x0F;
	MOVLW       15
	ANDWF       _Now+1, 0 
	MOVWF       GetDesireStatus_NowTemp_L0+3 
;Lock.c,872 :: 		if((TimeCompare(NowTemp,LockTime)) && (TimeCompare(UnlockTimeTemp,NowTemp)))
	MOVLW       GetDesireStatus_NowTemp_L0+0
	MOVWF       FARG_TimeCompare_A+0 
	MOVLW       hi_addr(GetDesireStatus_NowTemp_L0+0)
	MOVWF       FARG_TimeCompare_A+1 
	MOVLW       _LockTime+0
	MOVWF       FARG_TimeCompare_B+0 
	MOVLW       hi_addr(_LockTime+0)
	MOVWF       FARG_TimeCompare_B+1 
	CALL        _TimeCompare+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GetDesireStatus194
	MOVLW       GetDesireStatus_UnlockTimeTemp_L0+0
	MOVWF       FARG_TimeCompare_A+0 
	MOVLW       hi_addr(GetDesireStatus_UnlockTimeTemp_L0+0)
	MOVWF       FARG_TimeCompare_A+1 
	MOVLW       GetDesireStatus_NowTemp_L0+0
	MOVWF       FARG_TimeCompare_B+0 
	MOVLW       hi_addr(GetDesireStatus_NowTemp_L0+0)
	MOVWF       FARG_TimeCompare_B+1 
	CALL        _TimeCompare+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_GetDesireStatus194
L__GetDesireStatus205:
;Lock.c,873 :: 		res=1; // should be locked
	MOVLW       1
	MOVWF       GetDesireStatus_res_L0+0 
L_GetDesireStatus194:
;Lock.c,874 :: 		}
L_GetDesireStatus191:
;Lock.c,878 :: 		return res;
	MOVF        GetDesireStatus_res_L0+0, 0 
	MOVWF       R0 
;Lock.c,879 :: 		}
L_end_GetDesireStatus:
	RETURN      0
; end of _GetDesireStatus
