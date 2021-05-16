void visualizer3()
{
  background(0);
  color corTraco = c1;
  noFill();
  pushMatrix();
  translate(1024/2,768/2);
  logfft.forward(player.left);
  for(int i = 0; i < 29; i++)
  {
    if(beat.isOnset())
    {
    if(corTraco == c1)
    {corTraco = c2;}
    else if(corTraco == c2)
    {corTraco = c3;}
    else if(corTraco == c3)
    {corTraco = c1;}
    }
    float amp = logfft.getAvg(i);
    if (amp < audioThresh)
    {
      circulos[i] = amp*(768/2);
    }
    else 
    {
      circulos[i] = max(0,min(768,circulos[i]-taxaCaida));
    }
    float freqCentro = logfft.getAverageCenterFrequency(i);
    float mediaComp = logfft.getAverageBandWidth(i);
    float freqGrave = freqCentro - mediaComp/2;
    float freqAguda = freqCentro + mediaComp/2;
    int x1 = (int)logfft.freqToIndex(freqGrave);
    int xr = (int)logfft.freqToIndex(freqAguda);
    pushStyle();
    stroke(corTraco,amp*255);
    strokeWeight(map(amp,0,1, strokeMin,strokeMax));
    strokeWeight((float)(xr-x1)*strokeMultiplier);
    ellipse(0,0,circulos[i],circulos[i]);
    popStyle();
  }
  popMatrix();
 
}
