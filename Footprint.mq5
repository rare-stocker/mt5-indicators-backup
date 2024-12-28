//+------------------------------------------------------------------+
//|                                             SimpleFootprint.mq5  |
//|                        Copyright 2023, MetaQuotes Software Corp. |
//|                                       https://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "2023"
#property link      "https://www.metaquotes.net/"
#property version   "1.00"
#property indicator_separate_window
#property indicator_buffers 1
#property indicator_plots   1
#property indicator_color1 clrBlue

//--- input parameters
input int    VolumeBars = 10; // Number of bars to calculate volume
input double PriceStep = 0.01; // Price step for histogram

//--- indicator buffers
double VolumeBuffer[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                           |
//+------------------------------------------------------------------+
int OnInit()
  {
   SetIndexBuffer(0, VolumeBuffer);
   //SetIndexStyle(0, DRAW_HISTOGRAM);
   //SetIndexLabel(0, "Volume");
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//| Custom indicator iteration function                                |
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
   // Clear the volume buffer
   ArraySetAsSeries(VolumeBuffer, true);
   ArrayInitialize(VolumeBuffer, 0);

   // Calculate volume for the last 'VolumeBars' bars
   for(int i = 0; i < VolumeBars && i < rates_total; i++)
     {
      double price = close[i];
      int index = (int)(price / PriceStep);
      if(index < ArraySize(VolumeBuffer))
        {
         VolumeBuffer[index] += (long)volume[i];
        }
     }

   return(rates_total);
}
//+------------------------------------------------------------------+