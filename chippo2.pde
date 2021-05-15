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
PImage escolher,escolherSelecionado,play,playSelecionado,pause,pauseSelecionado,stop,stopSelecionado,barraVol,sobre,sobreSelecionado,volmenos,volmenosSelecionado,volmais,volmaisSelecionado,info,inst,instSelecionado,esquemaTeclado,erroAbrir,fechar,fecharSelecionado;
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
int vPreset = 1; int volume = -2;
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
boolean shaderPonta = true;
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
// SINTETIZADOR
// osciladores, filtro ADSR & modulação(Bitcrush + DELAY)
Oscil osc1,osc2,osc3;
Gain gain1,gain2,gain3;
ADSR adsr1,adsr2,adsr3;
Delay delay1,delay2,delay3;
BitCrush bc1, bc2,bc3;
// Player gravacao
FilePlayer gravacao;
int cols, rows;
int alt = 3000; //altura d grid do terreno
int lar = 2000; //largura d grid do terreno
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
//
void setup() {
  // CANVAS
  fullScreen(P3D);
  surface.setSize(1024,768);
  surface.setLocation((displayWidth/2)-(width/2), (displayHeight/2)-(height/2));
  background(0);
  fonte = createFont("Seurat.otf",14);
  textFont(fonte);
  //
  minim = new Minim(this);
  player = minim.loadFile("track1.mp3",1024);
  beat = new BeatDetect();
  meta = player.getMetaData();
  beat.setSensitivity(20);
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
  osc1 = new Oscil( 440, 0f, Waves.SQUARE ); osc2 = new Oscil( 440, 0f, Waves.SAW); osc3 = new Oscil( 440, 0f, Waves.SINE);
  adsr1 = new ADSR( 0.5f, 0.01, 0.05, 0.5, 0.5, 0,0 ); adsr2 = new ADSR( 0.5f, 0.01, 0.05, 0.5, 0.5, 0,0 );adsr3 = new ADSR( 0.5f, 0.01, 0.05, 0.5, 0.5,0,0 );
  gain1 = new Gain(0.f); gain2 = new Gain(0.f); gain3 = new Gain(0.f);
  delay1 = new Delay(0.1,0,true,true); delay2 = new Delay(0.1,0,true,true);delay3 = new Delay(0.1,0,true,true);
  out = minim.getLineOut(Minim.STEREO,1024,44100,16);
  adsr1.noteOn(); adsr2.noteOn(); adsr3.noteOn();
  bc1 = new BitCrush(16, out.sampleRate()); bc2 = new BitCrush(16, out.sampleRate()); bc3 = new BitCrush(16, out.sampleRate());
  osc1.patch(adsr1); osc2.patch(adsr2);osc3.patch(adsr3);
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
  frameRate(60);
  temacor();
  cam = new PeasyCam(this, 500,0,1000,50);
  //
  edges = loadShader("edges.glsl");
}
void draw() {
    beat.detect(player.mix);
    fft.forward(player.mix);
    luatam = 100;
    fill(c3);
    // MODO VISUALIZADOR / PLAYER
    // PRESET 1 = padrão
    if(vPreset == 1 && modoInstrumento == false){
      background(0);
      for(int i = 0; i < player.bufferSize(); i++)
      {
      cam.beginHUD();
      stroke(255);
      noFill();
      line(i, height/2+player.mix.get(i)*300,i, height/2-player.mix.get(i)*300);
      rotate(PI);
      cam.endHUD();
      }        
      for(int i = 0; i < player.bufferSize(); i++)
      {
      cam.beginHUD();
      stroke(c3,150);
      noFill();
      line(i, height/2+player.mix.get(i)*300,i, height/2-player.mix.get(i)*300);
      rotate(HALF_PI);
      cam.endHUD();
      }
    }
    if(vPreset == 2 && modoInstrumento == false){
     background(c4);
     if (beat.isOnset() && fft.getBand(1) > 20 && cont3 == 0 && dinamico == true) {  //quando ele detecta uma batida, a frequencia da musica ta alta e o contador for igual a 0 ele muda a cor do grid, o motivo de ser meio dificil de mudar e pra nao ficar tao ruim no olho tanta cor mudando
      meio = color(random(red(meio)-20, red(meio)+20), random(green(meio)-20, green(meio)+20), random(blue(meio)-20, blue(meio)+20));
      topo = color(random(red(topo)-20, red(topo)+20), random(green(topo)-20, green(topo)+20), random(blue(topo)-20, blue(topo)+20));
      baixo = color(random(red(baixo)-20, red(baixo)+20), random(green(baixo)-20, green(baixo)+20), random(blue(baixo)-20, blue(baixo)+20));
    }
    if (beat.isOnset()) {  //toda vez q detecta uma batida muda a cor do background, aumenta o tamanho da lua e adiciona 1 ao contador 3 usado aqui em cima
      br = random(0, 180);
      bg = random(0, 180);
      bb = random(0, 255);
      luatam += 50;
      cont3++;
    }
    if (cont3 == 10) cont3 = 0;
    background(br, bg, bb); //cor do background
    //aqui e mais uma vez eu testando coisa com cor, da pra mudar esses valores tranquilo tb
    color interA = lerpColor(topo, meio, .33); //esse e usado pra parte do topo do terreno, so pra nao ficar mt longe da cor do meio 
    color interB = lerpColor(baixo, meio, .33); //esse e usado pra parte funda do terreno, so pra nao ficar mt longe da cor do meio 
    //o lerpcolor ele praticamente junta as duas cores
    pushMatrix();
    color inverse = color(255-br, 255-bg, 255-bb); //esse e a variavel color q eu descobri q existe, ele pega a cor do background e subtrai em 255, q acaba invertendo ela
    strokeWeight(map(fft.getBand(1), -1, 20, 0.1, 0.4)); // a grossura do stroke da lua, o map ele vai pega o valor da frequencia do canal 1 e vai mapea de -1 ate 20 para 0.1 ate 0.3...
    noFill();
    translate(luapos, -700, -1600); //muda a posicao da lua, o terceiro argumento e o z
    stroke(red(inverse), green(inverse), blue(inverse)); //a cor inversa do background e vai pro stroke da lua
    sphere(luatam); //cria uma esfera 3D, dava pra usar o ellipse mas eu achei esse mais legal
    if (cont2 == true) { // verifica o estado do cont2 que verifica qual lado q a lua tenq andar
      luapos -= map(fft.getBand(1), -1, 10, 0.02, 0.12); //se cont2 for verdadeiro ele vai subtrair o luapos se acordo com o map da frequencia do canal 1, qnd a musica estiver com uma frequencia alta a lua se move mais rapido
      rotateY(map(fft.getBand(1), -1, 10, 0, 0.5)); //mesma coisa de cima mas ele gira a lua, e bem dificil de ver mas s
    } else {
      luapos += map(fft.getBand(1), -1, 10, 0.02, 0.12); // mesma coisa que ali em cima mas ele soma agora, esse vai pra direita e o de cima pra esquerda
      rotateY(map(fft.getBand(1), -1, 10, 0, -0.5));
    }
    if (luapos > 1050) { //o ngc do cont2, se a pos dele for 1050 ele comeca a ir pra esquerda, e qnd for -600 vai pra direita
      cont2 = true;
    } 
    if (luapos<-600) {
      cont2 = false;
    }
    luaposcord = map(luapos, -600, 1050, 70, 420);
    popMatrix();
    strokeWeight(map(fft.getBand(1), 0, 70, 2, 2.7)); //stroke do terreno, os quadradinho, q tb muda quanto maior a frequencia do canal 1 da musica
    if (player.isPlaying()) { //se o player estiver tocando ele muda a velocidade da camera
      camera -= map(fft.getBand(1), -1, 13, 0.02, 0.028)+0.01; //qnt maior a freq maior a velocidade
    } else {
      camera -= 0.00;
    }
    float y2 = camera;

    for (int y = 0; y < rows; y++) {
      float x2 = 0;
    for (int x = 0; x < cols; x++) { //aqui vai executar o codigo ate q o x seja igual ao numero de colunas e em cima o y igual ao numero de linhas
      //a diferenca do noise em relacao ao random, e q o noise faz os valores em volta serem parecidos, no nosso caso faz as elevacoes ficarem mais suaves, soq ele so faz de 0 a 1 entao tenq dar map()
      terreno[x][y] = map(noise(x2, y2), 0, 1, -100, 130); //o -100 e a altura minima e o 100 maximo, a ideia a mudar isso de acordo com a musica
      //vai definir um ponto entre os dois ultimos valores do map para cada linha em cada coluna, o terreno e usado pra mudar o valor z do ponto no grid
      x2 += 0.1;
    }
      y2 += 0.07;
  }

  stroke(meio);
  translate(width/2, (height/2)+10, -750); //muda a posicao do grid pra ficar no meio da tela, o -750 e o quao distante ele ta no z
  rotateX(radians(60)); //vai deixar o plano meio q deitado
  translate(-lar/2, -alt/2); //vai deixar o centro do grid pra ficar no centro da tela, se n fica so a pontinha no centro
  for (int y = 0; y < rows - 1; y++) {
    beginShape(QUAD_STRIP); //o formato do poligono q a gente vai usar, da pra deixar em triangulo tb mas eu achei q com quadrado fica melhor
    xm = (cols/2) +1; // o xm ele e meio q um contador oposto do x, isso e pra deixar q quanto menor o CANAL da frequencia mais no meio ele fica, e so pra deixa um pouco mais simetrico e nao uma parte grande no lado esquerdo e fica diminuindo quanto mais pra direita
    for (int x = 0; x < cols; x++) {
      if (x < cols/2) { //se o ponto x estiver no lado esquerdo, ele substrai o xm, e se tiver na direita soma
        xm -= 1;
      } else if (x >= cols/2) {
        xm ++;
      }
      if (terreno[x][y] + 2> -20 && terreno[x][y] + 2< 20) { //isso e pra prencher o terreno com cor dependendo da altura definido aleatoriamente la em cima
        fill(meio); //preenche os pontos entre -20 e 20 na cor interB
      } else if (terreno[x][y] +2>= 20) { //se o ponto for maior ou igual a 20 
        fill(interA); //preenche os pontos maior ou igual q 20 na cor interA e adiciona o valor da frequencia da musica vezes 1.5 pra ficar melhor de ver
        //1,2,3 4band1, 3,2,1
        fft.scaleBand(x+7, 1.05); // aumenta a escala dos canais das linhas x em algum valor, recomendo entre 1 e 1.1,
        terreno[x][y] += fft.getBand(xm)*1.7;
      } else {

        fill(interB); // muda a cor dos pontos mais fundos do grid
      }
      if (terreno[x][y] > 300) terreno[x][y] = 300; //limite da altura do terreno
      vertex(x*tam, y*tam, terreno[x][y]); //cria os pontos do grid
      vertex(x*tam, (y+1)*tam, terreno[x][y+1]); //o +1 e pra colocar o ponto na proxima posicao do y e do terreno
    }
    endShape(CLOSE); //fecha o forma
  }
    }
    // botão escolher 86x72
    // 43x36 demais botões
    if(exibir == true && modoInstrumento == false)
    {
    segundos = (player.position()/1000)%60;
    minutos = player.position()/60000;
    cam.beginHUD();
    image(escolher,0,0); image(play,86,0); image(pause,129,0); 
    image(stop,172,0); image(sobre,215,0); image(inst,258,0); 
    image(barraVol,100,60); image(volmenos,0,72); image(volmais,43,72);
    image(fechar,981,0);
    fill(c4);
    if(segundos <= 9 && segundosTotal <=9){text(minutos+":0"+segundos+"/"+minutosTotal+":0"+segundosTotal,10,150);}
    else if(segundos <= 9 && segundosTotal > 9){text(minutos+":0"+segundos+"/"+minutosTotal+":"+segundosTotal,10,150);}
    else if(segundos > 9 && segundosTotal <=9){text(minutos+":"+segundos+"/"+minutosTotal+":0"+segundosTotal,10,150);}
    else if(segundos > 9 && segundosTotal > 9){text(minutos+":"+segundos+"/"+minutosTotal+":"+segundosTotal,10,150);}
    fill(c3,125);
    noStroke();
    rect(86,36,215,12);
    stroke(c4);
    strokeWeight(1);
    float posicao = map( player.position(), 0, player.length(), 86, 301);
    line(posicao, 48, posicao, 36 );
    cam.endHUD();
    if(mp3 == true){   cam.beginHUD();
    fill(c4); textSize(14); text(meta.author()+"  -  "+meta.title()+"  -  "+meta.album(),10,130);   cam.endHUD();}
    }
 
    if(erroArquivo == true)
    {cam.beginHUD();image(erroAbrir,273,234);cam.endHUD();}

    // MODO INSTRUMENTO
    //
    // Da linha 138 até 
    if(modoInstrumento == true){
    // INTERFACE MODO INSTRUMENTO
    exibir = true;
    cam.beginHUD();
    fill(c4); background(0); stroke(c3); strokeWeight(1);
    if(uniao == true) {text("Modo: União", 50 , 240);}
    if(uniao == false) {text("Modo: Triade (Acorde)",50,240);}
    if(latch == false) {text("Latch: Desligado", 50, 260);}
    if(latch == true) {text("Latch: Ligado", 50,260);}
    if(dPreset1 == true) {text("Delay: 1",50,300);}
    if(dPreset2 == true) {text("Delay: 2",50,300);}
    if(dPreset3 == true){text("Delay: 3",50,300);}
    if(dPreset4 == true) {text("Delay: 4",50,300);}
    if(bcPreset1 == true) {text("Bits (Amostra): 16",50,280);}
    if(bcPreset2 == true) {text("Bits (Amostra): 8",50,280);}
    if(bcPreset3 == true) {text("Bits (Amostra): 6",50,280);}
    if(bcPreset4 == true) {text("Bits (Amostra): 4",50,280);}
    if(gPreset1 == true) {text("Ganho: 0 dB",50,320);}
    if(gPreset2 == true) {text("Ganho: +1.5 dB",50,320);}
    if(gPreset3 == true) {text("Ganho: +3 dB",50,320);}
    if(gPreset4 == true) {text("Ganho: +5 dB",50,320);}
    if(oPreset1 == true) {text("Oitava: -2", 50, 340);}
    if(oPreset2 == true) {text("Oitava: -1", 50 , 340);}
    if(oPreset3 == true) {text("Oitava: 0",50,340);}
    if(oPreset4 == true) {text("Oitava: +1", 50, 340);}
    if(oPreset5 == true) {text("Oitava: +2", 50 , 340);}
    if(tSobre == true) {image(esquemaTeclado,273,117);}
    if(osc1.getWaveform() == Waves.SQUARE) {text("Oscilador 1: Quadrado",50,180);}
    if(osc1.getWaveform() == Waves.SAW) {text("Oscilador 1: Serra",50,180);}
    if(osc1.getWaveform() == Waves.TRIANGLE) {text("Oscilador 1: Triângulo",50,180);}
    if(osc1.getWaveform() == Waves.SINE) {text("Oscilador 1: Seno",50,180);}
    if(osc1.getWaveform() == Waves.QUARTERPULSE) {text("Oscilador 1: Pulso",50,180);}
    if(osc2.getWaveform() == Waves.SQUARE) {text("Oscilador 2: Quadrado",50,200);}
    if(osc2.getWaveform() == Waves.SAW) {text("Oscilador 2: Serra",50,200);}
    if(osc2.getWaveform() == Waves.TRIANGLE) {text("Oscilador 2: Triângulo",50,200);}
    if(osc2.getWaveform() == Waves.SINE) {text("Oscilador 2: Seno",50,200);}
    if(osc2.getWaveform() == Waves.QUARTERPULSE) {text("Oscilador 2: Pulso",50,200);}    
    if(osc3.getWaveform() == Waves.SQUARE) {text("Oscilador 3: Quadrado",50,220);}
    if(osc3.getWaveform() == Waves.SAW) {text("Oscilador 3: Serra",50,220);}
    if(osc3.getWaveform() == Waves.TRIANGLE) {text("Oscilador 3: Triângulo",50,220);}
    if(osc3.getWaveform() == Waves.SINE) {text("Oscilador 3: Seno",50,220);}
    if(osc3.getWaveform() == Waves.QUARTERPULSE) {text("Oscilador 3: Pulso",50,220);}
    // FIM 
    // INTERFACE INSTRUMENTO
    for(int i = 0; i < out.bufferSize() - 1; i++)
    {
      image(inst,0,0);
      image(sobre,43,0);
      image(fechar,981,0);
      if (gravador.isRecording())
      {
      text("Agora pressione ENTER para terminar de gravar.",300, 500);
      }
      else if ( !gravado )
      {
      text("Pressione ENTER para começar a gravar!", 300, 500);
      }
      else if( salvo == false)
      {
      text("Pressione ESPAÇO para salvar!", 300, 500);
      }
      else if( salvo == true)
      {
       text("Pressione ENTER para gravar novamente...", 300, 480); 
       text("Pressione V para ouvir a gravação...", 300, 500);
       text("Pressione B para pausar a gravação...", 300, 520);
      }
      line( i, 500 - out.mix.get(i)*100, i+1, 500 - out.mix.get(i+1)*100 );
    }
    cam.endHUD();
    }  
    //FIM^MODO INSTRUMENTO
    // ^^^^^^^^^^
    cam.beginHUD();
    if(cSobre == true)
      {  
      image(info,273,234);
      }
    if(((mouseX<86) && (mouseY<72)) && exibir == true && modoInstrumento == false){
      image(escolherSelecionado,0,0);}
    if(((mouseX>86 && mouseX < 130 ) && (mouseY<36)) && exibir == true && modoInstrumento == false){
      image(playSelecionado,86,0);
    }
    if(((mouseX>130 && mouseX < 173 ) && (mouseY<36)) && exibir == true && modoInstrumento == false){
      image(pauseSelecionado,130,0);
    }
    if(((mouseX>173 && mouseX < 216  ) && (mouseY<36)) && exibir == true && modoInstrumento == false){
      image(stopSelecionado,173,0);
    }
    if(((mouseX>216 && mouseX < 259  ) && (mouseY<36)) && exibir == true && modoInstrumento == false){
      image(sobreSelecionado,216,0);
    }
    if(((mouseX>259 && mouseX < 302) && (mouseY<36)) && exibir == true && modoInstrumento == false){
      image(instSelecionado,259,0);
    }
    if(((mouseX > 0 && mouseX < 43  ) && (mouseY > 72 && mouseY < 99)) && exibir == true && modoInstrumento == false){
      image(volmenosSelecionado,0,72);
    }
    if(((mouseX > 43 && mouseX < 86  ) && (mouseY > 72 && mouseY < 99)) && exibir == true && modoInstrumento == false){
      image(volmaisSelecionado,43,72);
    }
    // MODO INSTRUMENTO
    if(mouseX < 43 && mouseY < 36 && modoInstrumento == true){
      image(instSelecionado,0,0);
    }
    if((mouseX > 43 && mouseX < 86) && mouseY < 36 && modoInstrumento == true){
      image(sobreSelecionado,43,0);
    }
     if(((mouseX>981 ) && (mouseY<32)) && exibir == true){
      image(fecharSelecionado,981,0);}
    cam.endHUD();
    if(volume == 0 && modoInstrumento == false){
    barraVol = loadImage("volume0.png");
    player.setGain(0);
    }
    if(volume == -1 && modoInstrumento == false){
    barraVol = loadImage("volume-1.png");
    player.setGain(-8);
    }
    if(volume == -2 && modoInstrumento == false){
    barraVol = loadImage("volume-2.png");
    player.setGain(-16);
    }
    if(volume ==-3 && modoInstrumento == false){
    player.setGain(-24);
    barraVol = loadImage("volume-3.png");
    }
    if(volume ==-4 && modoInstrumento == false)
    {
    player.setGain(-30);
    barraVol = loadImage("volume-4.png");
    }
    if(volume == -5 && modoInstrumento == false)
    {
    player.setGain(-100);
    barraVol = loadImage("volume-5.png");
    }
    // FORÇAR VOLUME 
    // UM VALOR
    if(volume <=-6)
    {
    volume =-5;
    }
    if(volume > 0)       
    {
    volume =0;
    }
}
void mousePressed() {
  if ((mouseX >= luaposcord - 30 && mouseX <= luaposcord + 30 && mouseY >= 24 && mouseY <= 71 || mouseX <= luaposcord - 30 && mouseX >= luaposcord + 30 && mouseY >= 24 && mouseY <= 71) && modoInstrumento == false && vPreset == 2) {
  click++;
  temacor();
  }
  if((mouseX > 86 && mouseX < 301) && (mouseY > 36 && mouseY < 48) && modoInstrumento == false && exibir == true){
  int posicao = int(map(mouseX, 86, 301, 0, player.length() ) );
  player.cue( posicao );}
  if(((mouseX<86) && (mouseY<72)) && exibir == true && modoInstrumento == false)
  {
  player.pause();
  player.rewind();
  selectInput("Selecione o arquivo (.MP3/.WAV/.AIFF/.AU/.SND):", "fileSelected");
  }
  // play
  if(((mouseX>86 && mouseX < 130 ) && (mouseY<36)) && exibir == true && modoInstrumento == false)
    {
      if(player.isPlaying())
      {
        player.pause();
      }
      else if( player.position() >= player.length())
      {
       player.rewind();
       player.play();
      }
      else
      {
        player.play();
      }
    }
  if(((mouseX>130 && mouseX < 173 ) && (mouseY<36)) && exibir == true && modoInstrumento == false)
    {
    player.pause();
    }
  if(((mouseX>173 && mouseX < 216  ) && (mouseY<36)) && exibir == true && modoInstrumento == false)
    {
    player.pause();
    player.rewind();
    }
  if(((mouseX>216 && mouseX < 259  ) && (mouseY<36)) && exibir == true && modoInstrumento == false)
    {
    if(cSobre == false)
      {
      cSobre = true;
      }
    else if(cSobre == true)
      {
      cSobre = false;
      }
    }
  if(((mouseX > 273 && mouseX < 773) && (mouseY >234 && mouseY <534)) && exibir == true && modoInstrumento == false && erroArquivo == true)
  {
  erroArquivo = false;
  }
  if(((mouseX>0 && mouseX < 43 ) && (mouseY>72 && mouseY < 99)) && exibir == true && modoInstrumento == false)
    {
      volume -=1;
    }
  if(((mouseX > 43 && mouseX < 86  ) && (mouseY > 72 && mouseY < 99)) && exibir == true && modoInstrumento == false){
      volume +=1;
    }
  if((mouseX > 273 && mouseX < 773) && (mouseY >234 && mouseY <534) && cSobre==true && modoInstrumento == false)
  {
    cSobre = false;
  }
  if(((mouseX>259 && mouseX < 302) && (mouseY<36)) && exibir == true && modoInstrumento == false){
    player.pause();
    modoInstrumento = true;
  }
  // MODO INSTRUMENTO
  if(((mouseX < 43) && (mouseY<36)) && modoInstrumento == true){
      osc1.setAmplitude(0f);
      osc2.setAmplitude(0f);
      osc3.setAmplitude(0f);
      modoInstrumento = false;
      if(gravacao != null) 
      {gravacao.pause(); gravacao.rewind();}
    }
  if((mouseX > 43 && mouseX < 86) && mouseY < 36 && modoInstrumento == true)
  {
    if(tSobre == false)
    {
      tSobre = true;
    }
    else
    {
      tSobre = false;
    }
  }
  if((mouseX > 273 && mouseX < 773) && (mouseY >117 && mouseY <417) && tSobre==true && modoInstrumento == true)
  {
    tSobre = false;
  }
  if(((mouseX>981 ) && (mouseY<32)) && exibir == true){
      exit();}
}
// PLAYER
// &
// VISUALIZER
// seleção de arquivo 
void fileSelected(File selection) {
  if (selection == null) {
    println("Janela fechada.");
  } 
  else {
    println("Usuário selecionou. " + selection.getAbsolutePath());
    
    if (selection.getAbsolutePath().endsWith(".mp3"))
    {
      erroArquivo = false;
      mp3 = true;
      player = minim.loadFile(selection.getAbsolutePath(),1024);
      segundosTotal = (player.length()/1000)-((player.length()/60000)*60);
      minutosTotal = player.length()/60000;
      meta = player.getMetaData();
      beat.detect(player.mix);
      fft.forward(player.mix);
    }
    else if(selection.getAbsolutePath().endsWith(".wav") || selection.getAbsolutePath().endsWith(".aiff") || selection.getAbsolutePath().endsWith(".au") || selection.getAbsolutePath().endsWith(".snd")){
      erroArquivo = false;
      mp3 = false;
      player = minim.loadFile(selection.getAbsolutePath(),1024);
      segundosTotal = (player.length()/1000)-((player.length()/60000)*60);
      minutosTotal = player.length()/60000;
      player.rewind();
      beat.detect(player.mix);
      fft.forward(player.mix);
    }
    else{erroArquivo = true;}
  }
// evento de atalhos
}
void keyPressed(){
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
    if(player.isPlaying())
    {
      player.pause();
    }
    else if(player.position() == player.length())
    {
     player.rewind();
     player.play();
    }
    else if(player.isPlaying() == false)
    {
      player.play();
    }
  }
  if ((key =='h' || key =='H') && modoInstrumento == false)
    {
    if(exibir == true)
      {
      exibir = false;
      }
    else if(exibir == false)
      {
      exibir = true;
      }
    }
  // MODO INSTRUMENTO
  // NOTAS MUSICAIS
  if((key == 'a' || key == 'A') && modoInstrumento == true)
  {
    if(uniao == true){
    osc1.setFrequency(c); osc1.setAmplitude(0.3f);
    osc2.setFrequency(c/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency((c/6)); osc3.setAmplitude(0.5f);}
    else{
    osc1.setFrequency(c); osc1.setAmplitude(0.3f);
    osc2.setFrequency(e/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency(g/6); osc3.setAmplitude(0.5f);}
  } 
  if((key == 'w' || key == 'W') && modoInstrumento == true)
  {
    if(uniao == true){
    osc1.setFrequency(cM); osc1.setAmplitude(0.3f);
    osc2.setFrequency(cM/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency(cM/6); osc3.setAmplitude(0.5f);}
    else{
    osc1.setFrequency(cM); osc1.setAmplitude(0.3f);
    osc2.setFrequency(f/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency(gM/6); osc3.setAmplitude(0.5f);}
  }
  if((key == 's' || key == 'S') && modoInstrumento == true)
  {
    if(uniao == true){
    osc1.setFrequency(d); osc1.setAmplitude(0.3f);
    osc2.setFrequency(d/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency(d/6); osc3.setAmplitude(0.5f);}
    else{
    osc1.setFrequency(d); osc1.setAmplitude(0.3f);
    osc2.setFrequency(fM/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency((a*2)/6); osc3.setAmplitude(0.5f);
    }
  }
  if((key == 'e' || key == 'E') && modoInstrumento == true)
  {
    if(uniao == true){
    osc1.setFrequency(dM); osc1.setAmplitude(0.3f);
    osc2.setFrequency(dM/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency(dM/6); osc3.setAmplitude(0.5f);}
    else{
    osc1.setFrequency(dM); osc1.setAmplitude(0.3f);
    osc2.setFrequency(g/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency((aM*2)/6); osc3.setAmplitude(0.5f);}
  }
  if((key == 'd' || key == 'D') && modoInstrumento == true)
  {
    if(uniao == true){
    osc1.setFrequency(e); osc1.setAmplitude(0.3f);
    osc2.setFrequency(e/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency(e/6); osc3.setAmplitude(0.5f);}
    else{
    osc1.setFrequency(e); osc1.setAmplitude(0.3f);
    osc2.setFrequency(gM/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency((b*2)/6); osc3.setAmplitude(0.5f);}
  }
  if((key == 'f' || key == 'F') && modoInstrumento == true)
  {
    if(uniao == true){
    osc1.setFrequency(f); osc1.setAmplitude(0.3f);
    osc2.setFrequency(f/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency(f/6); osc3.setAmplitude(0.5f);}
    else{
    osc1.setFrequency(f); osc1.setAmplitude(0.3f);
    osc2.setFrequency((a*2)/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency((c*2)/6); osc3.setAmplitude(0.5f);}
  }
  if((key == 't' || key == 'T') && modoInstrumento == true)
  {
    if(uniao == true){
    osc1.setFrequency(fM); osc1.setAmplitude(0.3f);
    osc2.setFrequency(fM/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency(fM/6); osc3.setAmplitude(0.5f);}
    else{
    osc1.setFrequency(fM); osc1.setAmplitude(0.3f);
    osc2.setFrequency((aM*2)/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency((cM*2)/6); osc3.setAmplitude(0.5f);}
  }
  if((key == 'g' || key == 'G') && modoInstrumento == true)
  {
    if(uniao == true){
    osc1.setFrequency(g); osc1.setAmplitude(0.3f);
    osc2.setFrequency((g/2)); osc2.setAmplitude(0.4f);
    osc3.setFrequency(g/6); osc3.setAmplitude(0.5f);}
    else{
    osc1.setFrequency(g); osc1.setAmplitude(0.3f);
    osc2.setFrequency((b*2)/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency((d*2)/6); osc3.setAmplitude(0.5f);}
  }
  if((key == 'y' || key == 'Y') && modoInstrumento == true)
  {
    if(uniao == true){
    osc1.setFrequency(gM); osc1.setAmplitude(0.3f);
    osc2.setFrequency(gM/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency(gM/6); osc3.setAmplitude(0.5f);}
    else{  
    osc1.setFrequency(gM); osc1.setAmplitude(0.3f);
    osc2.setFrequency((c*2)/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency((dM*2)/6); osc3.setAmplitude(0.5f);}
  }
  if((key == 'h' || key == 'H') && modoInstrumento == true)
  {
    if(uniao == true){
    osc1.setFrequency(a*2); osc1.setAmplitude(0.3f);
    osc2.setFrequency((a*2)/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency((a*2)/6); osc3.setAmplitude(0.5f);}
    else{
    osc1.setFrequency(a*2); osc1.setAmplitude(0.3f);
    osc2.setFrequency((cM*2)/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency((e*2)/6); osc3.setAmplitude(0.5f);}
  }
  if((key == 'u' || key == 'U') && modoInstrumento == true)
  {
    if(uniao == true){
    osc1.setFrequency(aM*2); osc1.setAmplitude(0.3f);
    osc2.setFrequency((aM*2)/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency((aM*2)/6); osc3.setAmplitude(0.5f);}
    else{
    osc1.setFrequency(aM*2); osc1.setAmplitude(0.3f);
    osc2.setFrequency((d*2)/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency((f*2)/6); osc3.setAmplitude(0.5f);}
  }
  if((key == 'j' || key == 'J') && modoInstrumento == true)
  {
    if(uniao == true){
    osc1.setFrequency(b*2); osc1.setAmplitude(0.3f);
    osc2.setFrequency((b*2)/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency((b*2)/6); osc3.setAmplitude(0.5f);}
    else{
    osc1.setFrequency(b*2); osc1.setAmplitude(0.3f);
    osc2.setFrequency((dM*2)/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency((fM*2)/6); osc3.setAmplitude(0.5f);}
  }
  if((key == 'k' || key == 'K') && modoInstrumento == true)
  {
    if(uniao == true){
    osc1.setFrequency(c*2); osc1.setAmplitude(0.3f);
    osc2.setFrequency((c*2)/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency((c*2)/6); osc3.setAmplitude(0.5f);}
    else{  
    osc1.setFrequency(c*2); osc1.setAmplitude(0.3f);
    osc2.setFrequency((e*2)/2); osc2.setAmplitude(0.4f);
    osc3.setFrequency((g*2)/6); osc3.setAmplitude(0.5f);}
  }
  // TECLAS | NOTAS MUSICAIS
  // FIM
  if(key == TAB && modoInstrumento == true)
  {
    if(uniao == true)
    {uniao = false;}
    else
    {uniao = true;}
  }
  if((key == 'q' || key =='Q') && modoInstrumento == true)
  {
    if(latch == false)
    {latch = true;}
    else
    {latch = false;}
  }
  if((key == 'z' || key =='Z') && modoInstrumento == true)
  {
    if(oPreset3 == true)
  {
    oPreset3 = false; oPreset2 = true;
    a = 440/2; aM = 466/2; b = 494/2; c = 524/2; cM = 554/2; d = 588/2; dM = 624/2; e = 660/2; f = 700/2; fM = 740/2; g = 784/2; gM = 832/2;
  }
  else if(oPreset2 == true)
  {
    oPreset2 = false; oPreset1 = true;
    a = 440/4; aM = 466/4; b = 494/4; c = 524/4; cM = 554/4; d = 588/4; dM = 624/4; e = 660/4; f = 700/4; fM = 740/4; g = 784/4; gM = 832/4;
  }
  else if(oPreset1 == true || oPreset4 == true || oPreset5 == true)
  {
   oPreset1 = false; oPreset3 = true; oPreset4 = false; oPreset5 = false;
   a = 440; aM = 466; b = 494; c = 524; cM = 554; d = 588; dM = 624; e = 660; f = 700; fM = 740; g = 784; gM = 832;
  }
  }
  if((key == 'x' || key =='X') && modoInstrumento == true)
  {
  if(oPreset3 == true)
  {
    oPreset3 = false; oPreset4 = true;
    a = 440*2; aM = 466*2; b = 494*2; c = 524*2; cM = 554*2; d = 588*2; dM = 624*2; e = 660*2; f = 700*2; fM = 740*2; g = 784*2; gM = 832*2;
  }
  else if(oPreset4 == true)
  {
    oPreset4 = false; oPreset5 = true;
    a = 440*4; aM = 466*4; b = 494*4; c = 524*4; cM = 554*4; d = 588*4; dM = 624*4; e = 660*4; f = 700*4; fM = 740*4; g = 784*4; gM = 832*4;
  }
  else if(oPreset5 == true || oPreset1 == true || oPreset2 == true)
  {
    oPreset5 = false; oPreset3 = true; oPreset1 = false; oPreset2 = false;
    a = 440; aM = 466; b = 494; c = 524; cM = 554; d = 588; dM = 624; e = 660; f = 700; fM = 740; g = 784; gM = 832; 
  }
  }
  if(key == '1' && modoInstrumento == false){vPreset=1;}
  if(key == '2' && modoInstrumento == false){vPreset=2;}
  if(key == '1' && modoInstrumento == true)
  {
    if(osc1.getWaveform() == Waves.SQUARE)
    {
    osc1.setWaveform(Waves.TRIANGLE);
    }
    else if(osc1.getWaveform() == Waves.TRIANGLE)
    {
    osc1.setWaveform(Waves.SINE);
    }
    else if(osc1.getWaveform() == Waves.SINE)
    {
    osc1.setWaveform(Waves.SAW);
    }
    else if(osc1.getWaveform() == Waves.SAW)
    {
    osc1.setWaveform(Waves.QUARTERPULSE);
    }
    else if(osc1.getWaveform() == Waves.QUARTERPULSE)
    {
    osc1.setWaveform(Waves.SQUARE);
    }
  }
  if(key == '2' && modoInstrumento == true)
  {
    if(osc2.getWaveform() == Waves.SQUARE)
    {
    osc2.setWaveform(Waves.TRIANGLE);
    }
    else if(osc2.getWaveform() == Waves.TRIANGLE)
    {
    osc2.setWaveform(Waves.SINE);
    }
    else if(osc2.getWaveform() == Waves.SINE)
    {
    osc2.setWaveform(Waves.SAW);
    }
    else if(osc2.getWaveform() == Waves.SAW)
    {
    osc2.setWaveform(Waves.QUARTERPULSE);
    }
    else if(osc2.getWaveform() == Waves.QUARTERPULSE)
    {
    osc2.setWaveform(Waves.SQUARE);
    }
  }
  if(key == '3' && modoInstrumento == true)
  {
    if(osc3.getWaveform() == Waves.SQUARE)
    {
    osc3.setWaveform(Waves.TRIANGLE);
    }
    else if(osc3.getWaveform() == Waves.TRIANGLE)
    {
    osc3.setWaveform(Waves.SINE);
    }
    else if(osc3.getWaveform() == Waves.SINE)
    {
    osc3.setWaveform(Waves.SAW);
    }
    else if(osc3.getWaveform() == Waves.SAW)
    {
    osc3.setWaveform(Waves.QUARTERPULSE);
    }
    else if(osc3.getWaveform() == Waves.QUARTERPULSE)
    {
    osc3.setWaveform(Waves.SQUARE);
    }
  }  
  if(key =='4' && modoInstrumento == true)
  {
   if(dPreset1 == true)
    {
     dPreset1 = false;
     dPreset2 = true;
     delay1.setDelTime(0.2); delay1.setDelAmp(0.25); delay2.setDelTime(0.2); delay2.setDelAmp(0.25); delay3.setDelTime(0.2); delay3.setDelAmp(0.25);
    } 
   else if(dPreset2 == true)
    {
     dPreset2 = false;
     dPreset3 = true;
     delay1.setDelTime(0.4); delay1.setDelAmp(0.5); delay2.setDelTime(0.4); delay2.setDelAmp(0.5); delay3.setDelTime(0.4); delay3.setDelAmp(0.5); 
    }
   else if(dPreset3 == true)
    {
     dPreset3 = false;
     dPreset4 = true;
     delay1.setDelTime(0.4); delay1.setDelAmp(0.7); delay2.setDelTime(0.4); delay2.setDelAmp(0.7); delay3.setDelTime(0.4); delay3.setDelAmp(0.7);
   }
   else if(dPreset4 == true)
   {
     dPreset4 = false;
     dPreset1 = true;
     delay1.setDelTime(0.1); delay1.setDelAmp(0); delay2.setDelTime(0.1); delay2.setDelAmp(0); delay3.setDelTime(0.1); delay3.setDelAmp(0);
   }
  }
  if(key =='5' && modoInstrumento == true)
  {
   if(bcPreset1 == true)
   {
   bcPreset1 = false;
   bcPreset2 = true;
   bc1.setBitRes(8); bc2.setBitRes(8);bc3.setBitRes(8);
   }
   else if(bcPreset2 == true)
   {
   bcPreset2 = false;
   bcPreset3 = true;
   bc1.setBitRes(6);bc2.setBitRes(6);bc3.setBitRes(6);
   }
   else if(bcPreset3 == true)
   {
   bcPreset3 = false;
   bcPreset4 = true;
   bc1.setBitRes(4); bc2.setBitRes(4); bc3.setBitRes(4); 
   }
   else if(bcPreset4 == true)
   {
   bcPreset4 = false;
   bcPreset1 = true;
   bc1.setBitRes(16); bc2.setBitRes(16); bc3.setBitRes(16);
   }
  } 
  if(key =='6' && modoInstrumento == true)
  {
   if(gPreset1 == true)
   {
   gPreset1 = false; gPreset2 = true;
   gain1.setValue(1.5); gain2.setValue(1.5); gain3.setValue(1.5);
   }
   else if(gPreset2 == true)
   {   
   gPreset2 = false; gPreset3 = true;
   gain1.setValue(3); gain2.setValue(3); gain3.setValue(3);}
   else if(gPreset3 == true)
   {   
   gPreset3 = false; gPreset4 = true;
   gain1.setValue(5); gain2.setValue(5); gain3.setValue(5);}
   else if(gPreset4 == true)
   {   
   gPreset4 = false; gPreset1 = true;
   gain1.setValue(0.f); gain2.setValue(0.f); gain3.setValue(0.f);}
   }
  if( key == ENTER && modoInstrumento == true ) 
    {
    if(gravador.isRecording() ) 
    {
      gravador.endRecord();
      gravado = true;
      salvo = false;
    }
    else 
    {
      gravador = minim.createRecorder(out,"gravacao.wav");
      gravador.beginRecord();
    }
  }
 if(gravado && key ==  ' ' && modoInstrumento == true && gravador.isRecording() ==false)
 {
  if(gravacao != null)
    {
    gravacao.unpatch( out );
    gravacao.close();
    }
    salvo = true;
    gravacao = new FilePlayer( gravador.save() );
    gravacao.patch( out );
    gravacao.play();
 }
 if((key == 'v' || key == 'V') && modoInstrumento == true && gravador.isRecording() == false)
 {
  if(gravacao != null){ 
    gravacao.rewind();
    gravacao.play(); }
 }
 if((key =='b' || key =='B') && modoInstrumento == true && gravado == true)
 {
  gravacao.pause();
  gravacao.rewind();
 }
}
void keyReleased(){
  if( key !='1' && key!='2' && key !='3' && key !='4' && key !='5' && key !='6' && key !='7' && key !='8' && key !='9' &&  key !=TAB && modoInstrumento == true && latch == false)
  {
  osc1.setAmplitude(0f);  osc2.setAmplitude(0f);osc3.setAmplitude(0f);
  }
}
void temacor() { // aqui define qual palette de cor pra colocar, pode fazer o teu proprio se quiser so coloca mais um ngc no click e arruma pra voltar pra 1
  if (click == 2) { // um tema meio marrom
    meio = color (139, 69, 20); 
    topo = color (255, 248, 220);
    baixo = color(80, 69, 19);
  }
  if (click == 3) { // tema meio q parecido com gameboy
    meio = color (11, 16, 0); 
    topo = color (164, 178, 111);
    baixo = color(162, 162, 162);
  }
  if (click == 4) { // tema tommy hilfiger kk
    meio = color (16, 19, 35);   
    topo = color (191, 25, 25); 
    baixo = color(214, 212, 203);
  }
  if (click == 5) { // tema roxo pq sim nao precisa de motivo
    meio = color (109, 22, 114);   
    topo = color (10, 10, 10); 
    baixo = color(225, 225, 225);
  }
  if (click == 6) { //topo laranja, meio azul e baixo amarelo
    meio = color (32, 73, 144); 
    topo = color (220, 170, 40);
    baixo = color(225, 225, 140);
  }
  if (click == 7) click = 1;
  if (click == 1) { //tema padrao, preto cinza e branco
    meio = color (54, 54, 54);   
    topo = color (236, 236, 236); 
    baixo = color(154, 154, 154);
  }
}
void removeFrameBorder() {
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify();
}
