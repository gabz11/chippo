// importa  o minim
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import peasy.PeasyCam;
import processing.awt.PSurfaceAWT;
import java.awt.MouseInfo;
import java.awt.Point;
// VARIAVEIS
String selection;
PFont fonte;
PShader edges;
PImage escolher, escolherSelecionado, play, playSelecionado, pause, pauseSelecionado, stop, stopSelecionado, barraVol, sobre, sobreSelecionado, volmenos, volmenosSelecionado, volmais, volmaisSelecionado, info, inst, instSelecionado, esquemaTeclado, erroAbrir, fechar, fecharSelecionado;
float raio;
// INTERFACE
// Esquema de cores do programa
color c1 = #F1F6F9; // branco 
color c2 = #14274E; // azul escuro
color c3 = #394867; // azul "cinza"
color c4 = #9BA4B4; // cinza leve
color c5 = #370617; // laranja escuro
color c6 = #9d0208; // laranja meio escuro
color c7 = #d00000; // vermelho
int vPreset = 1; 
int volume = -2;
// NOTAS MUSICAIS | FREQUENCIA
boolean tSobre = false, cSobre = false, exibir = true;
// MODO INSTRUMENTO 
int a = 440, aM = 466, b = 494, c = 524, cM = 554, d = 588, dM = 624, e = 660, f = 700, fM = 740, g = 784, gM = 832;
boolean modoInstrumento = false, uniao = true, gravado = false;
boolean dPreset1 = true, dPreset2 = false, dPreset3 = false, dPreset4 = false;
boolean bcPreset1 = true, bcPreset2 = false, bcPreset3 = false, bcPreset4 = false;
boolean latch = false;
boolean oPreset1 = false, oPreset2 = false, oPreset3 = true, oPreset4 = false, oPreset5 = false;
boolean gPreset1 = true, gPreset2 = false, gPreset3 = false, gPreset4 = false;
boolean salvo = false;
boolean mp3 = true, erroArquivo = false;
boolean terminou;
//
int segundos, minutos;
int segundosTotal, minutosTotal;
int contaSegundo = 1000;
Minim minim;
PSurfaceAWT awtSurface;
PSurfaceAWT.SmoothCanvas smoothCanvas;
// player & gravação
AudioPlayer player;
AudioRecorder gravador;
AudioMetaData meta;
// saida sintetizador
AudioOutput out;
// detector de batida para visualizer
BeatDetect beat;
FFT fft;
PeasyCam cam;
// SINTETIZADOR aka MODO INSTRUMENTO
// osciladores, filtro ADSR & modulação(Bitcrush + DELAY)
Oscil osc1, osc2, osc3;
Gain gain1, gain2, gain3;
ADSR adsr1, adsr2, adsr3;
Delay delay1, delay2, delay3;
BitCrush bc1, bc2, bc3;
// Player gravacao
FilePlayer gravacao;
// VISUALIZER 2
//
int cols, rows;
int alt = 3000; //altura d grid do terreno
int lar = 2500; //largura d grid do terreno
int tam = 25; //tamanho de cada quadradinho
//as cores de tudo, mas n vai ser sempre exatamente essa cor, pra cada cor vai ser escolhido um numero entre ele mesmo e um outro com uma diferenca de no maximo 20, e o topo e baixo vai puxar um pouco da cor do meio pra n ficar mt pra todo lado
color meio; 
color topo;
color baixo;
//a cor do background muda sempre com um valor random dentro do draw()
float br = 0;
float bg = 0;
float bb = 0;
//contadores para coisas aleatorias, o cont1 eu deletei e n mudei os outros kk
boolean cont2;
int cont3 = 0;
int xm = 0;
int click = 1;
boolean dinamico = false;
//posicao e tamanho da lua que fica indo de um lado pro outro e de vez em quando aumenta de tamanho
float luapos = 0;
int luatam;
float luaposcord = 0;
//velocidade da movimentacao do grid
float camera;
//em java chama um array de duas dimensoes dessa maneira
float[][] terreno;
// FIM VISUALIZER 2
//
void setup() {
  // CANVAS
  fullScreen(P3D);
  surface.setSize(1024, 768);
  surface.setLocation((displayWidth/2)-(width/2), (displayHeight/2)-(height/2));
  background(0);
  fonte = createFont("Seurat.otf", 14);
  textFont(fonte);
  //
  minim = new Minim(this);
  player = minim.loadFile("track1.mp3", 1024);
  beat = new BeatDetect();
  meta = player.getMetaData();
  beat.setSensitivity(500);
  ellipseMode(RADIUS);
  raio = 20;
  escolher = loadImage("escolher1.png");
  escolherSelecionado = loadImage("escolherSelecionado.png");
  play = loadImage("playALT.png");
  playSelecionado = loadImage("playALTSelecionado.png");
  pause = loadImage("pauseALT.png");
  pauseSelecionado = loadImage("pauseALTSelecionado.png");
  stop = loadImage("stopALT.png");
  stopSelecionado = loadImage("stopALTSelecionado.png");
  barraVol = loadImage("volume0.png");
  sobre = loadImage("sobre.png");
  sobreSelecionado = loadImage("sobreSelecionado.png");
  volmenos = loadImage("volmenos.png");
  volmenosSelecionado = loadImage("volmenosSelecionado.png");
  volmais = loadImage("volmais.png");
  volmaisSelecionado = loadImage("volmaisSelecionado.png");
  info = loadImage("info.png");
  inst = loadImage("modoinstrumento.png");
  instSelecionado = loadImage("modoinstrumentoSelecionado.png");
  esquemaTeclado = loadImage("esquemaTeclado.png");
  erroAbrir = loadImage("erroArquivo.png");
  fechar = loadImage("fechar.png");
  fecharSelecionado = loadImage("fecharSelecionado.png");
  // SINTETIZADOR
  osc1 = new Oscil( 440, 0f, Waves.SQUARE ); 
  osc2 = new Oscil( 440, 0f, Waves.SAW); 
  osc3 = new Oscil( 440, 0f, Waves.SINE);
  adsr1 = new ADSR( 0.5f, 0.01, 0.05, 0.5, 0.5, 0, 0 ); 
  adsr2 = new ADSR( 0.5f, 0.01, 0.05, 0.5, 0.5, 0, 0 );
  adsr3 = new ADSR( 0.5f, 0.01, 0.05, 0.5, 0.5, 0, 0 );
  gain1 = new Gain(0.f); 
  gain2 = new Gain(0.f); 
  gain3 = new Gain(0.f);
  delay1 = new Delay(0.1, 0, true, true); 
  delay2 = new Delay(0.1, 0, true, true);
  delay3 = new Delay(0.1, 0, true, true);
  out = minim.getLineOut(Minim.STEREO, 1024, 44100, 16);
  adsr1.noteOn(); 
  adsr2.noteOn(); 
  adsr3.noteOn();
  bc1 = new BitCrush(16, out.sampleRate()); 
  bc2 = new BitCrush(16, out.sampleRate()); 
  bc3 = new BitCrush(16, out.sampleRate());
  osc1.patch(adsr1); 
  osc2.patch(adsr2);
  osc3.patch(adsr3);
  adsr1.patch( bc1 ).patch( delay1 ).patch(gain1).patch(out);
  adsr2.patch( bc2 ).patch( delay2 ).patch(gain2).patch(out);
  adsr3.patch( bc3 ).patch( delay3 ).patch(gain3).patch(out);
  // GRAVADOR
  gravador = minim.createRecorder(out, "gravacao.wav");
  // TEMPO
  segundosTotal = (player.length()/1000)-((player.length()/60000)*60);
  minutosTotal = player.length()/60000;
  //
  // VISUALIZER TERRENO
  cols = lar / tam; //o tamanho de colunas e igual a largura do grid dividido pelo tamanho do quadradinho
  rows = alt / tam; //o tamanho de linhas e igual a altura do grid dividido pelo tamanho do quadradinho
  terreno = new float[cols][rows]; //os valores do array terreno serao o mesmo q o cols e rows
  fft = new FFT(player.bufferSize(), player.sampleRate()); //o ngc pra fazer o FFT funciona
  temacor();
  cam = new PeasyCam(this, 500, 0, 1000, 50);
  //
  edges = loadShader("edges.glsl");

  cam.setActive(false); // EU DESATIVEI SO PQ EU N TO ENTENDO COMO Q FUNCIONA E N FUNCIONA COM O NGC DE CLICA NA LUA PRA MUDA O TEMA
}
void draw() {
  beat.detect(player.mix);
  fft.forward(player.mix);
  //fill(c3);
  // MODO VISUALIZADOR / PLAYER
  // PRESET 1 = padrão
  if (vPreset == 1 && modoInstrumento == false) {
    background(0);
    for (int i = 0; i < player.bufferSize(); i++)
    {
      cam.beginHUD();
      stroke(255);
      noFill();
      line(i, height/2+player.mix.get(i)*300, i, height/2-player.mix.get(i)*300);
      rotate(PI);
      cam.endHUD();
    }        
    for (int i = 0; i < player.bufferSize(); i++)
    {
      cam.beginHUD();
      stroke(c3, 150);
      noFill();
      line(i, height/2+player.mix.get(i)*300, i, height/2-player.mix.get(i)*300);
      rotate(HALF_PI);
      cam.endHUD();
    }
  }
  if (vPreset == 2 && modoInstrumento == false) {
    //background(c4);
    visualizer2();
  }

  // botão escolher 86x72
  // 43x36 demais botões
  if (exibir == true && modoInstrumento == false)
  {
    segundos = (player.position()/1000)%60;
    minutos = player.position()/60000;
    cam.beginHUD();
    image(escolher, 0, 0); 
    image(play, 86, 0); 
    image(pause, 129, 0); 
    image(stop, 172, 0); 
    image(sobre, 215, 0); 
    image(inst, 258, 0); 
    image(barraVol, 100, 60); 
    image(volmenos, 0, 72); 
    image(volmais, 43, 72);
    image(fechar, 981, 0);
    fill(c4);
    if (segundos <= 9 && segundosTotal <=9) {
      text(minutos+":0"+segundos+"/"+minutosTotal+":0"+segundosTotal, 10, 150);
    } else if (segundos <= 9 && segundosTotal > 9) {
      text(minutos+":0"+segundos+"/"+minutosTotal+":"+segundosTotal, 10, 150);
    } else if (segundos > 9 && segundosTotal <=9) {
      text(minutos+":"+segundos+"/"+minutosTotal+":0"+segundosTotal, 10, 150);
    } else if (segundos > 9 && segundosTotal > 9) {
      text(minutos+":"+segundos+"/"+minutosTotal+":"+segundosTotal, 10, 150);
    }
    fill(c3, 125);
    noStroke();
    rect(86, 36, 215, 12);
    stroke(c4);
    strokeWeight(1);
    float posicao = map( player.position(), 0, player.length(), 86, 301);
    line(posicao, 48, posicao, 36 );
    cam.endHUD();
    if (mp3 == true) {   
      cam.beginHUD();
      fill(c4); 
      textSize(14); 
      text(meta.author()+"  -  "+meta.title()+"  -  "+meta.album(), 10, 130);   
      cam.endHUD();
    }
  }

  if (erroArquivo == true)
  {
    cam.beginHUD();
    image(erroAbrir, 273, 234);
    cam.endHUD();
  }

  // MODO INSTRUMENTO
  //
  // Da linha 138 até 
  if (modoInstrumento == true) {
    modoInstrumento = true;
    modoInstrumento();
  }
  cam.beginHUD();
  if (cSobre == true)
  {  
    image(info, 273, 234);
  }
  if (((mouseX<86) && (mouseY<72)) && exibir == true && modoInstrumento == false) {
    image(escolherSelecionado, 0, 0);
  }
  if (((mouseX>86 && mouseX < 130 ) && (mouseY<36)) && exibir == true && modoInstrumento == false) {
    image(playSelecionado, 86, 0);
  }
  if (((mouseX>130 && mouseX < 173 ) && (mouseY<36)) && exibir == true && modoInstrumento == false) {
    image(pauseSelecionado, 130, 0);
  }
  if (((mouseX>173 && mouseX < 216  ) && (mouseY<36)) && exibir == true && modoInstrumento == false) {
    image(stopSelecionado, 173, 0);
  }
  if (((mouseX>216 && mouseX < 259  ) && (mouseY<36)) && exibir == true && modoInstrumento == false) {
    image(sobreSelecionado, 216, 0);
  }
  if (((mouseX>259 && mouseX < 302) && (mouseY<36)) && exibir == true && modoInstrumento == false) {
    image(instSelecionado, 259, 0);
  }
  if (((mouseX > 0 && mouseX < 43  ) && (mouseY > 72 && mouseY < 99)) && exibir == true && modoInstrumento == false) {
    image(volmenosSelecionado, 0, 72);
  }
  if (((mouseX > 43 && mouseX < 86  ) && (mouseY > 72 && mouseY < 99)) && exibir == true && modoInstrumento == false) {
    image(volmaisSelecionado, 43, 72);
  }
  cam.endHUD();
  if (volume == 0 && modoInstrumento == false) {
    barraVol = loadImage("volume0.png");
    player.setGain(0);
  }
  if (volume == -1 && modoInstrumento == false) {
    barraVol = loadImage("volume-1.png");
    player.setGain(-8);
  }
  if (volume == -2 && modoInstrumento == false) {
    barraVol = loadImage("volume-2.png");
    player.setGain(-16);
  }
  if (volume ==-3 && modoInstrumento == false) {
    player.setGain(-24);
    barraVol = loadImage("volume-3.png");
  }
  if (volume ==-4 && modoInstrumento == false)
  {
    player.setGain(-30);
    barraVol = loadImage("volume-4.png");
  }
  if (volume == -5 && modoInstrumento == false)
  {
    player.setGain(-100);
    barraVol = loadImage("volume-5.png");
  }
  // FORÇAR VOLUME 
  // UM VALOR
  if (volume <=-6)
  {
    volume =-5;
  }
  if (volume > 0)       
  {
    volume =0;
  }
}
void mousePressed() {
  if(modoInstrumento == true)
  {hudmodoInstrumento();}
  if ((mouseX >= luaposcord - 30 && mouseX <= luaposcord + 30 && mouseY >= 24 && mouseY <= 71 || mouseX <= luaposcord - 30 && mouseX >= luaposcord + 30 && mouseY >= 24 && mouseY <= 71) && modoInstrumento == false && vPreset == 2) {
    click++;
    temacor();
  }
  if ((mouseX > 86 && mouseX < 301) && (mouseY > 36 && mouseY < 48) && modoInstrumento == false && exibir == true) {
    int posicao = int(map(mouseX, 86, 301, 0, player.length() ) );
    player.cue( posicao );
  }
  if (((mouseX<86) && (mouseY<72)) && exibir == true && modoInstrumento == false)
  {
    player.pause();
    player.rewind();
    selectInput("Selecione o arquivo (.MP3/.WAV/.AIFF/.AU/.SND):", "fileSelected");
  }
  // play
  if (((mouseX>86 && mouseX < 130 ) && (mouseY<36)) && exibir == true && modoInstrumento == false)
  {
    if (player.isPlaying())
    {
      player.pause();
    } else if ( player.position() >= player.length())
    {
      player.rewind();
      player.play();
    } else
    {
      player.play();
    }
  }
  if (((mouseX>130 && mouseX < 173 ) && (mouseY<36)) && exibir == true && modoInstrumento == false)
  {
    player.pause();
  }
  if (((mouseX>173 && mouseX < 216  ) && (mouseY<36)) && exibir == true && modoInstrumento == false)
  {
    player.pause();
    player.rewind();
  }
  if (((mouseX>216 && mouseX < 259  ) && (mouseY<36)) && exibir == true && modoInstrumento == false)
  {
    if (cSobre == false)
    {
      cSobre = true;
    } else if (cSobre == true)
    {
      cSobre = false;
    }
  }
  if (((mouseX > 273 && mouseX < 773) && (mouseY >234 && mouseY <534)) && exibir == true && modoInstrumento == false && erroArquivo == true)
  {
    erroArquivo = false;
  }
  if (((mouseX>0 && mouseX < 43 ) && (mouseY>72 && mouseY < 99)) && exibir == true && modoInstrumento == false)
  {
    volume -=1;
  }
  if (((mouseX > 43 && mouseX < 86  ) && (mouseY > 72 && mouseY < 99)) && exibir == true && modoInstrumento == false) {
    volume +=1;
  }
  if ((mouseX > 273 && mouseX < 773) && (mouseY >234 && mouseY <534) && cSobre==true && modoInstrumento == false)
  {
    cSobre = false;
  }
  if (((mouseX>259 && mouseX < 302) && (mouseY<36)) && exibir == true && modoInstrumento == false) {
    player.pause();
    modoInstrumento = true;
  }
  // MODO INSTRUMENTO
}
// PLAYER
// &
// VISUALIZER
// seleção de arquivo 
void fileSelected(File selection) {
  if (selection == null) {
    println("Janela fechada.");
  } else {
    println("Usuário selecionou. " + selection.getAbsolutePath());
    if (selection.getAbsolutePath().endsWith(".mp3"))
    {
      erroArquivo = false;
      mp3 = true;
      player = minim.loadFile(selection.getAbsolutePath(), 1024);
      segundosTotal = (player.length()/1000)-((player.length()/60000)*60);
      minutosTotal = player.length()/60000;
      meta = player.getMetaData();
      beat.detect(player.mix);
      fft.forward(player.mix);
    } else if (selection.getAbsolutePath().endsWith(".wav") || selection.getAbsolutePath().endsWith(".aiff") || selection.getAbsolutePath().endsWith(".au") || selection.getAbsolutePath().endsWith(".snd")) {
      erroArquivo = false;
      mp3 = false;
      player = minim.loadFile(selection.getAbsolutePath(), 1024);
      segundosTotal = (player.length()/1000)-((player.length()/60000)*60);
      minutosTotal = player.length()/60000;
      player.rewind();
      beat.detect(player.mix);
      fft.forward(player.mix);
    } else {
      erroArquivo = true;
    }
  }
  // evento de atalhos
}
public void keyPressed() {
  if (modoInstrumento == true)
  {teclasmodoInstrumento();}
  if (key == 'd' || key == 'D' && vPreset == 2) { // se aperta d o boolean dinamica fica positivo ou negativo dependendo da situacao atual dele, se true a cor do terreno vai mudar de vez em quando
    if (dinamico == false) dinamico = true; 
    else dinamico = false;
    temacor();
  }
  if ((key =='-') && modoInstrumento == false)
  {
    volume -= 1;
  }
  if (key == '+' && modoInstrumento == false)
  {
    volume += 1;
  }
  if (key == ' ' && modoInstrumento == false)
  {
    if (player.isPlaying())
    {
      player.pause();
    } else if (player.position() == player.length())
    {
      player.rewind();
      player.play();
    } else if (player.isPlaying() == false)
    {
      player.play();
    }
  }
  if ((key =='h' || key =='H') && modoInstrumento == false)
  {
    if (exibir == true)
    {
      exibir = false;
    } else if (exibir == false)
    {
      exibir = true;
    }
  }
  // MODO INSTRUMENTO
  // NOTAS MUSICAIS
  
  if (key == '1' && modoInstrumento == false) {
    vPreset=1;
  }
  if (key == '2' && modoInstrumento == false) {
    vPreset=2;
  }
  
}
void keyReleased() {
  if ( key !='1' && key!='2' && key !='3' && key !='4' && key !='5' && key !='6' && key !='7' && key !='8' && key !='9' &&  key !=TAB && modoInstrumento == true && latch == false)
  {
    osc1.setAmplitude(0f);  
    osc2.setAmplitude(0f);
    osc3.setAmplitude(0f);
  }
}

void removeFrameBorder() {
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify();
}
