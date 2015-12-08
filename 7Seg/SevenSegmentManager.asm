
_DisableSegments:

;SevenSegmentManager.c,12 :: 		void DisableSegments()
;SevenSegmentManager.c,14 :: 		Digit1En=DisableLogic;
	BSF         PORTB+0, 0 
;SevenSegmentManager.c,16 :: 		Digit2En=DisableLogic;
	BSF         PORTB+0, 3 
;SevenSegmentManager.c,19 :: 		Digit3En=DisableLogic;
	BSF         PORTB+0, 2 
;SevenSegmentManager.c,22 :: 		Digit4En=DisableLogic;
	BSF         PORTB+0, 1 
;SevenSegmentManager.c,24 :: 		}
L_end_DisableSegments:
	RETURN      0
; end of _DisableSegments

_EnableSegment:

;SevenSegmentManager.c,34 :: 		void EnableSegment(char seg)
;SevenSegmentManager.c,36 :: 		switch(seg)
	GOTO        L_EnableSegment0
;SevenSegmentManager.c,38 :: 		case 0:
L_EnableSegment2:
;SevenSegmentManager.c,39 :: 		Digit1En=EnableLogic;
	BCF         PORTB+0, 0 
;SevenSegmentManager.c,40 :: 		break;
	GOTO        L_EnableSegment1
;SevenSegmentManager.c,42 :: 		case 1:
L_EnableSegment3:
;SevenSegmentManager.c,43 :: 		Digit2En=EnableLogic;
	BCF         PORTB+0, 3 
;SevenSegmentManager.c,44 :: 		break;
	GOTO        L_EnableSegment1
;SevenSegmentManager.c,46 :: 		case 2:
L_EnableSegment4:
;SevenSegmentManager.c,47 :: 		Digit3En=EnableLogic;
	BCF         PORTB+0, 2 
;SevenSegmentManager.c,48 :: 		break;
	GOTO        L_EnableSegment1
;SevenSegmentManager.c,50 :: 		case 3:
L_EnableSegment5:
;SevenSegmentManager.c,51 :: 		Digit4En=EnableLogic;
	BCF         PORTB+0, 1 
;SevenSegmentManager.c,52 :: 		break;
	GOTO        L_EnableSegment1
;SevenSegmentManager.c,54 :: 		}
L_EnableSegment0:
	MOVF        FARG_EnableSegment_seg+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_EnableSegment2
	MOVF        FARG_EnableSegment_seg+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_EnableSegment3
	MOVF        FARG_EnableSegment_seg+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_EnableSegment4
	MOVF        FARG_EnableSegment_seg+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_EnableSegment5
L_EnableSegment1:
;SevenSegmentManager.c,55 :: 		}
L_end_EnableSegment:
	RETURN      0
; end of _EnableSegment

_EnableSegmentI:

;SevenSegmentManager.c,69 :: 		void EnableSegmentI(char seg)
;SevenSegmentManager.c,71 :: 		switch(seg)
	GOTO        L_EnableSegmentI6
;SevenSegmentManager.c,73 :: 		case 0:
L_EnableSegmentI8:
;SevenSegmentManager.c,74 :: 		Digit1EnI=EnableLogic;
	BCF         PORTB+0, 1 
;SevenSegmentManager.c,75 :: 		break;
	GOTO        L_EnableSegmentI7
;SevenSegmentManager.c,77 :: 		case 1:
L_EnableSegmentI9:
;SevenSegmentManager.c,78 :: 		Digit2EnI=EnableLogic;
	BCF         PORTB+0, 2 
;SevenSegmentManager.c,79 :: 		break;
	GOTO        L_EnableSegmentI7
;SevenSegmentManager.c,81 :: 		case 2:
L_EnableSegmentI10:
;SevenSegmentManager.c,82 :: 		Digit3EnI=EnableLogic;
	BCF         PORTB+0, 3 
;SevenSegmentManager.c,83 :: 		break;
	GOTO        L_EnableSegmentI7
