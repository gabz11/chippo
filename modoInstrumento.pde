void modoInstrumento()
  {
     // INTERFACE MODO INSTRUMENTO
    exibir = true;
    cam.beginHUD();
    fill(c4); 
    background(0); 
    stroke(c3); 
    strokeWeight(1);
    if (uniao == true) {
      text("TAB - Modo: União", 50, 180);
    }
    if (uniao == false) {
      text("TAB - Modo: Triade (Acorde)", 50, 180);
    }
    if (latch == false) {
      text("Q - Latch: Desligado", 50, 200);
    }
    if (latch == true) {
      text("Q - Latch: Ligado", 50, 200);
    }
    if (dtPreset1 == true) {
      text("4 - Tempo máximo (Delay): 20 %", 50, 300);
    }
    if (dtPreset2 == true) {
      text("4 - Tempo máximo (Delay): 35 %", 50, 300);
    }
    if (dtPreset3 == true) {
      text("4 - Tempo máximo (Delay): 50 %", 50, 300);
    }
    if (dtPreset4 == true) {
      text("4 - Tempo máximo (Delay): 65 %", 50, 300);
    }
    if (dtPreset5 == true){text("4 - Tempo máximo (Delay): 80%", 50, 300);}
    if (daPreset1 == true){text("5 - Amplitude máxima (Delay): 0 %",50,320);}
    if (daPreset2 == true){text("5 - Amplitude máxima (Delay): 25 %",50,320);}
    if (daPreset3 == true){text("5 - Amplitude máxima (Delay): 50 %",50,320);}
    if (daPreset4 == true){text("5 - Amplitude máxima (Delay): 65 %",50,320);}
    if (daPreset5 == true){text("5 - Amplitude máxima (Delay): 90 %",50,320);}
    if (bcPreset1 == true) {
      text("6 - Bits (Amostra): 16", 50, 340);
    }
    if (bcPreset2 == true) {
      text("6 - Bits (Amostra): 8", 50, 340);
    }
    if (bcPreset3 == true) {
      text("6 - Bits (Amostra): 6", 50, 340);
    }
    if (bcPreset4 == true) {
      text("6 - Bits (Amostra): 4", 50, 340);
    }
    if (gPreset1 == true) {
      text("7 - Ganho: 0 dB", 50, 360);
    }
    if (gPreset2 == true) {
      text("7 - Ganho: +1.5 dB", 50, 360);
    }
    if (gPreset3 == true) {
      text("7 - Ganho: +3 dB", 50, 360);
    }
    if (gPreset4 == true) {
      text("7 - Ganho: +5 dB", 50, 360);
    }
    if (oPreset1 == true) {
      text("Z/X - Oitava: -2", 50, 160);
    }
    if (oPreset2 == true) {
      text("Z/X - Oitava: -1", 50, 160);
    }
    if (oPreset3 == true) {
      text("Z/X - Oitava: 0", 50, 160);
    }
    if (oPreset4 == true) {
      text("Z/X - Oitava: +1", 50, 160);
    }
    if (oPreset5 == true) {
      text("Z/X - Oitava: +2", 50, 160);
    }
    if (fPreset1 == true){text("8 - Corte (Filtro): 4000 Hz",50,380);}
    if (fPreset2 == true){text("8 - Corte (Filtro): 6000 Hz",50,380);}
    if (fPreset3 == true){text("8 - Corte (Filtro): 8000 Hz",50,380);}
    if (fPreset4 == true){text("8 - Corte (Filtro): 2500 Hz",50,380);}
    if (rPreset1 == true){text("9 - Resonancia (Filtro): 20 %",50,400);}
    if (rPreset2 == true){text("9 - Resonancia (Filtro): 40 %",50,400);}
    if (rPreset3 == true){text("9 - Resonancia (Filtro): 60 %",50,400);}
    if (rPreset4 == true){text("9 - Resonancia (Filtro): 80 %",50,400);}
    if (rPreset5 == true){text("9 - Resonancia (Filtro): 90 %",50,400);}
    if (tSobre == true) {
      image(esquemaTeclado, 273, 117);
    }
    if (osc1.getWaveform() == Waves.SQUARE) {
      text("1 - Oscilador 1: Quadrado", 50, 240);
    }
    if (osc1.getWaveform() == Waves.SAW) {
      text("1 - Oscilador 1: Serra", 50, 240);
    }
    if (osc1.getWaveform() == Waves.TRIANGLE) {
      text("1 - Oscilador 1: Triângulo", 50, 240);
    }
    if (osc1.getWaveform() == Waves.SINE) {
      text("1 - Oscilador 1: Seno", 50, 240);
    }
    if (osc1.getWaveform() == Waves.QUARTERPULSE) {
      text("1 - Oscilador 1: Pulso", 50, 240);
    }
    if (osc2.getWaveform() == Waves.SQUARE) {
      text("2 - Oscilador 2: Quadrado", 50, 260);
    }
    if (osc2.getWaveform() == Waves.SAW) {
      text("2 - Oscilador 2: Serra", 50, 260);
    }
    if (osc2.getWaveform() == Waves.TRIANGLE) {
      text("2 - Oscilador 2: Triângulo", 50, 260);
    }
    if (osc2.getWaveform() == Waves.SINE) {
      text("2 - Oscilador 2: Seno", 50, 260);
    }
    if (osc2.getWaveform() == Waves.QUARTERPULSE) {
      text("2 - Oscilador 2: Pulso", 50, 260);
    }    
    if (osc3.getWaveform() == Waves.SQUARE) {
      text("3 - Oscilador 3: Quadrado", 50, 280);
    }
    if (osc3.getWaveform() == Waves.SAW) {
      text("3 - Oscilador 3: Serra", 50, 280);
    }
    if (osc3.getWaveform() == Waves.TRIANGLE) {
      text("3 - Oscilador 3: Triângulo", 50, 280);
    }
    if (osc3.getWaveform() == Waves.SINE) {
      text("3 - Oscilador 3: Seno", 50, 280);
    }
    if (osc3.getWaveform() == Waves.QUARTERPULSE) {
      text("3 - Oscilador 3: Pulso", 50, 280);
    }
    if (gravador.isRecording())
      {
        fill(c7);
        text("Agora pressione ENTER para terminar de gravar.", 300, 490);
      } 
    else if ( !gravado )
      {
        fill(c1);
        text("Pressione ENTER para começar a gravar!", 300, 490);
      } 
    else if ( salvo == false)
      {
        fill(c1);
        text("Pressione ESPAÇO para salvar!", 300, 490);
      } 
    else if ( salvo == true)
      {
        fill(c1);
        text("Pressione ENTER para gravar novamente...", 300, 490); 
        fill(c4);
        text("Pressione V para ouvir a gravação...", 300, 530);
        text("Pressione B para pausar a gravação...", 300, 550);
      }
    // FIM 
    // INTERFACE INSTRUMENTO
    for (int i = 0; i < out.bufferSize() - 1; i++)
    {
      image(inst, 0, 0);
      image(sobre, 43, 0);
      image(fechar, 981, 0);
      stroke(c1);
      line( i, 500 - out.mix.get(i)*100, i+1, 500 - out.mix.get(i+1)*100 );
    }
  cam.endHUD();
  cam.beginHUD();
    // MODO INSTRUMENTO
  if (mouseX < 43 && mouseY < 36 && modoInstrumento == true) {
    image(instSelecionado, 0, 0);
  }
  if ((mouseX > 43 && mouseX < 86) && mouseY < 36 && modoInstrumento == true) {
    image(sobreSelecionado, 43, 0);
  }
  cam.endHUD();}
