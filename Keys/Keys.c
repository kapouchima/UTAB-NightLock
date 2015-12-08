#include "Keys.h"

char SystemState=0,DebouncingCounter=0,RepeatCounter=0,PrevVal=0,RepeatNoCounter=0;




void KeysSystem_EPOCH()
{
  if(DebouncingCounter>0) DebouncingCounter=DebouncingCounter-1;
  if(RepeatCounter>0) RepeatCounter=RepeatCounter-1;
}





char KeysSystem_Task()
{
  char val=0,res=0;
  #ifdef Key1
    val.b0=Key1;
  #endif

  #ifdef Key2
    val.b1=Key2;
  #endif

  #ifdef Key3
    val.b2=Key3;
  #endif

  #ifdef Key4
    val.b3=Key4;
  #endif

  #ifdef Key5
    val.b4=Key5;
  #endif

  #ifdef Key6
    val.b5=Key6;
  #endif

  #ifdef Key7
    val.b6=Key7;
  #endif

  #ifdef Key8
    val.b7=Key8;
  #endif
  

  switch(SystemState)
  {
    case 0:
      if((val!=0) && (DebouncingCounter==0)){res=val;DebouncingCounter=DebouncingCycles;RepeatCounter=StartRepeatCycles;SystemState=1;PrevVal=val;}
      break;
      
    case 1:
     if((DebouncingCounter==0) && (val == 0)){res=0;PrevVal=0;DebouncingCounter=DebouncingCycles;SystemState=0;}
     if((DebouncingCounter==0) && (val == PrevVal) && (RepeatCounter == 0)){res=val,SystemState=2;RepeatCounter=SlowRepeatCycles;RepeatNoCounter=SlowRepeatCount;}
     if((DebouncingCounter==0) && (val != PrevVal) && (val != 0)){res=val;PrevVal=val;DebouncingCounter=DebouncingCycles;}
     break;
     
    case 2:
      if((val == PrevVal) && (RepeatCounter == 0) && (RepeatNoCounter > 0)){res=val;RepeatCounter=SlowRepeatCycles;RepeatNoCounter=RepeatNoCounter-1;}
      if((val == PrevVal) && (RepeatCounter == 0) && (RepeatNoCounter == 0)){res=val;RepeatCounter=MidRepeatCycles;RepeatNoCounter=MidRepeatCount;SystemState=3;}
      if((val != PrevVal) && (val != 0)){res=val;PrevVal=val;DebouncingCounter=DebouncingCycles;RepeatCounter=StartRepeatCycles;SystemState=1;}
      if(val == 0){res=0;PrevVal=0;DebouncingCounter=DebouncingCycles;SystemState=0;}
      break;
      
   case 3:
      if((val == PrevVal) && (RepeatCounter == 0) && (RepeatNoCounter > 0)){res=val;RepeatCounter=MidRepeatCycles;RepeatNoCounter=RepeatNoCounter-1;}
      if((val == PrevVal) && (RepeatCounter == 0) && (RepeatNoCounter == 0)){res=val;RepeatCounter=FastRepeatCycles;SystemState=4;}
      if((val != PrevVal) && (val != 0)){res=val;PrevVal=val;DebouncingCounter=DebouncingCycles;RepeatCounter=StartRepeatCycles;SystemState=1;}
      if(val == 0){res=0;PrevVal=0;DebouncingCounter=DebouncingCycles;SystemState=0;}
      break;
      
   case 4:
      if((val == PrevVal) && (RepeatCounter == 0)){res=val;RepeatCounter=FastRepeatCycles;}
      if((val != PrevVal) && (val != 0)){res=val;PrevVal=val;DebouncingCounter=DebouncingCycles;RepeatCounter=StartRepeatCycles;SystemState=1;}
      if(val == 0){res=0;PrevVal=0;DebouncingCounter=DebouncingCycles;SystemState=0;}
      break;
  }
  
  return res;
}
