//+------------------------------------------------------------------+
//|                                                          ggg.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_chart_window
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
#property indicator_buffers 2 
#property indicator_plots   2 
    
// rendering settings 
#property indicator_type1   DRAW_ARROW 
#property indicator_type2   DRAW_ARROW 
#property indicator_color1  clrBlue 
#property indicator_color2  clrRed 
#property indicator_label1  "Fractal Up" 
#property indicator_label2  "Fractal Down" 
    
// indicator buffers 
double UpBuffer[]; 
double DownBuffer[];

input int FractalOrder = 3;
const int ArrowShift = 10;

int OnInit() 
{ 
   // binding buffers 
   SetIndexBuffer(0, UpBuffer, INDICATOR_DATA); 
   SetIndexBuffer(1, DownBuffer, INDICATOR_DATA); 
    
   // up and down arrow character codes 
   PlotIndexSetInteger(0, PLOT_ARROW, 217); 
   PlotIndexSetInteger(1, PLOT_ARROW, 218); 
    
   // padding for arrows 
   PlotIndexSetInteger(0, PLOT_ARROW_SHIFT, -ArrowShift); 
   PlotIndexSetInteger(1, PLOT_ARROW_SHIFT, +ArrowShift); 
    
   // setting an empty value (can be omitted, since EMPTY_VALUE is the default) 
   PlotIndexSetDouble(0, PLOT_EMPTY_VALUE, EMPTY_VALUE); 
   PlotIndexSetDouble(1, PLOT_EMPTY_VALUE, EMPTY_VALUE); 
    
   return FractalOrder > 0 ? INIT_SUCCEEDED : INIT_PARAMETERS_INCORRECT; 
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
   if(prev_calculated == 0) 
   { 
      // at the start, fill the arrays entirely 
      ArrayInitialize(UpBuffer, EMPTY_VALUE); 
      ArrayInitialize(DownBuffer, EMPTY_VALUE); 
   } 
   else 
   { 
      // on new bars we also clean the elements 
      for(int i = prev_calculated; i < rates_total; ++i) 
      { 
         UpBuffer[i] = EMPTY_VALUE; 
         DownBuffer[i] = EMPTY_VALUE; 
      } 
   }
   // that next
   // view all or new bars that have bars in the FractalOrder environment 
   for(int i = fmax(prev_calculated - FractalOrder - 1, FractalOrder); 
       i < rates_total - FractalOrder; ++i) 
   { 
      // check if the upper price is higher than neighboring bars 
      UpBuffer[i] = high[i]; 
      for(int j = 1; j <= FractalOrder; ++j) 
      { 
         if(high[i] <= high[i + j] || high[i] <= high[i - j]) 
         { 
            UpBuffer[i] = EMPTY_VALUE; 
            break; 
         } 
      } 
       
      // check if the lower price is lower than neighboring bars 
      DownBuffer[i] = low[i]; 
      for(int j = 1; j <= FractalOrder; ++j) 
      { 
         if(low[i] >= low[i + j] || low[i] >= low[i - j]) 
         { 
            DownBuffer[i] = EMPTY_VALUE; 
            break; 
         } 
      } 
   } 
    
   return rates_total; 
}