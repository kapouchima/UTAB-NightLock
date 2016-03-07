#line 1 "C:/Users/Kapouchima/Desktop/Lock/Firmware/UTAB-NightLock/7Seg/SevenSegmentManager.c"
#line 1 "c:/users/kapouchima/desktop/lock/firmware/utab-nightlock/7seg/sevensegmentmanager.h"
#line 49 "c:/users/kapouchima/desktop/lock/firmware/utab-nightlock/7seg/sevensegmentmanager.h"
typedef struct
{
 char Display[ 4 ];
 char RefreshCounter;
 char AnimationCounter;
}SevenSegment;


extern char RTL;
extern char CenterFlash;


void SevenSegmentManager_Task(SevenSegment *);
void SevenSegmentManager_AnimationEPOCH(SevenSegment *);
#line 12 "C:/Users/Kapouchima/Desktop/Lock/Firmware/UTAB-NightLock/7Seg/SevenSegmentManager.c"
void DisableSegments()
{
  portb.b0 = 1 ;

  portb.b3 = 1 ;


  portb.b2 = 1 ;


  portb.b1 = 1 ;

}









void EnableSegment(char seg)
{
 switch(seg)
 {
 case 0:
  portb.b0 = 0 ;
 break;

 case 1:
  portb.b3 = 0 ;
 break;

 case 2:
  portb.b2 = 0 ;
 break;

 case 3:
  portb.b1 = 0 ;
 break;

 }
}
#line 69 "C:/Users/Kapouchima/Desktop/Lock/Firmware/UTAB-NightLock/7Seg/SevenSegmentManager.c"
void EnableSegmentI(char seg)
{
 switch(seg)
 {
 case 0:
  portb.b1 = 0 ;
 break;

 case 1:
  portb.b2 = 0 ;
 break;

 case 2:
  portb.b3 = 0 ;
 break;

 case 3:
  portb.b0 = 0 ;
 break;

 }
}
#line 103 "C:/Users/Kapouchima/Desktop/Lock/Firmware/UTAB-NightLock/7Seg/SevenSegmentManager.c"
void PlayAnimation(char animCode)
{

}
#line 122 "C:/Users/Kapouchima/Desktop/Lock/Firmware/UTAB-NightLock/7Seg/SevenSegmentManager.c"
void SetChar(char ch)
{
 char i=ch;

 if(i.b7) porte.b2 = 0 ;
 else  porte.b2 = 1 ;

 i.b0=0;

 switch(ch)
 {
 case 0x00:
  portd.b0 = 0 ; portc.b0 = 0 ; porta.b7 = 0 ; porte.b1 = 0 ; porte.b0 = 0 ; portc.b2 = 0 ; porta.b6 = 1 ;break;

 case 0x01:
  portd.b0 = 1 ; portc.b0 = 0 ; porta.b7 = 0 ; porte.b1 = 1 ; porte.b0 = 1 ; portc.b2 = 1 ; porta.b6 = 1 ;break;

 case 0x02:
  portd.b0 = 0 ; portc.b0 = 0 ; porta.b7 = 1 ; porte.b1 = 0 ; porte.b0 = 0 ; portc.b2 = 1 ; porta.b6 = 0 ;break;

 case 0x03:
  portd.b0 = 0 ; portc.b0 = 0 ; porta.b7 = 0 ; porte.b1 = 0 ; porte.b0 = 1 ; portc.b2 = 1 ; porta.b6 = 0 ;break;

 case 0x04:
  portd.b0 = 1 ; portc.b0 = 0 ; porta.b7 = 0 ; porte.b1 = 1 ; porte.b0 = 1 ; portc.b2 = 0 ; porta.b6 = 0 ;break;

 case 0x05:
  portd.b0 = 0 ; portc.b0 = 1 ; porta.b7 = 0 ; porte.b1 = 0 ; porte.b0 = 1 ; portc.b2 = 0 ; porta.b6 = 0 ;break;

 case 0x06:
  portd.b0 = 0 ; portc.b0 = 1 ; porta.b7 = 0 ; porte.b1 = 0 ; porte.b0 = 0 ; portc.b2 = 0 ; porta.b6 = 0 ;break;

 case 0x07:
  portd.b0 = 0 ; portc.b0 = 0 ; porta.b7 = 0 ; porte.b1 = 1 ; porte.b0 = 1 ; portc.b2 = 1 ; porta.b6 = 1 ;break;

 case 0x08:
  portd.b0 = 0 ; portc.b0 = 0 ; porta.b7 = 0 ; porte.b1 = 0 ; porte.b0 = 0 ; portc.b2 = 0 ; porta.b6 = 0 ;break;

 case 0x09:
  portd.b0 = 0 ; portc.b0 = 0 ; porta.b7 = 0 ; porte.b1 = 0 ; porte.b0 = 1 ; portc.b2 = 0 ; porta.b6 = 0 ;break;

 case 0x0A:
 PlayAnimation(1);

 case 11:
  portd.b0 = 1 ; portc.b0 = 1 ; porta.b7 = 1 ; porte.b1 = 0 ; porte.b0 = 1 ; portc.b2 = 1 ; porta.b6 = 1 ;break;

 case 12:
  portd.b0 = 1 ; portc.b0 = 1 ; porta.b7 = 1 ; porte.b1 = 1 ; porte.b0 = 1 ; portc.b2 = 1 ; porta.b6 = 0 ;break;

 case 13:
  portd.b0 = 0 ; portc.b0 = 1 ; porta.b7 = 1 ; porte.b1 = 0 ; porte.b0 = 1 ; portc.b2 = 1 ; porta.b6 = 0 ;break;
 }
}
#line 189 "C:/Users/Kapouchima/Desktop/Lock/Firmware/UTAB-NightLock/7Seg/SevenSegmentManager.c"
void SetCharI(char ch)
{
 char i=ch;

 if(i.b7) porte.b2 = 0 ;
 else  porte.b2 = 1 ;

 i.b0=0;

 switch(ch)
 {
 case 0x00:
  porte.b1 = 0 ; porte.b0 = 0 ; portc.b2 = 0 ; portd.b0 = 0 ; portc.b0 = 0 ; porta.b7 = 0 ; porta.b6 = 1 ;break;

 case 0x01:
  porte.b1 = 1 ; porte.b0 = 0 ; portc.b2 = 0 ; portd.b0 = 1 ; portc.b0 = 1 ; porta.b7 = 1 ; porta.b6 = 1 ;break;

 case 0x02:
  porte.b1 = 0 ; porte.b0 = 0 ; portc.b2 = 1 ; portd.b0 = 0 ; portc.b0 = 0 ; porta.b7 = 1 ; porta.b6 = 0 ;break;

 case 0x03:
  porte.b1 = 0 ; porte.b0 = 0 ; portc.b2 = 0 ; portd.b0 = 0 ; portc.b0 = 1 ; porta.b7 = 1 ; porta.b6 = 0 ;break;

 case 0x04:
  porte.b1 = 1 ; porte.b0 = 0 ; portc.b2 = 0 ; portd.b0 = 1 ; portc.b0 = 1 ; porta.b7 = 0 ; porta.b6 = 0 ;break;

 case 0x05:
  porte.b1 = 0 ; porte.b0 = 1 ; portc.b2 = 0 ; portd.b0 = 0 ; portc.b0 = 1 ; porta.b7 = 0 ; porta.b6 = 0 ;break;

 case 0x06:
  porte.b1 = 0 ; porte.b0 = 1 ; portc.b2 = 0 ; portd.b0 = 0 ; portc.b0 = 0 ; porta.b7 = 0 ; porta.b6 = 0 ;break;

 case 0x07:
  porte.b1 = 0 ; porte.b0 = 0 ; portc.b2 = 0 ; portd.b0 = 1 ; portc.b0 = 1 ; porta.b7 = 1 ; porta.b6 = 1 ;break;

 case 0x08:
  porte.b1 = 0 ; porte.b0 = 0 ; portc.b2 = 0 ; portd.b0 = 0 ; portc.b0 = 0 ; porta.b7 = 0 ; porta.b6 = 0 ;break;

 case 0x09:
  porte.b1 = 0 ; porte.b0 = 0 ; portc.b2 = 0 ; portd.b0 = 0 ; portc.b0 = 1 ; porta.b7 = 0 ; porta.b6 = 0 ;break;

 case 0x0A:
 PlayAnimation(1);

 case 11:
  porte.b1 = 1 ; porte.b0 = 1 ; portc.b2 = 1 ; portd.b0 = 0 ; portc.b0 = 1 ; porta.b7 = 1 ; porta.b6 = 1 ;break;

 case 12:
  porte.b1 = 1 ; porte.b0 = 1 ; portc.b2 = 1 ; portd.b0 = 1 ; portc.b0 = 1 ; porta.b7 = 1 ; porta.b6 = 0 ;break;

 case 13:
  porte.b1 = 0 ; porte.b0 = 1 ; portc.b2 = 1 ; portd.b0 = 0 ; portc.b0 = 1 ; porta.b7 = 1 ; porta.b6 = 0 ;break;
 }
}
#line 255 "C:/Users/Kapouchima/Desktop/Lock/Firmware/UTAB-NightLock/7Seg/SevenSegmentManager.c"
void SevenSegmentManager_Task(SevenSegment *sys)
{

 if(RTL==0)
 {
 DisableSegments();
 SetChar(sys->Display[sys->RefreshCounter]);
 if((sys->RefreshCounter==3)||(sys->RefreshCounter==2))
  porte.b2 =CenterFlash;
 EnableSegment(sys->RefreshCounter);
 }
 else
 {
 DisableSegments();
 SetCharI(sys->Display[sys->RefreshCounter]);
 if((sys->RefreshCounter==0)||(sys->RefreshCounter==1))
  porte.b2 =CenterFlash;
 EnableSegmentI(sys->RefreshCounter);
 }



 sys->RefreshCounter=sys->RefreshCounter+1;
 if(sys->RefreshCounter >=  4 )
 sys->RefreshCounter=0;
}
#line 293 "C:/Users/Kapouchima/Desktop/Lock/Firmware/UTAB-NightLock/7Seg/SevenSegmentManager.c"
void SevenSegmentManager_AnimationEPOCH(SevenSegment *sys)
{
 if(sys->AnimationCounter >= 255)
 sys->AnimationCounter=0;
 else
 sys->AnimationCounter=sys->AnimationCounter+1;
}