;SevenSegmentManager.c,85 :: 		case 3:
L_EnableSegmentI11:
;SevenSegmentManager.c,86 :: 		Digit4EnI=EnableLogic;
	BCF         PORTB+0, 0 
;SevenSegmentManager.c,87 :: 		break;
	GOTO        L_EnableSegmentI7
;SevenSegmentManager.c,89 :: 		}
L_EnableSegmentI6:
	MOVF        FARG_EnableSegmentI_seg+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_EnableSegmentI8
	MOVF        FARG_EnableSegmentI_seg+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_EnableSegmentI9
	MOVF        FARG_EnableSegmentI_seg+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_EnableSegmentI10
	MOVF        FARG_EnableSegmentI_seg+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_EnableSegmentI11
L_EnableSegmentI7:
;SevenSegmentManager.c,90 :: 		}
L_end_EnableSegmentI:
	RETURN      0
; end of _EnableSegmentI

_PlayAnimation:

;SevenSegmentManager.c,103 :: 		void PlayAnimation(char animCode)
;SevenSegmentManager.c,106 :: 		}
L_end_PlayAnimation:
	RETURN      0
; end of _PlayAnimation

_SetChar:

;SevenSegmentManager.c,122 :: 		void SetChar(char ch)
;SevenSegmentManager.c,124 :: 		char i=ch;
	MOVF        FARG_SetChar_ch+0, 0 
	MOVWF       SetChar_i_L0+0 
;SevenSegmentManager.c,126 :: 		if(i.b7)SegDp=On;
	BTFSS       SetChar_i_L0+0, 7 
	GOTO        L_SetChar12
	BCF         PORTE+0, 2 
	GOTO        L_SetChar13
L_SetChar12:
;SevenSegmentManager.c,127 :: 		else SegDp=Off;
	BSF         PORTE+0, 2 
L_SetChar13:
;SevenSegmentManager.c,129 :: 		i.b0=0;
	BCF         SetChar_i_L0+0, 0 
;SevenSegmentManager.c,131 :: 		switch(ch)
	GOTO        L_SetChar14
;SevenSegmentManager.c,133 :: 		case 0x00:
L_SetChar16:
;SevenSegmentManager.c,134 :: 		SegA=On;SegB=On;SegC=On;SegD=On;SegE=On;SegF=On;SegG=Off;break;
	BCF         PORTD+0, 0 
	BCF         PORTC+0, 0 
	BCF         PORTA+0, 7 
	BCF         PORTE+0, 1 
	BCF         PORTE+0, 0 
	BCF         PORTC+0, 2 
	BSF         PORTA+0, 6 
	GOTO        L_SetChar15
;SevenSegmentManager.c,136 :: 		case 0x01:
L_SetChar17:
;SevenSegmentManager.c,137 :: 		SegA=Off;SegB=On;SegC=On;SegD=Off;SegE=Off;SegF=Off;SegG=Off;break;
	BSF         PORTD+0, 0 
	BCF         PORTC+0, 0 
	BCF         PORTA+0, 7 
	BSF         PORTE+0, 1 
	BSF         PORTE+0, 0 
	BSF         PORTC+0, 2 
	BSF         PORTA+0, 6 
	GOTO        L_SetChar15
;SevenSegmentManager.c,139 :: 		case 0x02:
L_SetChar18:
;SevenSegmentManager.c,140 :: 		SegA=On;SegB=On;SegC=Off;SegD=On;SegE=On;SegF=Off;SegG=On;break;
	BCF         PORTD+0, 0 
	BCF         PORTC+0, 0 
	BSF         PORTA+0, 7 
	BCF         PORTE+0, 1 
	BCF         PORTE+0, 0 
	BSF         PORTC+0, 2 
	BCF         PORTA+0, 6 
	GOTO        L_SetChar15
