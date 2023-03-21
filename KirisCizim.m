
function [x]=KirisCizim(ElemanKiris,ElemanKat,fiKirisBoyCap,fiKirEt,KirisUz,KirisDonSay,KirisKordXY,bk,hk,KirEtSarilmaUz,KirEtAralikMin)

    x=figure('Name','Kiris');
    hold on

for k=ElemanKat;
for i=ElemanKiris;
    dus=2+max(fiKirisBoyCap(i,[2 5],k))/20+fiKirEt/10
    n=KirisUz(i,1,k)/5
    h=hk(i,1,k)-2*dus
    dalt=KirisUz(i,1,k)-2*n-2*h-2*dus
    SolUstM=KirisDonSay(i,1,k)-2
    UstAcik=KirisDonSay(i,2,k)-2
    SagUstM=KirisDonSay(i,3,k)-2
    SolAltM=KirisDonSay(i,4,k)-2
    AltAcik=KirisDonSay(i,5,k)-2
    SagAltM=KirisDonSay(i,6,k)-2
    
    if KirisKordXY(i,1,k)==KirisKordXY(i,3,k);
    axis([KirisKordXY(i,1,k)-KirisUz(i,1,k)/2 KirisKordXY(i,3,k)+KirisUz(i,1,k)/2 KirisKordXY(i,2,k)-10 KirisKordXY(i,4,k)+10  KirisKordXY(i,5,k)-KirisUz(i,1,k)/2 KirisKordXY(i,5,k)+KirisUz(i,1,k)/2])    
        
    KC(i,1,k)=KirisKordXY(i,1,k)-bk(i,1,k)/2;
    KC(i,2,k)=KirisKordXY(i,2,k);
    KC(i,3,k)=KirisKordXY(i,5,k)-hk(i,1,k)/2;
    
    KC(i,4,k)=KirisKordXY(i,1,k)+bk(i,1,k)/2;
    KC(i,5,k)=KirisKordXY(i,2,k);
    KC(i,6,k)=KirisKordXY(i,5,k)-hk(i,1,k)/2;
    
    KC(i,7,k)=KirisKordXY(i,1,k)-bk(i,1,k)/2;
    KC(i,8,k)=KirisKordXY(i,2,k);
    KC(i,9,k)=KirisKordXY(i,5,k)+hk(i,1,k)/2;
    
    KC(i,10,k)=KirisKordXY(i,1,k)+bk(i,1,k)/2;
    KC(i,11,k)=KirisKordXY(i,2,k);
    KC(i,12,k)=KirisKordXY(i,5,k)+hk(i,1,k)/2;
    
    
    
    KC(i,13,k)=KirisKordXY(i,3,k)-bk(i,1,k)/2;
    KC(i,14,k)=KirisKordXY(i,4,k);
    KC(i,15,k)=KirisKordXY(i,5,k)-hk(i,1,k)/2;
    
    KC(i,16,k)=KirisKordXY(i,3,k)+bk(i,1,k)/2;
    KC(i,17,k)=KirisKordXY(i,4,k);
    KC(i,18,k)=KirisKordXY(i,5,k)-hk(i,1,k)/2;
    
    KC(i,19,k)=KirisKordXY(i,3,k)-bk(i,1,k)/2;
    KC(i,20,k)=KirisKordXY(i,4,k);
    KC(i,21,k)=KirisKordXY(i,5,k)+hk(i,1,k)/2;
    
    KC(i,22,k)=KirisKordXY(i,3,k)+bk(i,1,k)/2;
    KC(i,23,k)=KirisKordXY(i,4,k);
    KC(i,24,k)=KirisKordXY(i,5,k)+hk(i,1,k)/2;
    
    patch([KC(i,1,k) KC(i,4,k) KC(i,10,k) KC(i,7,k)],[KC(i,2,k) KC(i,5,k) KC(i,11,k) KC(i,8,k)],[KC(i,3,k) KC(i,6,k) KC(i,12,k) KC(i,9,k)],'red');
    patch([KC(i,13,k) KC(i,16,k) KC(i,22,k) KC(i,19,k)],[KC(i,14,k) KC(i,17,k) KC(i,23,k) KC(i,20,k)],[KC(i,15,k) KC(i,18,k) KC(i,24,k) KC(i,21,k)],'red');
    patch([KC(i,4,k) KC(i,16,k) KC(i,22,k) KC(i,10,k)],[KC(i,5,k) KC(i,17,k) KC(i,23,k) KC(i,11,k)],[KC(i,6,k) KC(i,18,k) KC(i,24,k) KC(i,12,k)],'red');
    patch([KC(i,1,k) KC(i,13,k) KC(i,19,k) KC(i,7,k)],[KC(i,2,k) KC(i,14,k) KC(i,20,k) KC(i,8,k)],[KC(i,3,k) KC(i,15,k) KC(i,21,k) KC(i,9,k)],'red');
    patch([KC(i,7,k) KC(i,10,k) KC(i,22,k) KC(i,19,k)],[KC(i,8,k) KC(i,11,k) KC(i,23,k) KC(i,20,k)],[KC(i,9,k) KC(i,12,k) KC(i,24,k) KC(i,21,k)],'red');
    patch([KC(i,1,k) KC(i,4,k) KC(i,16,k) KC(i,13,k)],[KC(i,2,k) KC(i,5,k) KC(i,17,k) KC(i,14,k)],[KC(i,3,k) KC(i,6,k) KC(i,18,k) KC(i,15,k)],'red');
    alpha(0.3);
    
    
    % Alt ve Ust Donatýlarýn Çizimi
    DBX=KC(i,1,k)+dus
    DBY=KC(i,2,k)-10
    DBZ=KC(i,3,k)+dus
    DSX=KC(i,13,k)+dus
    DSY=KC(i,14,k)+10
    DSZ=KC(i,15,k)+dus
    [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,1,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    
    DBX=KC(i,4,k)-dus
    DBY=KC(i,5,k)-10
    DBZ=KC(i,6,k)+dus
    DSX=KC(i,16,k)-dus
    DSY=KC(i,17,k)+10
    DSZ=KC(i,18,k)+dus
    [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,1,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    
    DBX=KC(i,7,k)+dus
    DBY=KC(i,8,k)-10
    DBZ=KC(i,9,k)-dus
    DSX=KC(i,19,k)+dus
    DSY=KC(i,20,k)+10
    DSZ=KC(i,21,k)-dus
    [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,1,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
   
    
    DBX=KC(i,10,k)-dus
    DBY=KC(i,11,k)-10
    DBZ=KC(i,12,k)-dus
    DSX=KC(i,22,k)-dus
    DSY=KC(i,23,k)+10
    DSZ=KC(i,24,k)-dus
    [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,1,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    
    UstAcikAralik=(bk(i,1,k)-2*dus)/(UstAcik+1)
    for j=1:1:UstAcik %>> Ust Aciklik Donatisinin Cizdirilmesi
        DBX=KC(i,10,k)-dus-j*UstAcikAralik
        DBY=KC(i,11,k)-10
        DBZ=KC(i,12,k)-dus
        DSX=KC(i,22,k)-dus-j*UstAcikAralik
        DSY=KC(i,23,k)+10
        DSZ=KC(i,24,k)-dus
        [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,1,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
        
    end
    
    AltAcikAralik=(bk(i,1,k)-2*dus)/(AltAcik+1)
    for j=1:1:AltAcik %>> Alt Aciklik Donatisinin Cizdirilmesi
        DBX=KC(i,4,k)-dus-j*AltAcikAralik
        DBY=KC(i,5,k)-10
        DBZ=KC(i,6,k)+dus
        DSX=KC(i,16,k)-dus-j*AltAcikAralik
        DSY=KC(i,17,k)+10
        DSZ=KC(i,18,k)+dus
        [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,1,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    end
    %% SaðÜst Mesnet Ek Donatisinin Cizdirilmesi
    SagEkDonati=SagUstM-UstAcik %>> SaðÜst Mesnet Ek Donatisinin Cizdirilmesi
    emin=max([2.5 fiKirisBoyCap(i,3,k)/10])
    DonSay=floor((bk(i,1,k)-2*dus)/emin)
    while ((bk(i,1,k)-2*dus)-(DonSay-1)*fiKirisBoyCap(i,1,k)/10)/(DonSay-1)<emin
        DonSay=DonSay-1
    end
    DonatiAralik=((bk(i,1,k)-2*dus))/(DonSay-1)
    DonKatSay=floor(SagEkDonati/DonSay)
    if DonKatSay==0
        DonKatSay=1
    end
    DonArtanSay=mod(SagEkDonati,DonSay)
    zdus=0
    for zdus=fiKirisBoyCap(i,3,k)/10:fiKirisBoyCap(i,3,k)/10:DonKatSay*fiKirisBoyCap(i,3,k)/10
    for j=0:1:DonSay-1 %>> SaðÜst Mesnet Ek Donatisinin Cizdirilmesi
        DBX=KC(i,22,k)-dus-j*DonatiAralik
        DBY=KC(i,23,k)-n-10
        DBZ=KC(i,24,k)-dus-zdus
        DSX=KC(i,10,k)-dus-j*DonatiAralik
        DSY=KC(i,23,k)+10
        DSZ=KC(i,12,k)-dus-zdus
        [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,3,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    end
    end
    zdus=zdus+fiKirisBoyCap(i,3,k)/10
    DonatiAralik=((bk(i,1,k)-2*dus))/(DonArtanSay-1)
    for j=0:1:DonArtanSay-1 %>> SaðÜst Mesnet Ek Donatisinin Cizdirilmesi
        DBX=KC(i,22,k)-dus-j*DonatiAralik
        DBY=KC(i,23,k)-n-10
        DBZ=KC(i,24,k)-dus-zdus
        DSX=KC(i,10,k)-dus-j*DonatiAralik
        DSY=KC(i,23,k)+10
        DSZ=KC(i,12,k)-dus-zdus
        [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,3,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    end
    
    %% Sol Üst Mesnet Ek Donatisinin Cizdirilmesi
    SolEkDonati=SolUstM-UstAcik %>> Sol Mesnet Ek Donatisinin Cizdirilmesi
    emin=max([2.5 fiKirisBoyCap(i,1,k)/10])
    DonSay=floor((bk(i,1,k)-2*dus)/emin)
    while ((bk(i,1,k)-2*dus)-(DonSay-1)*fiKirisBoyCap(i,1,k)/10)/(DonSay-1)<emin
        DonSay=DonSay-1
    end
    DonatiAralik=((bk(i,1,k)-2*dus))/(DonSay-1)
    DonKatSay=floor(SolEkDonati/DonSay)
    if DonKatSay==0
        DonKatSay=1
    end
    DonArtanSay=mod(SolEkDonati,DonSay)
    zdus=0
    for zdus=fiKirisBoyCap(i,1,k)/10:fiKirisBoyCap(i,1,k)/10:DonKatSay*fiKirisBoyCap(i,1,k)/10
    for j=0:1:DonSay-1 %>> Sol Mesnet Ek Donatisinin Cizdirilmesi
        DBX=KC(i,10,k)-dus-j*DonatiAralik
        DBY=KC(i,11,k)-10
        DBZ=KC(i,12,k)-dus-zdus
        DSX=KC(i,22,k)-dus-j*DonatiAralik
        DSY=KC(i,11,k)+n+10
        DSZ=KC(i,24,k)-dus-zdus
        [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,1,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    end
    end
    zdus=zdus+fiKirisBoyCap(i,1,k)/10
    DonatiAralik=((bk(i,1,k)-2*dus))/(DonArtanSay-1)
    for j=0:1:DonArtanSay-1 %>> Sol Mesnet Ek Donatisinin Cizdirilmesi
        DBX=KC(i,10,k)-dus-j*DonatiAralik
        DBY=KC(i,11,k)-10
        DBZ=KC(i,12,k)-dus-zdus
        DSX=KC(i,22,k)-dus-j*DonatiAralik
        DSY=KC(i,11,k)+n+10
        DSZ=KC(i,24,k)-dus-zdus
        [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,1,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    end
    %% Sol Alt Mesnet Donatýlarýnýn Çizidirilmesi
    
    SolEkDonati=SolAltM-UstAcik %>> Sol Mesnet Ek Donatisinin Cizdirilmesi
    emin=max([2.5 fiKirisBoyCap(i,4,k)/10])
    DonSay=floor((bk(i,1,k)-2*dus)/emin)
    while ((bk(i,1,k)-2*dus)-(DonSay-1)*fiKirisBoyCap(i,1,k)/10)/(DonSay-1)<emin
        DonSay=DonSay-1
    end
    DonatiAralik=((bk(i,1,k)-2*dus))/(DonSay-1)
    DonKatSay=floor(SolEkDonati/DonSay)
    if DonKatSay==0
        DonKatSay=1
    end
    DonArtanSay=mod(SolEkDonati,DonSay)
    zdus=0
    for zdus=fiKirisBoyCap(i,4,k)/10:fiKirisBoyCap(i,4,k)/10:DonKatSay*fiKirisBoyCap(i,4,k)/10
    for j=0:1:DonSay-1 %>> Sol Mesnet Ek Donatisinin Cizdirilmesi
        DBX=KC(i,4,k)-dus-j*DonatiAralik
        DBY=KC(i,5,k)-10
        DBZ=KC(i,6,k)+dus+zdus
        DSX=KC(i,16,k)-dus-j*DonatiAralik
        DSY=KC(i,5,k)+n+10
        DSZ=KC(i,18,k)+dus+zdus
        [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,4,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    end
    end
    zdus=zdus+fiKirisBoyCap(i,4,k)/10
    DonatiAralik=((bk(i,1,k)-2*dus))/(DonArtanSay-1)
    for j=0:1:DonArtanSay-1 %>> Sol Mesnet Ek Donatisinin Cizdirilmesi
        DBX=KC(i,4,k)-dus-j*DonatiAralik
        DBY=KC(i,5,k)-10
        DBZ=KC(i,6,k)+dus+zdus
        DSX=KC(i,16,k)-dus-j*DonatiAralik
        DSY=KC(i,5,k)+n+10
        DSZ=KC(i,18,k)+dus+zdus
        [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,4,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    end
    
    %% Sað Alt Mesnet Donatýlarýnýn Çizidirilmesi
    
    SolEkDonati=SagAltM-UstAcik %>> Sol Mesnet Ek Donatisinin Cizdirilmesi
    emin=max([2.5 fiKirisBoyCap(i,6,k)/10])
    DonSay=floor((bk(i,1,k)-2*dus)/emin)
    while ((bk(i,1,k)-2*dus)-(DonSay-1)*fiKirisBoyCap(i,1,k)/10)/(DonSay-1)<emin
        DonSay=DonSay-1
    end
    DonatiAralik=((bk(i,1,k)-2*dus))/(DonSay-1)
    DonKatSay=floor(SolEkDonati/DonSay)
    if DonKatSay==0
        DonKatSay=1
    end
    DonArtanSay=mod(SolEkDonati,DonSay)
    zdus=0
    for zdus=fiKirisBoyCap(i,6,k)/10:fiKirisBoyCap(i,6,k)/10:DonKatSay*fiKirisBoyCap(i,6,k)/10
    for j=0:1:DonSay-1 %>> Sol Mesnet Ek Donatisinin Cizdirilmesi
        DBX=KC(i,16,k)-dus-j*DonatiAralik
        DBY=KC(i,17,k)+10
        DBZ=KC(i,18,k)+dus+zdus
        DSX=KC(i,4,k)-dus-j*DonatiAralik
        DSY=KC(i,17,k)-n-10
        DSZ=KC(i,6,k)+dus+zdus
        [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,6,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    end
    end
    zdus=zdus+fiKirisBoyCap(i,6,k)/10
    DonatiAralik=((bk(i,1,k)-2*dus))/(DonArtanSay-1)
    for j=0:1:DonArtanSay-1 %>> Sol Mesnet Ek Donatisinin Cizdirilmesi
        DBX=KC(i,16,k)-dus-j*DonatiAralik
        DBY=KC(i,17,k)+10
        DBZ=KC(i,18,k)+dus+zdus
        DSX=KC(i,4,k)-dus-j*DonatiAralik
        DSY=KC(i,17,k)-n-10
        DSZ=KC(i,6,k)+dus+zdus
        [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,6,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    end
    
    %% Kiriþ Etriyelerinin Çizimi
    Bas=[0 KirEtSarilmaUz(i,1,k) KirEtSarilmaUz(i,1,k)+(KirisUz(i,1,k)-2*KirEtSarilmaUz(i,1,k))]
    Son=[Bas(1)+KirEtSarilmaUz(i,1,k) Bas(2)+(KirisUz(i,1,k)-2*KirEtSarilmaUz(i,1,k)) Bas(3)+KirEtSarilmaUz(i,1,k)]
    Art=[KirEtAralikMin(i,1,k) KirEtAralikMin(i,2,k) KirEtAralikMin(i,1,k)]
    
    for ji=1:3
    for j=Bas(ji):Art(ji):Son(ji)
        
    EtEksn=dus-max(fiKirisBoyCap(i,:,k)/20)-fiKirEt/20
    EB1=KC(i,1,k)+EtEksn
    EB2=KC(i,2,k)+j
    EB3=KC(i,3,k)+EtEksn
    EB4=KC(i,4,k)-EtEksn
    EB5=KC(i,5,k)+j
    EB6=KC(i,6,k)+EtEksn
    EB7=KC(i,7,k)+EtEksn
    EB8=KC(i,8,k)+j
    EB9=KC(i,9,k)-EtEksn
    EB10=KC(i,10,k)-EtEksn
    EB11=KC(i,11,k)+j
    EB12=KC(i,12,k)-EtEksn
    [X,Y,Z]=cylinder2P(fiKirEt/20,10,[EB1 EB2 EB3],[EB4 EB5 EB6]);surf(X,Y,Z);
    [X,Y,Z]=cylinder2P(fiKirEt/20,10,[EB4 EB5 EB6],[EB10 EB11 EB12]);surf(X,Y,Z);
    [X,Y,Z]=cylinder2P(fiKirEt/20,10,[EB1 EB2 EB3],[EB7 EB8 EB9]);surf(X,Y,Z);
    [X,Y,Z]=cylinder2P(fiKirEt/20,10,[EB7 EB8 EB9],[EB10 EB11 EB12]);surf(X,Y,Z);
    end
    end
    
    else if KirisKordXY(i,2,k)==KirisKordXY(i,4,k);
    axis([KirisKordXY(i,1,k)-10 KirisKordXY(i,3,k)+10 KirisKordXY(i,2,k)-KirisUz(i,1,k)/2 KirisKordXY(i,4,k)+KirisUz(i,1,k)/2  KirisKordXY(i,5,k)-KirisUz(i,1,k)/2 KirisKordXY(i,5,k)+KirisUz(i,1,k)/2])
    
    
    KC(i,1,k)=KirisKordXY(i,1,k);
    KC(i,2,k)=KirisKordXY(i,2,k)-bk(i,1,k)/2;
    KC(i,3,k)=KirisKordXY(i,5,k)-hk(i,1,k)/2;
    
    KC(i,4,k)=KirisKordXY(i,1,k);
    KC(i,5,k)=KirisKordXY(i,2,k)+bk(i,1,k)/2;
    KC(i,6,k)=KirisKordXY(i,5,k)-hk(i,1,k)/2;
    
    KC(i,7,k)=KirisKordXY(i,1,k);
    KC(i,8,k)=KirisKordXY(i,2,k)-bk(i,1,k)/2;
    KC(i,9,k)=KirisKordXY(i,5,k)+hk(i,1,k)/2;
    
    KC(i,10,k)=KirisKordXY(i,1,k);
    KC(i,11,k)=KirisKordXY(i,2,k)+bk(i,1,k)/2;
    KC(i,12,k)=KirisKordXY(i,5,k)+hk(i,1,k)/2;
    
    
    
    KC(i,13,k)=KirisKordXY(i,3,k);
    KC(i,14,k)=KirisKordXY(i,4,k)-bk(i,1,k)/2;
    KC(i,15,k)=KirisKordXY(i,5,k)-hk(i,1,k)/2;
    
    KC(i,16,k)=KirisKordXY(i,3,k);
    KC(i,17,k)=KirisKordXY(i,4,k)+bk(i,1,k)/2;
    KC(i,18,k)=KirisKordXY(i,5,k)-hk(i,1,k)/2;
    
    KC(i,19,k)=KirisKordXY(i,3,k);
    KC(i,20,k)=KirisKordXY(i,4,k)-bk(i,1,k)/2;
    KC(i,21,k)=KirisKordXY(i,5,k)+hk(i,1,k)/2;
    
    KC(i,22,k)=KirisKordXY(i,3,k);
    KC(i,23,k)=KirisKordXY(i,4,k)+bk(i,1,k)/2;
    KC(i,24,k)=KirisKordXY(i,5,k)+hk(i,1,k)/2;
    
    patch([KC(i,1,k) KC(i,4,k) KC(i,10,k) KC(i,7,k)],[KC(i,2,k) KC(i,5,k) KC(i,11,k) KC(i,8,k)],[KC(i,3,k) KC(i,6,k) KC(i,12,k) KC(i,9,k)],'red');
    patch([KC(i,13,k) KC(i,16,k) KC(i,22,k) KC(i,19,k)],[KC(i,14,k) KC(i,17,k) KC(i,23,k) KC(i,20,k)],[KC(i,15,k) KC(i,18,k) KC(i,24,k) KC(i,21,k)],'red');
    patch([KC(i,4,k) KC(i,16,k) KC(i,22,k) KC(i,10,k)],[KC(i,5,k) KC(i,17,k) KC(i,23,k) KC(i,11,k)],[KC(i,6,k) KC(i,18,k) KC(i,24,k) KC(i,12,k)],'red');
    patch([KC(i,1,k) KC(i,13,k) KC(i,19,k) KC(i,7,k)],[KC(i,2,k) KC(i,14,k) KC(i,20,k) KC(i,8,k)],[KC(i,3,k) KC(i,15,k) KC(i,21,k) KC(i,9,k)],'red');
    patch([KC(i,7,k) KC(i,10,k) KC(i,22,k) KC(i,19,k)],[KC(i,8,k) KC(i,11,k) KC(i,23,k) KC(i,20,k)],[KC(i,9,k) KC(i,12,k) KC(i,24,k) KC(i,21,k)],'red');
    patch([KC(i,1,k) KC(i,4,k) KC(i,16,k) KC(i,13,k)],[KC(i,2,k) KC(i,5,k) KC(i,17,k) KC(i,14,k)],[KC(i,3,k) KC(i,6,k) KC(i,18,k) KC(i,15,k)],'red');
    alpha(0.3);
    
    % Alt ve Ust Donatýlarýn Çizimi
    DBX=KC(i,1,k)-10
    DBY=KC(i,2,k)+dus
    DBZ=KC(i,3,k)+dus
    DSX=KC(i,13,k)+10
    DSY=KC(i,14,k)+dus
    DSZ=KC(i,15,k)+dus
    [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,1,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    
    DBX=KC(i,4,k)-10
    DBY=KC(i,5,k)-dus
    DBZ=KC(i,6,k)+dus
    DSX=KC(i,16,k)+10
    DSY=KC(i,17,k)-dus
    DSZ=KC(i,18,k)+dus
    [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,1,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    
    DBX=KC(i,7,k)-10
    DBY=KC(i,8,k)+dus
    DBZ=KC(i,9,k)-dus
    DSX=KC(i,19,k)+10
    DSY=KC(i,20,k)+dus
    DSZ=KC(i,21,k)-dus
    [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,1,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
   
    
    DBX=KC(i,10,k)-10
    DBY=KC(i,11,k)-dus
    DBZ=KC(i,12,k)-dus
    DSX=KC(i,22,k)+10
    DSY=KC(i,23,k)-dus
    DSZ=KC(i,24,k)-dus
    [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,1,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    
    UstAcikAralik=(bk(i,1,k)-2*dus)/(UstAcik+1)
    for j=1:1:UstAcik %>> Ust Aciklik Donatisinin Cizdirilmesi
        DBX=KC(i,10,k)-10
        DBY=KC(i,11,k)-dus-j*UstAcikAralik
        DBZ=KC(i,12,k)-dus
        DSX=KC(i,22,k)+10
        DSY=KC(i,23,k)-dus-j*UstAcikAralik
        DSZ=KC(i,24,k)-dus
        [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,1,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
        
    end
    
    AltAcikAralik=(bk(i,1,k)-2*dus)/(AltAcik+1)
    for j=1:1:AltAcik %>> Alt Aciklik Donatisinin Cizdirilmesi
        DBX=KC(i,4,k)-10
        DBY=KC(i,5,k)-dus-j*AltAcikAralik
        DBZ=KC(i,6,k)+dus
        DSX=KC(i,16,k)+10
        DSY=KC(i,17,k)-dus-j*AltAcikAralik
        DSZ=KC(i,18,k)+dus
        [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,1,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    end
    %% SaðÜst Mesnet Ek Donatisinin Cizdirilmesi
    SagEkDonati=SagUstM-UstAcik %>> SaðÜst Mesnet Ek Donatisinin Cizdirilmesi
    emin=max([2.5 fiKirisBoyCap(i,3,k)/10])
    DonSay=floor((bk(i,1,k)-2*dus)/emin)
    while ((bk(i,1,k)-2*dus)-(DonSay-1)*fiKirisBoyCap(i,1,k)/10)/(DonSay-1)<emin
        DonSay=DonSay-1
    end
    DonatiAralik=((bk(i,1,k)-2*dus))/(DonSay-1)
    DonKatSay=floor(SagEkDonati/DonSay)
    if DonKatSay==0
        DonKatSay=1
    end
    DonArtanSay=mod(SagEkDonati,DonSay)
    zdus=0
    for zdus=2*fiKirisBoyCap(i,3,k)/10:2*fiKirisBoyCap(i,3,k)/10:DonKatSay*2*fiKirisBoyCap(i,3,k)/10
    for j=0:1:DonSay-1 %>> SaðÜst Mesnet Ek Donatisinin Cizdirilmesi
        DBX=KC(i,22,k)+10
        DBY=KC(i,23,k)-dus-j*DonatiAralik
        DBZ=KC(i,24,k)-dus-zdus
        DSX=KC(i,22,k)-n-10
        DSY=KC(i,11,k)-dus-j*DonatiAralik
        DSZ=KC(i,12,k)-dus-zdus
        [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,3,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    end
    end
    zdus=zdus+2*fiKirisBoyCap(i,3,k)/10
    DonatiAralik=((bk(i,1,k)-2*dus))/(DonArtanSay-1)
    for j=0:1:DonArtanSay-1 %>> SaðÜst Mesnet Ek Donatisinin Cizdirilmesi
        DBX=KC(i,22,k)+10
        DBY=KC(i,23,k)-dus-j*DonatiAralik
        DBZ=KC(i,24,k)-dus-zdus
        DSX=KC(i,22,k)-n-10
        DSY=KC(i,11,k)-dus-j*DonatiAralik
        DSZ=KC(i,12,k)-dus-zdus
        [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,3,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    end
    
    %% Sol Üst Mesnet Ek Donatisinin Cizdirilmesi
    SolEkDonati=SolUstM-UstAcik %>> SolÜst Mesnet Ek Donatisinin Cizdirilmesi
    emin=max([2.5 fiKirisBoyCap(i,1,k)/10])
    DonSay=floor((bk(i,1,k)-2*dus)/emin)
    while ((bk(i,1,k)-2*dus)-(DonSay-1)*fiKirisBoyCap(i,1,k)/10)/(DonSay-1)<emin
        DonSay=DonSay-1
    end
    DonatiAralik=((bk(i,1,k)-2*dus))/(DonSay-1)
    DonKatSay=floor(SolEkDonati/DonSay)
    if DonKatSay==0
        DonKatSay=1
    end
    DonArtanSay=mod(SolEkDonati,DonSay)
    zdus=0
    for zdus=2*fiKirisBoyCap(i,1,k)/10:2*fiKirisBoyCap(i,1,k)/10:DonKatSay*2*fiKirisBoyCap(i,1,k)/10
    for j=0:1:DonSay-1 %>> SolÜst Mesnet Ek Donatisinin Cizdirilmesi
        DBX=KC(i,10,k)+n+10
        DBY=KC(i,11,k)-dus-j*DonatiAralik
        DBZ=KC(i,12,k)-dus-zdus
        DSX=KC(i,10,k)-10
        DSY=KC(i,23,k)-dus-j*DonatiAralik
        DSZ=KC(i,24,k)-dus-zdus
        [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,1,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    end
    end
    zdus=zdus+2*fiKirisBoyCap(i,1,k)/10
    DonatiAralik=((bk(i,1,k)-2*dus))/(DonArtanSay-1)
    for j=0:1:DonArtanSay-1 %>> SolÜst Mesnet Ek Donatisinin Cizdirilmesi
        DBX=KC(i,10,k)+n+10
        DBY=KC(i,11,k)-dus-j*DonatiAralik
        DBZ=KC(i,12,k)-dus-zdus
        DSX=KC(i,10,k)-10
        DSY=KC(i,23,k)-dus-j*DonatiAralik
        DSZ=KC(i,24,k)-dus-zdus
        [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,1,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    end
    %% Sol Alt Mesnet Donatýlarýnýn Çizidirilmesi
    
    SolEkDonati=SolAltM-UstAcik %>> SolAlt Mesnet Ek Donatisinin Cizdirilmesi
    emin=max([2.5 fiKirisBoyCap(i,4,k)/10])
    DonSay=floor((bk(i,1,k)-2*dus)/emin)
    while ((bk(i,1,k)-2*dus)-(DonSay-1)*fiKirisBoyCap(i,1,k)/10)/(DonSay-1)<emin
        DonSay=DonSay-1
    end
    DonatiAralik=((bk(i,1,k)-2*dus))/(DonSay-1)
    DonKatSay=floor(SolEkDonati/DonSay)
    if DonKatSay==0
        DonKatSay=1
    end
    DonArtanSay=mod(SolEkDonati,DonSay)
    zdus=0
    for zdus=2*fiKirisBoyCap(i,4,k)/10:2*fiKirisBoyCap(i,4,k)/10:DonKatSay*2*fiKirisBoyCap(i,4,k)/10
    for j=0:1:DonSay-1 %>> SolAlt Mesnet Ek Donatisinin Cizdirilmesi
        DBX=KC(i,4,k)+n+10
        DBY=KC(i,5,k)-dus-j*DonatiAralik
        DBZ=KC(i,6,k)+dus+zdus
        DSX=KC(i,4,k)-10
        DSY=KC(i,17,k)-dus-j*DonatiAralik
        DSZ=KC(i,18,k)+dus+zdus
        [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,4,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    end
    end
    zdus=zdus+2*fiKirisBoyCap(i,4,k)/10
    DonatiAralik=((bk(i,1,k)-2*dus))/(DonArtanSay-1)
    for j=0:1:DonArtanSay-1 %>> SolAlt Mesnet Ek Donatisinin Cizdirilmesi
        DBX=KC(i,4,k)+n+10
        DBY=KC(i,5,k)-dus-j*DonatiAralik
        DBZ=KC(i,6,k)+dus+zdus
        DSX=KC(i,4,k)-10
        DSY=KC(i,17,k)-dus-j*DonatiAralik
        DSZ=KC(i,18,k)+dus+zdus
        [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,4,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    end
    
    %% Sað Alt Mesnet Donatýlarýnýn Çizidirilmesi
    
    SolEkDonati=SagAltM-UstAcik %>> SaðAlt Mesnet Ek Donatisinin Cizdirilmesi
    emin=max([2.5 fiKirisBoyCap(i,6,k)/10])
    DonSay=floor((bk(i,1,k)-2*dus)/emin)
    while ((bk(i,1,k)-2*dus)-(DonSay-1)*fiKirisBoyCap(i,1,k)/10)/(DonSay-1)<emin
        DonSay=DonSay-1
    end
    DonatiAralik=((bk(i,1,k)-2*dus))/(DonSay-1)
    DonKatSay=floor(SolEkDonati/DonSay)
    if DonKatSay==0
        DonKatSay=1
    end
    DonArtanSay=mod(SolEkDonati,DonSay)
    zdus=0
    for zdus=2*fiKirisBoyCap(i,6,k)/10:2*fiKirisBoyCap(i,6,k)/10:DonKatSay*2*fiKirisBoyCap(i,6,k)/10
    for j=0:1:DonSay-1 %>> SaðAlt Mesnet Ek Donatisinin Cizdirilmesi
        DBX=KC(i,16,k)-n-10
        DBY=KC(i,17,k)-dus-j*DonatiAralik
        DBZ=KC(i,18,k)+dus+zdus
        DSX=KC(i,16,k)+10
        DSY=KC(i,5,k)-dus-j*DonatiAralik
        DSZ=KC(i,6,k)+dus+zdus
        [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,6,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    end
    end
    zdus=zdus+2*fiKirisBoyCap(i,6,k)/10
    DonatiAralik=((bk(i,1,k)-2*dus))/(DonArtanSay-1)
    for j=0:1:DonArtanSay-1 %>> SaðAlt Mesnet Ek Donatisinin Cizdirilmesi
        DBX=KC(i,16,k)-n-10
        DBY=KC(i,17,k)-dus-j*DonatiAralik
        DBZ=KC(i,18,k)+dus+zdus
        DSX=KC(i,16,k)+10
        DSY=KC(i,5,k)-dus-j*DonatiAralik
        DSZ=KC(i,6,k)+dus+zdus
        [X,Y,Z]=cylinder2P(fiKirisBoyCap(i,6,k)/20,10,[DBX DBY DBZ],[DSX DSY DSZ]);surf(X,Y,Z);
    end
    
    %% Kiriþ Etriyelerinin Çizimi
    Bas=[0 KirEtSarilmaUz(i,1,k) KirEtSarilmaUz(i,1,k)+(KirisUz(i,1,k)-2*KirEtSarilmaUz(i,1,k))]
    Son=[Bas(1)+KirEtSarilmaUz(i,1,k) Bas(2)+(KirisUz(i,1,k)-2*KirEtSarilmaUz(i,1,k)) Bas(3)+KirEtSarilmaUz(i,1,k)]
    Art=[KirEtAralikMin(i,1,k) KirEtAralikMin(i,2,k) KirEtAralikMin(i,1,k)]
    
    for ji=1:3
    for j=Bas(ji):Art(ji):Son(ji)
        
    EtEksn=dus-max(fiKirisBoyCap(i,:,k)/20)-fiKirEt/20
    EB1=KC(i,1,k)+j
    EB2=KC(i,2,k)+EtEksn
    EB3=KC(i,3,k)+EtEksn
    EB4=KC(i,4,k)+j
    EB5=KC(i,5,k)-EtEksn
    EB6=KC(i,6,k)+EtEksn
    EB7=KC(i,7,k)+j
    EB8=KC(i,8,k)+EtEksn
    EB9=KC(i,9,k)-EtEksn
    EB10=KC(i,10,k)+j
    EB11=KC(i,11,k)-EtEksn
    EB12=KC(i,12,k)-EtEksn
    [X,Y,Z]=cylinder2P(fiKirEt/20,10,[EB1 EB2 EB3],[EB4 EB5 EB6]);surf(X,Y,Z);
    [X,Y,Z]=cylinder2P(fiKirEt/20,10,[EB4 EB5 EB6],[EB10 EB11 EB12]);surf(X,Y,Z);
    [X,Y,Z]=cylinder2P(fiKirEt/20,10,[EB1 EB2 EB3],[EB7 EB8 EB9]);surf(X,Y,Z);
    [X,Y,Z]=cylinder2P(fiKirEt/20,10,[EB7 EB8 EB9],[EB10 EB11 EB12]);surf(X,Y,Z);
    
    end
    end
        end
    end
            
        end
end
    
end
