#ifndef _SEVENSEGMODULE
#define _SEVENSEGMODULE

#define EnableLogic 0
#define DisableLogic 1

#define On 0
#define Off 1

#define DIGITS 4

#define SegA portd.b0
#define SegB portc.b0
#define SegC porta.b7
#define SegD porte.b1
#define SegE porte.b0
#define SegF portc.b2
#define SegG porta.b6
#define SegDp porte.b2


#define SegAI porte.b1
#define SegBI porte.b0
#define SegCI portc.b2
#define SegDI portd.b0
#define SegEI portc.b0
#define SegFI porta.b7
#define SegGI porta.b6
#define SegDpI porte.b2

#define Digit1En portb.b0
#define Digit2En portb.b3
#define Digit3En portb.b2
#define Digit4En portb.b1

#define Digit1EnI portb.b1
#define Digit2EnI portb.b2
#define Digit3EnI portb.b3
#define Digit4EnI portb.b0
//#define Digit5En portd.b0
//#define Digit6En portd.b0







typedef struct
{
  char Display[DIGITS];
  char RefreshCounter;
  char AnimationCounter;
}SevenSegment;


extern char RTL;
extern char CenterFlash;


void SevenSegmentManager_Task(SevenSegment *);
void SevenSegmentManager_AnimationEPOCH(SevenSegment *);

#endif