;SevenSegmentManager.c,142 :: 		case 0x03:
L_SetChar19:
;SevenSegmentManager.c,143 :: 		SegA=On;SegB=On;SegC=On;SegD=On;SegE=Off;SegF=Off;SegG=On;break;
	BCF         PORTD+0, 0 
	BCF         PORTC+0, 0 
	BCF         PORTA+0, 7 
	BCF         PORTE+0, 1 
	BSF         PORTE+0, 0 
	BSF         PORTC+0, 2 
	BCF         PORTA+0, 6 
	GOTO        L_SetChar15
;SevenSegmentManager.c,145 :: 		case 0x04:
L_SetChar20:
;SevenSegmentManager.c,146 :: 		SegA=Off;SegB=On;SegC=On;SegD=Off;SegE=Off;SegF=On;SegG=On;break;
	BSF         PORTD+0, 0 
	BCF         PORTC+0, 0 
	BCF         PORTA+0, 7 
	BSF         PORTE+0, 1 
	BSF         PORTE+0, 0 
	BCF         PORTC+0, 2 
	BCF         PORTA+0, 6 
	GOTO        L_SetChar15
;SevenSegmentManager.c,148 :: 		case 0x05:
L_SetChar21:
;SevenSegmentManager.c,149 :: 		SegA=On;SegB=Off;SegC=On;SegD=On;SegE=Off;SegF=On;SegG=On;break;
	BCF         PORTD+0, 0 
	BSF         PORTC+0, 0 
	BCF         PORTA+0, 7 
	BCF         PORTE+0, 1 
	BSF         PORTE+0, 0 
	BCF         PORTC+0, 2 
	BCF         PORTA+0, 6 
	GOTO        L_SetChar15
;SevenSegmentManager.c,151 :: 		case 0x06:
L_SetChar22:
;SevenSegmentManager.c,152 :: 		SegA=On;SegB=Off;SegC=On;SegD=On;SegE=On;SegF=On;SegG=On;break;
	BCF         PORTD+0, 0 
	BSF         PORTC+0, 0 
	BCF         PORTA+0, 7 
	BCF         PORTE+0, 1 
	BCF         PORTE+0, 0 
	BCF         PORTC+0, 2 
	BCF         PORTA+0, 6 
	GOTO        L_SetChar15
;SevenSegmentManager.c,154 :: 		case 0x07:
L_SetChar23:
;SevenSegmentManager.c,155 :: 		SegA=On;SegB=On;SegC=On;SegD=Off;SegE=Off;SegF=Off;SegG=Off;break;
	BCF         PORTD+0, 0 
	BCF         PORTC+0, 0 
	BCF         PORTA+0, 7 
	BSF         PORTE+0, 1 
	BSF         PORTE+0, 0 
	BSF         PORTC+0, 2 
	BSF         PORTA+0, 6 
	GOTO        L_SetChar15
;SevenSegmentManager.c,157 :: 		case 0x08:
L_SetChar24:
;SevenSegmentManager.c,158 :: 		SegA=On;SegB=On;SegC=On;SegD=On;SegE=On;SegF=On;SegG=On;break;
	BCF         PORTD+0, 0 
	BCF         PORTC+0, 0 
	BCF         PORTA+0, 7 
	BCF         PORTE+0, 1 
	BCF         PORTE+0, 0 
	BCF         PORTC+0, 2 
	BCF         PORTA+0, 6 
	GOTO        L_SetChar15
;SevenSegmentManager.c,160 :: 		case 0x09:
L_SetChar25:
;SevenSegmentManager.c,161 :: 		SegA=On;SegB=On;SegC=On;SegD=On;SegE=Off;SegF=On;SegG=On;break;
	BCF         PORTD+0, 0 
	BCF         PORTC+0, 0 
	BCF         PORTA+0, 7 
	BCF         PORTE+0, 1 
	BSF         PORTE+0, 0 
	BCF         PORTC+0, 2 
	BCF         PORTA+0, 6 
	GOTO        L_SetChar15
