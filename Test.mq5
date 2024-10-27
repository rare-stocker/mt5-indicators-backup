//+------------------------------------------------------------------+
//|                                                         Test.mq5 |
//|                                 Copyright 2024, AlgoJupiter Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, AlgoJupiter Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_chart_window 
#property indicator_buffers 1 
#property indicator_plots   1 
//---- plot Numeration 
#property indicator_label1  "Numeration" 
#property indicator_type1   DRAW_LINE 
#property indicator_color1  clrAliceBlue 
//--- indicator buffers 
double         NumerationBuffer[];
int            NumerationHandle; 
//+------------------------------------------------------------------+ 
//| Custom indicator initialization function                         | 
//+------------------------------------------------------------------+ 
int OnInit() 
  { 
//--- indicator buffers mapping 
   SetIndexBuffer(0,NumerationBuffer,INDICATOR_DATA); 
//--- set indexing for the buffer like in timeseries 
   ArraySetAsSeries(NumerationBuffer,true); 
//--- set accuracy of showing in DataWindow 
   IndicatorSetInteger(INDICATOR_DIGITS,0); 
//--- how the name of the indicator array is displayed in DataWindow 
   PlotIndexSetString(0,PLOT_LABEL,"Bar #");  
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
//---  we'll store the time of the current zero bar opening 
   static datetime currentBarTimeOpen=0; 
//--- revert access to array time[] - do it like in timeseries 
   ArraySetAsSeries(time,true); 
//--- If time of zero bar differs from the stored one 
   if(currentBarTimeOpen!=time[0]) 
     { 
     //--- enumerate all bars from the current to the chart depth 
      for(int i=rates_total-1;i>=0;i--) NumerationBuffer[i]=i; 
      currentBarTimeOpen=time[0]; 
     }
     CopyBuffer(NumerationHandle, 0, prev_calculated, rates_total, NumerationBuffer);
//--- return value of prev_calculated for next call 
   return(rates_total); 
  }