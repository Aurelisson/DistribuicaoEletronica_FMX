unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.EditBox, FMX.NumberBox, FMX.Controls.Presentation, FMX.Layouts;

type
  TForm1 = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    Layout3: TLayout;
    Label2: TLabel;
    edtVal: TNumberBox;
    btCalcular: TButton;
    lbCamadas: TLabel;
    lbPauling: TLabel;
    lbElemento: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btCalcularClick(Sender: TObject);
  private
    { Private declarations }
    Pauling : array[0..6,0..3] of Integer;
    VarreArrayX : array[0..27] of Integer;
    VarreArrayY : array[0..27] of Integer;
    Tabela : array[0..117] of String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.btCalcularClick(Sender: TObject);
Var I, nTot: Integer;
    nCamadaK,nCamadaL,nCamadaM,nCamadaN,nCamadaO,nCamadaP,nCamadaQ : Integer;
    nValCamada : Single;
    cPauling : array[0..6,0..3] of String;
    cSubNivel : String;
    cElemento :String;
    nPesoAtomico : Integer;
begin
  nValCamada := edtVal.Value;

  I :=0;
  while I <= 117 do
  Begin
    nPesoAtomico := StrToInt(Copy(Tabela[I], 0, Pos(';',Tabela[I])-1));
    cElemento := Copy(Tabela[I], Pos(';',Tabela[I])+1, Tabela[I].Length);
    if nPesoAtomico = nValCamada then
    Begin
      lbElemento.Text := cElemento;
      I := 119;
    End;
    I := I + 1;
  End;

  nCamadaK := 0;
  nCamadaL := 0;
  nCamadaM := 0;
  nCamadaN := 0;
  nCamadaO := 0;
  nCamadaP := 0;
  nCamadaQ := 0;
  I := 0;
  lbPauling.Text := '';
  While I <= 27 do
  Begin
    if VarreArrayY[I] = 0 then
      cSubNivel := 's';
    if VarreArrayY[I] = 1 then
      cSubNivel := 'p';
    if VarreArrayY[I] = 2 then
      cSubNivel := 'd';
    if VarreArrayY[I] = 3 then
      cSubNivel := 'f';

    if Pauling[VarreArrayX[I],VarreArrayY[I]] <> 0 then
    Begin
      if nValCamada >= Pauling[VarreArrayX[I],VarreArrayY[I]] then
      Begin
        nValCamada := nValCamada - Pauling[VarreArrayX[I],VarreArrayY[I]];

        cPauling[VarreArrayX[I],VarreArrayY[I]] := IntToStr(VarreArrayX[I] + 1) +
                                                 cSubNivel +
                                                 IntToStr(Pauling[VarreArrayX[I],VarreArrayY[I]]);
        lbPauling.Text := lbPauling.Text + cPauling[VarreArrayX[I],VarreArrayY[I]] + ';';

        case VarreArrayX[I] of
          0: nCamadaK := nCamadaK + Pauling[VarreArrayX[I],VarreArrayY[I]];
          1: nCamadaL := nCamadaL + Pauling[VarreArrayX[I],VarreArrayY[I]];
          2: nCamadaM := nCamadaM + Pauling[VarreArrayX[I],VarreArrayY[I]];
          3: nCamadaN := nCamadaN + Pauling[VarreArrayX[I],VarreArrayY[I]];
          4: nCamadaO := nCamadaO + Pauling[VarreArrayX[I],VarreArrayY[I]];
          5: nCamadaP := nCamadaP + Pauling[VarreArrayX[I],VarreArrayY[I]];
          6: nCamadaQ := nCamadaQ + Pauling[VarreArrayX[I],VarreArrayY[I]];
        end;
      End
      Else
      Begin
        if nValCamada > 0 then
        Begin
          cPauling[VarreArrayX[I],VarreArrayY[I]] := IntToStr(VarreArrayX[I] + 1) +
                                                   cSubNivel +
                                                   (nValCamada.ToString);
          lbPauling.Text := lbPauling.Text + cPauling[VarreArrayX[I],VarreArrayY[I]] + ';';

          case VarreArrayX[I] of
            0: nCamadaK := nCamadaK + Trunc(nValCamada);
            1: nCamadaL := nCamadaL + Trunc(nValCamada);
            2: nCamadaM := nCamadaM + Trunc(nValCamada);
            3: nCamadaN := nCamadaN + Trunc(nValCamada);
            4: nCamadaO := nCamadaO + Trunc(nValCamada);
            5: nCamadaP := nCamadaP + Trunc(nValCamada);
            6: nCamadaQ := nCamadaQ + Trunc(nValCamada);
          end;
        end;
        nValCamada := 0;
        I := 27;
      End;
    End;

    I := I + 1;
  End;



  lbCamadas.Text := 'K=' + IntToStr(nCamadaK) + ';';

  if nCamadaL > 0 then
    lbCamadas.Text := lbCamadas.Text + 'L=' + IntToStr(nCamadaL) + ';';

  if nCamadaM > 0 then
    lbCamadas.Text := lbCamadas.Text + 'M=' + IntToStr(nCamadaM) + ';';

  if nCamadaN > 0 then
    lbCamadas.Text := lbCamadas.Text + 'N=' + IntToStr(nCamadaN) + ';';

  if nCamadaO > 0 then
    lbCamadas.Text := lbCamadas.Text + 'O=' + IntToStr(nCamadaO) + ';';

  if nCamadaP > 0 then
    lbCamadas.Text := lbCamadas.Text + 'P=' + IntToStr(nCamadaP) + ';';

  if nCamadaQ > 0 then
    lbCamadas.Text := lbCamadas.Text + 'Q=' + IntToStr(nCamadaQ);