;SevenSegmentManager.c,163 :: 		case 0x0A:
L_SetChar26:
;SevenSegmentManager.c,164 :: 		PlayAnimation(1);
	MOVLW       1
	MOVWF       FARG_PlayAnimation_animCode+0 
	CALL        _PlayAnimation+0, 0
;SevenSegmentManager.c,166 :: 		case 11:
L_SetChar27:
;SevenSegmentManager.c,167 :: 		SegA=Off;SegB=Off;SegC=Off;SegD=On;SegE=Off;SegF=Off;SegG=Off;break;
	BSF         PORTD+0, 0 
	BSF         PORTC+0, 0 
	BSF         PORTA+0, 7 
	BCF         PORTE+0, 1 
	BSF         PORTE+0, 0 
	BSF         PORTC+0, 2 
	BSF         PORTA+0, 6 
	GOTO        L_SetChar15
;SevenSegmentManager.c,169 :: 		case 12:
L_SetChar28:
;SevenSegmentManager.c,170 :: 		SegA=Off;SegB=Off;SegC=Off;SegD=Off;SegE=Off;SegF=Off;SegG=On;break;
	BSF         PORTD+0, 0 
	BSF         PORTC+0, 0 
	BSF         PORTA+0, 7 
	BSF         PORTE+0, 1 
	BSF         PORTE+0, 0 
	BSF         PORTC+0, 2 
	BCF         PORTA+0, 6 
	GOTO        L_SetChar15
;SevenSegmentManager.c,172 :: 		case 13:
L_SetChar29:
;SevenSegmentManager.c,173 :: 		SegA=On;SegB=Off;SegC=Off;SegD=On;SegE=Off;SegF=Off;SegG=On;break;
	BCF         PORTD+0, 0 
	BSF         PORTC+0, 0 
	BSF         PORTA+0, 7 
	BCF         PORTE+0, 1 
	BSF         PORTE+0, 0 
	BSF         PORTC+0, 2 
	BCF         PORTA+0, 6 
	GOTO        L_SetChar15
;SevenSegmentManager.c,174 :: 		}
L_SetChar14:
	MOVF        FARG_SetChar_ch+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SetChar16
	MOVF        FARG_SetChar_ch+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SetChar17
	MOVF        FARG_SetChar_ch+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SetChar18
	MOVF        FARG_SetChar_ch+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SetChar19
	MOVF        FARG_SetChar_ch+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SetChar20
	MOVF        FARG_SetChar_ch+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SetChar21
	MOVF        FARG_SetChar_ch+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SetChar22
	MOVF        FARG_SetChar_ch+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SetChar23
	MOVF        FARG_SetChar_ch+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SetChar24
	MOVF        FARG_SetChar_ch+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SetChar25
	MOVF        FARG_SetChar_ch+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_SetChar26
	MOVF        FARG_SetChar_ch+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_SetChar27
	MOVF        FARG_SetChar_ch+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_SetChar28
	MOVF        FARG_SetChar_ch+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_SetChar29
L_SetChar15:
;SevenSegmentManager.c,175 :: 		}
L_end_SetChar:
	RETURN      0
; end of _SetChar

_SetCharI:

;SevenSegmentManager.c,189 :: 		void SetCharI(char ch)
;SevenSegmentManager.c,191 :: 		char i=ch;
	MOVF        FARG_SetCharI_ch+0, 0 
	MOVWF       SetCharI_i_L0+0 
;SevenSegmentManager.c,193 :: 		if(i.b7)SegDpI=On;
	BTFSS       SetCharI_i_L0+0, 7 
	GOTO        L_SetCharI30
	BCF         PORTE+0, 2 
	GOTO        L_SetCharI31
L_SetCharI30:
;SevenSegmentManager.c,194 :: 		else SegDpI=Off;
	BSF         PORTE+0, 2 
L_SetCharI31:
;SevenSegmentManager.c,196 :: 		i.b0=0;
	BCF         SetCharI_i_L0+0, 0 
