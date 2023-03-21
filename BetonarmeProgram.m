clear all, close all,  clc;



[~,Katlar]=xlsfinfo('Kat.xlsx');
for k=1:numel(Katlar);
  [~,Kat(:,:,k)]=xlsread('Kat.xlsx',Katlar{k});
  KatKord(:,:,k)=xlsread('Kat.xlsx',Katlar{k});
end

z=length(Kat(1,1,:));
x=length(Kat(1,:,1));
y=length(Kat(:,1,1));

KatYuksek(1:z,1)=3;
TuglaBirAg=6;
TuglaKal=0.19;
SivaBirAg=2;
SivaKal=0.02;
GKomb=1.4;
fck=30;
fcd=fck/1.5;
fctd=0.35*sqrt(fck)/1.5;
fyk=420;
fyd=fyk/1.15;
fiDos=8; %[mm] Cinsinden Dosemede Kullanýlacak Donatý Çapý
fiDosAlan=(pi()*fiDos^2)/4;
fiKirEt=8
fiKolEt=8
fiKirBoy=14
fiTemBoy=16

nq=0.3; %>>Hareketli yük katýlým katsayýsý
EC30=32*10^6;

SD1=0.357;
SDS=1.067;
TA=0.2*SD1/SDS;
TB=SD1/SDS;
TL=6;
R=8;
D=3;
I=1;

%% Kolon Koordinat Atamasý
for k=1:1:z
for i=1:2:y;
    for j=1:2:x;
        KatYuksek(k,2)=sum(KatYuksek(1:k));
        if isempty(Kat{i,j,k})==0;
            KolonNum=mod(str2double(cell2mat(regexp(Kat{i,j},'\d*','Match'))),100);
KolonKord(KolonNum,1,k)=KatKord(1,j+1,k);
KolonKord(KolonNum,2,k)=KatKord(i+1,1,k);

        end
    end
end
end


A=zeros(y+4,x+4,z);
Katv2(:,:,1:z)=arrayfun(@num2str,A,'un',0);

Katv2(3:y+2,3:x+2,1:z)=Kat(1:y,1:x,1:z);

for k=1:1:z;
for i=3:1:y+2;
    for j=3:1:x+2;
if strcmp(Katv2(i,j,k),'');
            Katv2(i,j,k)={'0'};
        end
    end
end
end

