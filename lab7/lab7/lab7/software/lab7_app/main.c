



int main()
{
	int i = 0;
	volatile unsigned int *LED_PIO = (unsigned int*)0x50; //make a pointer to access the PIO block
	volatile unsigned int *SW_PIO = (unsigned int*) 0x40;
	volatile unsigned int initial =(*SW_PIO & 0b010000000000)>>10;
	volatile unsigned int run     =(*SW_PIO & 0b100000000000)>>11;
	volatile unsigned int sw      =(*SW_PIO <<24)>>24;
	volatile unsigned int flag=0;
	flag=0;
	 *LED_PIO = 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ; //clear all LEDs
	while ( (1+1) != 3) //infinite loop
	{
		initial =(*SW_PIO & 0b010000000000)>>10;
	    run     =(*SW_PIO & 0b100000000000)>>11;
		sw      =(*SW_PIO <<24)>>24;


		if(initial==0)
		  {
		   *LED_PIO = 0;
		  }
		if(run==0)
		  {
		   flag=1;
//		   *LED_PIO = 3;
		  }
		if((run==1) && (flag==1))
		  {

			*LED_PIO=sw+*LED_PIO;
		   flag=0;
		  }
		*LED_PIO=*LED_PIO+0;



	}



	return 1; //never gets here
}



// Main.c - makes LEDG0 on DE2-115 board blink if NIOS II is set up correctly
// for ECE 385 - University of Illinois - Electrical and Computer Engineering
// Author: Zuofu Cheng
//
//int main()
//{
//	int i = 0;
//	volatile unsigned int *LED_PIO = (unsigned int*)0x50; //make a pointer to access the PIO block
//
//	*LED_PIO = 0; //clear all LEDs
//	while ( (1+1) != 3) //infinite loop
//	{
//		for (i = 0; i < 100000; i++); //software delay
//		*LED_PIO |= 0x1; //set LSB
//		for (i = 0; i < 100000; i++); //software delay
//		*LED_PIO &= ~0x1; //clear LSB
//	}
//	return 1; //never gets here
//}

