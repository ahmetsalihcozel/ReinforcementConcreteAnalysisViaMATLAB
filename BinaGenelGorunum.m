%% Kolonlarýn Çizdirilmesi

function [a]=BinaGenelGorunum(KirisKordXY,KolonKord,z,KatYuksek)

    a=figure('Name','Bina Genel Görünüm')
    hold on
    
    KolonKord(:,:,size(KolonKord,3)+1)=0;
    KolonKord(:,:,2:size(KolonKord,3))=KolonKord(:,:,1:size(KolonKord,3)-1);
    for k=1:1:z;
    for i=1:1:size(KolonKord,1);
    KolonKord(i,3,k)=KatYuksek(k,2)*100;
    
    
        
    KolC(i,1,k)=KolonKord(i,1,k)-20;
    KolC(i,2,k)=KolonKord(i,2,k)-20;
    KolC(i,3,k)=KolonKord(i,3,k);
    
    KolC(i,4,k)=KolonKord(i,1,k)+20;
    KolC(i,5,k)=KolonKord(i,2,k)-20;
    KolC(i,6,k)=KolonKord(i,3,k);
    
    KolC(i,7,k)=KolonKord(i,1,k)-20;
    KolC(i,8,k)=KolonKord(i,2,k)+20;
    KolC(i,9,k)=KolonKord(i,3,k);
    
    KolC(i,10,k)=KolonKord(i,1,k)+20;
    KolC(i,11,k)=KolonKord(i,2,k)+20;
    KolC(i,12,k)=KolonKord(i,3,k);
    
    
    
    KolC(i,13,k)=KolonKord(i,1,k)-20;
    KolC(i,14,k)=KolonKord(i,2,k)-20;
    KolC(i,15,k)=KolonKord(i,3,k+1);
    
    KolC(i,16,k)=KolonKord(i,1,k)+20;
    KolC(i,17,k)=KolonKord(i,2,k)-20;
    KolC(i,18,k)=KolonKord(i,3,k+1);
    
    KolC(i,19,k)=KolonKord(i,1,k)-20;
    KolC(i,20,k)=KolonKord(i,2,k)+20;
    KolC(i,21,k)=KolonKord(i,3,k+1);
    
    KolC(i,22,k)=KolonKord(i,1,k)+20;
    KolC(i,23,k)=KolonKord(i,2,k)+20;
    KolC(i,24,k)=KolonKord(i,3,k+1);
    
    patch([KolC(i,1,k) KolC(i,4,k) KolC(i,10,k) KolC(i,7,k)],[KolC(i,2,k) KolC(i,5,k) KolC(i,11,k) KolC(i,8,k)],[KolC(i,3,k) KolC(i,6,k) KolC(i,12,k) KolC(i,9,k)],'red');
    patch([KolC(i,13,k) KolC(i,16,k) KolC(i,22,k) KolC(i,19,k)],[KolC(i,14,k) KolC(i,17,k) KolC(i,23,k) KolC(i,20,k)],[KolC(i,15,k) KolC(i,18,k) KolC(i,24,k) KolC(i,21,k)],'red');
    patch([KolC(i,4,k) KolC(i,16,k) KolC(i,22,k) KolC(i,10,k)],[KolC(i,5,k) KolC(i,17,k) KolC(i,23,k) KolC(i,11,k)],[KolC(i,6,k) KolC(i,18,k) KolC(i,24,k) KolC(i,12,k)],'red');
    patch([KolC(i,1,k) KolC(i,13,k) KolC(i,19,k) KolC(i,7,k)],[KolC(i,2,k) KolC(i,14,k) KolC(i,20,k) KolC(i,8,k)],[KolC(i,3,k) KolC(i,15,k) KolC(i,21,k) KolC(i,9,k)],'red');
    patch([KolC(i,7,k) KolC(i,10,k) KolC(i,22,k) KolC(i,19,k)],[KolC(i,8,k) KolC(i,11,k) KolC(i,23,k) KolC(i,20,k)],[KolC(i,9,k) KolC(i,12,k) KolC(i,24,k) KolC(i,21,k)],'red');
    patch([KolC(i,1,k) KolC(i,4,k) KolC(i,16,k) KolC(i,13,k)],[KolC(i,2,k) KolC(i,5,k) KolC(i,17,k) KolC(i,14,k)],[KolC(i,3,k) KolC(i,6,k) KolC(i,18,k) KolC(i,15,k)],'red');
    hold on
    end
    end
    
    
    %% Kiriþlerin Çizdirilmesi