%% Kiriþ Koordinat Atamasý
for k=1:1:z;
for i=3:1:y+2;
    for j=3:1:x+2;
        Kir=cell2mat(Katv2(i,j,k));
        
        if strcmp(Kir(1,1),'k')==1;
    
    Ust=cell2mat(Katv2(i-1,j,k));
    Alt=cell2mat(Katv2(i+1,j,k));
    Sol=cell2mat(Katv2(i,j-1,k));
    Sag=cell2mat(Katv2(i,j+1,k));
    if strcmp('s',Ust(1,1))==1 && strcmp('s',Alt(1,1))==1;
        u=mod(str2num(cell2mat(regexp(Katv2{i-1,j,k},'\d*','Match'))),100);
        a=mod(str2num(cell2mat(regexp(Katv2{i+1,j,k},'\d*','Match'))),100);
        KirisNum=mod(str2num(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
        
        KirisKordXY(KirisNum,1,k)=KolonKord(u,1,k);
        KirisKordXY(KirisNum,2,k)=KolonKord(u,2,k);
        KirisKordXY(KirisNum,3,k)=KolonKord(a,1,k);
        KirisKordXY(KirisNum,4,k)=KolonKord(a,2,k);
        KirisKordXY(KirisNum,5,k)=KatYuksek(k,1)*100;
        
        KirisKordYZ(KirisNum,1,k)=KirisKordXY(KirisNum,2,k)/100;
        KirisKordYZ(KirisNum,3,k)=KirisKordXY(KirisNum,4,k)/100;
        KirisKordYZ(KirisNum,2,k)=KatYuksek(k,2);
        KirisKordYZ(KirisNum,4,k)=KatYuksek(k,2);
        
        YZKirisleriKord(KirisNum,1,k)=KolonKord(a,1,k);
        YZKirisleriKord(KirisNum,2,k)=KolonKord(a,2,k);
        YZKirisleriKord(KirisNum,3,k)=KolonKord(u,1,k);
        YZKirisleriKord(KirisNum,4,k)=KolonKord(u,2,k);
        YZKirisleriKord(KirisNum,5,k)=KatYuksek(k,2)*100;
        
    else
        sa=mod(str2num(cell2mat(regexp(Katv2{i,j+1,k},'\d*','Match'))),100);
        so=mod(str2num(cell2mat(regexp(Katv2{i,j-1,k},'\d*','Match'))),100);
        KirisNum=mod(str2num(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
        
        KirisKordXY(KirisNum,1,k)=KolonKord(so,1,k);
        KirisKordXY(KirisNum,2,k)=KolonKord(so,2,k);
        KirisKordXY(KirisNum,3,k)=KolonKord(sa,1,k);
        KirisKordXY(KirisNum,4,k)=KolonKord(sa,2,k);
        KirisKordXY(KirisNum,5,k)=KatYuksek(k,1)*100
        
        KirisKordXZ(KirisNum,1,k)=KirisKordXY(KirisNum,1,k)/100;
        KirisKordXZ(KirisNum,3,k)=KirisKordXY(KirisNum,3,k)/100;
        KirisKordXZ(KirisNum,2,k)=KatYuksek(k,2);
        KirisKordXZ(KirisNum,4,k)=KatYuksek(k,2);
    end
        end
    end
end
end

%% Kiris Uzunluk Atamasý


for k=1:1:z;
for i=1:1:length(KirisKordXY(:,1,k));
    KirisUz(i,:,k)=sqrt((KirisKordXY(i,3,k)-KirisKordXY(i,1,k))^2+(KirisKordXY(i,2,k)-KirisKordXY(i,4,k))^2);
end
end

%% Doseme Koordinat ve Alan Atamasý
for k=1:1:z;
for i=3:1:y+2;
    for j=3:1:x+2;
        
    Dos=cell2mat(Katv2(i,j,k));
    if strcmp(Dos(1,1),'d')==1;
        
        SolUst=mod(str2double(cell2mat(regexp(Katv2{i-1,j-1,k},'\d*','Match'))),100);
        SagUst=mod(str2double(cell2mat(regexp(Katv2{i-1,j+1,k},'\d*','Match'))),100);
        SolAlt=mod(str2double(cell2mat(regexp(Katv2{i+1,j-1,k},'\d*','Match'))),100);
        SagAlt=mod(str2double(cell2mat(regexp(Katv2{i+1,j+1,k},'\d*','Match'))),100);
        
        DosNum=mod(str2double(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
        
        DosKord(DosNum,1,k)=KolonKord(SolUst,1,k);
        DosKord(DosNum,2,k)=KolonKord(SolUst,2,k);
        DosKord(DosNum,3,k)=KolonKord(SagUst,1,k);
        DosKord(DosNum,4,k)=KolonKord(SagUst,2,k);
        DosKord(DosNum,5,k)=KolonKord(SolAlt,1,k);
        DosKord(DosNum,6,k)=KolonKord(SolAlt,2,k);
        DosKord(DosNum,7,k)=KolonKord(SagAlt,1,k);
        DosKord(DosNum,8,k)=KolonKord(SagAlt,2,k);
        
        Kirisx=mod(str2num(cell2mat(regexp(Katv2{i+1,j,k},'\d*','Match'))),100);
        Kirisy=mod(str2num(cell2mat(regexp(Katv2{i,j+1,k},'\d*','Match'))),100);
        
        DosemeUz(DosNum,1,k)=KirisUz(Kirisx,1,k);
        DosemeUz(DosNum,2,k)=KirisUz(Kirisy,1,k);
          
    end
    end
end


for i=1:1:length(DosKord(:,1,k));
    
    AlanHes(1,1)=DosKord(i,1,k);
    AlanHes(1,2)=DosKord(i,2,k);
    AlanHes(2,1)=DosKord(i,3,k);
    AlanHes(2,2)=DosKord(i,4,k);
    AlanHes(3,1)=DosKord(i,7,k);
    AlanHes(3,2)=DosKord(i,8,k);
    AlanHes(4,1)=DosKord(i,5,k);
    AlanHes(4,2)=DosKord(i,6,k);
    
    DosAlan(i,1,k)=((AlanHes(1,1)*AlanHes(2,2)+AlanHes(2,1)*AlanHes(3,2)+AlanHes(3,1)*AlanHes(4,2)+AlanHes(4,1)*AlanHes(1,2))-(AlanHes(1,1)*AlanHes(4,2)+AlanHes(4,1)*AlanHes(3,2)+AlanHes(3,1)*AlanHes(2,2)+AlanHes(2,1)*AlanHes(1,2)))/20000;
    
end
end
%% Kiris Ön Boyutlandýrma (Minimum Kiris Yükekliði (hkmin)
KirisSay(1,1:z)=0;
for k=1:1:z;
for i=3:1:y+2;
    for j=3:1:x+2;
        Kir=cell2mat(Katv2(i,j,k));
        
        if strcmp(Kir(1,1),'k')==1;
            KirisSay(1,k)=KirisSay(1,k)+1;
            
            ikiUst=cell2mat(Katv2(i-2,j,k));
            ikiAlt=cell2mat(Katv2(i+2,j,k));
            ikiSol=cell2mat(Katv2(i,j-2,k));
            ikiSag=cell2mat(Katv2(i,j+2,k));
            
            birUst=cell2mat(Katv2(i-1,j,k));
            birAlt=cell2mat(Katv2(i+1,j,k));
            birSol=cell2mat(Katv2(i,j-1,k));
            birSag=cell2mat(Katv2(i,j+1,k));
            
            KirisNum=mod(str2num(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
            
            bk(KirisNum,1,k)=25
            
        if strcmp('s',birUst(1,1))==1 && strcmp('s',birAlt(1,1))==1;       
                
            if strcmp('k',ikiUst(1,1))==1 && strcmp('k',ikiAlt(1,1))==1;
            hk(KirisNum,1,k)=KirisUz(KirisNum,1,k)/15;
            lp(KirisNum,1,k)=0.6*KirisUz(KirisNum,1,k)/100;
            
                else if (strcmp('k',ikiUst(1,1))==1 && strcmp('k',ikiAlt(1,1))==0)||(strcmp('k',ikiUst(1,1))==0 && strcmp('k',ikiAlt(1,1))==1);
                hk(KirisNum,1,k)=KirisUz(KirisNum,1,k)/12;
                lp(KirisNum,1,k)=0.8*KirisUz(KirisNum,1,k)/100;
                            
                    else if strcmp('k',ikiUst(1,1))==0 && strcmp('k',ikiAlt(1,1))==0;
                    hk(KirisNum,1,k)=KirisUz(KirisNum,1,k)/10;
                    lp(KirisNum,1,k)=KirisUz(KirisNum,1,k)/100;
                        end
                        end
            end
            
        else if strcmp('s',birSol(1,1))==1 && strcmp('s',birSag(1,1))==1;
            
             if strcmp('k',ikiSol(1,1))==1 && strcmp('k',ikiSag(1,1))==1;
            hk(KirisNum,1,k)=KirisUz(KirisNum,1,k)/15;
            lp(KirisNum,1,k)=0.6*KirisUz(KirisNum,1,k)/100;
            
                else if (strcmp('k',ikiSol(1,1))==1 && strcmp('k',ikiSag(1,1))==0)||(strcmp('k',ikiSol(1,1))==0 && strcmp('k',ikiSag(1,1))==1);
                hk(KirisNum,1,k)=KirisUz(KirisNum,1,k)/12;
                lp(KirisNum,1,k)=0.8*KirisUz(KirisNum,1,k)/100;
                
            
                    else if strcmp('k',ikiSol(1,1))==0 && strcmp('k',ikiSag(1,1))==0;
                    hk(KirisNum,1,k)=KirisUz(KirisNum,1,k)/10;
                    lp(KirisNum,1,k)=KirisUz(KirisNum,1,k)/100;
                        end
                    end
            end
                        
                end
            end
   
        end
    end
end
end
    


for i=1:1:length(hk(:,1,1));
    for k=1:1:z;
        if  hk(i,1,k)<30;
            hk(i,1,k)=30;
        end
    end
end


hkmin(1:z,1)=5*ceil(max(hk(:,:,1:z))/5);



%% Döþeme Ön Boyutlandýrma (hfmin)

for k=1:1:z;
for i=3:1:y+2;
    for j=3:1:x+2;
        Dos=cell2mat(Katv2(i,j,k));
        if strcmp(Dos(1,1),'d')==1;
            UstD=cell2mat(Katv2(i-2,j,k));
            AltD=cell2mat(Katv2(i+2,j,k));
            SolD=cell2mat(Katv2(i,j-2,k));
            SagD=cell2mat(Katv2(i,j+2,k));
            DosNum=mod(str2num(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
            
        if (DosemeUz(DosNum,1,k)/DosemeUz(DosNum,2,k)>=2 || DosemeUz(DosNum,2,k)/DosemeUz(DosNum,1,k)>=2);
        
            if DosemeUz(DosNum,1,k)>DosemeUz(DosNum,2,k);
                
            if strcmp('d',UstD(1,1))==1 && strcmp('d',AltD(1,1))==1;
            hf(DosNum,1,k)=DosemeUz(DosNum,2,k)/30;
            
            
                else if (strcmp('d',UstD(1,1))==1 && strcmp('d',AltD(1,1))==0)||(strcmp('d',UstD(1,1))==0 && strcmp('d',AltD(1,1))==1);
                hf(DosNum,1,k)=DosemeUz(DosNum,2,k)/25;
                
                            
                    else if strcmp('d',UstD(1,1))==0 && strcmp('d',AltD(1,1))==0;
                    hf(DosNum,1,k)=DosemeUz(DosNum,2,k)/20;
                    
                        end
                    end
            end
            else
                
                if strcmp('d',SolD(1,1))==1 && strcmp('d',SagD(1,1))==1;
            hf(DosNum,1,k)=DosemeUz(DosNum,1,k)/30;
            
            
                else if (strcmp('d',SolD(1,1))==1 && strcmp('d',SagD(1,1))==0)||(strcmp('d',SolD(1,1))==0 && strcmp('d',SagD(1,1))==1);
                hf(DosNum,1,k)=DosemeUz(DosNum,1,k)/25;
                
                            
                    else if strcmp('d',SolD(1,1))==0 && strcmp('d',SagD(1,1))==0;
                    hf(DosNum,1,k)=DosemeUz(DosNum,1,k)/20;
                    
                        end
                    end
                end
            end
        else
            
            if DosemeUz(DosNum,1,k)>=DosemeUz(DosNum,2,k);
                
            if strcmp('d',UstD(1,1))==1 && strcmp('d',AltD(1,1))==1,
            hf(DosNum,1,k)=DosemeUz(DosNum,2,k)/35;
            
                else if (strcmp('d',UstD(1,1))==1 && strcmp('d',AltD(1,1))==0)||(strcmp('d',UstD(1,1))==0 && strcmp('d',AltD(1,1))==1);
                hf(DosNum,1,k)=DosemeUz(DosNum,2,k)/30;
                
                    else if strcmp('d',UstD(1,1))==0 && strcmp('d',AltD(1,1))==0;
                    hf(DosNum,1,k)=DosemeUz(DosNum,2,k)/25;
                    
                        end
                    end
            end
            else
                
                if strcmp('d',SolD(1,1))==1 && strcmp('d',SagD(1,1))==1;
            hf(DosNum,1,k)=DosemeUz(DosNum,1,k)/35;
            
                else if (strcmp('d',SolD(1,1))==1 && strcmp('d',SagD(1,1))==0)||(strcmp('d',SolD(1,1))==0 && strcmp('d',SagD(1,1))==1);
                hf(DosNum,1,k)=DosemeUz(DosNum,1,k)/30;
                            
                    else if strcmp('d',SolD(1,1))==0 && strcmp('d',SagD(1,1))==0;
                    hf(DosNum,1,k)=DosemeUz(DosNum,1,k)/25;
                    
                        end
                    end
                end
            end
            
            
            
        end
        end
    end
                        
end
end

Xk=[0.50 0.59 0.67 0.74 0.79 0.83 0.86 0.89 0.91 0.92 0.94; %-->Ýki Doðrultuda Çalýþan Döþemelerde
    0.71 0.78 0.83 0.87 0.90 0.92 0.94 0.95 0.96 0.97 0.97; %Kýsa Kenar Doðrultusu Ýçin Yük Daðýtma
    0.28 0.36 0.45 0.53 0.60 0.66 0.72 0.77 0.80 0.83 0.86; %Kat Sayýsý (Xk)
    0.50 0.59 0.67 0.74 0.79 0.83 0.86 0.89 0.91 0.92 0.94;
    0.83 0.88 0.91 0.93 0.95 0.96 0.97 0.97 0.98 0.98 0.98;
    0.16 0.22 0.29 0.36 0.43 0.50 0.56 0.62 0.67 0.72 0.76;
    0.66 0.74 0.80 0.85 0.88 0.91 0.92 0.94 0.95 0.96 0.97;
    0.33 0.42 0.50 0.58 0.65 0.71 0.76 0.80 0.84 0.86 0.88;
    0.50 0.59 0.67 0.74 0.79 0.83 0.86 0.89 0.91 0.92 0.94];

MomentAlfa=[0.025 0.030 0.034 0.038 0.041 0.045 0.053 0.062 0.025; %-->Ýki Doðrultuda Çalýþan Döþemelerde
            0.033 0.040 0.045 0.050 0.054 0.059 0.071 0.083 0.033; % Moment Katsayýlarý (alfa)
            0 0 0 0 0 0 0 0 0;                                     %%-->1.50 1.75 2.0 þeklinde gidiyor mod alýrken hata var düzeltilmeli!
            0.031 0.035 0.040 0.043 0.046 0.049 0.056 0.064 0.031;
            0.041 0.047 0.053 0.057 0.061 0.065 0.075 0.085 0.041;
            0.016 0.018 0.020 0.022 0.023 0.025 0.028 0.032 0.016;
            0.037 0.042 0.047 0.050 0.053 0.055 0.062 0.068 0.037;
            0.049 0.056 0.062 0.066 0.070 0.073 0.082 0.090 0.049;
            0.019 0.021 0.024 0.025 0.027 0.028 0.031 0.034 0.019;
            0.044 0.053 0.060 0.065 0.068 0.071 0.077 0.080 0.044;
            0 0 0 0 0 0 0 0 0.056;
            0.022 0.027 0.030 0.033 0.034 0.036 0.039 0.040 0;
            0.044 0.046 0.049 0.051 0.053 0.055 0.058 0.060 0.044;
            0.056 0.061 0.065 0.069 0.071 0.073 0.077 0.080 0;
            0 0 0 0 0 0 0 0 0.022;
            0.044 0.049 0.054 0.058 0.061 0.064 0.069 0.074 0.044;
            0.058 0.065 0.071 0.077 0.081 0.085 0.092 0.098 0.058;
            0.022 0.025 0.027 0.029 0.031 0.032 0.035 0.037 0.022;
            0.050 0.057 0.062 0.067 0.071 0.075 0.081 0.083 0.050;
            0 0 0 0 0 0 0 0 0;
            0.025 0.029 0.031 0.034 0.036 0.038 0.041 0.042 0.025];
    
%% Çift Yönlü Döþeme Sürekli Kenar Uzunluklarý Hesaplama
DosSay(1:z,1)=0;

for k=1:1:z;        %---->Tüm Katlardaki Döþeme Sayýsýnýn Bulunmasý
for i=3:1:y+2;                
    for j=3:1:x+2;
        Dos=cell2mat(Katv2(i,j,k));
        if strcmp(Dos(1,1),'d')==1;
            
            DosSay(k,1)=DosSay(k,1)+1;
            SurekliKenX=zeros(DosSay(k,1),1,z);
            SurekliKenY=zeros(DosSay(k,1),1,z);
        end
        end
    end
end

for k=1:1:z;
for i=3:1:y+2;
    for j=3:1:x+2;
        Dos=cell2mat(Katv2(i,j,k));
        if strcmp(Dos(1,1),'d')==1;

            
            UstD=cell2mat(Katv2(i-2,j,k));
            AltD=cell2mat(Katv2(i+2,j,k));
            SolD=cell2mat(Katv2(i,j-2,k));
            SagD=cell2mat(Katv2(i,j+2,k));
            DosNum=mod(str2double(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
            
            m=max(DosemeUz(DosNum,1,k),DosemeUz(DosNum,2,k))/min(DosemeUz(DosNum,1,k),DosemeUz(DosNum,2,k));
            
            if m<2;
                if strcmp('d',UstD(1,1))==1 && strcmp('d',AltD(1,1))==1;
                    SurekliKenX(DosNum,1,k)=DosemeUz(DosNum,1,k)*2;
                    
                    SurLl=2;
                    
                    else if (strcmp('d',UstD(1,1))==1 && strcmp('d',AltD(1,1))==0)||(strcmp('d',UstD(1,1))==0 && strcmp('d',AltD(1,1))==1);
                        SurekliKenX(DosNum,1,k)=DosemeUz(DosNum,1,k);
                        SurLl=1;
                        else
                            SurLl=0;
                        
                        end
                end
                
                if strcmp('d',SolD(1,1))==1 && strcmp('d',SagD(1,1))==1;
                    SurekliKenY(DosNum,1,k)=DosemeUz(DosNum,2,k)*2;
                    SurLs=2;
                    
                    else if (strcmp('d',SolD(1,1))==1 && strcmp('d',SagD(1,1))==0)||(strcmp('d',SolD(1,1))==0 && strcmp('d',SagD(1,1))==1);
                        SurekliKenY(DosNum,1,k)=DosemeUz(DosNum,2,k);
                        SurLs=1;    
                        else
                            SurLs=0;
                        end
                end
                    if SurLl==0 && SurLs==0;           %%-->Sürekl Kenar Durumlarýna Göre Xk Katsayýsýnýn Bulunmasý
                        TabY=1;
                else if SurLl==0 && SurLs==1;
                        TabY=2;
                else if SurLl==1 && SurLs==0;
                        TabY=3;
                else if SurLl==1 && SurLs==1;
                        TabY=4;
                else if SurLl==0 && SurLs==2;
                        TabY=5;
                else if SurLl==2 && SurLs==0;
                        TabY=6;
                else if SurLl==1 && SurLs==2;
                        TabY=7;
                else if SurLl==2 && SurLs==1;
                        TabY=8;
                else if SurLl==2 && SurLs==2;
                        TabY=9;
                    end
                    end
                    end
                    end
                    end
                    end
                    end
                    end
                    end
                    TabX=mod(round(m,1),1)*10+1;
                    DosXk(DosNum,1,k)=Xk(TabY,TabX);
                    
            else 
                SurekliKenX(DosNum,1,k)=0;
                 SurekliKenY(DosNum,1,k)=0;
            end 
        end
    end
    end
end

            
alfas=(SurekliKenX+SurekliKenY).*((2*(DosemeUz(:,1,1:z)+DosemeUz(:,2,1:z))).^-1);

for k=1:1:z;
for i=3:1:y+2;
    for j=3:1:x+2;
        Dos=cell2mat(Katv2(i,j,k));
        if strcmp(Dos(1,1),'d')==1; 
            DosNum=mod(str2num(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
            m=max(DosemeUz(DosNum,1,k),DosemeUz(DosNum,2,k))/min(DosemeUz(DosNum,1,k),DosemeUz(DosNum,2,k));
        if m<2;
            hfas(DosNum,1,k)=min(DosemeUz(DosNum,1,k),DosemeUz(DosNum,2,k))/(15+20/m)*(1-alfas(DosNum,1,k)/4);
        end
        end
    end
end
end

hf(1:length(hfas(:,1,1:z)),2,1:z)=hfas(:,:,1:z);
hfmin(1:z,1)=ceil(max(max(hf(:,:,1:z)))); %Minimum Doseme Kalýnlýðý

GamaBeton=25;

DosG1=GamaBeton.*hfmin/100; %kN/m^2 Doseme Beton Aðýrlýðý
DosG2=1;                    %kN/m^2 Kaplama + Sýva Aðýrlýðý

DosQ1=2;                    %kn/m^2 Doseme Hareketli Yükü TS498

Pd=1.4*(DosG1+DosG2)+1.6*DosQ1;


%% Kolon Ön Boyutlandýrma 


for k=1:1:z;
    for i=3:1:y+2;
        for j=3:1:x+2;
            Kol=cell2mat(Katv2(i,j,k));
        if strcmp(Kol(1,1),'s')==1;
        
        KolonNum=mod(str2double(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
        KolDosYuk(KolonNum,1,k)=0;
        for a=-1:2:1;    %Dosemelerden Kolonlara Gelen Yüklerin Hesabý
            for b=-1:2:1;
                Dos=cell2mat(Katv2(i+a,j+b,k));
                if strcmp(Dos(1,1),'d')==1;
                    DosNum=mod(str2double(cell2mat(regexp(Katv2{i+a,j+b,k},'\d*','Match'))),100);
                 KolDosYuk(KolonNum,1,k)=KolDosYuk(KolonNum,1,k)+(DosemeUz(DosNum,1,k)/200)*(DosemeUz(DosNum,2,k)/200)*Pd(k,1);
            end
            end
        end
        
        KolKirYuk(KolonNum,1,k)=0;
        KolDuvYuk(KolonNum,1,k)=0;
        
        for a=-1:2:1    %Kiriþlerden Kolonlara Gelen Yüklerin Hesabý
           KirisY=cell2mat(Katv2(i+a,j,k));
            if strcmp(KirisY(1,1),'k')==1;
               KirisNumY=mod(str2double(cell2mat(regexp(Katv2{i+a,j,k},'\d*','Match'))),100);
                    KolKirYuk(KolonNum,1,k)=KolKirYuk(KolonNum,1,k)+(KirisUz(KirisNumY,1,k)/200)*GamaBeton*hk(KirisNumY,1,z)/100*min(bk(:))/100*GKomb;
                    KolDuvYuk(KolonNum,1,k)=KolDuvYuk(KolonNum,1,k)+(KirisUz(KirisNumY,1,k)/200)*(KatYuksek(z,1)-hk(KirisNumY,1)/100)*(TuglaBirAg*TuglaKal+SivaBirAg*2*SivaKal)*GKomb;    
            end
        end
            for b=-1:2:1;
                KirisX=cell2mat(Katv2(i,j+b,k));
                if strcmp(KirisX(1,1),'k')==1;
                    KirisNumX=mod(str2double(cell2mat(regexp(Katv2{i,j+b,k},'\d*','Match'))),100);
                    KolKirYuk(KolonNum,1,k)=KolKirYuk(KolonNum,1,k)+(KirisUz(KirisNumX,1,k)/200)*GamaBeton*hk(KirisNumX,1,z)/100*min(bk(:))/100*GKomb; 
                    KolDuvYuk(KolonNum,1,k)=KolDuvYuk(KolonNum,1,k)+(KirisUz(KirisNumX,1,k)/200)*(KatYuksek(z,1)-hk(KirisNumX,1)/100)*(TuglaBirAg*TuglaKal+SivaBirAg*2*SivaKal)*GKomb;
                end
            end
            end
        end
    end
end

%Kolonlarýn ÖnBoyutlandýrýlmasý --> KESÝT ATAMASI

for k=z:-1:1;
    for i=3:1:y+2;
        for j=3:1:x+2;
            Kol=cell2mat(Katv2(i,j,k));
        if strcmp(Kol(1,1),'s')==1;
            KolonNum=mod(str2double(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
            KolKatYuk(KolonNum,1,k)=KolDosYuk(KolonNum,1,k)+KolKirYuk(KolonNum,1,k)+KolDuvYuk(KolonNum,1,k);
           
            KolTopYuk(KolonNum,1,z+1)=0;
            KolTopYuk(KolonNum,1,k)=KolTopYuk(KolonNum,1,k+1)+KolKatYuk(KolonNum,1,k);
            
            KolKesitAlan(KolonNum,1,k)=(10000*ceil((KolTopYuk(KolonNum,1,k)*1000)/(0.4*fck*10000)));
            if KolKesitAlan(KolonNum,1,k)<180000;
            KolKesitAlan(KolonNum,1,k)=180000;
            end
            KolAgirlik(KolonNum,1,k)=KolKesitAlan(KolonNum,1,k)*KatYuksek(k,1)*(10^-6)*GamaBeton;
            KolTopYuk(KolonNum,1,k)=KolTopYuk(KolonNum,1,k)+KolAgirlik(KolonNum,1,k);
            
            KolKesitAlan(KolonNum,1,k)=(10000*ceil((KolTopYuk(KolonNum,1,k)*1000)/(0.4*fck*10000)));
            if KolKesitAlan(KolonNum,1,k)<180000;
            KolKesitAlan(KolonNum,1,k)=180000;
            end
            KolonKesit(KolonNum,1,k)=50*ceil(sqrt(KolKesitAlan(KolonNum,1,k))/50);
            KolonKesit(KolonNum,2,k)=50*ceil(sqrt(KolKesitAlan(KolonNum,1,k))/50);
            KolonAtalet(KolonNum,1,k)=(KolonKesit(KolonNum,1,k)*(KolonKesit(KolonNum,2,k)^3))/12;
            KolonAtalet(KolonNum,2,k)=(KolonKesit(KolonNum,2,k)*(KolonKesit(KolonNum,1,k)^3))/12;
        end
        end
    end
end

%% DOSEME HESAPLARI

for k=1:1:z %---> DÖÞEME KESME KONTROLÜ
for i=3:1:y+2
    for j=3:1:x+2
        Dos=cell2mat(Katv2(i,j,k));
        if strcmp(Dos(1,1),'d')==1 
            DosNum=mod(str2num(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
            m=max(DosemeUz(DosNum,1,k),DosemeUz(DosNum,2,k))/min(DosemeUz(DosNum,1,k),DosemeUz(DosNum,2,k));
            if m<2
                    dDos(DosNum,1,k)=(max(hf(DosNum,:,k))-1.5-fiDos/20)/100;
                    dDos(DosNum,2,k)=(max(hf(DosNum,:,k))-1.5-fiDos/20-fiDos/10)/100;
                    DosXk(DosNum,1,k);
                    DosVd(DosNum,1,k)=DosXk(DosNum,1,k)*Pd(k,1)*(0.5*(min(DosemeUz(DosNum,1,k),DosemeUz(DosNum,2,k))/100)-dDos(DosNum,1,k));
                    DosVcr(DosNum,1,k)=0.65*fctd*1000*1*dDos(DosNum,1,k);
                    if DosVd > DosVcr
                        fprintf('d1%d Döþememesinde Vd>Vcr!',DosNum);
                    end
            end
        end
    end
end
end


for k=1:1:z %---> DÖÞEME Moment Katsayýlarýnýn Bulunmasý (alfa)
for i=3:1:y+2;
    for j=3:1:x+2;
        Dos=cell2mat(Katv2(i,j,k));
        if strcmp(Dos(1,1),'d')==1;

            UstD=cell2mat(Katv2(i-2,j,k));
            AltD=cell2mat(Katv2(i+2,j,k));
            SolD=cell2mat(Katv2(i,j-2,k));
            SagD=cell2mat(Katv2(i,j+2,k));
            
            DosNum=mod(str2double(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
            
            m=max(DosemeUz(DosNum,1,k),DosemeUz(DosNum,2,k))/min(DosemeUz(DosNum,1,k),DosemeUz(DosNum,2,k));
            
            if m<2;
                if DosemeUz(DosNum,1,k)>=DosemeUz(DosNum,2,k);              
                if strcmp('d',UstD(1,1))==1 && strcmp('d',AltD(1,1))==1;
                    SurLl=2;
                    else if ((strcmp('d',UstD(1,1))==1 && strcmp('d',AltD(1,1))==0)||(strcmp('d',UstD(1,1))==0 && strcmp('d',AltD(1,1))==1));
                        SurLl=1;
                        else
                            SurLl=0;
                        end
                end
                if strcmp('d',SolD(1,1))==1 && strcmp('d',SagD(1,1))==1;
                    SurLs=2;
                    else if ((strcmp('d',SolD(1,1))==1 && strcmp('d',SagD(1,1))==0)||(strcmp('d',SolD(1,1))==0 && strcmp('d',SagD(1,1))==1));
                        SurLs=1;    
                        else
                            SurLs=0;
                        end
                end
                
            else if DosemeUz(DosNum,2,k)>DosemeUz(DosNum,1,k);                    
                if strcmp('d',UstD(1,1))==1 && strcmp('d',AltD(1,1))==1;
                    SurLs=2;
                    else if ((strcmp('d',UstD(1,1))==1 && strcmp('d',AltD(1,1))==0)||(strcmp('d',UstD(1,1))==0 && strcmp('d',AltD(1,1))==1));
                        SurLs=1;
                        else
                            SurLs=0;
                        end
                end
                if strcmp('d',SolD(1,1))==1 && strcmp('d',SagD(1,1))==1;
                    SurLl=2;
                    else if ((strcmp('d',SolD(1,1))==1 && strcmp('d',SagD(1,1))==0)||(strcmp('d',SolD(1,1))==0 && strcmp('d',SagD(1,1))==1));
                        SurLl=1;    
                        else
                            SurLl=0;
                        end
                end
                
                end
                end
                
                     if SurLl==2 && SurLs==2;           %%-->Sürekli Kenar Durumlarýna Göre (alfa) Katsayýsýnýn Bulunmasý
                        TabY=1;
                else if SurLl==2 && SurLs==1 || SurLl==1 && SurLs==2;
                        TabY=2;
                else if SurLl==1 && SurLs==1;
                        TabY=3;
                else if SurLl==0 && SurLs==2;
                        TabY=4;
                else if SurLl==2 && SurLs==0;
                        TabY=5;
                else if SurLl==1 && SurLs==0 || SurLl==0 && SurLs==1;
                        TabY=6;
                else if SurLl==0 && SurLs==0;
                        TabY=7;
                    end
                    end
                    end
                    end
                    end
                    end
                    end
                    TabX=mod(round(m,1),1)*10+1;
                    DosAlfaKatS(DosNum,1,k)=MomentAlfa(3*TabY-2,TabX);
                    DosAlfaKatS(DosNum,2,k)=MomentAlfa(3*TabY-2,9);
                    DosAlfaKatS(DosNum,3,k)=MomentAlfa(3*TabY-1,TabX);
                    DosAlfaKatS(DosNum,4,k)=MomentAlfa(3*TabY-1,9);
                    DosAlfaKatS(DosNum,5,k)=MomentAlfa(3*TabY,TabX);
                    DosAlfaKatS(DosNum,6,k)=MomentAlfa(3*TabY,9);
                    
                    DosMd(DosNum,1,k)=DosAlfaKatS(DosNum,1,k)*Pd(k,1)*(min(DosemeUz(DosNum,1,k),DosemeUz(DosNum,2,k))/100)^2;
                    DosMd(DosNum,2,k)=DosAlfaKatS(DosNum,2,k)*Pd(k,1)*(min(DosemeUz(DosNum,1,k),DosemeUz(DosNum,2,k))/100)^2;
                    DosMd(DosNum,3,k)=DosAlfaKatS(DosNum,3,k)*Pd(k,1)*(min(DosemeUz(DosNum,1,k),DosemeUz(DosNum,2,k))/100)^2;
                    DosMd(DosNum,4,k)=DosAlfaKatS(DosNum,4,k)*Pd(k,1)*(min(DosemeUz(DosNum,1,k),DosemeUz(DosNum,2,k))/100)^2;
                    DosMd(DosNum,5,k)=DosAlfaKatS(DosNum,5,k)*Pd(k,1)*(min(DosemeUz(DosNum,1,k),DosemeUz(DosNum,2,k))/100)^2;
                    DosMd(DosNum,6,k)=DosAlfaKatS(DosNum,6,k)*Pd(k,1)*(min(DosemeUz(DosNum,1,k),DosemeUz(DosNum,2,k))/100)^2;
                    
                    BsncBlkDer(DosNum,1,k)=(dDos(DosNum,1,k)*1000)-sqrt(((dDos(DosNum,1,k)*1000)^2)-(2*DosMd(DosNum,1,k)*10^6)/(0.85*fcd*1000));
                    BsncBlkDer(DosNum,2,k)=(dDos(DosNum,1,k)*1000)-sqrt(((dDos(DosNum,1,k)*1000)^2)-(2*DosMd(DosNum,2,k)*10^6)/(0.85*fcd*1000));
                    BsncBlkDer(DosNum,3,k)=(dDos(DosNum,2,k)*1000)-sqrt(((dDos(DosNum,1,k)*1000)^2)-(2*DosMd(DosNum,3,k)*10^6)/(0.85*fcd*1000));
                    BsncBlkDer(DosNum,4,k)=(dDos(DosNum,1,k)*1000)-sqrt(((dDos(DosNum,1,k)*1000)^2)-(2*DosMd(DosNum,4,k)*10^6)/(0.85*fcd*1000));
                    BsncBlkDer(DosNum,5,k)=(dDos(DosNum,1,k)*1000)-sqrt(((dDos(DosNum,1,k)*1000)^2)-(2*DosMd(DosNum,5,k)*10^6)/(0.85*fcd*1000));
                    BsncBlkDer(DosNum,6,k)=(dDos(DosNum,1,k)*1000)-sqrt(((dDos(DosNum,1,k)*1000)^2)-(2*DosMd(DosNum,6,k)*10^6)/(0.85*fcd*1000));
                    
                    DosAsKU(DosNum,1,k)=(DosMd(DosNum,1,k)*10^6)/(fyd*(dDos(DosNum,1,k)*1000-BsncBlkDer(DosNum,1,k)/2));
                    DosAsKU(DosNum,2,k)=(DosMd(DosNum,2,k)*10^6)/(fyd*(dDos(DosNum,1,k)*1000-BsncBlkDer(DosNum,2,k)/2));
                    DosAsKU(DosNum,3,k)=(DosMd(DosNum,3,k)*10^6)/(fyd*(dDos(DosNum,1,k)*1000-BsncBlkDer(DosNum,3,k)/2));
                    DosAsKU(DosNum,4,k)=(DosMd(DosNum,4,k)*10^6)/(fyd*(dDos(DosNum,1,k)*1000-BsncBlkDer(DosNum,4,k)/2));
                    DosAsKU(DosNum,5,k)=(DosMd(DosNum,5,k)*10^6)/(fyd*(dDos(DosNum,1,k)*1000-BsncBlkDer(DosNum,5,k)/2));
                    DosAsKU(DosNum,6,k)=(DosMd(DosNum,6,k)*10^6)/(fyd*(dDos(DosNum,1,k)*1000-BsncBlkDer(DosNum,6,k)/2));
                     
                    if DosemeUz(DosNum,1,k)>=DosemeUz(DosNum,2,k)
                            DosAsXY(DosNum,1,k)=DosAsKU(DosNum,2,k);
                            DosAsXY(DosNum,2,k)=DosAsKU(DosNum,1,k);
                            DosAsXY(DosNum,3,k)=DosAsKU(DosNum,4,k);
                            DosAsXY(DosNum,4,k)=DosAsKU(DosNum,3,k);
                            DosAsXY(DosNum,5,k)=DosAsKU(DosNum,6,k);
                            DosAsXY(DosNum,6,k)=DosAsKU(DosNum,5,k);
                    else if DosemeUz(DosNum,1,k)<=DosemeUz(DosNum,2,k);
                            DosAsXY(DosNum,1,k)=DosAsKU(DosNum,1,k);
                            DosAsXY(DosNum,2,k)=DosAsKU(DosNum,2,k);
                            DosAsXY(DosNum,3,k)=DosAsKU(DosNum,3,k);
                            DosAsXY(DosNum,4,k)=DosAsKU(DosNum,4,k);
                            DosAsXY(DosNum,5,k)=DosAsKU(DosNum,5,k);
                            DosAsXY(DosNum,6,k)=DosAsKU(DosNum,6,k);
                    end
                    end
                    Dosk(DosNum,1,k)=max(hf(DosNum,1:2,k))/min(DosemeUz(DosNum,1,k),DosemeUz(DosNum,1,k));
                    % Döseme Rijitliklerinin bulunmasý k=hf/ls
            end 
        end
    end
end
end

for k=1:1:z %---> DÖÞEME Mesnet Dengeleme
for i=3:1:y+2;
    for j=3:1:x+2;
        Kir=cell2mat(Katv2(i,j,k));
        if strcmp(Kir(1,1),'k')==1;
            KirisNum=mod(str2double(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);

            Ust=cell2mat(Katv2(i-1,j,k));
            UstDNum=mod(str2double(cell2mat(regexp(Katv2{i-1,j,k},'\d*','Match'))),100);
            Alt=cell2mat(Katv2(i+1,j,k));
            AltDNum=mod(str2double(cell2mat(regexp(Katv2{i+1,j,k},'\d*','Match'))),100);
            Sol=cell2mat(Katv2(i,j-1,k));
            SolDNum=mod(str2double(cell2mat(regexp(Katv2{i,j-1,k},'\d*','Match'))),100);
            Sag=cell2mat(Katv2(i,j+1,k));
            SagDNum=mod(str2double(cell2mat(regexp(Katv2{i,j+1,k},'\d*','Match'))),100);
            
            if strcmp(Ust(1,1),'d')==1 && strcmp(Alt(1,1),'d')==1;
                if min(DosMd(UstDNum,4,k),DosMd(AltDNum,4,k))/max(DosMd(UstDNum,4,k),DosMd(AltDNum,4,k))<0.8;
                deltaM=max(DosMd(UstDNum,4,k),DosMd(AltDNum,4,k))-min(DosMd(UstDNum,4,k),DosMd(AltDNum,4,k));
                MesnetRedor(KirisNum,1,k)=Dosk(UstDNum,1,k)/(Dosk(UstDNum,1,k)+Dosk(AltDNum,1,k));
                MesnetRedor(KirisNum,2,k)=Dosk(AltDNum,1,k)/(Dosk(UstDNum,1,k)+Dosk(AltDNum,1,k));
                
                M1=min(DosMd(UstDNum,4,k),DosMd(AltDNum,4,k))+MesnetRedor(KirisNum,1,k)*(2/3)*deltaM;
                M2=max(DosMd(UstDNum,4,k),DosMd(AltDNum,4,k))-MesnetRedor(KirisNum,1,k)*(2/3)*deltaM;
                MdMesnet(KirisNum,1,k)=max(M1,M2);
                else
                        MdMesnet(KirisNum,1,k)=max(DosMd(UstDNum,4,k),DosMd(AltDNum,4,k));
                end
                BsncBlkDerMes=(dDos(UstDNum,1,k)*1000)-sqrt(((dDos(UstDNum,1,k)*1000)^2)-(2*MdMesnet(KirisNum,1,k)*10^6)/(0.85*fcd*1000)); %>> Max dDos degerini almýyor düzeltilecek...
                DosAsMes(KirisNum,1,k)=(MdMesnet(KirisNum,1,k)*10^6)/(fyd*(dDos(UstDNum,1,k)*1000-BsncBlkDerMes/2));
                

                if DosAsMes(KirisNum,1,k)>DosAsXY(UstDNum,2,k)/2;
                    DosAsek(KirisNum,1,k)=DosAsMes(KirisNum,1,k)-DosAsXY(UstDNum,2,k)/2;
                end
                
            else if strcmp(Sol(1,1),'d')==1 && strcmp(Sag(1,1),'d')==1;
                    if (min(DosMd(SolDNum,3,k),DosMd(SagDNum,3,k))/max(DosMd(SolDNum,3,k),DosMd(SagDNum,3,k)))<0.8;
                    
                    deltaM=max(DosMd(SolDNum,3,k),DosMd(SagDNum,3,k))-min(DosMd(SolDNum,3,k),DosMd(SagDNum,3,k));
                MesnetRedor(KirisNum,1,k)=Dosk(SolDNum,1,k)/(Dosk(SolDNum,1,k)+Dosk(SagDNum,1,k));
                MesnetRedor(KirisNum,2,k)=Dosk(SagDNum,1,k)/(Dosk(SolDNum,1,k)+Dosk(SagDNum,1,k));
                
                M1=min(DosMd(SolDNum,3,k),DosMd(SagDNum,4,k))+MesnetRedor(KirisNum,1,k)*(2/3)*deltaM;
                M2=max(DosMd(SolDNum,3,k),DosMd(SagDNum,4,k))-MesnetRedor(KirisNum,1,k)*(2/3)*deltaM;
                MdMesnet(KirisNum,1,k)=max(M1,M2);
                else
                        MdMesnet(KirisNum,1,k)=max(DosMd(SolDNum,4,k),DosMd(SagDNum,4,k));
                end
                BsncBlkDerMes=(dDos(SolDNum,1,k)*1000)-sqrt(((dDos(SolDNum,1,k)*1000)^2)-(2*MdMesnet(KirisNum,1,k)*10^6)/(0.85*fcd*1000)); %>> Max dDos degerini almýyor düzeltilecek...
                DosAsMes(KirisNum,1,k)=(MdMesnet(KirisNum,1,k)*10^6)/(fyd*(dDos(SolDNum,1,k)*1000-BsncBlkDerMes/2));
                
                        if DosAsMes(KirisNum,1,k)>DosAsXY(SolDNum,1,k)/2;
                            DosAsek(KirisNum,1,k)=DosAsMes(KirisNum,1,k)-DosAsXY(SolDNum,1,k)/2;
                        end
                        
                else if strcmp(Sol(1,1),'d')==1 && strcmp(Sag(1,1),'d')==0;
                        if DosAsXY(SolDNum,3,k)>DosAsXY(SolDNum,1,k)/2;
                            DosAsek(KirisNum,1,k)=DosAsXY(SolDNum,3,k)-DosAsXY(SolDNum,1,k)/2;
                        end
                else if strcmp(Sol(1,1),'d')==0 && strcmp(Sag(1,1),'d')==1;
                        if DosAsXY(SagDNum,3,k)>DosAsXY(SagDNum,1,k)/2;
                            DosAsek(KirisNum,1,k)=DosAsXY(SagDNum,3,k)-DosAsXY(SagDNum,1,k)/2;
                        end
                else if strcmp(Ust(1,1),'d')==1 && strcmp(Alt(1,1),'d')==0;
                        if DosAsXY(UstDNum,4,k)>DosAsXY(UstDNum,2,k)/2;
                            DosAsek(KirisNum,1,k)=DosAsXY(UstDNum,4,k)-DosAsXY(UstDNum,2,k)/2;
                        end
                else if strcmp(Ust(1,1),'d')==0 && strcmp(Alt(1,1),'d')==1;
                        if DosAsXY(AltDNum,4,k)>DosAsXY(AltDNum,2,k)/2;
                            DosAsek(KirisNum,1,k)=DosAsXY(AltDNum,4,k)-DosAsXY(AltDNum,2,k)/2;
                        end
                    end
                    end
                    end
                    end
                end    
            end
                        KN=KirisNum+k*100;
                        Ss(KirisNum,3,k)=ceil(1000/DosAsek(KirisNum,1,k)*fiDosAlan/10);
                        if isinf(Ss(KirisNum,3,k))==0;
                        MesnetDonati{KirisNum,1,k}=sprintf('k%.0f kiriþi mesnet donatýsý Ø8/%.0f cm',KN,Ss(KirisNum,3,k));
                        end
        end
    end
end
end


for k=1:1:z; %---> Döþemeye yerleþtirilecek donatýlarýn belirlenmesi
for i=3:1:y+2;
    for j=3:1:x+2;
        Dos=cell2mat(Katv2(i,j,k));
        if strcmp(Dos(1,1),'d')==1;
            DosNum=mod(str2double(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
            
            Ss(DosNum,1,k)=ceil(1000/DosAsXY(DosNum,1,k)*fiDosAlan/10);
            Ss(DosNum,2,k)=ceil(1000/DosAsXY(DosNum,2,k)*fiDosAlan/10);
            DN=DosNum+k*100;
            
            DosemeDonati{DosNum,1,k}=sprintf('d%.0f Döþemesi X yönündeki açýklýk donatýsý Ø8/%.0fcm P Ø8/%.0fcm D',DN,Ss(DosNum,1,k),Ss(DosNum,2,k));
            DosemeDonati{DosNum,2,k}=sprintf('d%.0f Döþemesi Y yönündeki açýklýk donatýsý Ø8/%.0fcm P Ø8/%.0fcm D',DN,Ss(DosNum,2,k),Ss(DosNum,2,k));
            
        end
    end
end
end

Ss(isinf(Ss))=0;

%% Kiriþlere Gelen Yüklerin Bulunmasý

KirDosYuk(max(KirisSay(:)),1,1:z)=0;
for k=1:1:z %---> Kiriþlere Döþemelerden Gelen Yüklerin Bulunmasý
for i=3:1:y+2;
    for j=3:1:x+2;
        Dos=cell2mat(Katv2(i,j,k));
        if strcmp(Dos(1,1),'d')==1;
            DosNum=mod(str2double(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
            
            UstK=cell2mat(Katv2(i-1,j,k));
            UstKNum=mod(str2double(cell2mat(regexp(Katv2{i-1,j,k},'\d*','Match'))),100);

            AltK=cell2mat(Katv2(i+1,j,k));
            AltKNum=mod(str2double(cell2mat(regexp(Katv2{i+1,j,k},'\d*','Match'))),100);

            SolK=cell2mat(Katv2(i,j-1,k));
            SolKNum=mod(str2double(cell2mat(regexp(Katv2{i,j-1,k},'\d*','Match'))),100);

            SagK=cell2mat(Katv2(i,j+1,k));
            SagKNum=mod(str2double(cell2mat(regexp(Katv2{i,j+1,k},'\d*','Match'))),100);

            m=max(DosemeUz(DosNum,1,k),DosemeUz(DosNum,2,k))/min(DosemeUz(DosNum,1,k),DosemeUz(DosNum,2,k));
            n=(3*m^2-1)/(6*m^2);
                    if DosemeUz(DosNum,1,k)>DosemeUz(DosNum,2,k);
                    KirDosYuk(UstKNum,1,k)=KirDosYuk(UstKNum,1,k)+n*Pd(k,1)*DosemeUz(DosNum,2,k)/100;
                    KirDosYuk(AltKNum,1,k)=KirDosYuk(AltKNum,1,k)+n*Pd(k,1)*DosemeUz(DosNum,2,k)/100;
                    KirDosYuk(SolKNum,1,k)=KirDosYuk(SolKNum,1,k)+(1/3)*Pd(k,1)*DosemeUz(DosNum,2,k)/100;
                    KirDosYuk(SagKNum,1,k)=KirDosYuk(SagKNum,1,k)+(1/3)*Pd(k,1)*DosemeUz(DosNum,2,k)/100;
                    
                    else if DosemeUz(DosNum,1,k)<DosemeUz(DosNum,2,k);
                    KirDosYuk(SolKNum,1,k)=KirDosYuk(SolKNum,1,k)+n*Pd(k,1)*DosemeUz(DosNum,1,k)/100;
                    KirDosYuk(SagKNum,1,k)=KirDosYuk(SagKNum,1,k)+n*Pd(k,1)*DosemeUz(DosNum,1,k)/100;
                    KirDosYuk(UstKNum,1,k)=KirDosYuk(UstKNum,1,k)+(1/3)*Pd(k,1)*DosemeUz(DosNum,1,k)/100;
                    KirDosYuk(AltKNum,1,k)=KirDosYuk(AltKNum,1,k)+(1/3)*Pd(k,1)*DosemeUz(DosNum,1,k)/100;
                    
                    else if DosemeUz(DosNum,1,k)==DosemeUz(DosNum,2,k);
                    KirDosYuk(SolKNum,1,k)=KirDosYuk(SolKNum,1,k)+(1/3)*Pd(k,1)*DosemeUz(DosNum,2,k)/100;
                    KirDosYuk(SagKNum,1,k)=KirDosYuk(SagKNum,1,k)+(1/3)*Pd(k,1)*DosemeUz(DosNum,2,k)/100;
                    KirDosYuk(UstKNum,1,k)=KirDosYuk(UstKNum,1,k)+(1/3)*Pd(k,1)*DosemeUz(DosNum,2,k)/100;
                    KirDosYuk(AltKNum,1,k)=KirDosYuk(AltKNum,1,k)+(1/3)*Pd(k,1)*DosemeUz(DosNum,2,k)/100;
                        
                        end
                        end
                    end
        end
    end
end
end



for k=1:1:z %---> Kiriþlere Duvarlardan gelen yüklerin ve kendi yüklerinin hesabý
for i=3:1:y+2;
    for j=3:1:x+2;
        Kir=cell2mat(Katv2(i,j,k));
        if strcmp(Kir(1,1),'k')==1;
            KirisNum=mod(str2double(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
               
               DuvarYuk(KirisNum,1,k)=(KatYuksek(z,1)-hk(KirisNum,1,k)/100)*(TuglaBirAg*TuglaKal+SivaBirAg*2*SivaKal)*GKomb;
               KirDosYuk(KirisNum,1,k)=KirDosYuk(KirisNum,1,k)+DuvarYuk(KirisNum,1,k);
               KirisOzAg(KirisNum,1,k)=(hk(KirisNum,1,k)/100)*(min(bk(:))/100)*GamaBeton;
               KirDosYuk(KirisNum,1,k)=KirDosYuk(KirisNum,1,k)+KirisOzAg(KirisNum,1,k);
               
               
               
            end
        end
    end
end

%% Eþdeðer Deprem Yükü Yöntemi Ýle Deprem Yüklerinin Belirlenmesi

for k=1:1:z
   KatYukleri(1,1,k)=sum(KolTopYuk(:,1,k))-sum(KolTopYuk(:,1,k+1)); %>> Kat Yüklerinin Bulunmasý [kN]
   kKat(1,1,k)=(12*EC30*(sum(KolonAtalet(:,2,k))*10^-12))/(KatYuksek(k,1)^3); %>>Yapýnýn Katlara Göre X Yönündeki Ötelenme Rijitliði
   kKat(1,2,k)=(12*EC30*(sum(KolonAtalet(:,1,k))*10^-12))/(KatYuksek(k,1)^3); %>>Yapýnýn Katlara Göre Y Yönündeki Ötelenme Rijitliði
   mihi(1,1,k)=KatYukleri(1,1,k)*KatYuksek(k,2);
end
dfi(1,1:2,1:z)=0;
for k=1:1:z;
    Ffi(1,1,k)=100*mihi(1,1,k)/sum(mihi(:));
end

for k=1:1:z %>> Yatay Fiktif Yüklerden Kaynaklý Deplasmanlarýn Bulunmasý
    dfi(1,1,k)=sum(Ffi(1,1,k:z))/kKat(1,1,k);
    dfi(1,1,k)=sum(dfi(1,1,1:k));
    dfi(1,2,k)=dfi(1,2,k)+sum(Ffi(1,1,k:z))/kKat(1,2,k);
    dfi(1,2,k)=sum(dfi(1,2,1:k));
end

%>> T doðal periyodun hesabý
    Tx=sqrt(2*pi()*(sum(KatYukleri(1,1,:).*(dfi(1,1,:).^2))/sum(Ffi(1,1,:).*dfi(1,1,:))));
    Ty=sqrt(2*pi()*(sum(KatYukleri(1,1,:).*(dfi(1,2,:).^2))/sum(Ffi(1,1,:).*dfi(1,2,:))));

%>> Taban Kesme Kuvvetinin Hesabý
if Tx>TB;
    RaTx=R/I;
else if Tx<=TB;
        RaTx=D+(R/I-D)*(Tx/TB);
    end
end

if Ty>TB;
    RaTy=R/I;
else if Ty<=TB;
        RaTy=D+(R/I-D)*(Ty/TB);
    end
end

if 0<=Tx && Tx<=TA;
SaeTx=(0.4+0.6*(Tx/TA))*SDS;
else if TA<=Tx && Tx<=TB;
        SaeTx=SDS;
else if TB<=Tx && Tx<=TL;
        SaeTx=SD1/Tx;
else if TL<=Tx;
        SaeTx=SD1*TL/Tx^2;
    end   
    end
    end
end

if 0<=Ty && Ty<=TA;
SaeTy=(0.4+0.6*(Ty/TA))*SDS;
else if TA<=Ty && Ty<=TB;
        SaeTy=SDS;
else if TB<=Ty && Ty<=TL;
        SaeTy=SD1/Ty;
else if TL<=Ty;
        SaeTy=SD1*TL/Ty^2;
    end   
    end
    end
end

SaRTx=SaeTx/RaTx;
SaRTy=SaeTy/RaTy;

VtEx=max((sum(KatYukleri(1,1,:))*SaRTx),(0.4*sum(KatYukleri(1,1,:))*I*SDS));
VtEy=max((sum(KatYukleri(1,1,:))*SaRTy),(0.4*sum(KatYukleri(1,1,:))*I*SDS));

deltFNx=0.0075*z*VtEx;
deltFNy=0.0075*z*VtEy;

for k=1:1:z;
Fix(1,1,k)=((VtEx-deltFNx)*KatYukleri(1,1,k)*KatYuksek(k,2))/sum(mihi(:));
Fiy(1,1,k)=((VtEy-deltFNy)*KatYukleri(1,1,k)*KatYuksek(k,2))/sum(mihi(:));
end 

%% Rijitlik Matrisi Yöntemi

XZAks=permute(Katv2,[3 2 1]); %>>XZ Aksinin Düzenlenmesi
XZAks(:,:,1:2)=[];
XZAks(:,:,y+0:y+2)=[];
XZAks(:,1:2,:)=[];
XZAks(:,x+1:x+2,:)=[];
XZAks(:,:,2:2:size(XZAks,3))=[];
XZAks=XZAks([3 2 1],:,:);

YZAks=permute(Katv2,[1 3 2]); %>>YZ Aksinin Düzenlenmesi
YZAks=permute(YZAks,[2 1 3]);
YZAks(:,:,1:2)=[];
YZAks(:,:,x+1:x+2)=[];
YZAks(:,1:2,:)=[];
YZAks(:,y+1:y+2,:)=[];
YZAks(:,:,2:2:size(YZAks,3))=[];
YZAks=YZAks([3 2 1],:,:);

NokYuks(1,1)=0;
NokYuks(2:z+1,1)=KatYuksek(1:z,2);

NokXY(:,:,1)=KolonKord(:,:,1);
NokXY(:,:,2:z+1)=KolonKord(:,:,1:z);
NokXY=NokXY/100;

NokXYZ=NokXY; %XYZ Noktalarinin 3 Boyutlu Kordinat Sistemine Göre Düzenlenmesi
for k=1:1:z+1;
NokXYZ(:,3,k)=NokYuks(k,1);
end

array=unique(NokXYZ(:,2,:)); %Y Degerlerinin Bulunmasý
for i=1:1:length(array);
arrayNum(i)=sum(sum(NokXYZ(:,2,:) == array(i)));
end

elNokXYZ = permute(NokXYZ,[1 3 2]);
elNokXYZ = reshape(elNokXYZ,[],size(NokXYZ,2),1);
NokXZ=zeros(max(arrayNum),1,length(array));

for j=1:1:length(array);    %XZ Eksenindeki Noktalarýn Ýsimlendirilmesi ve KordinatlarXZýn Atanmasý
    for elnum=1:1:arrayNum(j);
            NokNum=find(NokXYZ(:,2,:)==array(j));
            NokXZ(elnum,1,j)=NokNum(elnum,1);
            
            NokXZ(elnum,2,j)=elNokXYZ(NokXZ(elnum,1,j),1);
            NokXZ(elnum,3,j)=elNokXYZ(NokXZ(elnum,1,j),2);
            NokXZ(elnum,4,j)=elNokXYZ(NokXZ(elnum,1,j),3);
     end
end

array=unique(NokXYZ(:,1,:)); %X Degerlerinin Bulunmasý
for i=1:1:length(array);
arrayNum(i)=sum(sum(NokXYZ(:,1,:) == array(i)));
end

NokYZ=zeros(max(arrayNum),1,length(array));

for j=1:1:length(array);    %YZ Eksenindeki Noktalarýn Ýsimlendirilmesi ve KordinatlarXZýn Atanmasý
    for elnum=1:1:arrayNum(j);
            NokNum=find(NokXYZ(:,1,:)==array(j));
            NokYZ(elnum,1,j)=NokNum(elnum,1);
            
            NokYZ(elnum,2,j)=elNokXYZ(NokYZ(elnum,1,j),1);
            NokYZ(elnum,3,j)=elNokXYZ(NokYZ(elnum,1,j),2);
            NokYZ(elnum,4,j)=elNokXYZ(NokYZ(elnum,1,j),3);
     end
end

array=unique(NokXYZ(:,3,:)); %Z Degerlerinin Bulunmasý
for i=1:1:length(array);
arrayNum(i)=sum(sum(NokXYZ(:,3,:) == array(i)));
end

NokXY=zeros(max(arrayNum),1,length(array));

for j=1:1:length(array);
    for elnum=1:1:arrayNum(j);
            NokNum=find(NokXYZ(:,3,:)==array(j));
            NokXY(elnum,1,j)=NokNum(elnum,1);
            
            NokXY(elnum,2,j)=elNokXYZ(NokXY(elnum,1,j),1);
            NokXY(elnum,3,j)=elNokXYZ(NokXY(elnum,1,j),2);
            NokXY(elnum,4,j)=elNokXYZ(NokXY(elnum,1,j),3);
     end
end
         

for i=1:1:size(XZAks,1); %>>XZ Aksinin Dugum Noktalarina Göre Düzenlenmesi
    for j=1:1:size(XZAks,2);
        for k=1:1:size(XZAks,3);
            Str=cell2mat(XZAks(i,j,k));
            if strcmp('k',Str(1,1))==1;
                XZDgm(2*i-1,j,k)=XZAks(i,j,k);

            else if strcmp('s',Str(1,1))==1;
                XZDgm(2*i,j,k)=XZAks(i,j,k); 
            end       
            end
        end
    end
end


array=unique(NokXZ(:,4,:));
for k=1:1:size(NokXZ,3);
for i=1:1:length(array);
arrayNum(i,k)=sum(sum(NokXZ(:,4,k) == array(i)));
end
end

SatirSay=size(XZDgm,1)+1;


for k=1:1:size(XZDgm,3);
    DgmNok=1;
    Row=0;
    for i=SatirSay:-2:1;
        Row=Row+1;
        for j=1:2:2*arrayNum(Row,k)-1;
            XZDgm(i,j,k)=cellstr(num2str(NokXZ(DgmNok,1,k)));
            DgmNok=DgmNok+1;
        end
        end
end
    


for i=1:1:size(YZAks,1); %>>YZ Aksinin Dugum Noktalarina Göre Düzenlenmesi
    for j=1:1:size(YZAks,2);
        for k=1:1:size(YZAks,3);
            Str=cell2mat(YZAks(i,j,k));
            if strcmp('k',Str(1,1))==1;
                YZDgm(2*i-1,j,k)=YZAks(i,j,k);

            else if strcmp('s',Str(1,1))==1;
                YZDgm(2*i,j,k)=YZAks(i,j,k) ;   
            end       
            end
        end
    end
end



array=unique(NokYZ(:,4,:));
for k=1:1:size(NokYZ,3);
for i=1:1:length(array);
arrayNum(i,k)=sum(sum(NokYZ(:,4,k) == array(i)));
end
end

SatirSay=size(YZDgm,1)+1;


for k=1:1:size(YZDgm,3);
    DgmNok=1;
    Row=0;
    for i=SatirSay:-2:1;
        Row=Row+1;
        for j=1:2:2*arrayNum(Row,k)-1;
            YZDgm(i,j,k)=cellstr(num2str(NokYZ(DgmNok,1,k)));
            DgmNok=DgmNok+1;
        end
        end
end

sayac=0;
for k=1:1:z; %>>Kolon ve Kiriþlere Eleman Ýsmi Verilmesi 1=Kolon 2=Kiriþ
for i=3:1:y+2;
    for j=3:1:x+2;
        Eleman=cell2mat(Katv2(i,j,k));
        if strcmp(Eleman(1,1),'k')==1;
            sayac=sayac+1;
            ElNum=str2double(cell2mat(regexp(Katv2{i,j,k},'\d*','Match')));
            Elemanlar(sayac,1)=2000+ElNum;
        else if strcmp(Eleman(1,1),'s')==1;
                sayac=sayac+1;
                ElNum=str2double(cell2mat(regexp(Katv2{i,j,k},'\d*','Match')));
                Elemanlar(sayac,1)=1000+ElNum;
            end
            end   
        end
    end
end


tf = cellfun('isempty',XZDgm); % true for empty cells
XZDgm(tf) = {'0'};

tf = cellfun('isempty',YZDgm); % true for empty cells
YZDgm(tf) = {'0'};

NokXZTop = permute(NokXZ,[1 3 2]);
NokXZTop = reshape(NokXZTop,[],size(NokXZ,2),1);

for k=1:1:size(XZDgm,3);    %>>XZ Ekseninde Eleman Ýsimlerine Göre Elemanlarýn Baglý Oldugu Noktalarýn Bulunmasý
for i=1:1:size(XZDgm,1);
    for j=1:1:size(XZDgm,2);
        Eleman=cell2mat(XZDgm(i,j,k));
        
        if strcmp(Eleman(1,1),'k')==1;
        ElNum=str2double(cell2mat(regexp(XZDgm{i,j,k},'\d*','Match')));
        ElemanAd=2000+ElNum;
        indis=find(Elemanlar(:,1)==ElemanAd);
        
        Sol=cell2mat(XZDgm(i,j-1,k));
        Sag=cell2mat(XZDgm(i,j+1,k));
        
        Elemanlar(indis,2)=str2double(Sol);
        Elemanlar(indis,3)=str2double(Sag);
        
        index=find(NokXZTop(:,1)==str2double(Sol));%>>i Noktalarýn XZ Eksenkleri 4,5 Kolonlarýnda Saklý
        Elemanlar(indis,4)=NokXZTop(index,2);      %>>j Noktalarýn XZ Eksenleri 6,7 Kolonlarýnda Saklý
        Elemanlar(indis,5)=NokXZTop(index,4);      %>>i Noktalarýn YZ Eksenleri 8,9 Kolonlarýnda Saklý
                                                   %>>j Noktalarýn YZ Eksenkleri 10,11 Kolonlarýnda Saklý
        Elemanlar(indis,8)=NokXZTop(index,3);
        Elemanlar(indis,9)=NokXZTop(index,4);
                                                   
        index=find(NokXZTop(:,1)==str2double(Sag));
        Elemanlar(indis,6)=NokXZTop(index,2);
        Elemanlar(indis,7)=NokXZTop(index,4);
        
        Elemanlar(indis,10)=NokXZTop(index,3);
        Elemanlar(indis,11)=NokXZTop(index,4);

        else if strcmp(Eleman(1,1),'s')==1;
        ElNum=str2double(cell2mat(regexp(XZDgm{i,j,k},'\d*','Match')));
        ElemanAd=1000+ElNum;
        indis=find(Elemanlar(:,1)==ElemanAd);
        
        Ust=cell2mat(XZDgm(i-1,j,k));
        Alt=cell2mat(XZDgm(i+1,j,k));
        
        Elemanlar(indis,2)=str2double(Alt);
        Elemanlar(indis,3)=str2double(Ust);
        
        index=find(NokXZTop(:,1)==str2double(Alt));%>>i Noktalarýn XZ Eksenkleri 4,5 Kolonlarýnda Saklý
        Elemanlar(indis,4)=NokXZTop(index,2);      %>>j Noktalarýn XZ Eksenleri 6,7 Kolonlarýnda Saklý
        Elemanlar(indis,5)=NokXZTop(index,4);      %>>i Noktalarýn YZ Eksenleri 8,9 Kolonlarýnda Saklý
                                                   %>>j Noktalarýn YZ Eksenkleri 10,11 Kolonlarýnda Saklý
        Elemanlar(indis,8)=NokXZTop(index,3);
        Elemanlar(indis,9)=NokXZTop(index,4);
                                                   
        index=find(NokXZTop(:,1)==str2double(Ust));
        Elemanlar(indis,6)=NokXZTop(index,2);
        Elemanlar(indis,7)=NokXZTop(index,4);
        
        Elemanlar(indis,10)=NokXZTop(index,3);
        Elemanlar(indis,11)=NokXZTop(index,4);
          
            end
            end
        end
    end
end



NokYZTop = permute(NokYZ,[1 3 2]);
NokYZTop = reshape(NokYZTop,[],size(NokYZ,2),1);

for k=1:1:size(YZDgm,3);    %>>YZ Ekseninde Eleman Ýsimlerine Göre Elemanlarýn Baglý Oldugu Noktalarýn Bulunmasý
for i=1:1:size(YZDgm,1);
    for j=1:1:size(YZDgm,2);
        Eleman=cell2mat(YZDgm(i,j,k));
        
        if strcmp(Eleman(1,1),'k')==1;
        ElNum=str2double(cell2mat(regexp(YZDgm{i,j,k},'\d*','Match')));
        ElemanAd=2000+ElNum;
        indis=find(Elemanlar(:,1)==ElemanAd);
        
        Sol=cell2mat(YZDgm(i,j-1,k));
        Sag=cell2mat(YZDgm(i,j+1,k));
        
        Elemanlar(indis,2)=str2double(Sol);
        Elemanlar(indis,3)=str2double(Sag);
        
        index=find(NokXZTop(:,1)==str2double(Sol));%>>i Noktalarýn XZ Eksenkleri 4,5 Kolonlarýnda Saklý
        Elemanlar(indis,4)=NokXZTop(index,2);      %>>j Noktalarýn XZ Eksenleri 6,7 Kolonlarýnda Saklý
        Elemanlar(indis,5)=NokXZTop(index,4);      %>>i Noktalarýn YZ Eksenleri 8,9 Kolonlarýnda Saklý
                                                   %>>j Noktalarýn YZ Eksenkleri 10,11 Kolonlarýnda Saklý
        Elemanlar(indis,8)=NokXZTop(index,3);
        Elemanlar(indis,9)=NokXZTop(index,4);
                                                   
        index=find(NokXZTop(:,1)==str2double(Sag));
        Elemanlar(indis,6)=NokXZTop(index,2);
        Elemanlar(indis,7)=NokXZTop(index,4);
        
        Elemanlar(indis,10)=NokXZTop(index,3);
        Elemanlar(indis,11)=NokXZTop(index,4);

        else if strcmp(Eleman(1,1),'s')==1
        ElNum=str2double(cell2mat(regexp(YZDgm{i,j,k},'\d*','Match')));
        ElemanAd=1000+ElNum;
        indis=find(Elemanlar(:,1)==ElemanAd);
        
        Ust=cell2mat(YZDgm(i-1,j,k));
        Alt=cell2mat(YZDgm(i+1,j,k));
        
        Elemanlar(indis,2)=str2double(Alt);
        Elemanlar(indis,3)=str2double(Ust);
        
        index=find(NokYZTop(:,1)==str2double(Alt)); %>>i Noktalarýn XZ Eksenleri 4,5 Kolonlarýnda Saklý
        Elemanlar(indis,4)=NokYZTop(index,2);       %>>j Noktalarýn XZ Eksenleri 6,7 Kolonlarýnda Saklý
        Elemanlar(indis,5)=NokYZTop(index,4);       %>>i Noktalarýn YZ Eksenleri 8,9 Kolonlarýnda Saklý
                                                   %>>j Noktalarýn YZ Eksenleri 10,11 Kolonlarýnda Saklý
        Elemanlar(indis,8)=NokYZTop(index,3);
        Elemanlar(indis,9)=NokYZTop(index,4);
                                                   
        index=find(NokYZTop(:,1)==str2double(Ust));
        Elemanlar(indis,6)=NokYZTop(index,2);
        Elemanlar(indis,7)=NokYZTop(index,4);
        
        Elemanlar(indis,10)=NokYZTop(index,3);
        Elemanlar(indis,11)=NokYZTop(index,4);
        end
            end
        end
    end
end



for k=1:1:size(XZAks,3); %>>XZ Akslarýndaki Elemanlarýn Belirlenmesi
    sayac=0;
for i=1:1:size(XZAks,1);
    for j=1:1:size(XZAks,2);
        Eleman=cell2mat(XZAks(i,j,k));
        if strcmp(Eleman(1,1),'k')==1;
            sayac=sayac+1;
            ElNum=str2double(cell2mat(regexp(XZAks{i,j,k},'\d*','Match')));
            XZAksEleman(sayac,k)=2000+ElNum;
            qx(sayac,k)=KirDosYuk(mod(ElNum,100),floor(ElNum/100));
            
        else if strcmp(Eleman(1,1),'s')==1;
                sayac=sayac+1;
                ElNum=str2double(cell2mat(regexp(XZAks{i,j,k},'\d*','Match')));
                XZAksEleman(sayac,k)=1000+ElNum;
                
            end
            end   
        end
    end
end



for k=1:1:size(YZAks,3); %>>YZ Akslarýndaki Elemanlarýn Belirlenmesi
    sayac=0;
for i=1:1:size(YZAks,1);
    for j=1:1:size(YZAks,2);
        Eleman=cell2mat(YZAks(i,j,k));
        if strcmp(Eleman(1,1),'k')==1;
            sayac=sayac+1;
            ElNum=str2double(cell2mat(regexp(YZAks{i,j,k},'\d*','Match')));
            YZAksEleman(sayac,k)=2000+ElNum;
            qy(sayac,k)=KirDosYuk(mod(ElNum,100),floor(ElNum/100));
            
            
        else if strcmp(Eleman(1,1),'s')==1;
                sayac=sayac+1;
                ElNum=str2double(cell2mat(regexp(YZAks{i,j,k},'\d*','Match')));
                YZAksEleman(sayac,k)=1000+ElNum;
                
            end   
        end
    end
end
end


for j=1:1:size(XZAksEleman,2);
    for i=1:1:size(XZAksEleman,1);
        
        
        
        if any(XZAksEleman(i,j))==1;
    indis=find(Elemanlar(:,1)==XZAksEleman(i,j));
    
    ElemanUclariXZ(i,1:2,j)=Elemanlar(indis,2:3);

        end
    end
end

for j=1:1:size(YZAksEleman,2);
    for i=1:1:size(YZAksEleman,1);
        
        
        
        if any(YZAksEleman(i,j))==1;
    indis=find(Elemanlar(:,1)==YZAksEleman(i,j));
    
    ElemanUclariYZ(i,1:2,j)=Elemanlar(indis,2:3);

        end
    end
end

for j=1:1:size(XZAksEleman,2);
    
X(:,:,j)=unique(ElemanUclariXZ(:,1:2,j));
X(X(1,1,j)==0)=[];
for i=1:1:length(unique(X(:,:,j)));
    KordinatlarXZ(i,1,j)=elNokXYZ(X(i,1,j),1);
    KordinatlarXZ(i,2,j)=elNokXYZ(X(i,1,j),3);
end
end
X(:)=[];
for j=1:1:size(YZAksEleman,2);
    
X(:,:,j)=unique(ElemanUclariYZ(:,1:2,j));
X(X(1,1,j)==0)=[];
for i=1:1:length(unique(X(:,:,j)));
    KordinatlarYZ(i,1,j)=elNokXYZ(X(i,1,j),2);
    KordinatlarYZ(i,2,j)=elNokXYZ(X(i,1,j),3);
end
end

F=zeros(3*size(KordinatlarXZ,1),size(XZAksEleman,2));
Feksi=zeros(3*size(KordinatlarXZ,1),size(XZAksEleman,2));

for j=1:1:size(XZAksEleman,2);
    for i=1:1:size(KordinatlarXZ,1);
    if KordinatlarXZ(i,2,j)~=0;
        dserbest(3*i-2:3*i,j)=3*i-2:3*i;
    end
    end
    Z=unique(ElemanUclariXZ)
    Z(Z(1,1)==0)=[]
    Fa(:,j)=zeros(3*length(Z),1);
    FaEleman(1:length(find(1000*ceil(XZAksEleman(:,j)/1000)==3000)),j)=find(1000*ceil(XZAksEleman(:,j)/1000)==3000);
    FaNokta(1:length(ElemanUclariXZ(FaEleman(:,j),1:2,j)),1:2,j)=ElemanUclariXZ(FaEleman(:,j),1:2,j);
end



for j=1:1:size(XZDgm,3)
    sayac=0;
    for i=size(XZDgm,1)-1:-1:1
        cell=cell2mat(XZDgm(i,1,j));
        if strcmp(cell(1,1),'s')~=1;
            sayac=sayac+1;
            cellnum=str2double(cell2mat(regexp(XZDgm{i,1,j},'\d*','Match')));
            index=find(NokXZ(:,1,j)==cellnum);
            F(3*index-2,j)=Fix(sayac)/size(XZDgm,3);
        end
    end
end

for j=1:1:size(XZDgm,3)
    sayac=0;
    for i=size(XZDgm,1)-1:-1:1
        cell=cell2mat(XZDgm(i,1,j));
        if strcmp(cell(1,1),'s')~=1;
            sayac=sayac+1;
            cellnum=str2double(cell2mat(regexp(XZDgm{i,size(XZDgm,2),j},'\d*','Match')));
            index=find(NokXZ(:,1,j)==cellnum);
            Feksi(3*index-2,j)=-Fix(sayac)/size(XZDgm,3);
        end
    end
end



%% XZ Aksý Ýçin Rjitik Matrisi Yönteminin Uygulanmasý
KesMomXZ(:,:,:)=zeros(12,size(XZAksEleman,1),size(XZAksEleman,2));

for j=1:1:size(XZDgm,3) %>> Ex+1.4G+1.6Q

E=21e7;
A=0.16;
I=2.13e-3;


    KordinatlarXZj=KordinatlarXZ(:,:,j);
    AksElemanlarj=XZAksEleman(1:sum(XZAksEleman(:,j)~=0),j);
    ElemanUclariXZj=ElemanUclariXZ(1:sum(ElemanUclariXZ(:,:,j)~=0),1:2,j);
    dserbestj=dserbest(:,j);

    Faj=zeros(3*length(unique(ElemanUclariXZj)),1);
    FaElemanj=FaEleman(1:sum(FaEleman(:,j)~=0),j);
    FaNoktaj=ElemanUclariXZj(FaElemanj,1:2);
    
    Fj=F(:,j);
    
    
    
for i=1:1:length(AksElemanlarj)
        Li(i)=sqrt((KordinatlarXZj(find(ElemanUclariXZj(i,2)==NokXZ(:,1,j)),1)-KordinatlarXZj(find(ElemanUclariXZj(i,1)==NokXZ(:,1,j)),1))^2+(KordinatlarXZj(find(ElemanUclariXZj(i,2)==NokXZ(:,1,j)),2)-KordinatlarXZj(find(ElemanUclariXZj(i,1)==NokXZ(:,1,j)),2))^2);
 lx(i)=(KordinatlarXZj(find(ElemanUclariXZj(i,2)==NokXZ(:,1,j)),1)-KordinatlarXZj(find(ElemanUclariXZj(i,1)==NokXZ(:,1,j)),1))/Li(i);
 ly(i)=(KordinatlarXZj(find(ElemanUclariXZj(i,2)==NokXZ(:,1,j)),2)-KordinatlarXZj(find(ElemanUclariXZj(i,1)==NokXZ(:,1,j)),2))/Li(i);
 
 T(:,:,i)=[lx(i) ly(i) 0 0 0 0;
    -ly(i) lx(i) 0 0 0 0;
    0 0 1 0 0 0;
    0 0 0 lx(i) ly(i) 0;
    0 0 0 -ly(i) lx(i) 0;
    0 0 0 0 0 1];
 
Kiy(:,:,i)=[E*A/Li(i) 0 0 -E*A/Li(i) 0 0;
           0 12*E*I/Li(i)^3 6*E*I/Li(i)^2 0 -12*E*I/Li(i)^3 6*E*I/Li(i)^2;
           0 6*E*I/Li(i)^2 4*E*I/Li(i) 0 -6*E*I/Li(i)^2 2*E*I/Li(i);
           -E*A/Li(i) 0 0 E*A/Li(i) 0 0;
           0 -12*E*I/Li(i)^3 -6*E*I/Li(i)^2 0 12*E*I/Li(i)^3 -6*E*I/Li(i)^2;
           0 6*E*I/Li(i)^2 2*E*I/Li(i) 0 -6*E*I/Li(i)^2 4*E*I/Li(i);];
 
        
        Kig(:,:,i)=T(:,:,i)'*Kiy(:,:,i)*T(:,:,i);
 
 Kni(1,i)=3*find(ElemanUclariXZj(i,1)==NokXZ(:,1,j))-2;
 Kni(2,i)=3*find(ElemanUclariXZj(i,1)==NokXZ(:,1,j))-1;
 Kni(3,i)=3*find(ElemanUclariXZj(i,1)==NokXZ(:,1,j));
 Kni(4,i)=3*find(ElemanUclariXZj(i,2)==NokXZ(:,1,j))-2;
 Kni(5,i)=3*find(ElemanUclariXZj(i,2)==NokXZ(:,1,j))-1;
 Kni(6,i)=3*find(ElemanUclariXZj(i,2)==NokXZ(:,1,j));

end

            


for i=1:1:length(FaElemanj);       %Yayýlý yüklerin ankastrelik yükleri
    el=FaElemanj(i,1);
            noki=find(ElemanUclariXZ(el,1,j)==NokXZ(:,1,j));
            Faj(3*noki-2:3*noki)=Faj(3*noki-2:3*noki)+[0;qx(el,j)*Li(el)/2;qx(el,j)*Li(el)^2/12];
            nokj=find(ElemanUclariXZ(el,2,j)==NokXZ(:,1,j));
            Faj(3*nokj-2:3*nokj)=Faj(3*nokj-2:3*nokj)+[0;qx(el,j)*Li(el)/2;-qx(el,j)*Li(el)^2/12];
end


Fj=Fj+Faj;

    K=zeros(max(Kni(:)),max(Kni(:)));
for e=1:1:length(AksElemanlarj);
for i=1:1:6;
    for k=1:1:6;
        
    K(Kni(i,e),Kni(k,e))=K(Kni(i,e),Kni(k,e))+Kig(i,k,e);
    
    end
end
end
d=zeros(length(KordinatlarXZj)*3,1);

d(dserbestj(dserbestj~=0))=K(dserbestj(dserbestj~=0),dserbestj(dserbestj~=0))\Fj(dserbestj(dserbestj~=0));

Fj=Fj-Faj;

Fj=K*d;



for i=1:1:length(AksElemanlarj);
    
    
    dyer(:,:,i)=T(:,:,i)*d(Kni(:,i));
    fx(:,i,j)=Kiy(:,:,i)*dyer(:,:,i)+Faj(Kni(:,i));
    fx(:,i,j)=fx(:,i,j);
    
    Fsol=fx(1:3,i,j);
    Fsag=fx(4:6,i,j);

    V=[-qx(i) Fsol(2)];
    x=[0 0.5 1 1.5 2 2.5 3];
    Vi=polyval(V,x);
    
    M=[-qx(i)/2 Fsol(2) -Fsol(3)];
    x=[0 0.5 1 1.5 2 2.5 3];
    Mi=polyval(M,x);

     L=Li(i);
     
     TekTemTasXZ(1:3,i,j)=fx(1:3,i,j);
    
     if sign(Vi(1))==1;
         KesMomXZ(1,i,j)=max([Vi(1),KesMomXZ(1,i,j)]);
     else
         KesMomXZ(7,i,j)=min([Vi(1),KesMomXZ(7,i,j)]);
     end
     if sign(Vi(4))==1;
         KesMomXZ(2,i,j)=max([Vi(4),KesMomXZ(2,i,j)]);
     else
         KesMomXZ(8,i,j)=min([Vi(4),KesMomXZ(8,i,j)]);
     end
     if sign(Vi(7))==1;
         KesMomXZ(3,i,j)=max([Vi(7),KesMomXZ(3,i,j)]);
     else
         KesMomXZ(9,i,j)=min([Vi(7),KesMomXZ(9,i,j)]);
     end
     if sign(Mi(1))==1;
         KesMomXZ(4,i,j)=max([Mi(1),KesMomXZ(4,i,j)]);
     else
         KesMomXZ(10,i,j)=min([Mi(1),KesMomXZ(10,i,j)]);
     end
     if sign(Mi(4))==1;
         KesMomXZ(5,i,j)=max([Mi(4),KesMomXZ(5,i,j)]);
     else
         KesMomXZ(11,i,j)=min([Mi(4),KesMomXZ(11,i,j)]);
     end
     if sign(Mi(7))==1;
         KesMomXZ(6,i,j)=max([Mi(7),KesMomXZ(6,i,j)]);
     else
         KesMomXZ(12,i,j)=min([Mi(7),KesMomXZ(12,i,j)]);
     end
     
  
end

end

for j=1:1:size(XZDgm,3) %>> -Ex+1.4G+1.6Q

E=21e7;
A=0.16;
I=2.13e-3;


    KordinatlarXZj=KordinatlarXZ(:,:,j);
    AksElemanlarj=XZAksEleman(1:sum(XZAksEleman(:,j)~=0),j);
    ElemanUclariXZj=ElemanUclariXZ(1:sum(ElemanUclariXZ(:,:,j)~=0),1:2,j);
    dserbestj=dserbest(:,j);

    Faj=zeros(3*length(unique(ElemanUclariXZj)),1);
    FaElemanj=FaEleman(1:sum(FaEleman(:,j)~=0),j);
    FaNoktaj=ElemanUclariXZj(FaElemanj,1:2);
    
    Fj=Feksi(:,j);
    
    
    
for i=1:1:length(AksElemanlarj)
        Li(i)=sqrt((KordinatlarXZj(find(ElemanUclariXZj(i,2)==NokXZ(:,1,j)),1)-KordinatlarXZj(find(ElemanUclariXZj(i,1)==NokXZ(:,1,j)),1))^2+(KordinatlarXZj(find(ElemanUclariXZj(i,2)==NokXZ(:,1,j)),2)-KordinatlarXZj(find(ElemanUclariXZj(i,1)==NokXZ(:,1,j)),2))^2);
 lx(i)=(KordinatlarXZj(find(ElemanUclariXZj(i,2)==NokXZ(:,1,j)),1)-KordinatlarXZj(find(ElemanUclariXZj(i,1)==NokXZ(:,1,j)),1))/Li(i);
 ly(i)=(KordinatlarXZj(find(ElemanUclariXZj(i,2)==NokXZ(:,1,j)),2)-KordinatlarXZj(find(ElemanUclariXZj(i,1)==NokXZ(:,1,j)),2))/Li(i);
 
 T(:,:,i)=[lx(i) ly(i) 0 0 0 0;
    -ly(i) lx(i) 0 0 0 0;
    0 0 1 0 0 0;
    0 0 0 lx(i) ly(i) 0;
    0 0 0 -ly(i) lx(i) 0;
    0 0 0 0 0 1];
 
Kiy(:,:,i)=[E*A/Li(i) 0 0 -E*A/Li(i) 0 0;
           0 12*E*I/Li(i)^3 6*E*I/Li(i)^2 0 -12*E*I/Li(i)^3 6*E*I/Li(i)^2;
           0 6*E*I/Li(i)^2 4*E*I/Li(i) 0 -6*E*I/Li(i)^2 2*E*I/Li(i);
           -E*A/Li(i) 0 0 E*A/Li(i) 0 0;
           0 -12*E*I/Li(i)^3 -6*E*I/Li(i)^2 0 12*E*I/Li(i)^3 -6*E*I/Li(i)^2;
           0 6*E*I/Li(i)^2 2*E*I/Li(i) 0 -6*E*I/Li(i)^2 4*E*I/Li(i);];
 
        
        Kig(:,:,i)=T(:,:,i)'*Kiy(:,:,i)*T(:,:,i);
 
 Kni(1,i)=3*find(ElemanUclariXZj(i,1)==NokXZ(:,1,j))-2;
 Kni(2,i)=3*find(ElemanUclariXZj(i,1)==NokXZ(:,1,j))-1;
 Kni(3,i)=3*find(ElemanUclariXZj(i,1)==NokXZ(:,1,j));
 Kni(4,i)=3*find(ElemanUclariXZj(i,2)==NokXZ(:,1,j))-2;
 Kni(5,i)=3*find(ElemanUclariXZj(i,2)==NokXZ(:,1,j))-1;
 Kni(6,i)=3*find(ElemanUclariXZj(i,2)==NokXZ(:,1,j));

end

            


for i=1:1:length(FaElemanj);       %Yayýlý yüklerin ankastrelik yükleri
    el=FaElemanj(i,1);
            noki=find(ElemanUclariXZ(el,1,j)==NokXZ(:,1,j));
            Faj(3*noki-2:3*noki)=Faj(3*noki-2:3*noki)+[0;qx(el,j)*Li(el)/2;qx(el,j)*Li(el)^2/12];
            nokj=find(ElemanUclariXZ(el,2,j)==NokXZ(:,1,j));
            Faj(3*nokj-2:3*nokj)=Faj(3*nokj-2:3*nokj)+[0;qx(el,j)*Li(el)/2;-qx(el,j)*Li(el)^2/12];
end


Fj=Fj+Faj;

    K=zeros(max(Kni(:)),max(Kni(:)));
for e=1:1:length(AksElemanlarj);
for i=1:1:6;
    for k=1:1:6;
        
    K(Kni(i,e),Kni(k,e))=K(Kni(i,e),Kni(k,e))+Kig(i,k,e);
    
    end
end
end
d=zeros(length(KordinatlarXZj)*3,1);

d(dserbestj(dserbestj~=0))=K(dserbestj(dserbestj~=0),dserbestj(dserbestj~=0))\Fj(dserbestj(dserbestj~=0));

Fj=Fj-Faj;

Fj=K*d;

for i=1:1:length(AksElemanlarj);
    
    dyer(:,:,i)=T(:,:,i)*d(Kni(:,i));
    fx(:,i,j)=Kiy(:,:,i)*dyer(:,:,i)+Faj(Kni(:,i));
    fx(:,i,j)=fx(:,i,j);
    
    Fsol=fx(1:3,i,j);
    Fsag=fx(4:6,i,j);

    V=[-qx(i) Fsol(2)];
    x=[0 0.5 1 1.5 2 2.5 3];
    Vi=polyval(V,x);
    
    M=[-qx(i)/2 Fsol(2) -Fsol(3)];
    x=[0 0.5 1 1.5 2 2.5 3];
    Mi=polyval(M,x);

     L=Li(i);
     
     TekTemTasXZ(4:6,i,j)=fx(1:3,i,j);
    
    if sign(Vi(1))==1;
         KesMomXZ(1,i,j)=max([Vi(1),KesMomXZ(1,i,j)]);
     else
         KesMomXZ(7,i,j)=min([Vi(1),KesMomXZ(7,i,j)]);
     end
     if sign(Vi(4))==1;
         KesMomXZ(2,i,j)=max([Vi(4),KesMomXZ(2,i,j)]);
     else
         KesMomXZ(8,i,j)=min([Vi(4),KesMomXZ(8,i,j)]);
     end
     if sign(Vi(7))==1;
         KesMomXZ(3,i,j)=max([Vi(7),KesMomXZ(3,i,j)]);
     else
         KesMomXZ(9,i,j)=min([Vi(7),KesMomXZ(9,i,j)]);
     end
     if sign(Mi(1))==1;
         KesMomXZ(4,i,j)=max([Mi(1),KesMomXZ(4,i,j)]);
     else
         KesMomXZ(10,i,j)=min([Mi(1),KesMomXZ(10,i,j)]);
     end
     if sign(Mi(4))==1;
         KesMomXZ(5,i,j)=max([Mi(4),KesMomXZ(5,i,j)]);
     else
         KesMomXZ(11,i,j)=min([Mi(4),KesMomXZ(11,i,j)]);
     end
     if sign(Mi(7))==1;
         KesMomXZ(6,i,j)=max([Mi(7),KesMomXZ(6,i,j)]);
     else
         KesMomXZ(12,i,j)=min([Mi(7),KesMomXZ(12,i,j)]);
     end
   
end

end


for j=1:1:size(XZDgm,3) %>>1.4G+1.6Q

E=21e7;
A=0.16;
I=2.13e-3;


    KordinatlarXZj=KordinatlarXZ(:,:,j);
    AksElemanlarj=XZAksEleman(1:sum(XZAksEleman(:,j)~=0),j);
    ElemanUclariXZj=ElemanUclariXZ(1:sum(ElemanUclariXZ(:,:,j)~=0),1:2,j);
    dserbestj=dserbest(:,j);

    Faj=zeros(3*length(unique(ElemanUclariXZj)),1);
    FaElemanj=FaEleman(1:sum(FaEleman(:,j)~=0),j);
    FaNoktaj=ElemanUclariXZj(FaElemanj,1:2); 
    Fj=F(:,j);
    Fj(:)=0;
    
    
for i=1:1:length(AksElemanlarj);
        Li(i)=sqrt((KordinatlarXZj(find(ElemanUclariXZj(i,2)==NokXZ(:,1,j)),1)-KordinatlarXZj(find(ElemanUclariXZj(i,1)==NokXZ(:,1,j)),1))^2+(KordinatlarXZj(find(ElemanUclariXZj(i,2)==NokXZ(:,1,j)),2)-KordinatlarXZj(find(ElemanUclariXZj(i,1)==NokXZ(:,1,j)),2))^2);
 lx(i)=(KordinatlarXZj(find(ElemanUclariXZj(i,2)==NokXZ(:,1,j)),1)-KordinatlarXZj(find(ElemanUclariXZj(i,1)==NokXZ(:,1,j)),1))/Li(i);
 ly(i)=(KordinatlarXZj(find(ElemanUclariXZj(i,2)==NokXZ(:,1,j)),2)-KordinatlarXZj(find(ElemanUclariXZj(i,1)==NokXZ(:,1,j)),2))/Li(i);
 
 T(:,:,i)=[lx(i) ly(i) 0 0 0 0;
    -ly(i) lx(i) 0 0 0 0;
    0 0 1 0 0 0;
    0 0 0 lx(i) ly(i) 0;
    0 0 0 -ly(i) lx(i) 0;
    0 0 0 0 0 1];
 
Kiy(:,:,i)=[E*A/Li(i) 0 0 -E*A/Li(i) 0 0;
           0 12*E*I/Li(i)^3 6*E*I/Li(i)^2 0 -12*E*I/Li(i)^3 6*E*I/Li(i)^2;
           0 6*E*I/Li(i)^2 4*E*I/Li(i) 0 -6*E*I/Li(i)^2 2*E*I/Li(i);
           -E*A/Li(i) 0 0 E*A/Li(i) 0 0;
           0 -12*E*I/Li(i)^3 -6*E*I/Li(i)^2 0 12*E*I/Li(i)^3 -6*E*I/Li(i)^2;
           0 6*E*I/Li(i)^2 2*E*I/Li(i) 0 -6*E*I/Li(i)^2 4*E*I/Li(i);];
 
        
        Kig(:,:,i)=T(:,:,i)'*Kiy(:,:,i)*T(:,:,i);
 
 Kni(1,i)=3*find(ElemanUclariXZj(i,1)==NokXZ(:,1,j))-2;
 Kni(2,i)=3*find(ElemanUclariXZj(i,1)==NokXZ(:,1,j))-1;
 Kni(3,i)=3*find(ElemanUclariXZj(i,1)==NokXZ(:,1,j));
 Kni(4,i)=3*find(ElemanUclariXZj(i,2)==NokXZ(:,1,j))-2;
 Kni(5,i)=3*find(ElemanUclariXZj(i,2)==NokXZ(:,1,j))-1;
 Kni(6,i)=3*find(ElemanUclariXZj(i,2)==NokXZ(:,1,j));

end

            


for i=1:1:length(FaElemanj);       %Yayýlý yüklerin ankastrelik yükleri
    el=FaElemanj(i,1);
            noki=find(ElemanUclariXZ(el,1,j)==NokXZ(:,1,j));
            Faj(3*noki-2:3*noki)=Faj(3*noki-2:3*noki)+[0;qx(el,j)*Li(el)/2;qx(el,j)*Li(el)^2/12];
            nokj=find(ElemanUclariXZ(el,2,j)==NokXZ(:,1,j));
            Faj(3*nokj-2:3*nokj)=Faj(3*nokj-2:3*nokj)+[0;qx(el,j)*Li(el)/2;-qx(el,j)*Li(el)^2/12];
end


Fj=Fj+Faj;

    K=zeros(max(Kni(:)),max(Kni(:)));
for e=1:1:length(AksElemanlarj);
for i=1:1:6;
    for k=1:1:6;
        
    K(Kni(i,e),Kni(k,e))=K(Kni(i,e),Kni(k,e))+Kig(i,k,e);
    
    end
end
end
d=zeros(length(KordinatlarXZj)*3,1);

d(dserbestj(dserbestj~=0))=K(dserbestj(dserbestj~=0),dserbestj(dserbestj~=0))\Fj(dserbestj(dserbestj~=0));

Fj=Fj-Faj;

Fj=K*d;

for i=1:1:length(AksElemanlarj);

    dyer(:,:,i)=T(:,:,i)*d(Kni(:,i));
    fx(:,i,j)=Kiy(:,:,i)*dyer(:,:,i)+Faj(Kni(:,i));
    fx(:,i,j)=fx(:,i,j);
    
    Fsol=fx(1:3,i,j);
    Fsag=fx(4:6,i,j);

    V=[-qx(i) Fsol(2)];
    x=[0 0.5 1 1.5 2 2.5 3];
    Vi=polyval(V,x);
    
    M=[-qx(i)/2 Fsol(2) -Fsol(3)];
    x=[0 0.5 1 1.5 2 2.5 3];
    Mi=polyval(M,x);

     L=Li(i);
     
     TekTemTasXZ(7:9,i,j)=fx(1:3,i,j);
     
    
    if sign(Vi(1))==1;
         KesMomXZ(1,i,j)=max([Vi(1),KesMomXZ(1,i,j)]);
     else
         KesMomXZ(7,i,j)=min([Vi(1),KesMomXZ(7,i,j)]);
     end
     if sign(Vi(4))==1;
         KesMomXZ(2,i,j)=max([Vi(4),KesMomXZ(2,i,j)]);
     else
         KesMomXZ(8,i,j)=min([Vi(4),KesMomXZ(8,i,j)]);
     end
     if sign(Vi(7))==1;
         KesMomXZ(3,i,j)=max([Vi(7),KesMomXZ(3,i,j)]);
     else
         KesMomXZ(9,i,j)=min([Vi(7),KesMomXZ(9,i,j)]);
     end
     if sign(Mi(1))==1;
         KesMomXZ(4,i,j)=max([Mi(1),KesMomXZ(4,i,j)]);
     else
         KesMomXZ(10,i,j)=min([Mi(1),KesMomXZ(10,i,j)]);
     end
     if sign(Mi(4))==1;
         KesMomXZ(5,i,j)=max([Mi(4),KesMomXZ(5,i,j)]);
     else
         KesMomXZ(11,i,j)=min([Mi(4),KesMomXZ(11,i,j)]);
     end
     if sign(Mi(7))==1;
         KesMomXZ(6,i,j)=max([Mi(7),KesMomXZ(6,i,j)]);
     else
         KesMomXZ(12,i,j)=min([Mi(7),KesMomXZ(12,i,j)]);
     end
end

end


%% YZ Aksý Rijitlik Matris Yöntemi
KesMomYZ(:,:,:)=zeros(12,size(YZAksEleman,1),size(YZAksEleman,2));

Fa(:)=[];
FaEleman(:)=[];
FaNokta(:)=[];
clear dserbest;
clear dserbestj Faj FaElemanj FaNoktaj Fj AksElemanlarj Li lx ly T Kiy Kig Kni el noki nokj K d dyer fx Feksi;

F=zeros(3*size(KordinatlarYZ(:,:,j),1),size(YZAksEleman,2));

for j=1:1:size(YZAksEleman,2);
    for i=1:1:size(KordinatlarYZ,1);
    if KordinatlarYZ(i,2,j)~=0;
        dserbest(3*i-2:3*i,j)=3*i-2:3*i;
    end
    end
    Z=unique(ElemanUclariYZ)
    Z(Z(1,1)==0)=[]
    Fa(:,j)=zeros(3*length(Z),1);
    FaEleman(1:length(find(1000*ceil(YZAksEleman(:,j)/1000)==3000)),j)=find(1000*ceil(YZAksEleman(:,j)/1000)==3000);
    FaNokta(1:length(ElemanUclariYZ(FaEleman(:,j),1:2,j)),1:2,j)=ElemanUclariYZ(FaEleman(:,j),1:2,j);
end




for j=1:1:size(YZDgm,3);
    sayac=0;
    for i=size(YZDgm,1)-1:-1:1;
        cell=cell2mat(YZDgm(i,1,j));
        if strcmp(cell(1,1),'s')~=1;
            sayac=sayac+1;
            cellnum=str2double(cell2mat(regexp(YZDgm{i,1,j},'\d*','Match')));
            index=find(NokYZ(:,1,j)==cellnum);
            F(3*index-2,j)=Fiy(sayac)/size(YZDgm,3);
        end
    end
end

Feksi=zeros(3*size(KordinatlarYZ,1),size(YZAksEleman,2));

for j=1:1:size(YZDgm,3);
    sayac=0;
    for i=size(YZDgm,1)-1:-1:1;
        cell=cell2mat(YZDgm(i,1,j));
        if strcmp(cell(1,1),'s')~=1;
            sayac=sayac+1;
            cellnum=str2double(cell2mat(regexp(YZDgm{i,size(YZDgm,2),j},'\d*','Match')));
            index=find(NokYZ(:,1,j)==cellnum);
            Feksi(3*index-2,j)=-Fiy(sayac)/size(YZDgm,3);
        end
    end
end



for j=1:1:size(YZDgm,3) %>> Ey+1.4G+1.6Q;

E=21e7;
A=0.16;
I=2.13e-3;


    KordinatlarYZj=KordinatlarYZ(:,:,j);
    AksElemanlarj=YZAksEleman(1:sum(YZAksEleman(:,j)~=0),j);
    ElemanUclariYZj=ElemanUclariYZ(1:sum(ElemanUclariYZ(:,:,j)~=0),1:2,j);
    dserbestj=dserbest(:,j);

    Faj=zeros(3*length(unique(ElemanUclariYZj)),1);
    FaElemanj=FaEleman(1:sum(FaEleman(:,j)~=0),j);
    FaNoktaj=ElemanUclariYZj(FaElemanj,1:2);
    Fj=F(:,j);
    
    
    
for i=1:1:length(AksElemanlarj)
        Li(i)=sqrt((KordinatlarYZj(find(ElemanUclariYZj(i,2)==NokYZ(:,1,j)),1)-KordinatlarYZj(find(ElemanUclariYZj(i,1)==NokYZ(:,1,j)),1))^2+(KordinatlarYZj(find(ElemanUclariYZj(i,2)==NokYZ(:,1,j)),2)-KordinatlarYZj(find(ElemanUclariYZj(i,1)==NokYZ(:,1,j)),2))^2);
 lx(i)=(KordinatlarYZj(find(ElemanUclariYZj(i,2)==NokYZ(:,1,j)),1)-KordinatlarYZj(find(ElemanUclariYZj(i,1)==NokYZ(:,1,j)),1))/Li(i);
 ly(i)=(KordinatlarYZj(find(ElemanUclariYZj(i,2)==NokYZ(:,1,j)),2)-KordinatlarYZj(find(ElemanUclariYZj(i,1)==NokYZ(:,1,j)),2))/Li(i);
 
 T(:,:,i)=[lx(i) ly(i) 0 0 0 0;
    -ly(i) lx(i) 0 0 0 0;
    0 0 1 0 0 0;
    0 0 0 lx(i) ly(i) 0;
    0 0 0 -ly(i) lx(i) 0;
    0 0 0 0 0 1];
 
Kiy(:,:,i)=[E*A/Li(i) 0 0 -E*A/Li(i) 0 0;
           0 12*E*I/Li(i)^3 6*E*I/Li(i)^2 0 -12*E*I/Li(i)^3 6*E*I/Li(i)^2;
           0 6*E*I/Li(i)^2 4*E*I/Li(i) 0 -6*E*I/Li(i)^2 2*E*I/Li(i);
           -E*A/Li(i) 0 0 E*A/Li(i) 0 0;
           0 -12*E*I/Li(i)^3 -6*E*I/Li(i)^2 0 12*E*I/Li(i)^3 -6*E*I/Li(i)^2;
           0 6*E*I/Li(i)^2 2*E*I/Li(i) 0 -6*E*I/Li(i)^2 4*E*I/Li(i);];
 
        
        Kig(:,:,i)=T(:,:,i)'*Kiy(:,:,i)*T(:,:,i);
 
 Kni(1,i)=3*find(ElemanUclariYZj(i,1)==NokYZ(:,1,j))-2;
 Kni(2,i)=3*find(ElemanUclariYZj(i,1)==NokYZ(:,1,j))-1;
 Kni(3,i)=3*find(ElemanUclariYZj(i,1)==NokYZ(:,1,j));
 Kni(4,i)=3*find(ElemanUclariYZj(i,2)==NokYZ(:,1,j))-2;
 Kni(5,i)=3*find(ElemanUclariYZj(i,2)==NokYZ(:,1,j))-1;
 Kni(6,i)=3*find(ElemanUclariYZj(i,2)==NokYZ(:,1,j));

end

            


for i=1:1:length(FaElemanj);       %Yayýlý yüklerin ankastrelik yükleri
    el=FaElemanj(i,1);
            noki=find(ElemanUclariYZ(el,1,j)==NokYZ(:,1,j));
            Faj(3*noki-2:3*noki)=Faj(3*noki-2:3*noki)+[0;qy(el,j)*Li(el)/2;qy(el,j)*Li(el)^2/12];
            nokj=find(ElemanUclariYZ(el,2,j)==NokYZ(:,1,j));
            Faj(3*nokj-2:3*nokj)=Faj(3*nokj-2:3*nokj)+[0;qy(el,j)*Li(el)/2;-qy(el,j)*Li(el)^2/12];
end


Fj=Fj+Faj;

    K=zeros(max(Kni(:)),max(Kni(:)));
for e=1:1:length(AksElemanlarj);
for i=1:1:6;
    for k=1:1:6;
        
    K(Kni(i,e),Kni(k,e))=K(Kni(i,e),Kni(k,e))+Kig(i,k,e);
    
    end
end
end
d=zeros(length(KordinatlarYZj)*3,1);

d(dserbestj(dserbestj~=0))=K(dserbestj(dserbestj~=0),dserbestj(dserbestj~=0))\Fj(dserbestj(dserbestj~=0));

Fj=Fj-Faj;

Fj=K*d;

for i=1:1:length(AksElemanlarj);
    

    dyer(:,:,i)=T(:,:,i)*d(Kni(:,i));
    fx(:,i,j)=Kiy(:,:,i)*dyer(:,:,i)+Faj(Kni(:,i));
    fx(:,i,j)=fx(:,i,j);
    
    Fsol=fx(1:3,i,j);
    Fsag=fx(4:6,i,j);

    V=[-qy(i) Fsol(2)];
    x=[0 0.5 1 1.5 2 2.5 3];
    Vi=polyval(V,x);
    
    M=[-qy(i)/2 1*Fsol(2) -Fsol(3)];
    x=[0 0.5 1 1.5 2 2.5 3];
    Mi=polyval(M,x);

     L=Li(i);
     
     TekTemTasYZ(1:3,i,j)=fx(1:3,i,j);
    
    if sign(Vi(1))==1;
         KesMomYZ(1,i,j)=max([Vi(1),KesMomYZ(1,i,j)]);
     else
         KesMomYZ(7,i,j)=min([Vi(1),KesMomYZ(7,i,j)]);
     end
     if sign(Vi(4))==1;
         KesMomYZ(2,i,j)=max([Vi(4),KesMomYZ(2,i,j)]);
     else
         KesMomYZ(8,i,j)=min([Vi(4),KesMomYZ(8,i,j)]);
     end
     if sign(Vi(7))==1;
         KesMomYZ(3,i,j)=max([Vi(7),KesMomYZ(3,i,j)]);
     else
         KesMomYZ(9,i,j)=min([Vi(7),KesMomYZ(9,i,j)]);
     end
     if sign(Mi(1))==1;
         KesMomYZ(4,i,j)=max([Mi(1),KesMomYZ(4,i,j)]);
     else
         KesMomYZ(10,i,j)=min([Mi(1),KesMomYZ(10,i,j)]);
     end
     if sign(Mi(4))==1;
         KesMomYZ(5,i,j)=max([Mi(4),KesMomYZ(5,i,j)]);
     else
         KesMomYZ(11,i,j)=min([Mi(4),KesMomYZ(11,i,j)]);
     end
     if sign(Mi(7))==1;
         KesMomYZ(6,i,j)=max([Mi(7),KesMomYZ(6,i,j)]);
     else
         KesMomYZ(12,i,j)=min([Mi(7),KesMomYZ(12,i,j)]);
     end
   
end

end

for j=1:1:size(YZDgm,3) %>> -Ey+1.4G+1.6Q;

E=21e7;
A=0.16;
I=2.13e-3;


    KordinatlarYZj=KordinatlarYZ(:,:,j);
    AksElemanlarj=YZAksEleman(1:sum(YZAksEleman(:,j)~=0),j);
    ElemanUclariYZj=ElemanUclariYZ(1:sum(ElemanUclariYZ(:,:,j)~=0),1:2,j);
    dserbestj=dserbest(:,j);

    Faj=zeros(3*length(unique(ElemanUclariYZj)),1);
    FaElemanj=FaEleman(1:sum(FaEleman(:,j)~=0),j);
    FaNoktaj=ElemanUclariYZj(FaElemanj,1:2);
    Fj=Feksi(:,j);
    
    
    
for i=1:1:length(AksElemanlarj)
        Li(i)=sqrt((KordinatlarYZj(find(ElemanUclariYZj(i,2)==NokYZ(:,1,j)),1)-KordinatlarYZj(find(ElemanUclariYZj(i,1)==NokYZ(:,1,j)),1))^2+(KordinatlarYZj(find(ElemanUclariYZj(i,2)==NokYZ(:,1,j)),2)-KordinatlarYZj(find(ElemanUclariYZj(i,1)==NokYZ(:,1,j)),2))^2);
 lx(i)=(KordinatlarYZj(find(ElemanUclariYZj(i,2)==NokYZ(:,1,j)),1)-KordinatlarYZj(find(ElemanUclariYZj(i,1)==NokYZ(:,1,j)),1))/Li(i);
 ly(i)=(KordinatlarYZj(find(ElemanUclariYZj(i,2)==NokYZ(:,1,j)),2)-KordinatlarYZj(find(ElemanUclariYZj(i,1)==NokYZ(:,1,j)),2))/Li(i);
 
 T(:,:,i)=[lx(i) ly(i) 0 0 0 0;
    -ly(i) lx(i) 0 0 0 0;
    0 0 1 0 0 0;
    0 0 0 lx(i) ly(i) 0;
    0 0 0 -ly(i) lx(i) 0;
    0 0 0 0 0 1];
 
Kiy(:,:,i)=[E*A/Li(i) 0 0 -E*A/Li(i) 0 0;
           0 12*E*I/Li(i)^3 6*E*I/Li(i)^2 0 -12*E*I/Li(i)^3 6*E*I/Li(i)^2;
           0 6*E*I/Li(i)^2 4*E*I/Li(i) 0 -6*E*I/Li(i)^2 2*E*I/Li(i);
           -E*A/Li(i) 0 0 E*A/Li(i) 0 0;
           0 -12*E*I/Li(i)^3 -6*E*I/Li(i)^2 0 12*E*I/Li(i)^3 -6*E*I/Li(i)^2;
           0 6*E*I/Li(i)^2 2*E*I/Li(i) 0 -6*E*I/Li(i)^2 4*E*I/Li(i);];
 
        
        Kig(:,:,i)=T(:,:,i)'*Kiy(:,:,i)*T(:,:,i);
 
 Kni(1,i)=3*find(ElemanUclariYZj(i,1)==NokYZ(:,1,j))-2;
 Kni(2,i)=3*find(ElemanUclariYZj(i,1)==NokYZ(:,1,j))-1;
 Kni(3,i)=3*find(ElemanUclariYZj(i,1)==NokYZ(:,1,j));
 Kni(4,i)=3*find(ElemanUclariYZj(i,2)==NokYZ(:,1,j))-2;
 Kni(5,i)=3*find(ElemanUclariYZj(i,2)==NokYZ(:,1,j))-1;
 Kni(6,i)=3*find(ElemanUclariYZj(i,2)==NokYZ(:,1,j));

end

            


for i=1:1:length(FaElemanj);       %Yayýlý yüklerin ankastrelik yükleri
    el=FaElemanj(i,1);
            noki=find(ElemanUclariYZ(el,1,j)==NokYZ(:,1,j));
            Faj(3*noki-2:3*noki)=Faj(3*noki-2:3*noki)+[0;qy(el,j)*Li(el)/2;qy(el,j)*Li(el)^2/12];
            nokj=find(ElemanUclariYZ(el,2,j)==NokYZ(:,1,j));
            Faj(3*nokj-2:3*nokj)=Faj(3*nokj-2:3*nokj)+[0;qy(el,j)*Li(el)/2;-qy(el,j)*Li(el)^2/12];
end


Fj=Fj+Faj;

    K=zeros(max(Kni(:)),max(Kni(:)));
for e=1:1:length(AksElemanlarj);
for i=1:1:6;
    for k=1:1:6;
        
    K(Kni(i,e),Kni(k,e))=K(Kni(i,e),Kni(k,e))+Kig(i,k,e);
    
    end
end
end
d=zeros(length(KordinatlarYZj)*3,1);

d(dserbestj(dserbestj~=0))=K(dserbestj(dserbestj~=0),dserbestj(dserbestj~=0))\Fj(dserbestj(dserbestj~=0));

Fj=Fj-Faj;

Fj=K*d;

for i=1:1:length(AksElemanlarj);

    dyer(:,:,i)=T(:,:,i)*d(Kni(:,i));
    fx(:,i,j)=Kiy(:,:,i)*dyer(:,:,i)+Faj(Kni(:,i));
    fx(:,i,j)=fx(:,i,j);
    
    Fsol=fx(1:3,i,j);
    Fsag=fx(4:6,i,j);

    V=[-qy(i) Fsol(2)];
    x=[0 0.5 1 1.5 2 2.5 3];
    Vi=polyval(V,x);
    
    M=[-qy(i)/2 1*Fsol(2) -Fsol(3)];
    x=[0 0.5 1 1.5 2 2.5 3];
    Mi=polyval(M,x);

     L=Li(i);
     
     TekTemTasYZ(4:6,i,j)=fx(1:3,i,j);
    
    if sign(Vi(1))==1;
         KesMomYZ(1,i,j)=max([Vi(1),KesMomYZ(1,i,j)]);
     else
         KesMomYZ(7,i,j)=min([Vi(1),KesMomYZ(7,i,j)]);
     end
     if sign(Vi(4))==1;
         KesMomYZ(2,i,j)=max([Vi(4),KesMomYZ(2,i,j)]);
     else
         KesMomYZ(8,i,j)=min([Vi(4),KesMomYZ(8,i,j)]);
     end
     if sign(Vi(7))==1;
         KesMomYZ(3,i,j)=max([Vi(7),KesMomYZ(3,i,j)]);
     else
         KesMomYZ(9,i,j)=min([Vi(7),KesMomYZ(9,i,j)]);
     end
     if sign(Mi(1))==1;
         KesMomYZ(4,i,j)=max([Mi(1),KesMomYZ(4,i,j)]);
     else
         KesMomYZ(10,i,j)=min([Mi(1),KesMomYZ(10,i,j)]);
     end
     if sign(Mi(4))==1;
         KesMomYZ(5,i,j)=max([Mi(4),KesMomYZ(5,i,j)]);
     else
         KesMomYZ(11,i,j)=min([Mi(4),KesMomYZ(11,i,j)]);
     end
     if sign(Mi(7))==1;
         KesMomYZ(6,i,j)=max([Mi(7),KesMomYZ(6,i,j)]);
     else
         KesMomYZ(12,i,j)=min([Mi(7),KesMomYZ(12,i,j)]);
     end
   
end

end

for j=1:1:size(YZDgm,3) %>>1.4G+1.6Q

E=21e7;
A=0.16;
I=2.13e-3;


    KordinatlarYZj=KordinatlarYZ(:,:,j);
    AksElemanlarj=YZAksEleman(1:sum(YZAksEleman(:,j)~=0),j);
    ElemanUclariYZj=ElemanUclariYZ(1:sum(ElemanUclariYZ(:,:,j)~=0),1:2,j);
    dserbestj=dserbest(:,j);

    Faj=zeros(3*length(unique(ElemanUclariYZj)),1);
    FaElemanj=FaEleman(1:sum(FaEleman(:,j)~=0),j);
    FaNoktaj=ElemanUclariYZj(FaElemanj,1:2);
 
    Fj=F(:,j);
    Fj(:)=0;
    
    
for i=1:1:length(AksElemanlarj);
        Li(i)=sqrt((KordinatlarYZj(find(ElemanUclariYZj(i,2)==NokYZ(:,1,j)),1)-KordinatlarYZj(find(ElemanUclariYZj(i,1)==NokYZ(:,1,j)),1))^2+(KordinatlarYZj(find(ElemanUclariYZj(i,2)==NokYZ(:,1,j)),2)-KordinatlarYZj(find(ElemanUclariYZj(i,1)==NokYZ(:,1,j)),2))^2);
 lx(i)=(KordinatlarYZj(find(ElemanUclariYZj(i,2)==NokYZ(:,1,j)),1)-KordinatlarYZj(find(ElemanUclariYZj(i,1)==NokYZ(:,1,j)),1))/Li(i);
 ly(i)=(KordinatlarYZj(find(ElemanUclariYZj(i,2)==NokYZ(:,1,j)),2)-KordinatlarYZj(find(ElemanUclariYZj(i,1)==NokYZ(:,1,j)),2))/Li(i);
 
 T(:,:,i)=[lx(i) ly(i) 0 0 0 0;
    -ly(i) lx(i) 0 0 0 0;
    0 0 1 0 0 0;
    0 0 0 lx(i) ly(i) 0;
    0 0 0 -ly(i) lx(i) 0;
    0 0 0 0 0 1];
 
Kiy(:,:,i)=[E*A/Li(i) 0 0 -E*A/Li(i) 0 0;
           0 12*E*I/Li(i)^3 6*E*I/Li(i)^2 0 -12*E*I/Li(i)^3 6*E*I/Li(i)^2;
           0 6*E*I/Li(i)^2 4*E*I/Li(i) 0 -6*E*I/Li(i)^2 2*E*I/Li(i);
           -E*A/Li(i) 0 0 E*A/Li(i) 0 0;
           0 -12*E*I/Li(i)^3 -6*E*I/Li(i)^2 0 12*E*I/Li(i)^3 -6*E*I/Li(i)^2;
           0 6*E*I/Li(i)^2 2*E*I/Li(i) 0 -6*E*I/Li(i)^2 4*E*I/Li(i);];
 
        
        Kig(:,:,i)=T(:,:,i)'*Kiy(:,:,i)*T(:,:,i);
 
 Kni(1,i)=3*find(ElemanUclariYZj(i,1)==NokYZ(:,1,j))-2;
 Kni(2,i)=3*find(ElemanUclariYZj(i,1)==NokYZ(:,1,j))-1;
 Kni(3,i)=3*find(ElemanUclariYZj(i,1)==NokYZ(:,1,j));
 Kni(4,i)=3*find(ElemanUclariYZj(i,2)==NokYZ(:,1,j))-2;
 Kni(5,i)=3*find(ElemanUclariYZj(i,2)==NokYZ(:,1,j))-1;
 Kni(6,i)=3*find(ElemanUclariYZj(i,2)==NokYZ(:,1,j));

end

            


for i=1:1:length(FaElemanj);       %Yayýlý yüklerin ankastrelik yükleri
    el=FaElemanj(i,1);
            noki=find(ElemanUclariYZ(el,1,j)==NokYZ(:,1,j));
            Faj(3*noki-2:3*noki)=Faj(3*noki-2:3*noki)+[0;qy(el,j)*Li(el)/2;qy(el,j)*Li(el)^2/12];
            nokj=find(ElemanUclariYZ(el,2,j)==NokYZ(:,1,j));
            Faj(3*nokj-2:3*nokj)=Faj(3*nokj-2:3*nokj)+[0;qy(el,j)*Li(el)/2;-qy(el,j)*Li(el)^2/12];
end

Fj=Fj+Faj;

    K=zeros(max(Kni(:)),max(Kni(:)));
for e=1:1:length(AksElemanlarj);
for i=1:1:6;
    for k=1:1:6;
        
    K(Kni(i,e),Kni(k,e))=K(Kni(i,e),Kni(k,e))+Kig(i,k,e);
    
    end
end
end
d=zeros(length(KordinatlarYZj)*3,1);

d(dserbestj(dserbestj~=0))=K(dserbestj(dserbestj~=0),dserbestj(dserbestj~=0))\Fj(dserbestj(dserbestj~=0));

Fj=Fj-Faj;

Fj=K*d;

for i=1:1:length(AksElemanlarj);

    dyer(:,:,i)=T(:,:,i)*d(Kni(:,i));
    fx(:,i,j)=Kiy(:,:,i)*dyer(:,:,i)+Faj(Kni(:,i));
    fx(:,i,j)=fx(:,i,j);
    
    Fsol=fx(1:3,i,j);
    Fsag=fx(4:6,i,j);

    V=[-qy(i) Fsol(2)];
    x=[0 0.5 1 1.5 2 2.5 3];
    Vi=polyval(V,x);
    
    M=[-qy(i)/2 1*Fsol(2) -Fsol(3)];
    x=[0 0.5 1 1.5 2 2.5 3];
    Mi=polyval(M,x);

     L=Li(i);
    
     TekTemTasYZ(7:9,i,j)=fx(1:3,i,j);
     
    if sign(Vi(1))==1;
         KesMomYZ(1,i,j)=max([Vi(1),KesMomYZ(1,i,j)]);
     else
         KesMomYZ(7,i,j)=min([Vi(1),KesMomYZ(7,i,j)]);
     end
     if sign(Vi(4))==1;
         KesMomYZ(2,i,j)=max([Vi(4),KesMomYZ(2,i,j)]);
     else
         KesMomYZ(8,i,j)=min([Vi(4),KesMomYZ(8,i,j)]);
     end
     if sign(Vi(7))==1;
         KesMomYZ(3,i,j)=max([Vi(7),KesMomYZ(3,i,j)]);
     else
         KesMomYZ(9,i,j)=min([Vi(7),KesMomYZ(9,i,j)]);
     end
     if sign(Mi(1))==1;
         KesMomYZ(4,i,j)=max([Mi(1),KesMomYZ(4,i,j)]);
     else
         KesMomYZ(10,i,j)=min([Mi(1),KesMomYZ(10,i,j)]);
     end
     if sign(Mi(4))==1;
         KesMomYZ(5,i,j)=max([Mi(4),KesMomYZ(5,i,j)]);
     else
         KesMomYZ(11,i,j)=min([Mi(4),KesMomYZ(11,i,j)]);
     end
     if sign(Mi(7))==1;
         KesMomYZ(6,i,j)=max([Mi(7),KesMomYZ(6,i,j)]);
     else
         KesMomYZ(12,i,j)=min([Mi(7),KesMomYZ(12,i,j)]);
     end
   
end

end

%% Kiriþ ve Kolonlara Gelen Kuvvetlerin Düzenlenmesi

for i=1:1:size(XZAksEleman,1) %>> Kiriþlere Gelen Kuvvetlerin Tekrar Düzenlenmesi
    for j=1:1:size(XZAksEleman,2)
        if floor(XZAksEleman(i,j)/1000)==2 %Kiriþ
        Kiris=mod(XZAksEleman(i,j),1000);
        KirisKat=floor(Kiris/100);
        KirisNum=mod(Kiris,100);
        TasarimDegerlerKir(:,KirisNum,KirisKat)=KesMomXZ(:,i,j);
        end
    end
end

for i=1:1:size(YZAksEleman,1); %>> Kiriþlere Gelen Kuvvetlerin Tekrar Düzenlenmesi
    for j=1:1:size(YZAksEleman,2);
        if floor(YZAksEleman(i,j)/1000)==2; %Kiriþ
        Kiris=mod(YZAksEleman(i,j),1000);
        KirisKat=floor(Kiris/100);
        KirisNum=mod(Kiris,100);
        TasarimDegerlerKir(:,KirisNum,KirisKat)=KesMomYZ(:,i,j);
        end
    end
end

for i=1:1:size(XZAksEleman,1); %>> Kolonlara Gelen Kuvvetlerin Tekrar Düzenlenmesi
    for j=1:1:size(XZAksEleman,2);
        if floor(XZAksEleman(i,j)/1000)==1 %Kolon
        Kolon=mod(XZAksEleman(i,j),1000);
        KolonKat=floor(Kolon/100);
        KolonNum=mod(Kolon,100);
        TasarimDegerlerKol(:,KolonNum,KolonKat)=KesMomXZ(:,i,j);
        if KolonKat==1;
        TemelNdVdMd(1:9,KolonNum,1)=TekTemTasXZ(:,i,j);
        end
        end
    end
end

for i=1:1:size(YZAksEleman,1); %>> Kolonlara Gelen Kuvvetlerin Tekrar Düzenlenmesi
    for j=1:1:size(YZAksEleman,2);
        if floor(YZAksEleman(i,j)/1000)==1; %Kolon
        Kolon=mod(YZAksEleman(i,j),1000);
        KolonKat=floor(Kolon/100);
        KolonNum=mod(Kolon,100);
        TasarimDegerlerKol(:,KolonNum,KolonKat)=KesMomYZ(:,i,j);
        if KolonKat==1;
        TemelNdVdMd(10:18,KolonNum,1)=TekTemTasYZ(:,i,j);
        end
        end
    end
end


%%
z=length(Kat(1,1,:));
x=length(Kat(1,:,1));
y=length(Kat(:,1,1));


for k=1:1:z;
for i=3:1:y+2;
    for j=3:1:x+2;
        Kir=cell2mat(Katv2(i,j,k));
        
        if strcmp(Kir(1,1),'k')==1;
            
            birUst=cell2mat(Katv2(i-1,j,k));
            birAlt=cell2mat(Katv2(i+1,j,k));
            birSol=cell2mat(Katv2(i,j-1,k));
            birSag=cell2mat(Katv2(i,j+1,k));
            
            KirisNum=mod(str2num(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
            
            dk(KirisNum,1,k)=hk(KirisNum,1,k)*10-fiKirEt-fiKirBoy/2-20;
            
        if strcmp('s',birUst(1,1))==1 && strcmp('s',birAlt(1,1))==1;
            
            if strcmp('d',birSol(1,1))==1 && strcmp('d',birSag(1,1))==1;
                bf(KirisNum,1,k)=bk(KirisNum,1,k)/100+0.2*lp(KirisNum,1,k);
                bf(KirisNum,2:3,k)=1;
       else if strcmp('d',birSol(1,1))==1 && strcmp('d',birSag(1,1))==0;
                bf(KirisNum,1,k)=bk(KirisNum,1,k)/100+0.1*lp(KirisNum,1,k);
                bf(KirisNum,2,k)=1;
                bf(KirisNum,3,k)=0;
       else if strcmp('d',birSol(1,1))==0 && strcmp('d',birSag(1,1))==1;
                bf(KirisNum,1,k)=bk(KirisNum,1,k)/100+0.1*lp(KirisNum,1,k);
                bf(KirisNum,2,k)=0;
                bf(KirisNum,3,k)=1;
           end
           end
           end
           
   else if strcmp('s',birSol(1,1))==1 && strcmp('s',birSag(1,1))==1;
           
            if strcmp('d',birUst(1,1))==1 && strcmp('d',birAlt(1,1))==1;
                bf(KirisNum,1,k)=bk(KirisNum,1,k)/100+0.2*lp(KirisNum,1,k);
                bf(KirisNum,2:3,k)=1;
       else if strcmp('d',birUst(1,1))==1 && strcmp('d',birAlt(1,1))==0;
                bf(KirisNum,1,k)=bk(KirisNum,1,k)/100+0.1*lp(KirisNum,1,k);
                bf(KirisNum,2,k)=1;
                bf(KirisNum,3,k)=0;
       else if strcmp('d',birUst(1,1))==0 && strcmp('d',birAlt(1,1))==1;
                bf(KirisNum,1,k)=bk(KirisNum,1,k)/100+0.1*lp(KirisNum,1,k);
                bf(KirisNum,2,k)=0;
                bf(KirisNum,3,k)=1;
           end
           end
           end
            end
        end
        end
    end
end
end

%% Tablalý Kiriþlerin Hesabý

for m=4:1:6 %Üst Basýnç Alt Çekme T(Tablalý Kiriþ) Moment +
for k=1:1:z;
for i=3:1:y+2;
    for j=3:1:x+2;
        Kir=cell2mat(Katv2(i,j,k));
        if strcmp(Kir(1,1),'k')==1;
            KirisNum=mod(str2num(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
            Mr=0.85*fcd*bf(KirisNum,1,k)*1000*hfmin(k,1)*10*(dk(KirisNum,1,k)-(hfmin(k,1)*10)/2)*10^-6;
            Md=TasarimDegerlerKir(m,KirisNum,k);
            
        if Md>Mr;
            
        Fcf=0.85*fcd*hfmin(k,1)*10*(bf(KirisNum,1,k)*1000-bk(KirisNum,1,k)*10);
        Asf=(Fcf/fyd); %mm^2
        Mf=Fcf*(dk(KirisNum,1,k)-(hfmin(k,1)*10)/2)*(10^-6);
        Mw=Md-Mf;
        kmw=(Mw*10^6)/(bk(KirisNum,1,k)*10*dk(KirisNum,1,k)^2);
        
        while (2*kmw)/(0.85*fcd)>=1;
            
        bk(KirisNum,1,k)=bk(KirisNum,1,k)+5;
        hk(KirisNum,1,k)=hk(KirisNum,1,k)+10;
        dk(KirisNum,1,k)=hk(KirisNum,1,k)*10-fiKirEt-fiKirBoy/2-20;   
            
        Fcf=0.85*fcd*hfmin(k,1)*10*(bf(KirisNum,1,k)*1000-bk(KirisNum,1,k)*10);
        Asf=(Fcf/fyd); %mm^2
        Mf=Fcf*(dk(KirisNum,1,k)-(hfmin(k,1)*10)/2)*(10^-6);
        Mw=Md-Mf;
        kmw=(Mw*10^6)/(bk(KirisNum,1,k)*10*dk(KirisNum,1,k)^2);    
        end
        
        Row=0.85*(fcd/fyd)*(1-sqrt(1-((2*kmw)/(0.85*fcd))));
        Asw=Row*bk(KirisNum,1,k)*10*dk(KirisNum,1,k);
        As(KirisNum,m-3,k)=Asw+Asf;
        
        else
            
        
        RoUs=0.85*(fcd/fyd)*(1-sqrt(1-(2*(Md*10^6)/(bf(KirisNum,1,k)*1000*(dk(KirisNum,1,k)^2)))/(0.85*fcd)));
        As(KirisNum,m-3,k)=RoUs*bf(KirisNum,1,k)*1000*dk(KirisNum,1,k); 
        end
        
            Ro(KirisNum,1,k)=As(KirisNum,m-3,k)/(bk(KirisNum,1,k)*10*dk(KirisNum,1,k));
            Rob=0.85*0.82*(fcd/fyd)*(600/(600+fyd))*((bf(KirisNum,1,k)*1000)/(bk(KirisNum,1,k)*10));
            Ros=0.235*(fcd/fyd);
            Romax=min([0.0200,Rob,Ros]);
            Romin=0.8*(fctd/fyd);
            
            if Romin>Ro(KirisNum,1,k);
            Ro(KirisNum,1,k)=Romin;
            As(KirisNum,m-3,k)=Ro(KirisNum,1,k)*bk(KirisNum,1,k)*10*dk(KirisNum,1,k);
                
            else if Ro(KirisNum,1,k)>=Romax %%!!!!
            bk(KirisNum,1,k)=bk(KirisNum,1,k)+5;
            hk(KirisNum,1,k)=hk(KirisNum,1,k)+10;
            dk(KirisNum,1,k)=hk(KirisNum,1,k)*10-fiKirEt-fiKirBoy/2-20;
              
            while Romin<=Ro(KirisNum,1,k) && Ro(KirisNum,1,k)<=Romax;
                
                if Md>Mr;
            
        Fcf=0.85*fcd*hfmin(k,1)*10*(bf(KirisNum,1,k)*1000-bk(KirisNum,1,k)*10);
        Asf=(Fcf/fyd); %mm^2
        Mf=Fcf*(dk(KirisNum,1,k)-(hfmin(k,1)*10)/2)*(10^-6);
        Mw=Md-Mf;
        kmw=(Mw*10^6)/(bk(KirisNum,1,k)*10*dk(KirisNum,1,k)^2);
        
        while (2*kmw)/(0.85*fcd)>=1;
            
        bk(KirisNum,1,k)=bk(KirisNum,1,k)+5;
        hk(KirisNum,1,k)=hk(KirisNum,1,k)+10;
        dk(KirisNum,1,k)=hk(KirisNum,1,k)*10-fiKirEt-fiKirBoy/2-20;   
            
        Fcf=0.85*fcd*hfmin(k,1)*10*(bf(KirisNum,1,k)*1000-bk(KirisNum,1,k)*10);
        Asf=(Fcf/fyd); %mm^2
        Mf=Fcf*(dk(KirisNum,1,k)-(hfmin(k,1)*10)/2)*(10^-6);
        Mw=Md-Mf;
        kmw=(Mw*10^6)/(bk(KirisNum,1,k)*10*dk(KirisNum,1,k)^2);    
        end
        
        Row=0.85*(fcd/fyd)*(1-sqrt(1-((2*kmw)/(0.85*fcd))));
        Asw=Row*bk(KirisNum,1,k)*10*dk(KirisNum,1,k);
        As(KirisNum,m-3,k)=Asw+Asf;
        
        else
            
        
        RoUs=0.85*(fcd/fyd)*(1-sqrt(1-(2*(Md*10^6)/(bf(KirisNum,1,k)*1000*(dk(KirisNum,1,k)^2)))/(0.85*fcd)));
        As(KirisNum,m-3,k)=RoUs*bf(KirisNum,1,k)*1000*dk(KirisNum,1,k); 
        end
        
            Ro(KirisNum,1,k)=As(KirisNum,m-3,k)/(bk(KirisNum,1,k)*10*dk(KirisNum,1,k));
            Rob=0.85*0.82*(fcd/fyd)*(600/(600+fyd))*((bf(KirisNum,1,k)*1000)/(bk(KirisNum,1,k)*10));
            Ros=0.235*(fcd/fyd);
            Romax=min([0.0200,Rob,Ros]);
            Romin=0.8*(fctd/fyd);
            
            if Romin>Ro(KirisNum,1,k);
            Ro(KirisNum,1,k)=Romin;
            As(KirisNum,m-3,k)=Ro(KirisNum,1,k)*bk(KirisNum,1,k)*10*dk(KirisNum,1,k);
                
            else if Ro(KirisNum,1,k)>=Romax; %%!!!!
            bk(KirisNum,1,k)=bk(KirisNum,1,k)+5;
            hk(KirisNum,1,k)=hk(KirisNum,1,k)+10;
            dk(KirisNum,1,k)=hk(KirisNum,1,k)*10-fiKirEt-fiKirBoy/2-20;
            
            end
                end 
            end
        end
            end
        end
    end
end
end
end


for m=10:1:12 %Alt Basýnç Üst Çekme T(Tablalý Kiriþ(Dikdörtgen Kiriþ Gibi Düþünülür Beton Çekme Dayanýmý Çok Düþük)) Moment (-)
for k=1:1:z;
for i=3:1:y+2;
    for j=3:1:x+2;
        Kir=cell2mat(Katv2(i,j,k));
        if strcmp(Kir(1,1),'k')==1;
            KirisNum=mod(str2num(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
            Md=abs(TasarimDegerlerKir(m,KirisNum,k));
            if Md>0
            
            Ro(KirisNum,1,k)=2;
            Romax=1;
            while Ro(KirisNum,1,k) >= Romax;
            ai=dk(KirisNum,1,k)*0.15;
            ai1=ai+0.25;
            while abs(ai1-ai) > 1;
            As(KirisNum,m-6,k)=(Md*10^6)/(fyd*(dk(KirisNum,1,k)-ai/2));
            ai1=((As(KirisNum,m-6,k))*fyd)/(0.85*fcd*bk(KirisNum,1,k)*10);
            ai=ai-0.5;
            end
            a=ai1;
            As(KirisNum,m-6,k)=(Md*10^6)/(fyd*(dk(KirisNum,1,k)-a/2));
            Ro(KirisNum,1,k)=As(KirisNum,m-6,k)/(bk(KirisNum,1,k)*10*dk(KirisNum,1,k));
            Rob=0.85*0.85*(fcd/fyd)*(600/(600+fyd))*((bf(KirisNum,1,k)*1000)/(bk(KirisNum,1,k)*10));
            Ros=0.235*(fcd/fyd);
            Romax=min([0.0200,Rob,Ros]);
            Romin=0.8*(fctd/fyd);
            if Romin>Ro(KirisNum,1,k);
                Ro(KirisNum,1,k)=Romin;
            As(KirisNum,m-6,k)=Ro(KirisNum,1,k)*bk(KirisNum,1,k)*10*dk(KirisNum,1,k);     
            else if Ro(KirisNum,1,k)>=Romax;
            bk(KirisNum,1,k)=bk(KirisNum,1,k)+5;
            hk(KirisNum,1,k)=hk(KirisNum,1,k)+10;
            dk(KirisNum,1,k)=hk(KirisNum,1,k)*10-fiKirEt-fiKirBoy/2-20;
                    
                end
            end
            
            end
            end
        end
    end
end
end
end

As(find(As(:)<=307))=307;


KirisDonSay=ceil(As/((pi()*fiKirBoy^2)/4));
fiKirisBoyCap=zeros(size(KirisDonSay,1),size(KirisDonSay,2),size(KirisDonSay,3));
fiKirisBoyCap(:)=14;

for m=1:1:6
for k=1:1:z; % Donatýlarýn Bastýrýlmasý
for i=3:1:y+2;
    for j=3:1:x+2;
        Kir=cell2mat(Katv2(i,j,k));
        if strcmp(Kir(1,1),'k')==1;
            KirisNum=mod(str2num(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
            e1=(bk(KirisNum,1,k)*10-KirisDonSay(KirisNum,m,k)*fiKirisBoyCap(KirisNum,m,k))/(KirisDonSay(KirisNum,m,k)-1);
            
            
            while  e1<min([25 fiKirisBoyCap(KirisNum,m,k)]); %Donatýlarýn Kiriþ Alt veya Üst Bölgesine Sýgmasý Ýçin Donatý Çapýnýn Artýrýlmasý
                fiKirisBoyCap(KirisNum,m,k)=fiKirisBoyCap(KirisNum,m,k)+2;
                KirisDonSay(KirisNum,m,k)=ceil(As(KirisNum,m,k)/((pi()*fiKirisBoyCap(KirisNum,m,k)^2)/4));
                e1=(bk(KirisNum,1,k)*10-KirisDonSay(KirisNum,m,k)*fiKirisBoyCap(KirisNum,m,k))/(KirisDonSay(KirisNum,m,k)-1);
            end
            
        end
    end
end
end
end

%% Kiriþ Etriye Hesabý

for m=[2 8] %Kesme Deðerlerine Göre Açýklýk Bölgesindeki Kiriþ Etriyelerinin Belirlenmesi
for k=1:1:z;
for i=3:1:y+2;
    for j=3:1:x+2;
        Kir=cell2mat(Katv2(i,j,k));
        if strcmp(Kir(1,1),'k')==1;
            KirisNum=mod(str2num(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
            Vd=abs(TasarimDegerlerKir(m,KirisNum,k))*10^3;
            Vrmax=Vd-10;
            while Vrmax < Vd;
            Vcr=0.65*fctd*bk(KirisNum,1,k)*10*dk(KirisNum,1,k);
            Vrmax=0.22*fcd*bk(KirisNum,1,k)*10*dk(KirisNum,1,k);
            Asw=2*(pi()*fiKirEt^2)/4;
            if Vd < Vcr;
                
                KirEtAralik(KirisNum,m,k)=(Asw*fyd)/(bk(KirisNum,1,k)*10*0.3*fctd);
                if KirEtAralik(KirisNum,m,k) < dk(KirisNum,1,k)/2;
                    KirEtAralik(KirisNum,m,k)=dk(KirisNum,1,k)/2;
                end
                if Vd > Vcr*3;
                    KirEtAralik(KirisNum,m,k)=dk(KirisNum,1,k)/4;
                end
                
            else if Vcr < Vd && Vd < Vrmax;
                Vc=0.8*Vcr;
                Vw=Vd-Vc;
                KirEtAralik(KirisNum,m,k)=(fyd*dk(KirisNum,1,k)*Asw)/(Vw);
                
                if KirEtAralik(KirisNum,m,k) < dk(KirisNum,1,k)/2;
                    KirEtAralik(KirisNum,m,k)=dk(KirisNum,1,k)/2;
                end
                if Vd > Vcr*3
                    KirEtAralik(KirisNum,m,k)=dk(KirisNum,1,k)/4;
                end
                
            else if Vrmax < Vd
            bk(KirisNum,1,k)=bk(KirisNum,1,k)+5;
            hk(KirisNum,1,k)=hk(KirisNum,1,k)+10;
            dk(KirisNum,1,k)=hk(KirisNum,1,k)*10-fiKirEt-fiKirBoy/2-20;         
            end
            end
            end
            
            end     
        end
    end
end
end
end

for m=[1 3 7 9] %Kesme Deðerlerine Göre Mesnet Bölgelerindeki Kiriþ Etriyelerinin Belirlenmesi
for k=1:1:z;
for i=3:1:y+2;
    for j=3:1:x+2;
        Kir=cell2mat(Katv2(i,j,k));
        if strcmp(Kir(1,1),'k')==1;
            KirisNum=mod(str2num(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
            Vd=abs(TasarimDegerlerKir(m,KirisNum,k))*10^3;
            Vrmax=Vd-10;
            while Vrmax < Vd;
            Vcr=0.65*fctd*bk(KirisNum,1,k)*10*dk(KirisNum,1,k);
            Vrmax=0.22*fcd*bk(KirisNum,1,k)*10*dk(KirisNum,1,k);
            Asw=2*(pi()*fiKirEt^2)/4;
            if Vd < Vcr;
                
                KirEtAralik(KirisNum,m,k)=(Asw*fyd)/(bk(KirisNum,1,k)*10*0.3*fctd);
                if KirEtAralik(KirisNum,m,k) < min([dk(KirisNum,1,k)/4,8*min(fiKirisBoyCap(KirisNum,:,k),150)]);
                    KirEtAralik(KirisNum,m,k)=min([dk(KirisNum,1,k)/4,8*min(fiKirisBoyCap(KirisNum,:,k),150)]);
                end
                
            else if Vcr < Vd && Vd < Vrmax;
                Vc=0.8*Vcr;
                Vw=Vd-Vc;
                KirEtAralik(KirisNum,m,k)=(fyd*dk(KirisNum,1,k)*Asw)/(Vw);
                
                if KirEtAralik(KirisNum,m,k) < min([dk(KirisNum,1,k)/4,8*min(fiKirisBoyCap(KirisNum,:,k),150)]);
                    KirEtAralik(KirisNum,m,k)=min([dk(KirisNum,1,k)/4,8*min(fiKirisBoyCap(KirisNum,:,k),150)]);
                end
                
            else if Vrmax < Vd;
                    asdasd=asdasd+1;
            bk(KirisNum,1,k)=bk(KirisNum,1,k)+5;
            hk(KirisNum,1,k)=hk(KirisNum,1,k)+10;
            dk(KirisNum,1,k)=hk(KirisNum,1,k)*10-fiKirEt-fiKirBoy/2-20;         
            end
            end
            end
            end
            KirEtSarilmaUz(KirisNum,1,k)=hk(KirisNum,1,k)*2;
            KirEtAciklikUz(KirisNum,1,k)=KirisUz(KirisNum,1,k)-hk(KirisNum,1,k)*2*2;
        end
    end
end
end
end

KirEtAciklikUz(find(sign(KirEtAciklikUz(:,:,1))==-1))=0

for k=1:1:z; %Min Kiris Etriye Aralýklarýnýn Belirlenmesi (s)
for i=3:1:y+2;
    for j=3:1:x+2;
        Kir=cell2mat(Katv2(i,j,k));
        if strcmp(Kir(1,1),'k')==1;
            KirisNum=mod(str2num(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
            KirEtAralikMin(KirisNum,1,k)=floor(min([KirEtAralik(KirisNum,1,k) KirEtAralik(KirisNum,3,k) KirEtAralik(KirisNum,7,k) KirEtAralik(KirisNum,9,k)])./10);
            KirEtAralikMin(KirisNum,2,k)=floor(min([KirEtAralik(KirisNum,2,k) KirEtAralik(KirisNum,8,k)])./10);
        end
    end
end
end





%% Kiriþ Donatýlarýnýn Bastýrýlmasý

for k=1:1:z; % Donatýlarýn Bastýrýlmasý
for i=3:1:y+2;
    for j=3:1:x+2;
        Kir=cell2mat(Katv2(i,j,k));
        if strcmp(Kir(1,1),'k')==1;
            KirisNum=mod(str2num(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
            KN=KirisNum+100*k;
            KirisDonati{1,KirisNum,k}=sprintf('k%.0f Kiriþi Sol Mesnet Üst Donatýsý %.0f/Ø%.0f',KN,KirisDonSay(KirisNum,1,k),fiKirisBoyCap(KirisNum,1,k));
            KirisDonati{2,KirisNum,k}=sprintf('k%.0f Kiriþi Açýklýk Alt Donatýsý %.0f/Ø%.0f',KN,KirisDonSay(KirisNum,2,k),fiKirisBoyCap(KirisNum,2,k));
            KirisDonati{3,KirisNum,k}=sprintf('k%.0f Kiriþi Sag Mesnet Üst Donatýsý %.0f/Ø%.0f',KN,KirisDonSay(KirisNum,3,k),fiKirisBoyCap(KirisNum,3,k));
            KirisDonati{4,KirisNum,k}=sprintf('k%.0f Kiriþi Sol Mesnet Alt Donatýsý %.0f/Ø%.0f',KN,KirisDonSay(KirisNum,4,k),fiKirisBoyCap(KirisNum,4,k));
            KirisDonati{5,KirisNum,k}=sprintf('k%.0f Kiriþi Açýklýk Üst Donatýsý %.0f/Ø%.0f',KN,KirisDonSay(KirisNum,5,k),fiKirisBoyCap(KirisNum,5,k));
            KirisDonati{6,KirisNum,k}=sprintf('k%.0f Kiriþi Sag Mesnet Alt Donatýsý %.0f/Ø%.0f',KN,KirisDonSay(KirisNum,6,k),fiKirisBoyCap(KirisNum,6,k));
            
            KirisEtriye{1,KirisNum,k}=sprintf('k%.0f Kiriþi Sarýlma Bölgesi Uzunluðu %.0fcm, Etriye Sayýsý %.0f/Ø%.0f, (Aralýk)s=%.0f',KN,KirEtSarilmaUz(KirisNum,1,k),ceil(KirEtSarilmaUz(KirisNum,1,k)/KirEtAralikMin(KirisNum,1,k)),fiKirEt,KirEtAralikMin(KirisNum,1,k));
            KirisEtriye{2,KirisNum,k}=sprintf('k%.0f Kiriþi Açýklýk Bölgesi Uzunluðu %.0fcm, Etriye Sayýsý %.0f/Ø%.0f, (Aralýk)s=%.0f',KN,KirEtAciklikUz(KirisNum,1,k),ceil(KirEtAciklikUz(KirisNum,1,k)/KirEtAralikMin(KirisNum,2,k)),fiKirEt,KirEtAralikMin(KirisNum,1,k));

        end
    end
end
end






hold off
%% Kolon Boyulandýrma

for k=1:1:z;
for i=3:1:y+2;
    for j=3:1:x+2;
        Kol=cell2mat(Katv2(i,j,k));
        if strcmp(Kol(1,1),'s')==1;
            KolonNum=mod(str2num(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
            Nd=KolTopYuk(KolonNum,1,k)*10^3;
            
            Ftop=-1;
            Yuzde1F=-2;
            dus=35;
            Xp=dus;
            b=KolonKesit(KolonNum,1,k);
            h=KolonKesit(KolonNum,2,k);
            dus=40;
            d=h-dus;
            Es=2*10^5;
            a=Xp*0.85;
            fiKolDon=16;
            
            Mdmax=max(max(abs([TasarimDegerlerKol(4:6,KolonNum,z) TasarimDegerlerKol(10:12,KolonNum,z)])));
            MrKolon(KolonNum,1,k)=Mdmax-1;
            
            
            while MrKolon(KolonNum,1,k)<Mdmax;

            while Ftop>Yuzde1F || sign(Ftop)==-1;
    
            
            Ast=((pi()*fiKolDon^2)/4)*3;
            Ast2=((pi()*fiKolDon^2)/4)*2;

            Nd=500000;

            es3=(0.003/(h/2))*(Xp-dus);
            es2=(0.003/(h/2))*(h/2-Xp);
            es1=(0.003/(h/2))*(h-Xp-dus);

            sigmas3=Es*es3;
            sigmas2=Es*es2;
            sigmas1=Es*es1;


                if sigmas3>fyd;
                sigmas3=fyd;
                end
                if sigmas2>fyd;
                sigmas2=fyd;
                end
                if sigmas1>fyd;
                sigmas1=fyd;
                end

                Fc=0.85*fcd*b*a;
                Ft3=sigmas3*Ast;
                Ft2=sigmas2*Ast2;
                Ft1=sigmas1*Ast;


                Ftop=Fc+Ft3-Ft2-Ft1-Nd;

                Yuzde1F=0.01*(Fc+Ft3);

                Xp=Xp+0.01;
                a=0.85*Xp;
            end
                MrKolon(KolonNum,1,k)=(Fc*(h/2-a/2)+Ft3*(h/2-dus)+Ft1*(h/2-dus))*10^-6;
                
                if MrKolon(KolonNum,1,k)<Mdmax;
                    b=b+50;
                    h=h+50;
                    fiKolDon=fiKolDon+2;
                end
            bkol(KolonNum,1,k)=b;
            hkol(KolonNum,1,k)=h;
            KolonDonati(KolonNum,1,k)=fiKolDon;
            KolonDonati(KolonNum,2,k)=((pi()*fiKolDon^2)/4)*8;
            KolonDonati(KolonNum,3,k)=KolonDonati(KolonNum,2,k)/(b*h);
            while KolonDonati(KolonNum,3,k)<0.01;
                fiKolDon=fiKolDon+2;
                KolonDonati(KolonNum,2,k)=((pi()*fiKolDon^2)/4)*8;
                KolonDonati(KolonNum,3,k)=KolonDonati(KolonNum,2,k)/(b*h);
            end
            end
        end
    end
end
end

dkol=hkol-KolonDonati(:,1,:)/2-fiKolEt-20;

for m=[2 8] %Kesme Deðerlerine Göre Açýklýk Bölgesindeki Kolon Etriyelerinin Belirlenmesi
for k=1:1:z;
for i=3:1:y+2;
    for j=3:1:x+2;
        Kir=cell2mat(Katv2(i,j,k));
        if strcmp(Kir(1,1),'s')==1;
            KolonNum=mod(str2num(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
            Vd=abs(TasarimDegerlerKol(m,KolonNum,k))*10^3;
            Vrmax=Vd-10;
            while Vrmax < Vd;
            Vcr=0.65*fctd*bkol(KolonNum,1,k)*10*dkol(KolonNum,1,k);
            Vrmax=0.22*fcd*bkol(KolonNum,1,k)*10*dkol(KolonNum,1,k);
            Asw=2*(pi()*fiKolEt^2)/4;
            if Vd < Vcr;
                
                KolEtAralik(KolonNum,m,k)=(Asw*fyd)/(bkol(KolonNum,1,k)*10*0.3*fctd);
                if KolEtAralik(KolonNum,m,k) < dkol(KolonNum,1,k)/2;
                    KolEtAralik(KolonNum,m,k)=dkol(KolonNum,1,k)/2;
                end
                if Vd > Vcr*3;
                    KolEtAralik(KolonNum,m,k)=dkol(KolonNum,1,k)/4;
                end
                
            else if Vcr < Vd && Vd < Vrmax;
                Vc=0.8*Vcr;
                Vw=Vd-Vc;
                KolEtAralik(KolonNum,m,k)=(fyd*dkol(KolonNum,1,k)*Asw)/(Vw);
                
                if KolEtAralik(KolonNum,m,k) < dkol(KolonNum,1,k)/2;
                    KolEtAralik(KolonNum,m,k)=dkol(KolonNum,1,k)/2;
                end
                if Vd > Vcr*3;
                    KolEtAralik(KolonNum,m,k)=dkol(KolonNum,1,k)/4;
                end
                
            else if Vrmax < Vd
            bkol(KolonNum,1,k)=bkol(KolonNum,1,k)+5;
            hkol(KolonNum,1,k)=hkol(KolonNum,1,k)+10;
            dkol(KolonNum,1,k)=hk(KolonNum,1,k)*10-fiKirEt-KolonDonati(KolonNum,1,k)/2-20;         
            end
            end
            end
            
            end     
        end
    end
end
end
end

for m=[1 3 7 9] %Kesme Deðerlerine Göre Mesnet Bölgelerindeki Kolon Etriyelerinin Belirlenmesi
for k=1:1:z;
for i=3:1:y+2;
    for j=3:1:x+2;
        Kol=cell2mat(Katv2(i,j,k));
        SolKir=cell2mat(Katv2(i,j-1,k));
        SagKir=cell2mat(Katv2(i,j+1,k));
        UstKir=cell2mat(Katv2(i-1,j,k));
        AltKir=cell2mat(Katv2(i+1,j,k));
        if strcmp(Kol(1,1),'s')==1;
            KolNum=mod(str2num(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
            say=0;
            
            if strcmp(SolKir(1,1),'k')==1;
                say=say+1;
                SolKiris=mod(str2num(cell2mat(regexp(Katv2{i,j-1,k},'\d*','Match'))),100);
                maxKirisKal(say)=hk(SolKiris,1,k);  
            end
            if strcmp(SagKir(1,1),'k')==1;
                say=say+1;
                SagKiris=mod(str2num(cell2mat(regexp(Katv2{i,j+1,k},'\d*','Match'))),100);
                maxKirisKal(say)=hk(SagKiris,1,k);  
            end
            if strcmp(UstKir(1,1),'k')==1;
                say=say+1;
                UstKiris=mod(str2num(cell2mat(regexp(Katv2{i-1,j,k},'\d*','Match'))),100);
                maxKirisKal(say)=hk(UstKiris,1,k);  
            end
            if strcmp(AltKir(1,1),'k')==1;
                say=say+1;
                AltKiris=mod(str2num(cell2mat(regexp(Katv2{i+1,j,k},'\d*','Match'))),100);
                maxKirisKal(say)=hk(AltKiris,1,k);        
            end
                
            Vd=abs(TasarimDegerlerKir(m,KolNum,k))*10^3;
            Vrmax=Vd-10;
            while Vrmax < Vd;
            Vcr=0.65*fctd*bk(KolNum,1,k)*10*dkol(KolNum,1,k);
            Vrmax=0.22*fcd*bk(KolNum,1,k)*10*dkol(KolNum,1,k);
            Asw=2*(pi()*fiKirEt^2)/4;
            if Vd < Vcr;
                
                KolEtAralik(KolNum,m,k)=(Asw*fyd)/(bk(KolNum,1,k)*10*0.3*fctd);
                if KolEtAralik(KolNum,m,k) < min([dkol(KolNum,1,k)/4,8*min(fiKirisBoyCap(KolNum,:,k),150)]);
                    KolEtAralik(KolNum,m,k)=min([dkol(KolNum,1,k)/4,8*min(fiKirisBoyCap(KolNum,:,k),150)]);
                end
                
            else if Vcr < Vd && Vd < Vrmax;
                Vc=0.8*Vcr;
                Vw=Vd-Vc;
                KolEtAralik(KolNum,m,k)=(fyd*dkol(KolNum,1,k)*Asw)/(Vw);
                
                if KolEtAralik(KolNum,m,k) < min([dkol(KolNum,1,k)/4,8*min(fiKirisBoyCap(KolNum,:,k),150)]);
                    KolEtAralik(KolNum,m,k)=min([dkol(KolNum,1,k)/4,8*min(fiKirisBoyCap(KolNum,:,k),150)]);
                end
                
            else if Vrmax < Vd;
                    asdasd=asdasd+1;
            bkol(KolNum,1,k)=bkol(KolNum,1,k)+5;
            hkol(KolNum,1,k)=hkol(KolNum,1,k)+5;
            dkol(KolNum,1,k)=hkol(KolNum,1,k)*10-fiKirEt-KolonDonati(KolonNum,1,k)/2-20;         
            end
            end
            end
            end
            
            KolEtSarilmaUz(KolNum,1,k)=min([(KatYuksek(k,1)*100-max(maxKirisKal))/6 max([bkol(KolNum,1,k) hkol(KolNum,1,k)]) 50]);
            KolEtAciklikUz(KolNum,1,k)=(KatYuksek(k,1)*100-max(maxKirisKal))-KolEtSarilmaUz(KolNum,1,k)*2;
        end
    end
end
end
end

for k=1:1:z; %Min Kolon Etriye Aralýklarýnýn Belirlenmesi (s)
for i=3:1:y+2;
    for j=3:1:x+2;
        Kol=cell2mat(Katv2(i,j,k));
        if strcmp(Kol(1,1),'s')==1;
            KolonNum=mod(str2num(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
            KolEtAralikMin(KolonNum,1,k)=floor(min([KolEtAralik(KolonNum,1,k) KolEtAralik(KolonNum,3,k) KolEtAralik(KolonNum,7,k) KolEtAralik(KolonNum,9,k)])./10);
            KolEtAralikMin(KolonNum,2,k)=floor(min([KolEtAralik(KolonNum,2,k) KolEtAralik(KolonNum,8,k)])./10);
        end
    end
end
end

%% Kolon Donatýlarýnýn Bastýrýlmasý

for k=1:1:z; % Donatýlarýn Bastýrýlmasý
for i=3:1:y+2;
    for j=3:1:x+2;
        Kol=cell2mat(Katv2(i,j,k));
        if strcmp(Kol(1,1),'s')==1;
            KolonNum=mod(str2num(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
            KN=KolonNum+100*k;
            KolDonati{1,KolonNum,k}=sprintf('k%.0f Kolkonu Boyuna Donatýsý %.0f/Ø%.0f',KN,8,KolonDonati(KolonNum,1,k));
            
            KolEtriye{1,KolonNum,k}=sprintf('k%.0f Kolonu Sarýlma Bölgesi Uzunluðu %.0fcm, Etriye Sayýsý %.0f/Ø%.0f, (Aralýk)s=%.0f',KN,KolEtSarilmaUz(KolonNum,1,k),ceil(KolEtSarilmaUz(KolonNum,1,k)/KolEtAralikMin(KolonNum,1,k)),fiKolEt,KolEtAralikMin(KolonNum,1,k));
            KolEtriye{2,KolonNum,k}=sprintf('k%.0f Kolonu Açýklýk Bölgesi Uzunluðu %.0fcm, Etriye Sayýsý %.0f/Ø%.0f, (Aralýk)s=%.0f',KN,KolEtAciklikUz(KolonNum,1,k),ceil(KolEtAciklikUz(KolonNum,1,k)/KolEtAralikMin(KolonNum,2,k)),fiKolEt,KolEtAralikMin(KolonNum,1,k));

        end
    end
end
end

%% Tekil Temel Boyutlandýrma
qt=530;

for i=3:1:y+2;
    for j=3:1:x+2;
        Kol=cell2mat(Katv2(i,j,k));
        if strcmp(Kol(1,1),'s')==1;
        KolonNum=mod(str2num(cell2mat(regexp(Katv2{i,j,k},'\d*','Match'))),100);
        
        say=0;
        for m=1:3:16;
            say=say+1;
            if sign(TemelNdVdMd(m,KolonNum))==-1;
            TemelNd(say,KolonNum)=abs(TemelNdVdMd(m,KolonNum));
            end
        end
            indis=find(TemelNdVdMd(:,KolonNum)==-max(TemelNd(:,KolonNum)));
            
            Bx(KolonNum)=1*(ceil(sqrt(max(TemelNd(:,KolonNum))/qt))/1);
            By(KolonNum)=Bx(KolonNum);
            e=abs(TemelNdVdMd(indis+2,KolonNum))/abs(TemelNdVdMd(indis,KolonNum));
            ekrit=min(Bx(KolonNum),By(KolonNum))/6;
            Ht(KolonNum)=max([0.25 (Bx(KolonNum)-(hkol(KolonNum,1,1)/1000))/4]);
            dtem(KolonNum,1,1)=Ht(KolonNum)*1000-50;
            TemelW=Bx(KolonNum)*By(KolonNum)*Ht(KolonNum)*25;
            TemelDonati(KolonNum)=8;
            
            qomax=qt+10;
            Vpd=2;
            Vpr=1;
            Vdx=2;
            Vcr=1;
            while e>ekrit || qomax>qt  || Vpd>Vpr || Vdx>Vcr;
                
                TemelW=Bx(KolonNum)*By(KolonNum)*Ht(KolonNum)*25;
                qomax=((max(TemelNd(:,KolonNum))+TemelW)/(Bx(KolonNum)*By(KolonNum)))*(1+(6*e)/(Bx(KolonNum)));
                qomin=((max(TemelNd(:,KolonNum))+TemelW)/(Bx(KolonNum)*By(KolonNum)))*(1-(6*e)/(Bx(KolonNum)));
                
                qof=qomax-(((qomax-qomin)/Bx(KolonNum))*((Bx(KolonNum)-(hkol(KolonNum,1,1)/1000))/2));
                b1=(hkol(KolonNum,1,1)/1000)+dtem(KolonNum,1,1)/1000;
                b2=(bkol(KolonNum,1,1)/1000)+dtem(KolonNum,1,1)/1000;
                qort=(qomax+qomin)/2;
            
                gama=1/(1+1.5*2*e/sqrt(b1+b2));
                up=(b1+b2)*2*1000;
                Vpr=gama*fctd*up*dtem(KolonNum,1,1)*10^-3;
                Vpd=(max(TemelNd(:,KolonNum))-b1*b2*qort)*10^-3;
                
                Vdx=((qomax-qof)/2)*((Bx(KolonNum)-(hkol(KolonNum,1,1)/100))/2)*By(KolonNum);
                Vcr=0.65*fctd*By(KolonNum)*1000*dtem(KolonNum,1,1)*10^-3;
                
                if e>ekrit || qomax>qt;
                Bx(KolonNum)=Bx(KolonNum)+0.2;
                By(KolonNum)=By(KolonNum)+0.2;
                ekrit=min(Bx(KolonNum),By(KolonNum))/6;
                end
                if Vdx>Vcr || Vpd>Vpr;
                   Ht(KolonNum)=Ht(KolonNum)+0.05;
                   dtem(KolonNum,1,k)=Ht(KolonNum)*1000-50;
                end
                Md=(((Bx(KolonNum)-(hkol(KolonNum,1,1)/100))^2)/24)*By(KolonNum)*(2*qomax-qof)*10^6;
                a=dkol(KolonNum,1,1)-sqrt(dkol(KolonNum,1,1)^2-(2*Md)/(0.85*fcd*By(KolonNum)*1000));
                AsTem(KolonNum)=Md/(fyd*(dkol(KolonNum,1,1)-a/2));
                minAs(KolonNum)=0.002*Bx(KolonNum)*1000*Ht(KolonNum)*1000;
                AsTem(KolonNum)=max([AsTem(KolonNum) minAs(KolonNum)]);
                   
            end   
        end  
                TemelDonati(KolonNum)=ceil(AsTem(KolonNum)/((pi()*fiTemBoy^2)/4));
        end
end

    

ElemanKiris=12
ElemanKat=2

KirisCizim(ElemanKiris,ElemanKat,fiKirisBoyCap,fiKirEt,KirisUz,KirisDonSay,KirisKordXY,bk,hk,KirEtSarilmaUz,KirEtAralikMin)
BinaGenelGorunum(KirisKordXY,KolonKord,z,KatYuksek)