;SevenSegmentManager.c,198 :: 		switch(ch)
	GOTO        L_SetCharI32
;SevenSegmentManager.c,200 :: 		case 0x00:
L_SetCharI34:
;SevenSegmentManager.c,201 :: 		SegAI=On;SegBI=On;SegCI=On;SegDI=On;SegEI=On;SegFI=On;SegGI=Off;break;
	BCF         PORTE+0, 1 
	BCF         PORTE+0, 0 
	BCF         PORTC+0, 2 
	BCF         PORTD+0, 0 
	BCF         PORTC+0, 0 
	BCF         PORTA+0, 7 
	BSF         PORTA+0, 6 
	GOTO        L_SetCharI33
;SevenSegmentManager.c,203 :: 		case 0x01:
L_SetCharI35:
;SevenSegmentManager.c,204 :: 		SegAI=Off;SegBI=On;SegCI=On;SegDI=Off;SegEI=Off;SegFI=Off;SegGI=Off;break;
	BSF         PORTE+0, 1 
	BCF         PORTE+0, 0 
	BCF         PORTC+0, 2 
	BSF         PORTD+0, 0 
	BSF         PORTC+0, 0 
	BSF         PORTA+0, 7 
	BSF         PORTA+0, 6 
	GOTO        L_SetCharI33
;SevenSegmentManager.c,206 :: 		case 0x02:
L_SetCharI36:
;SevenSegmentManager.c,207 :: 		SegAI=On;SegBI=On;SegCI=Off;SegDI=On;SegEI=On;SegFI=Off;SegGI=On;break;
	BCF         PORTE+0, 1 
	BCF         PORTE+0, 0 
	BSF         PORTC+0, 2 
	BCF         PORTD+0, 0 
	BCF         PORTC+0, 0 
	BSF         PORTA+0, 7 
	BCF         PORTA+0, 6 
	GOTO        L_SetCharI33
;SevenSegmentManager.c,209 :: 		case 0x03:
L_SetCharI37:
;SevenSegmentManager.c,210 :: 		SegAI=On;SegBI=On;SegCI=On;SegDI=On;SegEI=Off;SegFI=Off;SegGI=On;break;
	BCF         PORTE+0, 1 
	BCF         PORTE+0, 0 
	BCF         PORTC+0, 2 
	BCF         PORTD+0, 0 
	BSF         PORTC+0, 0 
	BSF         PORTA+0, 7 
	BCF         PORTA+0, 6 
	GOTO        L_SetCharI33
;SevenSegmentManager.c,212 :: 		case 0x04:
L_SetCharI38:
;SevenSegmentManager.c,213 :: 		SegAI=Off;SegBI=On;SegCI=On;SegDI=Off;SegEI=Off;SegFI=On;SegGI=On;break;
	BSF         PORTE+0, 1 
	BCF         PORTE+0, 0 
	BCF         PORTC+0, 2 
	BSF         PORTD+0, 0 
	BSF         PORTC+0, 0 
	BCF         PORTA+0, 7 
	BCF         PORTA+0, 6 
	GOTO        L_SetCharI33
;SevenSegmentManager.c,215 :: 		case 0x05:
L_SetCharI39:
;SevenSegmentManager.c,216 :: 		SegAI=On;SegBI=Off;SegCI=On;SegDI=On;SegEI=Off;SegFI=On;SegGI=On;break;
	BCF         PORTE+0, 1 
	BSF         PORTE+0, 0 
	BCF         PORTC+0, 2 
	BCF         PORTD+0, 0 
	BSF         PORTC+0, 0 
	BCF         PORTA+0, 7 
	BCF         PORTA+0, 6 
	GOTO        L_SetCharI33