void hudmodoInstrumento()
  {
    if (((mouseX < 43) && (mouseY<36)) && modoInstrumento == true) {
    osc1.setAmplitude(0f);
    osc2.setAmplitude(0f);
    osc3.setAmplitude(0f);
    if (gravacao != null) 
    {
      gravacao.pause(); 
      gravacao.rewind();
    }
    modoInstrumento = false;
    mousePressed = false;
  }
  if ((mouseX > 43 && mouseX < 86) && mouseY < 36 && modoInstrumento == true)
  {
    if (tSobre == false)
    {
      tSobre = true;
    } else
    {
      tSobre = false;
    }
  }
  if ((mouseX > 273 && mouseX < 773) && (mouseY >117 && mouseY <417) && tSobre==true && modoInstrumento == true)
  {
    tSobre = false;
  }
}
void teclasmodoInstrumento()
  {
    if ((key == 'a' || key == 'A') && modoInstrumento == true)
  {
    if (uniao == true) {
      osc1.setFrequency(c); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency(c/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency((c/6)); 
      osc3.setAmplitude(0.5f);
    } else {
      osc1.setFrequency(c); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency(e/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency(g/6); 
      osc3.setAmplitude(0.5f);
    }
  } 
  if ((key == 'w' || key == 'W') && modoInstrumento == true)
  {
    if (uniao == true) {
      osc1.setFrequency(cM); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency(cM/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency(cM/6); 
      osc3.setAmplitude(0.5f);
    } else {
      osc1.setFrequency(cM); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency(f/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency(gM/6); 
      osc3.setAmplitude(0.5f);
    }
  }
  if ((key == 's' || key == 'S') && modoInstrumento == true)
  {
    if (uniao == true) {
      osc1.setFrequency(d); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency(d/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency(d/6); 
      osc3.setAmplitude(0.5f);
    } else {
      osc1.setFrequency(d); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency(fM/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency((a*2)/6); 
      osc3.setAmplitude(0.5f);
    }
  }
  if ((key == 'e' || key == 'E') && modoInstrumento == true)
  {
    if (uniao == true) {
      osc1.setFrequency(dM); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency(dM/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency(dM/6); 
      osc3.setAmplitude(0.5f);
    } else {
      osc1.setFrequency(dM); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency(g/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency((aM*2)/6); 
      osc3.setAmplitude(0.5f);
    }
  }
  if ((key == 'd' || key == 'D') && modoInstrumento == true)
  {
    if (uniao == true) {
      osc1.setFrequency(e); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency(e/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency(e/6); 
      osc3.setAmplitude(0.5f);
    } else {
      osc1.setFrequency(e); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency(gM/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency((b*2)/6); 
      osc3.setAmplitude(0.5f);
    }
  }
  if ((key == 'f' || key == 'F') && modoInstrumento == true)
  {
    if (uniao == true) {
      osc1.setFrequency(f); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency(f/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency(f/6); 
      osc3.setAmplitude(0.5f);
    } else {
      osc1.setFrequency(f); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency((a*2)/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency((c*2)/6); 
      osc3.setAmplitude(0.5f);
    }
  }
  if ((key == 't' || key == 'T') && modoInstrumento == true)
  {
    if (uniao == true) {
      osc1.setFrequency(fM); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency(fM/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency(fM/6); 
      osc3.setAmplitude(0.5f);
    } else {
      osc1.setFrequency(fM); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency((aM*2)/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency((cM*2)/6); 
      osc3.setAmplitude(0.5f);
    }
  }
  if ((key == 'g' || key == 'G') && modoInstrumento == true)
  {
    if (uniao == true) {
      osc1.setFrequency(g); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency((g/2)); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency(g/6); 
      osc3.setAmplitude(0.5f);
    } else {
      osc1.setFrequency(g); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency((b*2)/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency((d*2)/6); 
      osc3.setAmplitude(0.5f);
    }
  }
  if ((key == 'y' || key == 'Y') && modoInstrumento == true)
  {
    if (uniao == true) {
      osc1.setFrequency(gM); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency(gM/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency(gM/6); 
      osc3.setAmplitude(0.5f);
    } else {  
      osc1.setFrequency(gM); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency((c*2)/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency((dM*2)/6); 
      osc3.setAmplitude(0.5f);
    }
  }
  if ((key == 'h' || key == 'H') && modoInstrumento == true)
  {
    if (uniao == true) {
      osc1.setFrequency(a*2); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency((a*2)/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency((a*2)/6); 
      osc3.setAmplitude(0.5f);
    } else {
      osc1.setFrequency(a*2); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency((cM*2)/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency((e*2)/6); 
      osc3.setAmplitude(0.5f);
    }
  }
  if ((key == 'u' || key == 'U') && modoInstrumento == true)
  {
    if (uniao == true) {
      osc1.setFrequency(aM*2); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency((aM*2)/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency((aM*2)/6); 
      osc3.setAmplitude(0.5f);
    } else {
      osc1.setFrequency(aM*2); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency((d*2)/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency((f*2)/6); 
      osc3.setAmplitude(0.5f);
    }
  }
  if ((key == 'j' || key == 'J') && modoInstrumento == true)
  {
    if (uniao == true) {
      osc1.setFrequency(b*2); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency((b*2)/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency((b*2)/6); 
      osc3.setAmplitude(0.5f);
    } else {
      osc1.setFrequency(b*2); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency((dM*2)/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency((fM*2)/6); 
      osc3.setAmplitude(0.5f);
    }
  }
  if ((key == 'k' || key == 'K') && modoInstrumento == true)
  {
    if (uniao == true) {
      osc1.setFrequency(c*2); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency((c*2)/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency((c*2)/6); 
      osc3.setAmplitude(0.5f);
    } else {  
      osc1.setFrequency(c*2); 
      osc1.setAmplitude(0.3f);
      osc2.setFrequency((e*2)/2); 
      osc2.setAmplitude(0.4f);
      osc3.setFrequency((g*2)/6); 
      osc3.setAmplitude(0.5f);
    }
  }
  // TECLAS | NOTAS MUSICAIS
  // FIM
  if (key == TAB && modoInstrumento == true)
  {
    if (uniao == true)
    {
      uniao = false;
    } else
    {
      uniao = true;
    }
  }
  if ((key == 'q' || key =='Q') && modoInstrumento == true)
  {
    if (latch == false)
    {
      latch = true;
    } else
    {
      latch = false;
    }
  }
  if ((key == 'z' || key =='Z') && modoInstrumento == true)
  {
    if (oPreset3 == true)
    {
      oPreset3 = false; 
      oPreset2 = true;
      a = 440/2; 
      aM = 466/2; 
      b = 494/2; 
      c = 524/2; 
      cM = 554/2; 
      d = 588/2; 
      dM = 624/2; 
      e = 660/2; 
      f = 700/2; 
      fM = 740/2; 
      g = 784/2; 
      gM = 832/2;
    } else if (oPreset2 == true)
    {
      oPreset2 = false; 
      oPreset1 = true;
      a = 440/4; 
      aM = 466/4; 
      b = 494/4; 
      c = 524/4; 
      cM = 554/4; 
      d = 588/4; 
      dM = 624/4; 
      e = 660/4; 
      f = 700/4; 
      fM = 740/4; 
      g = 784/4; 
      gM = 832/4;
    } else if (oPreset1 == true || oPreset4 == true || oPreset5 == true)
    {
      oPreset1 = false; 
      oPreset3 = true; 
      oPreset4 = false; 
      oPreset5 = false;
      a = 440; 
      aM = 466; 
      b = 494; 
      c = 524; 
      cM = 554; 
      d = 588; 
      dM = 624; 
      e = 660; 
      f = 700; 
      fM = 740; 
      g = 784; 
      gM = 832;
    }
  }
  if ((key == 'x' || key =='X') && modoInstrumento == true)
  {
    if (oPreset3 == true)
    {
      oPreset3 = false; 
      oPreset4 = true;
      a = 440*2; 
      aM = 466*2; 
      b = 494*2; 
      c = 524*2; 
      cM = 554*2; 
      d = 588*2; 
      dM = 624*2; 
      e = 660*2; 
      f = 700*2; 
      fM = 740*2; 
      g = 784*2; 
      gM = 832*2;
    } else if (oPreset4 == true)
    {
      oPreset4 = false; 
      oPreset5 = true;
      a = 440*4; 
      aM = 466*4; 
      b = 494*4; 
      c = 524*4; 
      cM = 554*4; 
      d = 588*4; 
      dM = 624*4; 
      e = 660*4; 
      f = 700*4; 
      fM = 740*4; 
      g = 784*4; 
      gM = 832*4;
    } else if (oPreset5 == true || oPreset1 == true || oPreset2 == true)
    {
      oPreset5 = false; 
      oPreset3 = true; 
      oPreset1 = false; 
      oPreset2 = false;
      a = 440; 
      aM = 466; 
      b = 494; 
      c = 524; 
      cM = 554; 
      d = 588; 
      dM = 624; 
      e = 660; 
      f = 700; 
      fM = 740; 
      g = 784; 
      gM = 832;
    }
  }
  if (key == '1' && modoInstrumento == true)
  {
    if (osc1.getWaveform() == Waves.SQUARE)
    {
      osc1.setWaveform(Waves.TRIANGLE);
    } else if (osc1.getWaveform() == Waves.TRIANGLE)
    {
      osc1.setWaveform(Waves.SINE);
    } else if (osc1.getWaveform() == Waves.SINE)
    {
      osc1.setWaveform(Waves.SAW);
    } else if (osc1.getWaveform() == Waves.SAW)
    {
      osc1.setWaveform(Waves.QUARTERPULSE);
    } else if (osc1.getWaveform() == Waves.QUARTERPULSE)
    {
      osc1.setWaveform(Waves.SQUARE);
    }
  }
  if (key == '2' && modoInstrumento == true)
  {
    if (osc2.getWaveform() == Waves.SQUARE)
    {
      osc2.setWaveform(Waves.TRIANGLE);
    } else if (osc2.getWaveform() == Waves.TRIANGLE)
    {
      osc2.setWaveform(Waves.SINE);
    } else if (osc2.getWaveform() == Waves.SINE)
    {
      osc2.setWaveform(Waves.SAW);
    } else if (osc2.getWaveform() == Waves.SAW)
    {
      osc2.setWaveform(Waves.QUARTERPULSE);
    } else if (osc2.getWaveform() == Waves.QUARTERPULSE)
    {
      osc2.setWaveform(Waves.SQUARE);
    }
  }
  if (key == '3' && modoInstrumento == true)
  {
    if (osc3.getWaveform() == Waves.SQUARE)
    {
      osc3.setWaveform(Waves.TRIANGLE);
    } else if (osc3.getWaveform() == Waves.TRIANGLE)
    {
      osc3.setWaveform(Waves.SINE);
    } else if (osc3.getWaveform() == Waves.SINE)
    {
      osc3.setWaveform(Waves.SAW);
    } else if (osc3.getWaveform() == Waves.SAW)
    {
      osc3.setWaveform(Waves.QUARTERPULSE);
    } else if (osc3.getWaveform() == Waves.QUARTERPULSE)
    {
      osc3.setWaveform(Waves.SQUARE);
    }
  }  
  if (key =='4' && modoInstrumento == true)
  {
    if (dtPreset1 == true)
    {
      dtPreset1 = false;
      dtPreset2 = true;
      delay1.setDelTime(0.35); 
      delay2.setDelTime(0.35); 
      delay3.setDelTime(0.35); 
    } else if (dtPreset2 == true)
    {
      dtPreset2 = false;
      dtPreset3 = true;
      delay1.setDelTime(0.5); 
      delay2.setDelTime(0.5); 
      delay3.setDelTime(0.5); 
    } else if (dtPreset3 == true)
    {
      dtPreset3 = false;
      dtPreset4 = true;
      delay1.setDelTime(0.65); 
      delay2.setDelTime(0.65); 
      delay3.setDelTime(0.65); 
    } else if (dtPreset4 == true)
    {
      dtPreset4 = false;
      dtPreset1 = true;
      delay1.setDelTime(0.8); 
      delay2.setDelTime(0.8); 
      delay3.setDelTime(0.8); 
    }
    else if (dtPreset5 == true)
    {
     dtPreset5 = false;
     dtPreset1 = true;
     delay1.setDelTime(0.2); 
     delay2.setDelTime(0.2); 
     delay3.setDelTime(0.2); 
    }
  }
  if(key =='5' && modoInstrumento == true)
  {
       if (daPreset1 == true)
    {
      daPreset1 = false;
      daPreset2 = true;
      delay1.setDelAmp(0.25); 
      delay2.setDelAmp(0.25);  
      delay3.setDelAmp(0.25);
    } else if (daPreset2 == true)
    {
      daPreset2 = false;
      daPreset3 = true;
      delay1.setDelAmp(0.5); 
      delay2.setDelAmp(0.5); 
      delay3.setDelAmp(0.5);
    } else if (daPreset3 == true)
    {
      daPreset3 = false;
      daPreset4 = true;
      delay1.setDelAmp(0.65); 
      delay2.setDelAmp(0.65); 
      delay3.setDelAmp(0.65);
    } else if (daPreset4 == true)
    {
      daPreset4 = false;
      daPreset5 = true;
      delay1.setDelAmp(0.9); 
      delay2.setDelAmp(0.9); 
      delay3.setDelAmp(0.9);
    }
    else if (daPreset5 == true)
    {
     daPreset5 = false;
     daPreset1 = true;
     delay1.setDelAmp(0); 
     delay2.setDelAmp(0); 
     delay3.setDelAmp(0);
    }
  }
  if (key =='6' && modoInstrumento == true)
  {
    if (bcPreset1 == true)
    {
      bcPreset1 = false;
      bcPreset2 = true;
      bc1.setBitRes(8); 
      bc2.setBitRes(8);
      bc3.setBitRes(8);
    } else if (bcPreset2 == true)
    {
      bcPreset2 = false;
      bcPreset3 = true;
      bc1.setBitRes(6);
      bc2.setBitRes(6);
      bc3.setBitRes(6);
    } else if (bcPreset3 == true)
    {
      bcPreset3 = false;
      bcPreset4 = true;
      bc1.setBitRes(4); 
      bc2.setBitRes(4); 
      bc3.setBitRes(4);
    } else if (bcPreset4 == true)
    {
      bcPreset4 = false;
      bcPreset1 = true;
      bc1.setBitRes(16); 
      bc2.setBitRes(16); 
      bc3.setBitRes(16);
    }
  } 
  if (key =='7' && modoInstrumento == true)
  {
    if (gPreset1 == true)
    {
      gPreset1 = false; 
      gPreset2 = true;
      gain1.setValue(1.5); 
      gain2.setValue(1.5); 
      gain3.setValue(1.5);
    } else if (gPreset2 == true)
    {   
      gPreset2 = false; 
      gPreset3 = true;
      gain1.setValue(3); 
      gain2.setValue(3); 
      gain3.setValue(3);
    } else if (gPreset3 == true)
    {   
      gPreset3 = false; 
      gPreset4 = true;
      gain1.setValue(5); 
      gain2.setValue(5); 
      gain3.setValue(5);
    } else if (gPreset4 == true)
    {   
      gPreset4 = false; 
      gPreset1 = true;
      gain1.setValue(0.f); 
      gain2.setValue(0.f); 
      gain3.setValue(0.f);
    }
  }
    if (key =='8' && modoInstrumento == true)
    {
    if (fPreset1 == true)
    {
      fPreset1 = false; 
      fPreset2 = true;
      filtro1.frequency.setLastValue( 6000  );
      filtro2.frequency.setLastValue( 6000  );
      filtro3.frequency.setLastValue( 6000  );
    } 
    else if (fPreset2 == true)
    {   
      fPreset2 = false; 
      fPreset3 = true;
      filtro1.frequency.setLastValue( 8000  );
      filtro2.frequency.setLastValue( 8000  );
      filtro3.frequency.setLastValue( 8000 );
    } 
    else if (fPreset3 == true)
    {   
      fPreset3 = false; 
      fPreset4 = true;
      filtro1.frequency.setLastValue( 2500  );
      filtro2.frequency.setLastValue( 2500  );
      filtro3.frequency.setLastValue( 2500  );
    } 
    else if (fPreset4 == true)
    {   
      fPreset4 = false; 
      fPreset1 = true;
      filtro1.frequency.setLastValue( 4000  );
      filtro2.frequency.setLastValue( 4000  );
      filtro3.frequency.setLastValue( 4000  ); 
    }
  }
  if (key =='9' && modoInstrumento == true)
  {
       if (rPreset1 == true)
    {
      rPreset1 = false; 
      rPreset2 = true;
      filtro1.resonance.setLastValue( 0.4  );
      filtro2.resonance.setLastValue( 0.4  );
      filtro3.resonance.setLastValue( 0.4  );
    } 
    else if (rPreset2 == true)
    {   
      rPreset2 = false; 
      rPreset3 = true;
      filtro1.resonance.setLastValue( 0.6  );
      filtro2.resonance.setLastValue( 0.6  );
      filtro3.resonance.setLastValue( 0.6 );
    } 
    else if (rPreset3 == true)
    {   
      rPreset3 = false; 
      rPreset4 = true;
      filtro1.resonance.setLastValue( 0.8  );
      filtro2.resonance.setLastValue( 0.8  );
      filtro3.resonance.setLastValue( 0.8  );
    } 
    else if (rPreset4 == true)
    {   
      rPreset4 = false; 
      rPreset5 = true;
      filtro1.resonance.setLastValue( 0.9  );
      filtro2.resonance.setLastValue( 0.9  );
      filtro3.resonance.setLastValue( 0.9  ); 
    }
    else if (rPreset5 == true)
    {
     rPreset5 = false;
     rPreset1 = true;
     filtro1.resonance.setLastValue( 0.2  );
     filtro2.resonance.setLastValue( 0.2  );
     filtro3.resonance.setLastValue( 0.2  );     
    }
  }
  if ( key == ENTER && modoInstrumento == true ) 
  {
    if (gravador.isRecording() ) 
    {
      gravador.endRecord();
      gravado = true;
      salvo = false;
    } else 
    {
      gravador = minim.createRecorder(out, "gravacao.wav");
      gravador.beginRecord();
    }
  }
  if (gravado && key ==  ' ' && modoInstrumento == true && gravador.isRecording() ==false)
  {
    if (gravacao != null)
    {
      gravacao.unpatch( out );
      gravacao.close();
    }
    salvo = true;
    gravacao = new FilePlayer( gravador.save() );
    gravacao.patch( out );
    gravacao.play();
  }
  if ((key == 'v' || key == 'V') && modoInstrumento == true && gravador.isRecording() == false)
  {
    if (gravacao != null) { 
      gravacao.rewind();
      gravacao.play();
    }
  }
  if ((key =='b' || key =='B') && modoInstrumento == true && gravado == true)
  {
    gravacao.pause();
    gravacao.rewind();
  }
  }
void soltarTecla()
  {
  if ( key !='1' && key!='2' && key !='3' && key !='4' && key !='5' && key !='6' && key !='7' && key !='8' && key !='9' &&  key !=TAB && modoInstrumento == true && latch == false)
  {
    osc1.setAmplitude(0f);  
    osc2.setAmplitude(0f);
    osc3.setAmplitude(0f);
  }
  }
