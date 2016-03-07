#line 1 "C:/Users/Kapouchima/Desktop/Lock/Firmware/UTAB-NightLock/DS3231/DS3231.c"
#line 1 "c:/users/kapouchima/desktop/lock/firmware/utab-nightlock/ds3231/ds3231.h"




typedef struct
{
 char SecondBCD;
 char MinuteBCD;
 char HourBCD;

}Time;



void SetTime(Time *t);
void GetTime(Time *t);
#line 6 "C:/Users/Kapouchima/Desktop/Lock/Firmware/UTAB-NightLock/DS3231/DS3231.c"
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
#line 36 "C:/Users/Kapouchima/Desktop/Lock/Firmware/UTAB-NightLock/DS3231/DS3231.c"
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
