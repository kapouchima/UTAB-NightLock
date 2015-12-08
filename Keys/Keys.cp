#line 1 "C:/Users/Kapouchima/Desktop/Lock/Firmware/Keys/Keys.c"
#line 1 "c:/users/kapouchima/desktop/lock/firmware/keys/keys.h"
#line 41 "c:/users/kapouchima/desktop/lock/firmware/keys/keys.h"
void KeysSystem_EPOCH();
char KeysSystem_Task();
#line 3 "C:/Users/Kapouchima/Desktop/Lock/Firmware/Keys/Keys.c"
char SystemState=0,DebouncingCounter=0,RepeatCounter=0,PrevVal=0,RepeatNoCounter=0;




void KeysSystem_EPOCH()
{
 if(DebouncingCounter>0) DebouncingCounter=DebouncingCounter-1;
 if(RepeatCounter>0) RepeatCounter=RepeatCounter-1;
}





char KeysSystem_Task()
{
 char val=0,res=0;

 val.b0= (!portd.b1) ;



 val.b1= (!portd.b6) ;



 val.b2= (!portc.b6) ;



 val.b3= (!portd.b4) ;



 val.b4= (!portd.b5) ;
#line 54 "C:/Users/Kapouchima/Desktop/Lock/Firmware/Keys/Keys.c"
 switch(SystemState)
 {
 case 0:
 if((val!=0) && (DebouncingCounter==0)){res=val;DebouncingCounter= (10) ;RepeatCounter= (250) ;SystemState=1;PrevVal=val;}
 break;

 case 1:
 if((DebouncingCounter==0) && (val == 0)){res=0;PrevVal=0;DebouncingCounter= (10) ;SystemState=0;}
 if((DebouncingCounter==0) && (val == PrevVal) && (RepeatCounter == 0)){res=val,SystemState=2;RepeatCounter= (50) ;RepeatNoCounter= (50) ;}
 if((DebouncingCounter==0) && (val != PrevVal) && (val != 0)){res=val;PrevVal=val;DebouncingCounter= (10) ;}
 break;

 case 2:
 if((val == PrevVal) && (RepeatCounter == 0) && (RepeatNoCounter > 0)){res=val;RepeatCounter= (50) ;RepeatNoCounter=RepeatNoCounter-1;}
 if((val == PrevVal) && (RepeatCounter == 0) && (RepeatNoCounter == 0)){res=val;RepeatCounter= (50) ;RepeatNoCounter= (50) ;SystemState=3;}
 if((val != PrevVal) && (val != 0)){res=val;PrevVal=val;DebouncingCounter= (10) ;RepeatCounter= (250) ;SystemState=1;}
 if(val == 0){res=0;PrevVal=0;DebouncingCounter= (10) ;SystemState=0;}
 break;

 case 3:
 if((val == PrevVal) && (RepeatCounter == 0) && (RepeatNoCounter > 0)){res=val;RepeatCounter= (50) ;RepeatNoCounter=RepeatNoCounter-1;}
 if((val == PrevVal) && (RepeatCounter == 0) && (RepeatNoCounter == 0)){res=val;RepeatCounter= (50) ;SystemState=4;}
 if((val != PrevVal) && (val != 0)){res=val;PrevVal=val;DebouncingCounter= (10) ;RepeatCounter= (250) ;SystemState=1;}
 if(val == 0){res=0;PrevVal=0;DebouncingCounter= (10) ;SystemState=0;}
 break;

 case 4:
 if((val == PrevVal) && (RepeatCounter == 0)){res=val;RepeatCounter= (50) ;}
 if((val != PrevVal) && (val != 0)){res=val;PrevVal=val;DebouncingCounter= (10) ;RepeatCounter= (250) ;SystemState=1;}
 if(val == 0){res=0;PrevVal=0;DebouncingCounter= (10) ;SystemState=0;}
 break;
 }

 return res;
}
