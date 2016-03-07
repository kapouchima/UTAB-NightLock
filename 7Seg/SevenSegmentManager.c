#include "SevenSegmentManager.h"










void DisableSegments()
{
        Digit1En=DisableLogic;
      #if(DIGITS>1)
        Digit2En=DisableLogic;
      #endif
      #if(DIGITS>2)
        Digit3En=DisableLogic;
      #endif
      #if(DIGITS>3)
        Digit4En=DisableLogic;
      #endif
}









void EnableSegment(char seg)
{
  switch(seg)
  {
    case 0:
      Digit1En=EnableLogic;
      break;
      
    case 1:
      Digit2En=EnableLogic;
      break;
      
    case 2:
      Digit3En=EnableLogic;
      break;
      
    case 3:
      Digit4En=EnableLogic;
      break;

  }
}













void EnableSegmentI(char seg)
{
  switch(seg)
  {
    case 0:
      Digit1EnI=EnableLogic;
      break;

    case 1:
      Digit2EnI=EnableLogic;
      break;

    case 2:
      Digit3EnI=EnableLogic;
      break;

    case 3:
      Digit4EnI=EnableLogic;
      break;

  }
}












void PlayAnimation(char animCode)
{

}















void SetChar(char ch)
{
  char i=ch;
  
  if(i.b7)SegDp=On;
  else SegDp=Off;

  i.b0=0;
  
  switch(ch)
  {
    case 0x00:
      SegA=On;SegB=On;SegC=On;SegD=On;SegE=On;SegF=On;SegG=Off;break;
      
    case 0x01:
      SegA=Off;SegB=On;SegC=On;SegD=Off;SegE=Off;SegF=Off;SegG=Off;break;
      
    case 0x02:
      SegA=On;SegB=On;SegC=Off;SegD=On;SegE=On;SegF=Off;SegG=On;break;
      
    case 0x03:
      SegA=On;SegB=On;SegC=On;SegD=On;SegE=Off;SegF=Off;SegG=On;break;

    case 0x04:
      SegA=Off;SegB=On;SegC=On;SegD=Off;SegE=Off;SegF=On;SegG=On;break;
      
    case 0x05:
      SegA=On;SegB=Off;SegC=On;SegD=On;SegE=Off;SegF=On;SegG=On;break;
      
    case 0x06:
      SegA=On;SegB=Off;SegC=On;SegD=On;SegE=On;SegF=On;SegG=On;break;
      
    case 0x07:
      SegA=On;SegB=On;SegC=On;SegD=Off;SegE=Off;SegF=Off;SegG=Off;break;
      
    case 0x08:
      SegA=On;SegB=On;SegC=On;SegD=On;SegE=On;SegF=On;SegG=On;break;
      
    case 0x09:
      SegA=On;SegB=On;SegC=On;SegD=On;SegE=Off;SegF=On;SegG=On;break;
      
    case 0x0A:
      PlayAnimation(1);
      
    case 11:
      SegA=Off;SegB=Off;SegC=Off;SegD=On;SegE=Off;SegF=Off;SegG=Off;break;
      
    case 12:
      SegA=Off;SegB=Off;SegC=Off;SegD=Off;SegE=Off;SegF=Off;SegG=On;break;
      
    case 13:
      SegA=On;SegB=Off;SegC=Off;SegD=On;SegE=Off;SegF=Off;SegG=On;break;
  }
}













void SetCharI(char ch)
{
  char i=ch;

  if(i.b7)SegDpI=On;
  else SegDpI=Off;

  i.b0=0;

  switch(ch)
  {
    case 0x00:
      SegAI=On;SegBI=On;SegCI=On;SegDI=On;SegEI=On;SegFI=On;SegGI=Off;break;

    case 0x01:
      SegAI=Off;SegBI=On;SegCI=On;SegDI=Off;SegEI=Off;SegFI=Off;SegGI=Off;break;

    case 0x02:
      SegAI=On;SegBI=On;SegCI=Off;SegDI=On;SegEI=On;SegFI=Off;SegGI=On;break;

    case 0x03:
      SegAI=On;SegBI=On;SegCI=On;SegDI=On;SegEI=Off;SegFI=Off;SegGI=On;break;

    case 0x04:
      SegAI=Off;SegBI=On;SegCI=On;SegDI=Off;SegEI=Off;SegFI=On;SegGI=On;break;

    case 0x05:
      SegAI=On;SegBI=Off;SegCI=On;SegDI=On;SegEI=Off;SegFI=On;SegGI=On;break;

    case 0x06:
      SegAI=On;SegBI=Off;SegCI=On;SegDI=On;SegEI=On;SegFI=On;SegGI=On;break;

    case 0x07:
      SegAI=On;SegBI=On;SegCI=On;SegDI=Off;SegEI=Off;SegFI=Off;SegGI=Off;break;

    case 0x08:
      SegAI=On;SegBI=On;SegCI=On;SegDI=On;SegEI=On;SegFI=On;SegGI=On;break;

    case 0x09:
      SegAI=On;SegBI=On;SegCI=On;SegDI=On;SegEI=Off;SegFI=On;SegGI=On;break;

    case 0x0A:
      PlayAnimation(1);

    case 11:
      SegAI=Off;SegBI=Off;SegCI=Off;SegDI=On;SegEI=Off;SegFI=Off;SegGI=Off;break;

    case 12:
      SegAI=Off;SegBI=Off;SegCI=Off;SegDI=Off;SegEI=Off;SegFI=Off;SegGI=On;break;
      
    case 13:
      SegAI=On;SegBI=Off;SegCI=Off;SegDI=On;SegEI=Off;SegFI=Off;SegGI=On;break;
  }
}












void SevenSegmentManager_Task(SevenSegment *sys)
{   
    
    if(RTL==0)
    {
      DisableSegments();
      SetChar(sys->Display[sys->RefreshCounter]);
      if((sys->RefreshCounter==3)||(sys->RefreshCounter==2))
        SegDp=CenterFlash;
      EnableSegment(sys->RefreshCounter);
    }
    else
    {
      DisableSegments();
      SetCharI(sys->Display[sys->RefreshCounter]);
      if((sys->RefreshCounter==0)||(sys->RefreshCounter==1))
        SegDpI=CenterFlash;
      EnableSegmentI(sys->RefreshCounter);
    }

    
    
    sys->RefreshCounter=sys->RefreshCounter+1;
    if(sys->RefreshCounter >= DIGITS)
      sys->RefreshCounter=0;
}












void SevenSegmentManager_AnimationEPOCH(SevenSegment *sys)
{
  if(sys->AnimationCounter >= 255)
   sys->AnimationCounter=0;
  else
   sys->AnimationCounter=sys->AnimationCounter+1;
}