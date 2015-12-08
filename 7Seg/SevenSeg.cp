#line 1 "C:/Users/Kapouchima/Documents/PIC Projects/KapOS/7Seg/SevenSeg.c"
#line 1 "c:/users/kapouchima/documents/pic projects/kapos/7seg/sevensegmentmanager.h"
#line 34 "c:/users/kapouchima/documents/pic projects/kapos/7seg/sevensegmentmanager.h"
typedef struct
{
 char Display[ 4 ];
 char RefreshCounter;
 char AnimationCounter;
}SevenSegment;


void SevenSegmentManager_Task(SevenSegment *);
void SevenSegmentManager_AnimationEPOCH(SevenSegment *);
#line 3 "C:/Users/Kapouchima/Documents/PIC Projects/KapOS/7Seg/SevenSeg.c"
void main() {

}