;SevenSegmentManager.c,218 :: 		case 0x06:
L_SetCharI40:
;SevenSegmentManager.c,219 :: 		SegAI=On;SegBI=Off;SegCI=On;SegDI=On;SegEI=On;SegFI=On;SegGI=On;break;
	BCF         PORTE+0, 1 
	BSF         PORTE+0, 0 
	BCF         PORTC+0, 2 
	BCF         PORTD+0, 0 
	BCF         PORTC+0, 0 
	BCF         PORTA+0, 7 
	BCF         PORTA+0, 6 
	GOTO        L_SetCharI33
;SevenSegmentManager.c,221 :: 		case 0x07:
L_SetCharI41:
;SevenSegmentManager.c,222 :: 		SegAI=On;SegBI=On;SegCI=On;SegDI=Off;SegEI=Off;SegFI=Off;SegGI=Off;break;
	BCF         PORTE+0, 1 
	BCF         PORTE+0, 0 
	BCF         PORTC+0, 2 
	BSF         PORTD+0, 0 
	BSF         PORTC+0, 0 
	BSF         PORTA+0, 7 
	BSF         PORTA+0, 6 
	GOTO        L_SetCharI33
;SevenSegmentManager.c,224 :: 		case 0x08:
L_SetCharI42:
;SevenSegmentManager.c,225 :: 		SegAI=On;SegBI=On;SegCI=On;SegDI=On;SegEI=On;SegFI=On;SegGI=On;break;
	BCF         PORTE+0, 1 
	BCF         PORTE+0, 0 
	BCF         PORTC+0, 2 
	BCF         PORTD+0, 0 
	BCF         PORTC+0, 0 
	BCF         PORTA+0, 7 
	BCF         PORTA+0, 6 
	GOTO        L_SetCharI33
;SevenSegmentManager.c,227 :: 		case 0x09:
L_SetCharI43:
;SevenSegmentManager.c,228 :: 		SegAI=On;SegBI=On;SegCI=On;SegDI=On;SegEI=Off;SegFI=On;SegGI=On;break;
	BCF         PORTE+0, 1 
	BCF         PORTE+0, 0 
	BCF         PORTC+0, 2 
	BCF         PORTD+0, 0 
	BSF         PORTC+0, 0 
	BCF         PORTA+0, 7 
	BCF         PORTA+0, 6 
	GOTO        L_SetCharI33
;SevenSegmentManager.c,230 :: 		case 0x0A:
L_SetCharI44:
;SevenSegmentManager.c,231 :: 		PlayAnimation(1);
	MOVLW       1
	MOVWF       FARG_PlayAnimation_animCode+0 
	CALL        _PlayAnimation+0, 0
;SevenSegmentManager.c,233 :: 		case 11:
L_SetCharI45:
;SevenSegmentManager.c,234 :: 		SegAI=Off;SegBI=Off;SegCI=Off;SegDI=On;SegEI=Off;SegFI=Off;SegGI=Off;break;
	BSF         PORTE+0, 1 
	BSF         PORTE+0, 0 
	BSF         PORTC+0, 2 
	BCF         PORTD+0, 0 
	BSF         PORTC+0, 0 
	BSF         PORTA+0, 7 
	BSF         PORTA+0, 6 
	GOTO        L_SetCharI33
;SevenSegmentManager.c,236 :: 		case 12:
L_SetCharI46:
;SevenSegmentManager.c,237 :: 		SegAI=Off;SegBI=Off;SegCI=Off;SegDI=Off;SegEI=Off;SegFI=Off;SegGI=On;break;
	BSF         PORTE+0, 1 
	BSF         PORTE+0, 0 
	BSF         PORTC+0, 2 
	BSF         PORTD+0, 0 
	BSF         PORTC+0, 0 
	BSF         PORTA+0, 7 
	BCF         PORTA+0, 6 
	GOTO        L_SetCharI33
