
/* -----------------------------------------------------------------------------
 - Simple Signaling system for PIC18 Dveloped by : Sina Baghi
 -
 - SystemEPOCH should be called in cyclic form and it provides Time base for signaling system
 -
 - SignalingSystem_Task should be called in while(1). it's the main task of the signaling system
 -
 - SignalingSystem_AddSignal adds a single task in the signaling system
 -  The sigtime param is the signal Time from now
 -
 - SignalingSystem_ClearAllSignals clears all the signals in the signaling system except the signal
 -  with the signal code passed in to the function
 -
 - SignalingSystem_ClearSignal clears the signal in the signaling system
 -  with the signal code passed in to the function
 -
 - SignalingSystem_CheckSignal checks if Signal with sigcode fired and returns 1 if fired and clear the
 -  signal from buffer
 -------------------------------------------------------------------------------
 */



#ifndef SIGNALINGMODULE
#define SIGNALINGMODULE

#define SignalQueueElements 10

typedef struct
{
  char SignalCode;
  unsigned long Time;
  char Expired;
  char Fired;
}Signal;

typedef struct
{
  Signal SignalQueue[SignalQueueElements];
  unsigned long SystemEPOCH;
}SignalingSystem;

void SignalingSystem_SystemEPOCH(SignalingSystem *);
void SignalingSystem_AddSignal(SignalingSystem *,unsigned long ,char );
char SignalingSystem_CheckSignal(SignalingSystem * ,char );
void SignalingSystem_ClearSignal(SignalingSystem *,char);
void SignalingSystem_ClearAllSignals(SignalingSystem * ,char );
void SignalingSystem_Task(SignalingSystem *);
void SignalingSystem_Init(SignalingSystem *);

#endif