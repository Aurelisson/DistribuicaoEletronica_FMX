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
  //Alimenta Vetor com os Elementos da Tabela Periódica
  Tabela[0] := '89;Ac;Actínio;Actinium;Raio, do grego aktínos';
  Tabela[1] := '47;Ag;Prata;Argentum;Prata, do grego argyros';
  Tabela[2] := '13;Al;Alumínio;Alumen;Sal amargo, do latim alumen, ver alúmen';
  Tabela[3] := '95;Am;Amerício;Americium;Américas, continente.';
  Tabela[4] := '18;Ar;Argônio;Argon;Inerte, lento, do grego argos';
  Tabela[5] := '33;As;Arsénio;Arsenicum;Masculino, do grego arsenikos';
  Tabela[6] := '85;At;Ástato;Astatum;Instável, do grego astatos';
  Tabela[7] := '79;Au;Ouro;Aurum;Dourado, do latim aureus';
  Tabela[8] := '5;B;Boro;Borium;Bórax, do árabe buraq';
  Tabela[9] := '56;Ba;Bário;Barium;Densidade, pesado, do grego barys';
  Tabela[10] := '4;Be;Berílio;Beryllium;Berilo, azul-esverdeada, do grego beryllos';
  Tabela[11] := '107;Bh;Bóhrio;Bohrium;Niels Bohr';
  Tabela[12] := '83;Bi;Bismuto;Bismuthum;Massa branca, corrupção do alemão Weisse+masse';
  Tabela[13] := '97;Bk;Berquélio;Berkelium;Berkeley, Califórnia';
  Tabela[14] := '35;Br;Bromo;Bromum;Mau cheiro, fedido, do grego broma';
  Tabela[15] := '6;C;Carbono;Carbonium;Carvão, do latim carbo';
  Tabela[16] := '20;Ca;Cálcio;Calcium;Cal, do latim calx';
  Tabela[17] := '48;Cd;Cádmio;Cadmium;Solo, corrupção do grego kadmia';
  Tabela[18] := '58;Ce;Cério;Cerium;Ceres, planeta-anão e deus romano';
  Tabela[19] := '98;Cf;Califórnio;Californium;Califórnia, estado norte-americano';
  Tabela[20] := '17;Cl;Cloro;Clorum;Amarelo esverdeado, do grego chloros';
  Tabela[21] := '96;Cm;Cúrio;Curium;Pierre e Marie Curie';
  Tabela[22] := '112;Cn;Copernício;Copernicium;Nicolau Copérnico';
  Tabela[23] := '27;Co;Cobalto;Cobaltum;Duende, gnomo, corrupção do alemão Kobold';
  Tabela[24] := '24;Cr;Cromo;Chromium;Cor, do grego chroma';
  Tabela[25] := '55;Cs;Césio;Caesium;Azul-celeste, do latim caesius';
  Tabela[26] := '29;Cu;Cobre;Cuprum;Chipre, do latim cyprium';
  Tabela[27] := '105;Db;Dúbnio;Dubnium;Dubna, Rússia';
  Tabela[28] := '110;Ds;Darmstácio;Darmstadtium;Darmstadt, Alemanha';
  Tabela[29] := '66;Dy;Disprósio;Dysprosium;Inacessível, do grego dysprositos';
  Tabela[30] := '68;Er;Érbio;Erbium;Ytterby, Suécia';
  Tabela[31] := '99;Es;Einsténio;Einsteinium;Albert Einstein';
  Tabela[32] := '63;Eu;Európio;Europium;Europa';
  Tabela[33] := '9;F;Flúor;Fluorum;Fluir, do latim fluere';
  Tabela[34] := '26;Fe;Ferro;Ferrum;Ferro, do latim';
  Tabela[35] := '114;Fl;Fleróvio;Flerovium;Georgy Flyorov';
  Tabela[36] := '100;Fm;Férmio;Fermium;Enrico Fermi';
  Tabela[37] := '87;Fr;Frâncio;Francium;França';
  Tabela[38] := '31;Ga;Gálio;Galium;Gália, do latim Gallia';
  Tabela[39] := '64;Gd;Gadolínio;Gadolinium;Johan Gadolin';
  Tabela[40] := '32;Ge;Germânio;Germanium;Alemanha, do latim Germania';
  Tabela[41] := '1;H;Hidrogênio;Hydrogenium;Gera água, do grego hydror+genos';
  Tabela[42] := '2;He;Hélio;Helium;Sol, do grego helios';
  Tabela[43] := '72;Hf;Háfnio;Hafnium;Copenhagen, do latim Hafnia';
  Tabela[44] := '80;Hg;Mercúrio;Hydrargyrum;Líquido prateado, do latim hydra+argyros';
  Tabela[45] := '67;Ho;Hólmio;Holmium;Estocolmo, do latim Holmia';
  Tabela[46] := '108;Hs;Hássio;Hassium;Hessen, Alemanha';
  Tabela[47] := '53;I;Iodo;Iodum;Violeta, do grego ioeides';
  Tabela[48] := '49;In;Índio;Indium;Azul indigo, violeta, do latim indicium';
  Tabela[49] := '77;Ir;Irídio;Iridium;Íris, deusa do arco-íris, do latim iris';
  Tabela[50] := '19;K;Potássio;Kalium;Kalium (hidróxido de potássio), do grego kalium. Cinza de pote, do neerlandês pottasche';
  Tabela[51] := '36;Kr;Criptônio;Krypton;Oculto, do grego kryptos';
  Tabela[52] := '57;La;Lantânio;Lanthanum;Do grego lanthanein';
  Tabela[53] := '3;Li;Lítio;Lithium;Rocha, do grego lithos';
  Tabela[54] := '103;Lr;Laurêncio;Lawrencium;Ernest Lawrence';
  Tabela[55] := '71;Lu;Lutécio;Lutetium;Paris, do latim Lutetia';
  Tabela[56] := '116;Lv;Livermório;Livermorium;Laboratório Nacional de Lawrence Livermore';
  Tabela[57] := '115;Mc;Moscóvio;Moscovium;Moscovo';
  Tabela[58] := '101;Md;Mendelévio;Mendelevium;Dmitri Mendeleyev';
  Tabela[59] := '12;Mg;Magnésio;Magnesium;Magnésia, Grécia';
  Tabela[60] := '25;Mn;Manganês;Manganum;Imã, do latim magnes';
  Tabela[61] := '42;Mo;Molibdénio;Molybdenum;Chumbo, do grego molybdos';
  Tabela[62] := '109;Mt;Meitnério;Meitnerium;Lise Meitner';
  Tabela[63] := '7;N;Nitrogênio;Nitrogenium;Gera salitre (nitrato), do grego nitro+gen';
  Tabela[64] := '11;Na;Sódio;Natrium;Natron (Carbonato de sódio), do grego nítron. "Sem sabor", do italiano soda';
  Tabela[65] := '41;Nb;Nióbio;Niobium;Niobe, filha de Tântalo mitologia grega';
  Tabela[66] := '60;Nd;Neodímio;Neodymium;Novo gêmeo, do grego neos+didymos';
  Tabela[67] := '10;Ne;Neônio;Neon;Novo, do grego neos';
  Tabela[68] := '113;Nh;Nipônio;Nihonium;Nihon ou Nippon, Japão';
  Tabela[69] := '28;Ni;Níquel;Niccolum;Níquelina, do alemão Kupfernickel';
  Tabela[70] := '102;No;Nobélio;Nobelium;Alfred Nobel';
  Tabela[71] := '93;Np;Ne(p)túnio;Neptunium;Netuno, planeta e deus grego';
  Tabela[72] := '8;O;Oxigênio;Oxygenium;Gera ácido, do grego oxys+genes';
  Tabela[73] := '118;Og;Oganésson;Oganesson;Yuri Oganessian';
  Tabela[74] := '76;Os;Ósmio;Osmium;Odor, do grego osme';
  Tabela[75] := '15;P;Fósforo;Phosphorus;Portador da luz, do grego phosphoros';
  Tabela[76] := '91;Pa;Protactínio;Protactinium;Primeiro actínio, do grego protos+aktínos';
  Tabela[77] := '82;Pb;Chumbo;Plumbum;Do latim plumbum';
  Tabela[78] := '46;Pd;Paládio;Palladium;Palas, asteróide';
  Tabela[79] := '61;Pm;Promécio;Promethium;Prometeu, mitologia grega';
  Tabela[80] := '84;Po;Polônio;Polonium;Polônia';
  Tabela[81] := '59;Pr;Praseodímio;Praseodymium;Verde, do grego prasios';
  Tabela[82] := '78;Pt;Platina;Platinum;Prata pequena, do espanhol plata+ina(diminutivo)';
  Tabela[83] := '94;Pu;Plutônio;Plutonium;Plutão, planeta e deus grego';
  Tabela[84] := '88;Ra;Rádio;Radium;Raio, do latim radius';
  Tabela[85] := '37;Rb;Rubídio;Rubidium;Vermelho, do latim rubidus';
  Tabela[86] := '75;Re;Rênio;Rhenium;Rio Reno, Alemanha, do latim Rhenia';
  Tabela[87] := '104;Rf;Rutherfórdio;Rhuterfordium;Ernest Rutherford';
  Tabela[88] := '111;Rg;Roentgénio (Roentgênio);Roentgenium;Wilhelm Conrad Röntgen';
  Tabela[89] := '45;Rh;Ródio;Rhodium;Cor-de-rosa, do grego rhodon';
  Tabela[90] := '86;Rn;Rádon (Radônio);Radon;emanação do Radium';
  Tabela[91] := '44;Ru;Rutênio;Ruthenium;Rússia, do latim Ruthenia';
  Tabela[92] := '16;S;Enxofre;Sulphur;Do latim sulphur';
  Tabela[93] := '51;Sb;Antimônio;Stibium;Ver Antimônio';
  Tabela[94] := '21;Sc;Escândio;Scandium;Escandinávia';
  Tabela[95] := '34;Se;Selénio;Selenium;Lua, do grego selene';
  Tabela[96] := '106;Sg;Seabórgio;Seaborgium;Glenn T. Seaborg';
  Tabela[97] := '14;Si;Silício;Silicium;Sílex, do latim silex';
  Tabela[98] := '62;Sm;Samário;Samarium;Samarskite, mineral';
  Tabela[99] := '50;Sn;Estanho;Stannum;Duro, do latim stannum';
  Tabela[100] := '38;Sr;Estrôncio;Strontium;Strontian, Escócia';
  Tabela[101] := '73;Ta;Tântalo (tantálio);Tantalum;Rei Tântalo, mitologia grega';
  Tabela[102] := '65;Tb;Térbio;Terbium;Ytterby, Sweden';
  Tabela[103] := '43;Tc;Tecnécio;Technetium;Artificial, do grego technetos';
  Tabela[104] := '52;Te;Telúrio;Tellurium;Terra, planeta, do latim tellus';
  Tabela[105] := '90;Th;Tório;Thorium;Thor, deus nórdico';
  Tabela[106] := '22;Ti;Titânio;Titanium;Titãs, mitologia grega';
  Tabela[107] := '81;Tl;Tálio;Thallium;Tiro, do grego thallos';
  Tabela[108] := '69;Tm;Túlio;Thulium;Thule';
  Tabela[109] := '117;Ts;Tenesso;Tennessine;Tennessee';
  Tabela[110] := '92;U;Urânio;Uranium;Urano, planeta e deus grego';
  Tabela[111] := '23;V;Vanádio;Vanadium;Freya, deusa nórdica, do nórdico antigo Vanadis';
  Tabela[112] := '74;W;Tungstênio;Wolframium;Lobo espuma, do alemão Wolf';
  Tabela[113] := '54;Xe;Xenônio;Xenon;Estranho, do grego xenos';
  Tabela[114] := '39;Y;Ítrio;Yttrium;Ytterby, Suécia';
  Tabela[115] := '70;Yb;Itérbio;Ytterbium;Ytterby, Suécia';
  Tabela[116] := '30;Zn;Zinco;Zincum;Estanho, do alemão Zinn';
  Tabela[117] := '40;Zr;Zircônio;Zirconium;Dourado, do persa zargun';

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
