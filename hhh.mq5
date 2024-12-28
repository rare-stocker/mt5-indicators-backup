//+------------------------------------------------------------------+
//|                                                          hhh.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers 2
#property indicator_plots 2

//--- plot redLine
#property indicator_label1  "redLine"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrRed
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- plot greenLine
#property indicator_label2  "greenLine"
#property indicator_type2   DRAW_LINE
#property indicator_color2  clrGreen
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1
////--- plot redArrow
//#property indicator_label3  "redArrow"
//#property indicator_type3   DRAW_ARROW
//#property indicator_color3  clrRed
//#property indicator_style3  STYLE_SOLID
//#property indicator_width3  1
////--- plot greenArrow
//#property indicator_label4  "greenArrow"
//#property indicator_type4   DRAW_ARROW
//#property indicator_color4  clrGreen
//#property indicator_style4  STYLE_SOLID
//#property indicator_width4  1

double   oneBuffer[];
double   twoBuffer[];
bool  signalBuffer[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0, oneBuffer, INDICATOR_DATA);
   SetIndexBuffer(1, twoBuffer, INDICATOR_DATA);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
	int pos;
	if(prev_calculated>1)
	{
	  pos=prev_calculated-1;
	}else{
	  pos=0;
	}
	  
   for(int i=pos; i<rates_total; i++)
   {
      oneBuffer[i]=close[i];
      twoBuffer[i]=open[i];
   }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
