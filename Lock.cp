#line 1 "C:/Users/Kapouchima/Desktop/Lock/Firmware/Lock.c"
#line 1 "c:/users/kapouchima/desktop/lock/firmware/7seg/sevensegmentmanager.h"
#line 49 "c:/users/kapouchima/desktop/lock/firmware/7seg/sevensegmentmanager.h"
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
#line 1 "c:/users/kapouchima/desktop/lock/firmware/keys/keys.h"
#line 41 "c:/users/kapouchima/desktop/lock/firmware/keys/keys.h"
void KeysSystem_EPOCH();
char KeysSystem_Task();
#line 1 "c:/users/kapouchima/desktop/lock/firmware/ds3231/ds3231.h"




typedef struct
{
 char SecondBCD;
 char MinuteBCD;
 char HourBCD;

}Time;



void SetTime(Time *t);
void GetTime(Time *t);
#line 1 "c:/users/kapouchima/desktop/lock/firmware/signaling/signaling.h"
#line 30 "c:/users/kapouchima/desktop/lock/firmware/signaling/signaling.h"
typedef struct
{
 char SignalCode;
 unsigned long Time;
 char Expired;
 char Fired;
}Signal;

typedef struct
{
 Signal SignalQueue[ 10 ];
 unsigned long SystemEPOCH;
}SignalingSystem;

void SignalingSystem_SystemEPOCH(SignalingSystem *);
void SignalingSystem_AddSignal(SignalingSystem *,unsigned long ,char );
char SignalingSystem_CheckSignal(SignalingSystem * ,char );
void SignalingSystem_ClearSignal(SignalingSystem *,char);
void SignalingSystem_ClearAllSignals(SignalingSystem * ,char );
void SignalingSystem_Task(SignalingSystem *);
void SignalingSystem_Init(SignalingSystem *);
#line 34 "C:/Users/Kapouchima/Desktop/Lock/Firmware/Lock.c"
char Pass[4],TimeTemp[4],PassCounter=0,MenuExpireCounter=0,CenterFlash=1,SetCounter=0;
char Keys=0,Flag10ms=0,Flag500ms=0,Counter10ms=0,State=0,RTL=1,ValuePosition=0,StateOfNow=2;
Time Now,temp;


char TempLockTime[4],TempUnlockTime[4];

char LockTime[4];
char UnlockTime[4];
char OpenPass[4];
char MenuPass[4];


SevenSegment Segment;
SignalingSystem SigSys;


void MotorManager();
char CheckKey(char);
void StateManager();
void State0();
void State1();
void State2();
void State3();
void Menu0();
void Menu1();
void SaveConfig();
void LoadConfig();
char GetDesireStatus();
char TimeCompare(char *,char *);
void LockManager();



