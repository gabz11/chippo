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
      text("Modo: União", 50, 240);
    }
    if (uniao == false) {
      text("Modo: Triade (Acorde)", 50, 240);
    }
    if (latch == false) {
      text("Latch: Desligado", 50, 260);
    }
    if (latch == true) {
      text("Latch: Ligado", 50, 260);
    }
    if (dPreset1 == true) {
      text("Delay: 1", 50, 300);
    }
    if (dPreset2 == true) {
      text("Delay: 2", 50, 300);
    }
    if (dPreset3 == true) {
      text("Delay: 3", 50, 300);
    }
    if (dPreset4 == true) {
      text("Delay: 4", 50, 300);
    }
    if (bcPreset1 == true) {
      text("Bits (Amostra): 16", 50, 280);
    }
    if (bcPreset2 == true) {
      text("Bits (Amostra): 8", 50, 280);
    }
    if (bcPreset3 == true) {
      text("Bits (Amostra): 6", 50, 280);
    }
    if (bcPreset4 == true) {
      text("Bits (Amostra): 4", 50, 280);
    }
    if (gPreset1 == true) {
      text("Ganho: 0 dB", 50, 320);
    }
    if (gPreset2 == true) {
      text("Ganho: +1.5 dB", 50, 320);
    }
    if (gPreset3 == true) {
      text("Ganho: +3 dB", 50, 320);
    }
    if (gPreset4 == true) {
      text("Ganho: +5 dB", 50, 320);
    }
    if (oPreset1 == true) {
      text("Oitava: -2", 50, 340);
    }
    if (oPreset2 == true) {
      text("Oitava: -1", 50, 340);
    }
    if (oPreset3 == true) {
      text("Oitava: 0", 50, 340);
    }
    if (oPreset4 == true) {
      text("Oitava: +1", 50, 340);
    }
    if (oPreset5 == true) {
      text("Oitava: +2", 50, 340);
    }
    if (tSobre == true) {
      image(esquemaTeclado, 273, 117);
    }
    if (osc1.getWaveform() == Waves.SQUARE) {
      text("Oscilador 1: Quadrado", 50, 180);
    }
    if (osc1.getWaveform() == Waves.SAW) {
      text("Oscilador 1: Serra", 50, 180);
    }
    if (osc1.getWaveform() == Waves.TRIANGLE) {
      text("Oscilador 1: Triângulo", 50, 180);
    }
    if (osc1.getWaveform() == Waves.SINE) {
      text("Oscilador 1: Seno", 50, 180);
    }
    if (osc1.getWaveform() == Waves.QUARTERPULSE) {
      text("Oscilador 1: Pulso", 50, 180);
    }
    if (osc2.getWaveform() == Waves.SQUARE) {
      text("Oscilador 2: Quadrado", 50, 200);
    }
    if (osc2.getWaveform() == Waves.SAW) {
      text("Oscilador 2: Serra", 50, 200);
    }
    if (osc2.getWaveform() == Waves.TRIANGLE) {
      text("Oscilador 2: Triângulo", 50, 200);
    }
    if (osc2.getWaveform() == Waves.SINE) {
      text("Oscilador 2: Seno", 50, 200);
    }
    if (osc2.getWaveform() == Waves.QUARTERPULSE) {
      text("Oscilador 2: Pulso", 50, 200);
    }    
    if (osc3.getWaveform() == Waves.SQUARE) {
      text("Oscilador 3: Quadrado", 50, 220);
    }
    if (osc3.getWaveform() == Waves.SAW) {
      text("Oscilador 3: Serra", 50, 220);
    }
    if (osc3.getWaveform() == Waves.TRIANGLE) {
      text("Oscilador 3: Triângulo", 50, 220);
    }
    if (osc3.getWaveform() == Waves.SINE) {
      text("Oscilador 3: Seno", 50, 220);
    }
    if (osc3.getWaveform() == Waves.QUARTERPULSE) {
      text("Oscilador 3: Pulso", 50, 220);
    }
    // FIM 
    // INTERFACE INSTRUMENTO
    for (int i = 0; i < out.bufferSize() - 1; i++)
    {
      image(inst, 0, 0);
      image(sobre, 43, 0);
      image(fechar, 981, 0);
      if (gravador.isRecording())
      {
        text("Agora pressione ENTER para terminar de gravar.", 300, 500);
      } else if ( !gravado )
      {
        text("Pressione ENTER para começar a gravar!", 300, 500);
      } else if ( salvo == false)
      {
        text("Pressione ESPAÇO para salvar!", 300, 500);
      } else if ( salvo == true)
      {
        text("Pressione ENTER para gravar novamente...", 300, 480); 
        text("Pressione V para ouvir a gravação...", 300, 500);
        text("Pressione B para pausar a gravação...", 300, 520);
      }
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
    if (dPreset1 == true)
    {
      dPreset1 = false;
      dPreset2 = true;
      delay1.setDelTime(0.2); 
      delay1.setDelAmp(0.25); 
      delay2.setDelTime(0.2); 
      delay2.setDelAmp(0.25); 
      delay3.setDelTime(0.2); 
      delay3.setDelAmp(0.25);
    } else if (dPreset2 == true)
    {
      dPreset2 = false;
      dPreset3 = true;
      delay1.setDelTime(0.4); 
      delay1.setDelAmp(0.5); 
      delay2.setDelTime(0.4); 
      delay2.setDelAmp(0.5); 
      delay3.setDelTime(0.4); 
      delay3.setDelAmp(0.5);
    } else if (dPreset3 == true)
    {
      dPreset3 = false;
      dPreset4 = true;
      delay1.setDelTime(0.4); 
      delay1.setDelAmp(0.7); 
      delay2.setDelTime(0.4); 
      delay2.setDelAmp(0.7); 
      delay3.setDelTime(0.4); 
      delay3.setDelAmp(0.7);
    } else if (dPreset4 == true)
    {
      dPreset4 = false;
      dPreset1 = true;
      delay1.setDelTime(0.1); 
      delay1.setDelAmp(0); 
      delay2.setDelTime(0.1); 
      delay2.setDelAmp(0); 
      delay3.setDelTime(0.1); 
      delay3.setDelAmp(0);
    }
  }
  if (key =='5' && modoInstrumento == true)
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
  if (key =='6' && modoInstrumento == true)
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