end;

procedure TForm1.FormCreate(Sender: TObject);
Var X, Y : Integer;
begin
  //Alimenta Vetor com os Elementos da Tabela Peri�dica
  Tabela[0] := '89;Ac;Act�nio;Actinium;Raio, do�grego�akt�nos';
  Tabela[1] := '47;Ag;Prata;Argentum;Prata, do grego�argyros';
  Tabela[2] := '13;Al;Alum�nio;Alumen;Sal amargo, do latim�alumen, ver�al�men';
  Tabela[3] := '95;Am;Amer�cio;Americium;Am�ricas, continente.';
  Tabela[4] := '18;Ar;Arg�nio;Argon;Inerte,�lento, do�grego�argos';
  Tabela[5] := '33;As;Ars�nio;Arsenicum;Masculino, do�grego�arsenikos';
  Tabela[6] := '85;At;�stato;Astatum;Inst�vel, do�grego�astatos';
  Tabela[7] := '79;Au;Ouro;Aurum;Dourado, do latim�aureus';
  Tabela[8] := '5;B;Boro;Borium;B�rax, do �rabe�buraq';
  Tabela[9] := '56;Ba;B�rio;Barium;Densidade, pesado, do�grego�barys';
  Tabela[10] := '4;Be;Ber�lio;Beryllium;Berilo, azul-esverdeada, do grego�beryllos';
  Tabela[11] := '107;Bh;B�hrio;Bohrium;Niels Bohr';
  Tabela[12] := '83;Bi;Bismuto;Bismuthum;Massa branca, corrup��o do�alem�o�Weisse+masse';
  Tabela[13] := '97;Bk;Berqu�lio;Berkelium;Berkeley, Calif�rnia';
  Tabela[14] := '35;Br;Bromo;Bromum;Mau cheiro, fedido, do�grego�broma';
  Tabela[15] := '6;C;Carbono;Carbonium;Carv�o, do�latim�carbo';
  Tabela[16] := '20;Ca;C�lcio;Calcium;Cal, do�latim�calx';
  Tabela[17] := '48;Cd;C�dmio;Cadmium;Solo, corrup��o do�grego�kadmia';
  Tabela[18] := '58;Ce;C�rio;Cerium;Ceres, planeta-an�o e deus romano';
  Tabela[19] := '98;Cf;Calif�rnio;Californium;Calif�rnia, estado norte-americano';
  Tabela[20] := '17;Cl;Cloro;Clorum;Amarelo esverdeado, do�grego�chloros';
  Tabela[21] := '96;Cm;C�rio;Curium;Pierre�e�Marie Curie';
  Tabela[22] := '112;Cn;Copern�cio;Copernicium;Nicolau Cop�rnico';
  Tabela[23] := '27;Co;Cobalto;Cobaltum;Duende,�gnomo, corrup��o do�alem�o�Kobold';
  Tabela[24] := '24;Cr;Cromo;Chromium;Cor, do�grego�chroma';
  Tabela[25] := '55;Cs;C�sio;Caesium;Azul-celeste, do�latim�caesius';
  Tabela[26] := '29;Cu;Cobre;Cuprum;Chipre, do�latim�cyprium';
  Tabela[27] := '105;Db;D�bnio;Dubnium;Dubna, R�ssia';
  Tabela[28] := '110;Ds;Darmst�cio;Darmstadtium;Darmstadt, Alemanha';
  Tabela[29] := '66;Dy;Dispr�sio;Dysprosium;Inacess�vel, do�grego�dysprositos';
  Tabela[30] := '68;Er;�rbio;Erbium;Ytterby, Su�cia';
  Tabela[31] := '99;Es;Einst�nio;Einsteinium;Albert Einstein';
  Tabela[32] := '63;Eu;Eur�pio;Europium;Europa';
  Tabela[33] := '9;F;Fl�or;Fluorum;Fluir, do�latim�fluere';
  Tabela[34] := '26;Fe;Ferro;Ferrum;Ferro, do latim';
  Tabela[35] := '114;Fl;Fler�vio;Flerovium;Georgy Flyorov';
  Tabela[36] := '100;Fm;F�rmio;Fermium;Enrico Fermi';
  Tabela[37] := '87;Fr;Fr�ncio;Francium;Fran�a';
  Tabela[38] := '31;Ga;G�lio;Galium;G�lia, do�latim�Gallia';
  Tabela[39] := '64;Gd;Gadol�nio;Gadolinium;Johan Gadolin';
  Tabela[40] := '32;Ge;Germ�nio;Germanium;Alemanha, do�latim�Germania';
  Tabela[41] := '1;H;Hidrog�nio;Hydrogenium;Gera �gua, do�grego�hydror+genos';
  Tabela[42] := '2;He;H�lio;Helium;Sol, do�grego�helios';
  Tabela[43] := '72;Hf;H�fnio;Hafnium;Copenhagen, do�latim�Hafnia';
  Tabela[44] := '80;Hg;Merc�rio;Hydrargyrum;L�quido prateado, do�latim�hydra+argyros';
  Tabela[45] := '67;Ho;H�lmio;Holmium;Estocolmo, do�latim�Holmia';
  Tabela[46] := '108;Hs;H�ssio;Hassium;Hessen, Alemanha';
  Tabela[47] := '53;I;Iodo;Iodum;Violeta, do�grego�ioeides';
  Tabela[48] := '49;In;�ndio;Indium;Azul indigo,�violeta, do latim�indicium';
  Tabela[49] := '77;Ir;Ir�dio;Iridium;�ris, deusa do�arco-�ris, do�latim�iris';
  Tabela[50] := '19;K;Pot�ssio;Kalium;Kalium (hidr�xido de pot�ssio), do grego�kalium. Cinza de pote, do�neerland�s�pottasche';
  Tabela[51] := '36;Kr;Cript�nio;Krypton;Oculto, do�grego�kryptos';
  Tabela[52] := '57;La;Lant�nio;Lanthanum;Do�grego�lanthanein';
  Tabela[53] := '3;Li;L�tio;Lithium;Rocha, do�grego�lithos';
  Tabela[54] := '103;Lr;Laur�ncio;Lawrencium;Ernest Lawrence';
  Tabela[55] := '71;Lu;Lut�cio;Lutetium;Paris, do�latim�Lutetia';
  Tabela[56] := '116;Lv;Liverm�rio;Livermorium;Laborat�rio Nacional de Lawrence Livermore';
  Tabela[57] := '115;Mc;Mosc�vio;Moscovium;Moscovo';
  Tabela[58] := '101;Md;Mendel�vio;Mendelevium;Dmitri Mendeleyev';
  Tabela[59] := '12;Mg;Magn�sio;Magnesium;Magn�sia, Gr�cia';
  Tabela[60] := '25;Mn;Mangan�s;Manganum;Im�, do�latim�magnes';
  Tabela[61] := '42;Mo;Molibd�nio;Molybdenum;Chumbo, do�grego�molybdos';
  Tabela[62] := '109;Mt;Meitn�rio;Meitnerium;Lise Meitner';
  Tabela[63] := '7;N;Nitrog�nio;Nitrogenium;Gera salitre (nitrato), do�grego�nitro+gen';
  Tabela[64] := '11;Na;S�dio;Natrium;Natron (Carbonato de s�dio), do grego�n�tron. "Sem sabor", do italiano�soda';
  Tabela[65] := '41;Nb;Ni�bio;Niobium;Niobe, filha de T�ntalo mitologia grega';
  Tabela[66] := '60;Nd;Neod�mio;Neodymium;Novo g�meo, do�grego�neos+didymos';
  Tabela[67] := '10;Ne;Ne�nio;Neon;Novo, do�grego�neos';
  Tabela[68] := '113;Nh;Nip�nio;Nihonium;Nihon ou Nippon,�Jap�o';
  Tabela[69] := '28;Ni;N�quel;Niccolum;N�quelina, do�alem�o�Kupfernickel';
  Tabela[70] := '102;No;Nob�lio;Nobelium;Alfred Nobel';
  Tabela[71] := '93;Np;Ne(p)t�nio;Neptunium;Netuno, planeta e deus grego';
  Tabela[72] := '8;O;Oxig�nio;Oxygenium;Gera��cido, do�grego�oxys+genes';
  Tabela[73] := '118;Og;Ogan�sson;Oganesson;Yuri Oganessian';
  Tabela[74] := '76;Os;�smio;Osmium;Odor, do�grego�osme';
  Tabela[75] := '15;P;F�sforo;Phosphorus;Portador da luz, do�grego�phosphoros';
  Tabela[76] := '91;Pa;Protact�nio;Protactinium;Primeiro act�nio, do�grego�protos+akt�nos';
  Tabela[77] := '82;Pb;Chumbo;Plumbum;Do�latim�plumbum';
  Tabela[78] := '46;Pd;Pal�dio;Palladium;Palas, aster�ide';
  Tabela[79] := '61;Pm;Prom�cio;Promethium;Prometeu, mitologia grega';
  Tabela[80] := '84;Po;Pol�nio;Polonium;Pol�nia';
  Tabela[81] := '59;Pr;Praseod�mio;Praseodymium;Verde, do�grego�prasios';
  Tabela[82] := '78;Pt;Platina;Platinum;Prata pequena, do�espanhol�plata+ina(diminutivo)';
  Tabela[83] := '94;Pu;Plut�nio;Plutonium;Plut�o, planeta e deus grego';
  Tabela[84] := '88;Ra;R�dio;Radium;Raio, do�latim�radius';
  Tabela[85] := '37;Rb;Rub�dio;Rubidium;Vermelho, do�latim�rubidus';
  Tabela[86] := '75;Re;R�nio;Rhenium;Rio Reno, Alemanha, do latim�Rhenia';
  Tabela[87] := '104;Rf;Rutherf�rdio;Rhuterfordium;Ernest Rutherford';
  Tabela[88] := '111;Rg;Roentg�nio�(Roentg�nio);Roentgenium;Wilhelm Conrad R�ntgen';
  Tabela[89] := '45;Rh;R�dio;Rhodium;Cor-de-rosa, do�grego�rhodon';
  Tabela[90] := '86;Rn;R�don (Rad�nio);Radon;emana��o�do�Radium';
  Tabela[91] := '44;Ru;Rut�nio;Ruthenium;R�ssia, do�latim�Ruthenia';
  Tabela[92] := '16;S;Enxofre;Sulphur;Do�latim�sulphur';
  Tabela[93] := '51;Sb;Antim�nio;Stibium;Ver�Antim�nio';
  Tabela[94] := '21;Sc;Esc�ndio;Scandium;Escandin�via';
  Tabela[95] := '34;Se;Sel�nio;Selenium;Lua, do�grego�selene';
  Tabela[96] := '106;Sg;Seab�rgio;Seaborgium;Glenn T. Seaborg';
  Tabela[97] := '14;Si;Sil�cio;Silicium;S�lex, do�latim�silex';
  Tabela[98] := '62;Sm;Sam�rio;Samarium;Samarskite, mineral';
  Tabela[99] := '50;Sn;Estanho;Stannum;Duro, do latim�stannum';
  Tabela[100] := '38;Sr;Estr�ncio;Strontium;Strontian,�Esc�cia';
  Tabela[101] := '73;Ta;T�ntalo�(tant�lio);Tantalum;Rei�T�ntalo, mitologia grega';
  Tabela[102] := '65;Tb;T�rbio;Terbium;Ytterby, Sweden';
  Tabela[103] := '43;Tc;Tecn�cio;Technetium;Artificial, do�grego�technetos';
  Tabela[104] := '52;Te;Tel�rio;Tellurium;Terra, planeta, do�latim�tellus';
  Tabela[105] := '90;Th;T�rio;Thorium;Thor, deus n�rdico';
  Tabela[106] := '22;Ti;Tit�nio;Titanium;Tit�s, mitologia grega';
  Tabela[107] := '81;Tl;T�lio;Thallium;Tiro, do�grego�thallos';
  Tabela[108] := '69;Tm;T�lio;Thulium;Thule';
  Tabela[109] := '117;Ts;Tenesso;Tennessine;Tennessee';
  Tabela[110] := '92;U;Ur�nio;Uranium;Urano, planeta e deus grego';
  Tabela[111] := '23;V;Van�dio;Vanadium;Freya, deusa n�rdica, do n�rdico antigo�Vanadis';
  Tabela[112] := '74;W;Tungst�nio;Wolframium;Lobo espuma, do�alem�o�Wolf';
  Tabela[113] := '54;Xe;Xen�nio;Xenon;Estranho, do�grego�xenos';
  Tabela[114] := '39;Y;�trio;Yttrium;Ytterby, Su�cia';
  Tabela[115] := '70;Yb;It�rbio;Ytterbium;Ytterby, Su�cia';
  Tabela[116] := '30;Zn;Zinco;Zincum;Estanho, do�alem�o�Zinn';
  Tabela[117] := '40;Zr;Zirc�nio;Zirconium;Dourado, do persa�zargun';

  //Alimenta Array com Diagrama de Pauling
  for X := 0 to 6 do
  for Y := 0 to 3 do
  Begin
    if Y = 0 then
    Begin
      Pauling[X,Y] := 2;
    End;
    if Y = 1 then
    Begin
      if X = 0 then
        Pauling[X,Y] := 0
      Else
        Pauling[X,Y] := 6;
    End;
    if Y = 2 then
    Begin
      if (X = 0) or
         (X = 1) or
         (X = 6) then
        Pauling[X,Y] := 0
      Else
        Pauling[X,Y] := 10;
    End;
    if Y = 3 then
    Begin
      if (X = 3) or
         (X = 4) then
        Pauling[X,Y] := 14
      Else
        Pauling[X,Y] := 0;
    End;
  End;

  //Alimenta Array de Varredura da Pauling
  VarreArrayX[0]  :=0;
  VarreArrayX[1]  :=0;
  VarreArrayX[2]  :=1;
  VarreArrayX[3]  :=0;
  VarreArrayX[4]  :=1;
  VarreArrayX[5]  :=2;
  VarreArrayX[6]  :=0;
  VarreArrayX[7]  :=1;
  VarreArrayX[8]  :=2;
  VarreArrayX[9]  :=3;
  VarreArrayX[10]  :=1;
  VarreArrayX[11]  :=2;
  VarreArrayX[12]  :=3;
  VarreArrayX[13]  :=4;
  VarreArrayX[14]  :=2;
  VarreArrayX[15]  :=3;
  VarreArrayX[16]  :=4;
  VarreArrayX[17]  :=5;
  VarreArrayX[18]  :=3;
  VarreArrayX[19]  :=4;
  VarreArrayX[20]  :=5;
  VarreArrayX[21]  :=6;
  VarreArrayX[22]  :=4;
  VarreArrayX[23]  :=5;
  VarreArrayX[24]  :=6;
  VarreArrayX[25]  :=5;
  VarreArrayX[26]  :=6;
  VarreArrayX[27]  :=6;

  VarreArrayY[0]  :=0;
  VarreArrayY[1]  :=1;
  VarreArrayY[2]  :=0;
  VarreArrayY[3]  :=2;
  VarreArrayY[4]  :=1;
  VarreArrayY[5]  :=0;
  VarreArrayY[6]  :=3;
  VarreArrayY[7]  :=2;
  VarreArrayY[8]  :=1;
  VarreArrayY[9]  :=0;
  VarreArrayY[10]  :=3;
  VarreArrayY[11]  :=2;
  VarreArrayY[12]  :=1;
  VarreArrayY[13]  :=0;
  VarreArrayY[14]  :=3;
  VarreArrayY[15]  :=2;
  VarreArrayY[16]  :=1;
  VarreArrayY[17]  :=0;
  VarreArrayY[18]  :=3;
  VarreArrayY[19]  :=2;
  VarreArrayY[20]  :=1;
  VarreArrayY[21]  :=0;
  VarreArrayY[22]  :=3;
  VarreArrayY[23]  :=2;
  VarreArrayY[24]  :=1;
  VarreArrayY[25]  :=3;
  VarreArrayY[26]  :=2;
  VarreArrayY[27]  :=3;
end;

end.
