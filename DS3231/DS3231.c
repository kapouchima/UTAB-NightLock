#include "DS3231.h"




void SetTime(Time *t)
{

  i2c1_start();
  i2c1_wr(0xD0);
  i2c1_wr(0x00);
  i2c1_wr(t->SecondBCD);
  i2c1_wr(t->MinuteBCD);
  i2c1_wr(t->HourBCD);
  i2c1_stop();
  
}


















void GetTime(Time *t)
{

  i2c1_start();
  i2c1_wr(0xD0);
  i2c1_wr(0x00);
  I2C1_Repeated_Start();
  i2c1_wr(0xD1);
  t->SecondBCD=i2c1_rd(1);
  t->MinuteBCD=i2c1_rd(1);
  t->HourBCD=i2c1_rd(0);
  i2c1_stop();
  
}