//+------------------------------------------------------------------+
//|                                                     redgreen.mq5 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                    OpenClose.mq5 |
//|                        Copyright 2024, MetaQuotes Software Corp. |
//|                                  https://www.mql5.com            |
//+------------------------------------------------------------------+
#property copyright "2024, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property indicator_separate_window
#property indicator_buffers 1
#property indicator_plots 1

#property indicator_type1  DRAW_ARROW 
#property indicator_color1 clrRed
#property indicator_width1 2

// Indicator buffers
double Buffer[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
   // Indicator buffer mapping
   SetIndexBuffer(0, Buffer);
   //SetIndexStyle(0, DRAW_HISTOGRAM);

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
   // Loop through all bars
   for (int i = prev_calculated; i < rates_total; i++)
     {
      // Generate a signal based on the comparison between Open and Close prices
      if (close[i] > open[i])
        {
         Buffer[i] = 0;  // Buy signal
        }
      else if (close[i] < open[i])
        {
         Buffer[i] = 1; // Sell signal
        }
      else
        {
         Buffer[i] = NULL;  // No signal
        }
     }

   return(rates_total);
  }
//+------------------------------------------------------------------+
