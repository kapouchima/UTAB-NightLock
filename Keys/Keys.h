/* -----------------------------------------------------------------------------
 - Key reading Module for PIC18 Dveloped by : Sina Baghi
 -
 - KeysSystem_EPOCH should be called in cyclic form and it provides Time base for Key reading system
 -
 - KeysSystem_Task should be called in while(1). it's the main task of the key reading system and returns the key value
 -
 - There is 3 repeating levels for each hold key. number of each repeat phase and the speed of it can be adjust with repeatCycles and
 - Repeat count params these values are multiplied in system epoch time.
 -
 - StartRepeatCycles determines the initial time for starting repeating after pressing and holding any keys
 -
 - Key value should be defined in Key1 , Key2 and ... to Key8 in header file
 -------------------------------------------------------------------------------
 */



#ifndef KEYMODULE
#define KEYMODULE


#define Key1 (!portd.b1)
#define Key2 (!portd.b6)
#define Key3 (!portc.b6)
#define Key4 (!portd.b4)
#define Key5 (!portd.b5)



#define DebouncingCycles (10)
#define StartRepeatCycles (250)
#define SlowRepeatCycles (50)
#define SlowRepeatCount  (50)
#define MidRepeatCycles  (50)
#define MidRepeatCount   (50)
#define FastRepeatCycles (50)



void KeysSystem_EPOCH();
char KeysSystem_Task();

#endif