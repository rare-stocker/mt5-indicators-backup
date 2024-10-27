//+------------------------------------------------------------------+
//|                                                      Trailer.mq5 |
//|                                 Copyright 2024, AlgoJupiter Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, AlgoJupiter Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers 3
#property indicator_plots   2
//--- plot middle
#property indicator_label1  "upper"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrBlue
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- plot upper
#property indicator_label2  "lower"
#property indicator_type2   DRAW_LINE
#property indicator_color2  clrRed
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1

//--- inputs
input int   atr_period=14;
input double    atr_multiplier=1.0;
//--- indicator buffers
double         upperBuffer[];
double         lowerBuffer[];
double			atrBuffer[];

int			atrHandle;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
;
   SetIndexBuffer(0,upperBuffer,INDICATOR_DATA);
   SetIndexBuffer(1,lowerBuffer,INDICATOR_DATA);
   SetIndexBuffer(2, atrBuffer, INDICATOR_CALCULATIONS);
   
   atrHandle = iATR(Symbol(), PERIOD_CURRENT, atr_period);
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
	if(rates_total < atr_period){
		return 0;
	}
	
	int pos;
	if(prev_calculated>1)
	{
	  pos=prev_calculated-1;
	}else{
	  pos=0;
	}
	
	if(CopyBuffer(atrHandle, 0, 0, rates_total, atrBuffer) <=0){
		return (0);
	}
        
    for(int i=pos; i<rates_total; i++)
    {
        upperBuffer[i]=close[i] + atrBuffer[i] * atr_multiplier;
        lowerBuffer[i]=close[i] - atrBuffer[i] * atr_multiplier;
    }
   return(rates_total);
  }
//+------------------------------------------------------------------+