void Init()
{

 OSCCON=0b01100000;
 OSCTUNE.PLLEN=1;

 ANCON0=0;
 ANCON1=0;

 porta=0;
 portb=0;
 portc=0;
 portd=0;
 porte=0;
 trisa=0b00111111;
 trisb=0b11110000;
 trisc=0b11100010;
 trisd=0b01110010;
 trise=0b1000;

 TMR0H=0xFC;
 TMR0L=0x17;
 T0CON=0b10000011;
 TMR0IE_bit=1;
 TMR0IF_bit=0;
 GIE_bit=1;

 I2C1_Init(50000);

 SignalingSystem_Init(&SigSys);

 LoadConfig();

}
#line 115 "C:/Users/Kapouchima/Desktop/Lock/Firmware/Lock.c"
void interrupt()
{
 if(TMR0IF_bit)
 {
 TMR0H=0xFC;
 TMR0L=0x17;
 Flag10ms=1;
 if(Counter10ms<250)
 {Counter10ms=Counter10ms+1;}
 else
 {Counter10ms=0; Flag500ms=1;}
 TMR0IF_bit=0;
 }
}
#line 146 "C:/Users/Kapouchima/Desktop/Lock/Firmware/Lock.c"
void main() {


 char i;



 Init();




 for(i=0;i<3;i++)
 {
  (portd.b7) =1;
 delay_ms(100);
  (portd.b7) =0;
 delay_ms(100);
 }





 while(1)
 {

 if(Flag10ms)
 {
 KeysSystem_EPOCH();
 SevenSegmentManager_Task(&Segment);
 Flag10ms=0;
 }

 if(Flag500ms)
 {
 if(MenuExpireCounter > 0)
 MenuExpireCounter=MenuExpireCounter-1;
 if(State==0)
 {CenterFlash=!CenterFlash;}
 else
 {CenterFlash=1;}
 SignalingSystem_SystemEPOCH(&SigSys);
 SignalingSystem_Task(&SigSys);
 GetTime(&Now);
  (portd.b7) =Now.SecondBCD%2;
 Flag500ms=0;
 }

 Keys=KeysSystem_Task();
 StateManager();
 LockManager();
 MotorManager();
 }
}
#line 220 "C:/Users/Kapouchima/Desktop/Lock/Firmware/Lock.c"
void LockManager()
{
 if(GetDesireStatus())
 if(StateOfNow!=1)
 {
 SignalingSystem_AddSignal(&SigSys,1,2);
 SignalingSystem_AddSignal(&SigSys,1+ 4 ,3);
 StateOfNow=1;
 }

 if(!GetDesireStatus())
 if(StateOfNow!=0)
 {
 SignalingSystem_AddSignal(&SigSys,1,1);
 SignalingSystem_AddSignal(&SigSys,1+ 4 ,3);
 StateOfNow=0;
 }

}
#line 263 "C:/Users/Kapouchima/Desktop/Lock/Firmware/Lock.c"
void StateManager()
{

 if(MenuExpireCounter == 0)
 {if(State!=0)LoadConfig();State=0;}

 switch(State)
 {
 case 0:
 State0();break;

 case 1:
 State1();break;

 case 2:
 State2();break;

 case 3:
 State3();break;

 case 10:
 Menu0();break;

 case 11:
 Menu1();break;

 }
}
#line 304 "C:/Users/Kapouchima/Desktop/Lock/Firmware/Lock.c"
void State0()
{

 Segment.Display[0]=12;Segment.Display[1]=12;Segment.Display[2]=12;Segment.Display[3]=12;
 if((CheckKey('U')) || (CheckKey('D')))
 {PassCounter=0;Pass[0]=0;Pass[1]=0;Pass[2]=0;Pass[3]=0;MenuExpireCounter= 30 ;State=1;}

 if((CheckKey('L')) && (CheckKey('R')))
 {RTL.b0=!RTL.b0; EEPROM_Write(16,RTL);}

 if(CheckKey('C'))
 {PassCounter=0;Pass[0]=0;Pass[1]=0;Pass[2]=0;Pass[3]=0;MenuExpireCounter= 30 ;State=3;}

}
#line 333 "C:/Users/Kapouchima/Desktop/Lock/Firmware/Lock.c"
void State1()
{
 if(CheckKey('U'))
 if(Pass[PassCounter] < 9) Pass[PassCounter]=Pass[PassCounter]+1;

 if(CheckKey('D'))
 if(Pass[PassCounter] > 0) Pass[PassCounter]=Pass[PassCounter]-1;

 if(CheckKey('L'))
 if(PassCounter > 0) PassCounter=PassCounter-1;

 if(CheckKey('R'))
 if(PassCounter < 3) PassCounter=PassCounter+1;

 if(CheckKey('C'))
 State=2;

 Segment.Display[0]=Pass[0];Segment.Display[1]=Pass[1];Segment.Display[2]=Pass[2];Segment.Display[3]=Pass[3];

}
#line 368 "C:/Users/Kapouchima/Desktop/Lock/Firmware/Lock.c"
void State2()
{
 if((Pass[0]==OpenPass[0]) && (Pass[1]==OpenPass[1]) && (Pass[2]==OpenPass[2]) && (Pass[3]==OpenPass[3]))
 {
 if(GetDesireStatus())
 {
 SignalingSystem_AddSignal(&SigSys,1,1);
 SignalingSystem_AddSignal(&SigSys,1+ 4 ,3);
 SignalingSystem_AddSignal(&SigSys,1+ 20 + 4 ,2);
 SignalingSystem_AddSignal(&SigSys,1+ 4 + 20 + 4 ,3);
 }
 else
 {
 SignalingSystem_AddSignal(&SigSys,1,1);
 SignalingSystem_AddSignal(&SigSys,1+ 4 ,3);
 }
 }
 State=0;
}
#line 405 "C:/Users/Kapouchima/Desktop/Lock/Firmware/Lock.c"
void State3()
{
 if(CheckKey('U'))
 if(Pass[PassCounter] < 9) Pass[PassCounter]=Pass[PassCounter]+1;

 if(CheckKey('D'))
 if(Pass[PassCounter] > 0) Pass[PassCounter]=Pass[PassCounter]-1;

 if(CheckKey('L'))
 if(PassCounter > 0) PassCounter=PassCounter-1;

 if(CheckKey('R'))
 if(PassCounter < 3) PassCounter=PassCounter+1;

 if(CheckKey('C'))
 {
 if((Pass[0]==MenuPass[0]) && (Pass[1]==MenuPass[1]) && (Pass[2]==MenuPass[2]) && (Pass[3]==MenuPass[3]))
 State=10;
 else
 State=0;
 }

 Segment.Display[0]=Pass[0];Segment.Display[1]=Pass[1];Segment.Display[2]=Pass[2];Segment.Display[3]=Pass[3];
}
#line 452 "C:/Users/Kapouchima/Desktop/Lock/Firmware/Lock.c"
void Menu0()
{
 Segment.Display[0]=13;Segment.Display[1]=13;Segment.Display[2]=13;Segment.Display[3]=13;

 if(CheckKey('U'))
 {SetCounter=0;State=11;ValuePosition=0;TempLockTime[0]=LockTime[0];TempLockTime[1]=LockTime[1];TempLockTime[2]=LockTime[2];TempLockTime[3]=LockTime[3];}

 if(CheckKey('D'))
 {SetCounter=1;State=11;ValuePosition=0;TempUnlockTime[0]=UnlockTime[0];TempUnlockTime[1]=UnlockTime[1];TempUnlockTime[2]=UnlockTime[2];TempUnlockTime[3]=UnlockTime[3];}

 if(CheckKey('L'))
 {TimeTemp[0]=Now.HourBCD>>4;TimeTemp[1]=Now.HourBCD&0x0F;TimeTemp[2]=Now.MinuteBCD>>4;TimeTemp[3]=Now.MinuteBCD&0x0F;SetCounter=2;State=11;ValuePosition=0;}

 if(CheckKey('R'))
 {SetCounter=3;State=11;ValuePosition=0;}

 if(CheckKey('C'))
 {SetCounter=4;State=11;ValuePosition=0;}
}
#line 487 "C:/Users/Kapouchima/Desktop/Lock/Firmware/Lock.c"
void Menu1()
{
 switch(SetCounter)
 {
 case 0:
 if(CheckKey('U'))
 {
 if(ValuePosition==0)if(TempLockTime[0]<2)TempLockTime[0]=TempLockTime[0]+1;
 if(ValuePosition==2)if(TempLockTime[2]<5)TempLockTime[2]=TempLockTime[2]+1;
 if(ValuePosition==1)if(TempLockTime[1]<9)TempLockTime[1]=TempLockTime[1]+1;
 if(ValuePosition==3)if(TempLockTime[3]<9)LockTime[3]=TempLockTime[3]+1;
 if((TempLockTime[0]>=2)&&(TempLockTime[1]>3))TempLockTime[1]=3;
 }

 if(CheckKey('D'))
 if(TempLockTime[ValuePosition]>0)TempLockTime[ValuePosition]=TempLockTime[ValuePosition]-1;

 if(CheckKey('R'))
 if(ValuePosition<3)ValuePosition=ValuePosition+1;

 if(CheckKey('L'))
 if(ValuePosition>0)ValuePosition=ValuePosition-1;

 if(CheckKey('C'))
 {LockTime[0]=TempLockTime[0];LockTime[1]=TempLockTime[1];LockTime[2]=TempLockTime[2];LockTime[3]=TempLockTime[3];SaveConfig();State=10;CenterFlash=1;}

 Segment.Display[0]=TempLockTime[0];Segment.Display[1]=TempLockTime[1];Segment.Display[2]=TempLockTime[2];Segment.Display[3]=TempLockTime[3];CenterFlash=0;
 break;


 case 1:
 if(CheckKey('U'))
 {
 if(ValuePosition==0)if(TempUnlockTime[0]<2)TempUnlockTime[0]=TempUnlockTime[0]+1;
 if(ValuePosition==2)if(TempUnlockTime[0]<5)TempUnlockTime[2]=TempUnlockTime[2]+1;
 if(ValuePosition==1)if(TempUnlockTime[1]<9)TempUnlockTime[1]=TempUnlockTime[1]+1;
 if(ValuePosition==3)if(TempUnlockTime[3]<9)TempUnlockTime[3]=TempUnlockTime[3]+1;
 if((TempUnlockTime[0]>=2)&&(TempUnlockTime[1]>3))TempUnlockTime[1]=3;
 }

 if(CheckKey('D'))
 if(TempUnlockTime[ValuePosition]>0)TempUnlockTime[ValuePosition]=TempUnlockTime[ValuePosition]-1;

 if(CheckKey('R'))
 if(ValuePosition<3)ValuePosition=ValuePosition+1;

 if(CheckKey('L'))
 if(ValuePosition>0)ValuePosition=ValuePosition-1;

 if(CheckKey('C'))
 {UnlockTime[0]=TempUnlockTime[0];UnlockTime[1]=TempUnlockTime[1];UnlockTime[2]=TempUnlockTime[2];UnlockTime[3]=TempUnlockTime[3];SaveConfig();State=10;CenterFlash=1;}

 Segment.Display[0]=TempUnlockTime[0];Segment.Display[1]=TempUnlockTime[1];Segment.Display[2]=TempUnlockTime[2];Segment.Display[3]=TempUnlockTime[3];CenterFlash=0;
 break;


 case 2:
 if(CheckKey('U'))
 {
 if(ValuePosition==0)if(TimeTemp[0]<2)TimeTemp[0]=TimeTemp[0]+1;
 if(ValuePosition==2)if(TimeTemp[2]<5)TimeTemp[2]=TimeTemp[2]+1;
 if(ValuePosition==1)if(TimeTemp[1]<9)TimeTemp[1]=TimeTemp[1]+1;
 if(ValuePosition==3)if(TimeTemp[3]<9)TimeTemp[3]=TimeTemp[3]+1;
 }

 if(CheckKey('D'))
 if(TimeTemp[ValuePosition]>0)TimeTemp[ValuePosition]=TimeTemp[ValuePosition]-1;

 if(CheckKey('R'))
 if(ValuePosition<3)ValuePosition=ValuePosition+1;

 if(CheckKey('L'))
 if(ValuePosition>0)ValuePosition=ValuePosition-1;

 if(CheckKey('C'))
 {
 temp.SecondBCD=0;temp.MinuteBCD=TimeTemp[2]<<4;temp.MinuteBCD=temp.MinuteBCD|TimeTemp[3];
 temp.HourBCD=TimeTemp[0]<<4;temp.HourBCD=temp.HourBCD|TimeTemp[1];
 SetTime(&temp);
 State=10;
 CenterFlash=1;
 }

 Segment.Display[0]=TimeTemp[0];Segment.Display[1]=TimeTemp[1];Segment.Display[2]=TimeTemp[2];Segment.Display[3]=TimeTemp[3];CenterFlash=0;
 break;

 case 3:
 if(CheckKey('U'))
 if(OpenPass[ValuePosition]<9)OpenPass[ValuePosition]=OpenPass[ValuePosition]+1;

 if(CheckKey('D'))
 if(OpenPass[ValuePosition]>0)OpenPass[ValuePosition]=OpenPass[ValuePosition]-1;

 if(CheckKey('R'))
 if(ValuePosition<3)ValuePosition=ValuePosition+1;

 if(CheckKey('L'))
 if(ValuePosition>0)ValuePosition=ValuePosition-1;

 if(CheckKey('C'))
 {SaveConfig();State=10;}

 Segment.Display[0]=OpenPass[0];Segment.Display[1]=OpenPass[1];Segment.Display[2]=OpenPass[2];Segment.Display[3]=OpenPass[3];
 break;


 case 4:
 if(CheckKey('U'))
 if(MenuPass[ValuePosition]<9)MenuPass[ValuePosition]=MenuPass[ValuePosition]+1;

 if(CheckKey('D'))
 if(MenuPass[ValuePosition]>0)MenuPass[ValuePosition]=MenuPass[ValuePosition]-1;

 if(CheckKey('R'))
 if(ValuePosition<3)ValuePosition=ValuePosition+1;

 if(CheckKey('L'))
 if(ValuePosition>0)ValuePosition=ValuePosition-1;

 if(CheckKey('C'))
 {SaveConfig();State=10;}

 Segment.Display[0]=MenuPass[0];Segment.Display[1]=MenuPass[1];Segment.Display[2]=MenuPass[2];Segment.Display[3]=MenuPass[3];
 break;

 }
}
#line 636 "C:/Users/Kapouchima/Desktop/Lock/Firmware/Lock.c"
char CheckKey(char key)
{
 if(key == 'U')
 {
 if(RTL==0){if(Keys &  (0b00010) ) {MenuExpireCounter= 30 ;return 1;}}
 else {if(Keys &  (0b00100) ) {MenuExpireCounter= 30 ;return 1;}}
 }

 if(key == 'D')
 {
 if(RTL==0){if(Keys &  (0b00100) ) {MenuExpireCounter= 30 ;return 1;}}
 else {if(Keys &  (0b00010) ) {MenuExpireCounter= 30 ;return 1;}}
 }

 if(key == 'R')
 {
 if(RTL==0){if(Keys &  (0b10000) ) {MenuExpireCounter= 30 ;return 1;}}
 else {if(Keys &  (0b00001) ) {MenuExpireCounter= 30 ;return 1;}}
 }

 if(key == 'L')
 {
 if(RTL==0){if(Keys &  (0b00001) ) {MenuExpireCounter= 30 ;return 1;}}
 else {if(Keys &  (0b10000) ) {MenuExpireCounter= 30 ;return 1;}}
 }

 if(key == 'C')
 {
 if(RTL==0){if(Keys &  (0b01000) ) {MenuExpireCounter= 30 ;return 1;}}
 else {if(Keys &  (0b01000) ) {MenuExpireCounter= 30 ;return 1;}}
 }

 return 0;

}
#line 691 "C:/Users/Kapouchima/Desktop/Lock/Firmware/Lock.c"
void MotorManager()
{
 if(SignalingSystem_CheckSignal(&SigSys, 1))
 { (portd.b3) =0; (portd.b2) =1;}

 if(SignalingSystem_CheckSignal(&SigSys, 2))
 { (portd.b2) =0; (portd.b3) =1;}

 if(SignalingSystem_CheckSignal(&SigSys, 3))
 { (portd.b3) =0; (portd.b2) =0;}
}
#line 715 "C:/Users/Kapouchima/Desktop/Lock/Firmware/Lock.c"
void SaveConfig()
{
 EEPROM_Write(0,LockTime[0]);
 EEPROM_Write(1,LockTime[1]);
 EEPROM_Write(2,LockTime[2]);
 EEPROM_Write(3,LockTime[3]);

 EEPROM_Write(4,UnlockTime[0]);
 EEPROM_Write(5,UnlockTime[1]);
 EEPROM_Write(6,UnlockTime[2]);
 EEPROM_Write(7,UnlockTime[3]);

 EEPROM_Write(8,OpenPass[0]);
 EEPROM_Write(9,OpenPass[1]);
 EEPROM_Write(10,OpenPass[2]);
 EEPROM_Write(11,OpenPass[3]);

 EEPROM_Write(12,MenuPass[0]);
 EEPROM_Write(13,MenuPass[1]);
 EEPROM_Write(14,MenuPass[2]);
 EEPROM_Write(15,MenuPass[3]);

 EEPROM_Write(16,RTL);
}
#line 757 "C:/Users/Kapouchima/Desktop/Lock/Firmware/Lock.c"
void LoadConfig()
{
 LockTime[0]=EEPROM_Read(0);
 LockTime[1]=EEPROM_Read(1);
 LockTime[2]=EEPROM_Read(2);
 LockTime[3]=EEPROM_Read(3);

 UnlockTime[0]=EEPROM_Read(4);
 UnlockTime[1]=EEPROM_Read(5);
 UnlockTime[2]=EEPROM_Read(6);
 UnlockTime[3]=EEPROM_Read(7);

 OpenPass[0]=EEPROM_Read(8);
 OpenPass[1]=EEPROM_Read(9);
 OpenPass[2]=EEPROM_Read(10);
 OpenPass[3]=EEPROM_Read(11);

 MenuPass[0]=EEPROM_Read(12);
 MenuPass[1]=EEPROM_Read(13);
 MenuPass[2]=EEPROM_Read(14);
 MenuPass[3]=EEPROM_Read(15);

 RTL=EEPROM_Read(16);
}
#line 797 "C:/Users/Kapouchima/Desktop/Lock/Firmware/Lock.c"
char TimeCompare(char *A,char *B)
{
 char res=0;
 if(A[0] > B[0])
 res=1;
 if((A[0] == B[0]) && (A[1] > B[1]))
 res=1;
 if((A[0] == B[0]) && (A[1] == B[1]) && (A[2] > B[2]))
 res=1;
 if((A[0] == B[0]) && (A[1] == B[1]) && (A[2] == B[2]) && (A[3] > B[3]))
 res=1;
 if((A[0] == B[0]) && (A[1] == B[1]) && (A[2] == B[2]) && (A[3] == B[3]))
 res=2;

 return res;
}
#line 830 "C:/Users/Kapouchima/Desktop/Lock/Firmware/Lock.c"
char GetDesireStatus()
{
 char UnlockTimeTemp[4],NowTemp[4],NowTempAdded[4],res=0;

 if(TimeCompare(LockTime,UnlockTime)==1)
 {
 UnlockTimeTemp[0]=UnlockTime[0];UnlockTimeTemp[1]=UnlockTime[1];
 UnlockTimeTemp[2]=UnlockTime[2];UnlockTimeTemp[3]=UnlockTime[3];
 UnlockTimeTemp[0]=(UnlockTimeTemp[0]+2)+((UnlockTimeTemp[1]+4)/10);
 UnlockTimeTemp[1]=(UnlockTimeTemp[1]+4)%10;


 NowTemp[0]=Now.HourBCD>>4;
 NowTemp[1]=Now.HourBCD&0x0F;
 NowTemp[2]=Now.MinuteBCD>>4;
 NowTemp[3]=Now.MinuteBCD&0x0F;

 NowTempAdded[0]=(NowTemp[0]+2)+((NowTemp[1]+4)/10);
 NowTempAdded[1]=(NowTemp[1]+4)%10;
 NowTempAdded[2]=NowTemp[2];NowTempAdded[3]=NowTemp[3];

 if(TimeCompare(NowTemp,LockTime))
 res=1;

 if(TimeCompare(UnlockTimeTemp,NowTempAdded))
 res=1;
 }

 if(TimeCompare(UnlockTime,LockTime)==1)
 {
 UnlockTimeTemp[0]=UnlockTime[0];UnlockTimeTemp[1]=UnlockTime[1];
 UnlockTimeTemp[2]=UnlockTime[2];UnlockTimeTemp[3]=UnlockTime[3];

 NowTemp[0]=Now.HourBCD>>4;
 NowTemp[1]=Now.HourBCD&0x0F;
 NowTemp[2]=Now.MinuteBCD>>4;
 NowTemp[3]=Now.MinuteBCD&0x0F;

 if((TimeCompare(NowTemp,LockTime)) && (TimeCompare(UnlockTimeTemp,NowTemp)))
 res=1;
 }



 return res;
}
