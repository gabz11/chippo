void visualizer2() {
  luatam = 100; // reseta o tamanho da lua, pode mudar esse se quiser
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
  translate(luapos, -350, -1600); //muda a posicao da lua, o terceiro argumento e o z
  stroke(red(inverse), green(inverse), blue(inverse)); //a cor inversa do background e vai pro stroke da lua
  sphere(luatam); //cria uma esfera 3D, dava pra usar o ellipse mas eu achei esse mais legal
  if (cont2 == true) { // verifica o estado do cont2 que verifica qual lado q a lua tenq andar
    luapos -= map(fft.getBand(1), -1, 10, 0.02, 0.12); //se cont2 for verdadeiro ele vai subtrair o luapos se acordo com o map da frequencia do canal 1, qnd a musica estiver com uma frequencia alta a lua se move mais rapido
    rotateY(map(fft.getBand(1), -1, 10, 0, 0.5)); //mesma coisa de cima mas ele gira a lua, e bem dificil de ver mas s
  } else {
    luapos += map(fft.getBand(1), -1, 10, 0.02, 0.12); // mesma coisa que ali em cima mas ele soma agora, esse vai pra direita e o de cima pra esquerda
    rotateY(map(fft.getBand(1), -1, 10, 0, -0.5));
  }
  if (luapos > 1500) { //o ngc do cont2, se a pos dele for 1050 ele comeca a ir pra esquerda, e qnd for -600 vai pra direita
    cont2 = true;
    //println(luaposcord);
  } 
  if (luapos<-500) {
    cont2 = false;
    //println(luaposcord);
  }
  luaposcord = map(luapos, -500, 1500, 183, 835);
  popMatrix();
  float limitecontornoquad = map(fft.getBand(1), 0, 70, 2, 2.7);
  if (limitecontornoquad > 6) limitecontornoquad = 6;
  strokeWeight(limitecontornoquad); //stroke do terreno, os quadradinho, q tb muda quanto maior a frequencia do canal 1 da musica
  if (player.isPlaying()) { //se o player estiver tocando ele muda a velocidade da camera
    float cameraa = map(fft.getBand(1), -1, 10, 0.02, 0.028)+0.01;
    if (cameraa > 0.13) cameraa = 0.13; // limite pra velocidade da camera
    camera -= cameraa; //qnt maior a freq maior a velocidade
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
  translate((width/2), (height/2)+200, -850); //muda a posicao do grid pra ficar no meio da tela, o -750 e o quao distante ele ta no z
  rotateX(radians(60)); //vai deixar o plano meio q deitado
  translate(-lar/2, (-alt/2)+500); //vai deixar o centro do grid pra ficar no centro da tela, se n fica so a pontinha no centro
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
        if (x>5 && x<15) fft.scaleBand(x, 1.02); // aumenta a escala dos canais das linhas x em algum valor, recomendo entre 1 e 1.1,
        else if (x>=15 && x<30) fft.scaleBand(x, 1.05);
        else if (x>=30) fft.scaleBand(x, 1.07);
        terreno[x][y] += fft.getBand(xm)*1.7;
      } else {

        fill(interB); // muda a cor dos pontos mais fundos do grid
      }
      if (terreno[x][y] > 400) terreno[x][y] = 400; //limite da altura do terreno
      vertex(x*tam, y*tam, terreno[x][y]); //cria os pontos do grid
      vertex(x*tam, (y+1)*tam, terreno[x][y+1]); //o +1 e pra colocar o ponto na proxima posicao do y e do terreno
    }
    endShape(CLOSE); //fecha o forma
  }
}

void temacor() { // aqui define qual palette de cor pra colocar, pode fazer o teu proprio se quiser so coloca mais um ngc no click e arruma pra voltar pra 1
  if (click == 2) { // um tema meio marrom
    meio = color (139, 69, 20); 
    topo = color (255, 248, 220);
    baixo = color(80, 69, 19);
  }
  else if (click == 3) { // tema meio q parecido com gameboy
    meio = color (11, 16, 0); 
    topo = color (164, 178, 111);
    baixo = color(162, 162, 162);
  }
  else if (click == 4) { // tema tommy hilfiger kk
    meio = color (16, 19, 35);   
    topo = color (191, 25, 25); 
    baixo = color(214, 212, 203);
  }
  else if (click == 5) { // tema roxo pq sim nao precisa de motivo
    meio = color (88, 2, 89);  
    topo = color (253, 232, 149); 
    baixo = color(212, 1, 252);
  }
  else if (click == 6) { //topo laranja, meio azul e baixo amarelo
    meio = color (32, 73, 144); 
    topo = color (220, 170, 40);
    baixo = color(225, 225, 140);
  }
  else if (click == 7) { //azul, azul escuro e cinza
    meio = color (19, 23, 60);  
    topo = color (68, 255, 255);
    baixo = color(115, 122, 134);
  }
  else if (click == 8) click = 1;
  if (click == 1) { //tema padrao, preto cinza e branco
    meio = color (54, 54, 54);   
    topo = color (236, 236, 236); 
    baixo = color(154, 154, 154);
  }
}

void mouseClicked() {
  //println("x:", mouseX, "lua: ", luaposcord);
  //println("y:", mouseY); //y entre 24 e 71 e x entre 78 e 413
  if (mouseX >= luaposcord - 50 && mouseX <= luaposcord + 30 && mouseY >= 130 && mouseY <= 200 || mouseX <= luaposcord - 50 && mouseX >= luaposcord + 30 && mouseY >= 130 && mouseY <= 200) {
    click++;
    temacor();
  }
}