;SevenSegmentManager.c,239 :: 		case 13:
L_SetCharI47:
;SevenSegmentManager.c,240 :: 		SegAI=On;SegBI=Off;SegCI=Off;SegDI=On;SegEI=Off;SegFI=Off;SegGI=On;break;
	BCF         PORTE+0, 1 
	BSF         PORTE+0, 0 
	BSF         PORTC+0, 2 
	BCF         PORTD+0, 0 
	BSF         PORTC+0, 0 
	BSF         PORTA+0, 7 
	BCF         PORTA+0, 6 
	GOTO        L_SetCharI33
;SevenSegmentManager.c,241 :: 		}
L_SetCharI32:
	MOVF        FARG_SetCharI_ch+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SetCharI34
	MOVF        FARG_SetCharI_ch+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SetCharI35
	MOVF        FARG_SetCharI_ch+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SetCharI36
	MOVF        FARG_SetCharI_ch+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SetCharI37
	MOVF        FARG_SetCharI_ch+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SetCharI38
	MOVF        FARG_SetCharI_ch+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SetCharI39
	MOVF        FARG_SetCharI_ch+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SetCharI40
	MOVF        FARG_SetCharI_ch+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SetCharI41
	MOVF        FARG_SetCharI_ch+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SetCharI42
	MOVF        FARG_SetCharI_ch+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SetCharI43
	MOVF        FARG_SetCharI_ch+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_SetCharI44
	MOVF        FARG_SetCharI_ch+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_SetCharI45
	MOVF        FARG_SetCharI_ch+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_SetCharI46
	MOVF        FARG_SetCharI_ch+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_SetCharI47
L_SetCharI33:
;SevenSegmentManager.c,242 :: 		}
L_end_SetCharI:
	RETURN      0
; end of _SetCharI

_SevenSegmentManager_Task:

;SevenSegmentManager.c,255 :: 		void SevenSegmentManager_Task(SevenSegment *sys)
;SevenSegmentManager.c,258 :: 		if(RTL==0)
	MOVF        _RTL+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SevenSegmentManager_Task48
;SevenSegmentManager.c,260 :: 		DisableSegments();
	CALL        _DisableSegments+0, 0
;SevenSegmentManager.c,261 :: 		SetChar(sys->Display[sys->RefreshCounter]);
	MOVLW       4
	ADDWF       FARG_SevenSegmentManager_Task_sys+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_SevenSegmentManager_Task_sys+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_SevenSegmentManager_Task_sys+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SevenSegmentManager_Task_sys+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SetChar_ch+0 
	CALL        _SetChar+0, 0
;SevenSegmentManager.c,262 :: 		if(sys->RefreshCounter==1)
	MOVLW       4
	ADDWF       FARG_SevenSegmentManager_Task_sys+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SevenSegmentManager_Task_sys+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SevenSegmentManager_Task49
;SevenSegmentManager.c,263 :: 		SegDp=CenterFlash;
	BTFSC       _CenterFlash+0, 0 
	GOTO        L__SevenSegmentManager_Task62
	BCF         PORTE+0, 2 
	GOTO        L__SevenSegmentManager_Task63
L__SevenSegmentManager_Task62:
	BSF         PORTE+0, 2 
L__SevenSegmentManager_Task63:
L_SevenSegmentManager_Task49:
;SevenSegmentManager.c,264 :: 		EnableSegment(sys->RefreshCounter);
	MOVLW       4
	ADDWF       FARG_SevenSegmentManager_Task_sys+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SevenSegmentManager_Task_sys+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EnableSegment_seg+0 
	CALL        _EnableSegment+0, 0
;SevenSegmentManager.c,265 :: 		}
	GOTO        L_SevenSegmentManager_Task50
L_SevenSegmentManager_Task48:
;SevenSegmentManager.c,268 :: 		DisableSegments();
	CALL        _DisableSegments+0, 0
;SevenSegmentManager.c,269 :: 		SetCharI(sys->Display[sys->RefreshCounter]);
	MOVLW       4
	ADDWF       FARG_SevenSegmentManager_Task_sys+0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      FARG_SevenSegmentManager_Task_sys+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_SevenSegmentManager_Task_sys+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SevenSegmentManager_Task_sys+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SetCharI_ch+0 
	CALL        _SetCharI+0, 0
