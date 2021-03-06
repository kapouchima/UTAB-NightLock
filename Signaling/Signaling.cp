#line 1 "C:/Users/Kapouchima/Desktop/Lock/Firmware/UTAB-NightLock/Signaling/Signaling.c"
#line 1 "c:/users/kapouchima/desktop/lock/firmware/utab-nightlock/signaling/signaling.h"
#line 30 "c:/users/kapouchima/desktop/lock/firmware/utab-nightlock/signaling/signaling.h"
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
#line 5 "C:/Users/Kapouchima/Desktop/Lock/Firmware/UTAB-NightLock/Signaling/Signaling.c"
char SignalingSystem_CheckSignal(SignalingSystem *sys,char sigcode)
{
 char i=0,result=0;
 for(i=0;i< 10 ;i++)
 if((sys->SignalQueue[i].Expired==0)&&(sys->SignalQueue[i].Fired==1)&&(sys->SignalQueue[i].SignalCode==sigcode))
 {sys->SignalQueue[i].Expired=1;result=1;break;}
 return result;
}




void SignalingSystem_Task(SignalingSystem *sys)
{
 char i=0;
 for(i=0;i< 10 ;i++)
 if((sys->SignalQueue[i].Expired==0)&&(sys->SignalQueue[i].Time==sys->SystemEPOCH)&&(sys->SignalQueue[i].Fired==0))
 sys->SignalQueue[i].Fired=1;
}



void SignalingSystem_SystemEPOCH(SignalingSystem *sys)
{
 if(sys->SystemEPOCH!=0xFFFFFFFF)
 sys->SystemEPOCH=(sys->SystemEPOCH)+1;
 else
 sys->SystemEPOCH=0;
}



void SignalingSystem_AddSignal(SignalingSystem *sys,unsigned long sigtime,char sigcode)
{
 unsigned long signaltime=0;
 char i;
 signaltime=sys->SystemEPOCH+sigtime;

 for(i=0;i< 10 ;i++)
 if(sys->SignalQueue[i].Expired==1)
 {
 sys->SignalQueue[i].SignalCode=sigcode;
 sys->SignalQueue[i].Time=signaltime;
 sys->SignalQueue[i].Expired=0;
 sys->SignalQueue[i].Fired=0;
 break;
 }
}





void SignalingSystem_ClearAllSignals(SignalingSystem *sys,char sigcode)
{
char i;
 for(i=0;i< 10 ;i++)
 if((sys->SignalQueue[i].Expired==0)&&(sys->SignalQueue[i].SignalCode!=sigcode))
 sys->SignalQueue[i].Expired=1;
}




void SignalingSystem_ClearSignal(SignalingSystem *sys,char sigcode)
{
 char i;
 for(i=0;i< 10 ;i++)
 if((sys->SignalQueue[i].Expired==0)&&(sys->SignalQueue[i].SignalCode==sigcode))
 sys->SignalQueue[i].Expired=1;
}




void SignalingSystem_Init(SignalingSystem *sys)
{
 char i;
 for(i=0;i< 10 ;i++)
 {
 sys->SignalQueue[i].SignalCode=0;
 sys->SignalQueue[i].Time=0;
 sys->SignalQueue[i].Expired=1;
 sys->SignalQueue[i].Fired=0;
 }

 sys->SystemEPOCH=0;
}
