#ifndef DS3231
#define DS3132


typedef struct
{
  char SecondBCD;
  char MinuteBCD;
  char HourBCD;
  
}Time;



void SetTime(Time *t);
void GetTime(Time *t);





#endif