;SevenSegmentManager.c,270 :: 		if(sys->RefreshCounter==2)
	MOVLW       4
	ADDWF       FARG_SevenSegmentManager_Task_sys+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SevenSegmentManager_Task_sys+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SevenSegmentManager_Task51
;SevenSegmentManager.c,271 :: 		SegDpI=CenterFlash;
	BTFSC       _CenterFlash+0, 0 
	GOTO        L__SevenSegmentManager_Task64
	BCF         PORTE+0, 2 
	GOTO        L__SevenSegmentManager_Task65
L__SevenSegmentManager_Task64:
	BSF         PORTE+0, 2 
L__SevenSegmentManager_Task65:
L_SevenSegmentManager_Task51:
;SevenSegmentManager.c,272 :: 		EnableSegmentI(sys->RefreshCounter);
	MOVLW       4
	ADDWF       FARG_SevenSegmentManager_Task_sys+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SevenSegmentManager_Task_sys+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EnableSegmentI_seg+0 
	CALL        _EnableSegmentI+0, 0
;SevenSegmentManager.c,273 :: 		}
L_SevenSegmentManager_Task50:
;SevenSegmentManager.c,277 :: 		sys->RefreshCounter=sys->RefreshCounter+1;
	MOVLW       4
	ADDWF       FARG_SevenSegmentManager_Task_sys+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      FARG_SevenSegmentManager_Task_sys+1, 0 
	MOVWF       R2 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;SevenSegmentManager.c,278 :: 		if(sys->RefreshCounter >= DIGITS)
	MOVLW       4
	ADDWF       FARG_SevenSegmentManager_Task_sys+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SevenSegmentManager_Task_sys+1, 0 
	MOVWF       FSR0H 
	MOVLW       4
	SUBWF       POSTINC0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SevenSegmentManager_Task52
;SevenSegmentManager.c,279 :: 		sys->RefreshCounter=0;
	MOVLW       4
	ADDWF       FARG_SevenSegmentManager_Task_sys+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_SevenSegmentManager_Task_sys+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
L_SevenSegmentManager_Task52:
;SevenSegmentManager.c,280 :: 		}
L_end_SevenSegmentManager_Task:
	RETURN      0
; end of _SevenSegmentManager_Task

_SevenSegmentManager_AnimationEPOCH:

;SevenSegmentManager.c,293 :: 		void SevenSegmentManager_AnimationEPOCH(SevenSegment *sys)
;SevenSegmentManager.c,295 :: 		if(sys->AnimationCounter >= 255)
	MOVLW       5
	ADDWF       FARG_SevenSegmentManager_AnimationEPOCH_sys+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SevenSegmentManager_AnimationEPOCH_sys+1, 0 
	MOVWF       FSR0H 
	MOVLW       255
	SUBWF       POSTINC0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_SevenSegmentManager_AnimationEPOCH53
;SevenSegmentManager.c,296 :: 		sys->AnimationCounter=0;
	MOVLW       5
	ADDWF       FARG_SevenSegmentManager_AnimationEPOCH_sys+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_SevenSegmentManager_AnimationEPOCH_sys+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	GOTO        L_SevenSegmentManager_AnimationEPOCH54
L_SevenSegmentManager_AnimationEPOCH53:
;SevenSegmentManager.c,298 :: 		sys->AnimationCounter=sys->AnimationCounter+1;
	MOVLW       5
	ADDWF       FARG_SevenSegmentManager_AnimationEPOCH_sys+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      FARG_SevenSegmentManager_AnimationEPOCH_sys+1, 0 
	MOVWF       R2 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_SevenSegmentManager_AnimationEPOCH54:
;SevenSegmentManager.c,299 :: 		}
L_end_SevenSegmentManager_AnimationEPOCH:
	RETURN      0
; end of _SevenSegmentManager_AnimationEPOCH