for k=1:1:z;
for i=1:1:size(KirisKordXY,1);
    KirisKordXY(i,5,k)=KatYuksek(k,2)*100;
    
    if KirisKordXY(i,1,k)==KirisKordXY(i,3,k);
        
    KC(i,1,k)=KirisKordXY(i,1,k)-20;
    KC(i,2,k)=KirisKordXY(i,2,k);
    KC(i,3,k)=KirisKordXY(i,5,k)-20;
    
    KC(i,4,k)=KirisKordXY(i,1,k)+20;
    KC(i,5,k)=KirisKordXY(i,2,k);
    KC(i,6,k)=KirisKordXY(i,5,k)-20;
    
    KC(i,7,k)=KirisKordXY(i,1,k)-20;
    KC(i,8,k)=KirisKordXY(i,2,k);
    KC(i,9,k)=KirisKordXY(i,5,k)+20;
    
    KC(i,10,k)=KirisKordXY(i,1,k)+20;
    KC(i,11,k)=KirisKordXY(i,2,k);
    KC(i,12,k)=KirisKordXY(i,5,k)+20;
    
    
    
    KC(i,13,k)=KirisKordXY(i,3,k)-20;
    KC(i,14,k)=KirisKordXY(i,4,k);
    KC(i,15,k)=KirisKordXY(i,5,k)-20;
    
    KC(i,16,k)=KirisKordXY(i,3,k)+20;
    KC(i,17,k)=KirisKordXY(i,4,k);
    KC(i,18,k)=KirisKordXY(i,5,k)-20;
    
    KC(i,19,k)=KirisKordXY(i,3,k)-20;
    KC(i,20,k)=KirisKordXY(i,4,k);
    KC(i,21,k)=KirisKordXY(i,5,k)+20;
    
    KC(i,22,k)=KirisKordXY(i,3,k)+20;
    KC(i,23,k)=KirisKordXY(i,4,k);
    KC(i,24,k)=KirisKordXY(i,5,k)+20;
    
    patch([KC(i,1,k) KC(i,4,k) KC(i,10,k) KC(i,7,k)],[KC(i,2,k) KC(i,5,k) KC(i,11,k) KC(i,8,k)],[KC(i,3,k) KC(i,6,k) KC(i,12,k) KC(i,9,k)],'red');
    patch([KC(i,13,k) KC(i,16,k) KC(i,22,k) KC(i,19,k)],[KC(i,14,k) KC(i,17,k) KC(i,23,k) KC(i,20,k)],[KC(i,15,k) KC(i,18,k) KC(i,24,k) KC(i,21,k)],'red');
    patch([KC(i,4,k) KC(i,16,k) KC(i,22,k) KC(i,10,k)],[KC(i,5,k) KC(i,17,k) KC(i,23,k) KC(i,11,k)],[KC(i,6,k) KC(i,18,k) KC(i,24,k) KC(i,12,k)],'red');
    patch([KC(i,1,k) KC(i,13,k) KC(i,19,k) KC(i,7,k)],[KC(i,2,k) KC(i,14,k) KC(i,20,k) KC(i,8,k)],[KC(i,3,k) KC(i,15,k) KC(i,21,k) KC(i,9,k)],'red');
    patch([KC(i,7,k) KC(i,10,k) KC(i,22,k) KC(i,19,k)],[KC(i,8,k) KC(i,11,k) KC(i,23,k) KC(i,20,k)],[KC(i,9,k) KC(i,12,k) KC(i,24,k) KC(i,21,k)],'red');
    patch([KC(i,1,k) KC(i,4,k) KC(i,16,k) KC(i,13,k)],[KC(i,2,k) KC(i,5,k) KC(i,17,k) KC(i,14,k)],[KC(i,3,k) KC(i,6,k) KC(i,18,k) KC(i,15,k)],'red');
    hold on;
    else if KirisKordXY(i,2,k)==KirisKordXY(i,4,k);
            
    KC(i,1,k)=KirisKordXY(i,1,k);
    KC(i,2,k)=KirisKordXY(i,2,k)-20;
    KC(i,3,k)=KirisKordXY(i,5,k)-20;
    
    KC(i,4,k)=KirisKordXY(i,1,k);
    KC(i,5,k)=KirisKordXY(i,2,k)+20;
    KC(i,6,k)=KirisKordXY(i,5,k)-20;
    
    KC(i,7,k)=KirisKordXY(i,1,k);
    KC(i,8,k)=KirisKordXY(i,2,k)-20;
    KC(i,9,k)=KirisKordXY(i,5,k)+20;
    
    KC(i,10,k)=KirisKordXY(i,1,k);
    KC(i,11,k)=KirisKordXY(i,2,k)+20;
    KC(i,12,k)=KirisKordXY(i,5,k)+20;
    
    
    
    KC(i,13,k)=KirisKordXY(i,3,k);
    KC(i,14,k)=KirisKordXY(i,4,k)-20;
    KC(i,15,k)=KirisKordXY(i,5,k)-20;
    
    KC(i,16,k)=KirisKordXY(i,3,k);
    KC(i,17,k)=KirisKordXY(i,4,k)+20;
    KC(i,18,k)=KirisKordXY(i,5,k)-20;
    
    KC(i,19,k)=KirisKordXY(i,3,k);
    KC(i,20,k)=KirisKordXY(i,4,k)-20;
    KC(i,21,k)=KirisKordXY(i,5,k)+20;
    
    KC(i,22,k)=KirisKordXY(i,3,k);
    KC(i,23,k)=KirisKordXY(i,4,k)+20;
    KC(i,24,k)=KirisKordXY(i,5,k)+20;
    
    patch([KC(i,1,k) KC(i,4,k) KC(i,10,k) KC(i,7,k)],[KC(i,2,k) KC(i,5,k) KC(i,11,k) KC(i,8,k)],[KC(i,3,k) KC(i,6,k) KC(i,12,k) KC(i,9,k)],'red');
    patch([KC(i,13,k) KC(i,16,k) KC(i,22,k) KC(i,19,k)],[KC(i,14,k) KC(i,17,k) KC(i,23,k) KC(i,20,k)],[KC(i,15,k) KC(i,18,k) KC(i,24,k) KC(i,21,k)],'red');
    patch([KC(i,4,k) KC(i,16,k) KC(i,22,k) KC(i,10,k)],[KC(i,5,k) KC(i,17,k) KC(i,23,k) KC(i,11,k)],[KC(i,6,k) KC(i,18,k) KC(i,24,k) KC(i,12,k)],'red');
    patch([KC(i,1,k) KC(i,13,k) KC(i,19,k) KC(i,7,k)],[KC(i,2,k) KC(i,14,k) KC(i,20,k) KC(i,8,k)],[KC(i,3,k) KC(i,15,k) KC(i,21,k) KC(i,9,k)],'red');
    patch([KC(i,7,k) KC(i,10,k) KC(i,22,k) KC(i,19,k)],[KC(i,8,k) KC(i,11,k) KC(i,23,k) KC(i,20,k)],[KC(i,9,k) KC(i,12,k) KC(i,24,k) KC(i,21,k)],'red');
    patch([KC(i,1,k) KC(i,4,k) KC(i,16,k) KC(i,13,k)],[KC(i,2,k) KC(i,5,k) KC(i,17,k) KC(i,14,k)],[KC(i,3,k) KC(i,6,k) KC(i,18,k) KC(i,15,k)],'red');
    hold on
            
        end
    end
end
end
end
