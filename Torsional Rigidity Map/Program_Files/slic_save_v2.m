function slic_save_v2(v_number,VVV,Zp_1,kk,mode,area_mode,height,width)
Zp=double(Zp_1);   % set Z_plane position
kn=0;
for j=1:(v_number/3)                    
    VZ_1=VVV(1+3*(j-1),3)-Zp;
    VZ_2=VVV(2+3*(j-1),3)-Zp;
    VZ_3=VVV(3+3*(j-1),3)-Zp;
    if not(abs(VZ_1+VZ_2+VZ_3)==(abs(VZ_1)+abs(VZ_2)+abs(VZ_3)))
       kn=kn+1;
    end
end

V_V=zeros(kn*2,2);
k=0;
for j=1:(v_number/3)                    
    VZ_1=VVV(1+3*(j-1),3)-Zp;
    VZ_2=VVV(2+3*(j-1),3)-Zp;
    VZ_3=VVV(3+3*(j-1),3)-Zp;
    if not(abs(VZ_1+VZ_2+VZ_3)==(abs(VZ_1)+abs(VZ_2)+abs(VZ_3)))
       k=k+1;

       if (or((VZ_1==0),or((VZ_2==0),(VZ_3==0))))
           if (VZ_1==0)
               V_V(1+2*(k-1),1)=VVV(1+3*(j-1),1);
               V_V(1+2*(k-1),2)=VVV(1+3*(j-1),2);
               V_V(2+2*(k-1),1)=(-VZ_2)*(VVV(3+3*(j-1),1)-VVV(2+3*(j-1),1))/(VVV(3+3*(j-1),3)-VVV(2+3*(j-1),3))+VVV(2+3*(j-1),1); % Xp
               V_V(2+2*(k-1),2)=(-VZ_2)*(VVV(3+3*(j-1),2)-VVV(2+3*(j-1),2))/(VVV(3+3*(j-1),3)-VVV(2+3*(j-1),3))+VVV(2+3*(j-1),2); % Yp
           elseif (VZ_2==0)
               V_V(1+2*(k-1),1)=VVV(2+3*(j-1),1);
               V_V(1+2*(k-1),2)=VVV(2+3*(j-1),2);
               V_V(2+2*(k-1),1)=(-VZ_1)*(VVV(3+3*(j-1),1)-VVV(1+3*(j-1),1))/(VVV(3+3*(j-1),3)-VVV(1+3*(j-1),3))+VVV(1+3*(j-1),1); % Xp
               V_V(2+2*(k-1),2)=(-VZ_1)*(VVV(3+3*(j-1),2)-VVV(1+3*(j-1),2))/(VVV(3+3*(j-1),3)-VVV(1+3*(j-1),3))+VVV(1+3*(j-1),2); % Yp
           else %(VZ_3==0)
               V_V(1+2*(k-1),1)=VVV(3+3*(j-1),1);
               V_V(1+2*(k-1),2)=VVV(3+3*(j-1),2);
               V_V(2+2*(k-1),1)=(-VZ_1)*(VVV(2+3*(j-1),1)-VVV(1+3*(j-1),1))/(VVV(2+3*(j-1),3)-VVV(1+3*(j-1),3))+VVV(1+3*(j-1),1); % Xp
               V_V(2+2*(k-1),2)=(-VZ_1)*(VVV(2+3*(j-1),2)-VVV(1+3*(j-1),2))/(VVV(2+3*(j-1),3)-VVV(1+3*(j-1),3))+VVV(1+3*(j-1),2); % Yp
           end
       else
           if (abs(-VZ_1+VZ_2+VZ_3)==(abs(VZ_1)+abs(VZ_2)+abs(VZ_3)))
               V_V(1+2*(k-1),1)=(-VZ_1)*(VVV(2+3*(j-1),1)-VVV(1+3*(j-1),1))/(VVV(2+3*(j-1),3)-VVV(1+3*(j-1),3))+VVV(1+3*(j-1),1); % Xp [V1¡÷V2]
               V_V(1+2*(k-1),2)=(-VZ_1)*(VVV(2+3*(j-1),2)-VVV(1+3*(j-1),2))/(VVV(2+3*(j-1),3)-VVV(1+3*(j-1),3))+VVV(1+3*(j-1),2); % Yp
               V_V(2+2*(k-1),1)=(-VZ_1)*(VVV(3+3*(j-1),1)-VVV(1+3*(j-1),1))/(VVV(3+3*(j-1),3)-VVV(1+3*(j-1),3))+VVV(1+3*(j-1),1); % Xp [V1¡÷V3]
               V_V(2+2*(k-1),2)=(-VZ_1)*(VVV(3+3*(j-1),2)-VVV(1+3*(j-1),2))/(VVV(3+3*(j-1),3)-VVV(1+3*(j-1),3))+VVV(1+3*(j-1),2); % Yp 
           elseif (abs(VZ_1-VZ_2+VZ_3)==(abs(VZ_1)+abs(VZ_2)+abs(VZ_3)))
               V_V(1+2*(k-1),1)=(-VZ_2)*(VVV(1+3*(j-1),1)-VVV(2+3*(j-1),1))/(VVV(1+3*(j-1),3)-VVV(2+3*(j-1),3))+VVV(2+3*(j-1),1); % Xp [V2¡÷V1]
               V_V(1+2*(k-1),2)=(-VZ_2)*(VVV(1+3*(j-1),2)-VVV(2+3*(j-1),2))/(VVV(1+3*(j-1),3)-VVV(2+3*(j-1),3))+VVV(2+3*(j-1),2); % Yp
               V_V(2+2*(k-1),1)=(-VZ_2)*(VVV(3+3*(j-1),1)-VVV(2+3*(j-1),1))/(VVV(3+3*(j-1),3)-VVV(2+3*(j-1),3))+VVV(2+3*(j-1),1); % Xp [V2¡÷V3]
               V_V(2+2*(k-1),2)=(-VZ_2)*(VVV(3+3*(j-1),2)-VVV(2+3*(j-1),2))/(VVV(3+3*(j-1),3)-VVV(2+3*(j-1),3))+VVV(2+3*(j-1),2); % Yp
           else % (abs(VZ_1+VZ_2-VZ_3)==(abs(VZ_1)+abs(VZ_2)+abs(VZ_3)))
               V_V(1+2*(k-1),1)=(-VZ_3)*(VVV(1+3*(j-1),1)-VVV(3+3*(j-1),1))/(VVV(1+3*(j-1),3)-VVV(3+3*(j-1),3))+VVV(3+3*(j-1),1); % Xp [V3¡÷V1]
               V_V(1+2*(k-1),2)=(-VZ_3)*(VVV(1+3*(j-1),2)-VVV(3+3*(j-1),2))/(VVV(1+3*(j-1),3)-VVV(3+3*(j-1),3))+VVV(3+3*(j-1),2); % Yp
               V_V(2+2*(k-1),1)=(-VZ_3)*(VVV(2+3*(j-1),1)-VVV(3+3*(j-1),1))/(VVV(2+3*(j-1),3)-VVV(3+3*(j-1),3))+VVV(3+3*(j-1),1); % Xp [V3¡÷V2]
               V_V(2+2*(k-1),2)=(-VZ_3)*(VVV(2+3*(j-1),2)-VVV(3+3*(j-1),2))/(VVV(2+3*(j-1),3)-VVV(3+3*(j-1),3))+VVV(3+3*(j-1),2); % Yp
           end
       end
    end
end
V_VV=double((V_V));
if (area_mode==1)
    slic_1=zeros(uint16(max(VVV(:,1))+3),uint16(max(VVV(:,2))+3));
else
    slic_1=zeros(height,width);
end

zz=zeros(1,k);
if or(mode==1,mode>=3)
    for m=1:k
        f_1=[V_VV(1+2*(m-1),1),V_VV(1+2*(m-1),2)];
        f_2=[V_VV(2+2*(m-1),1),V_VV(2+2*(m-1),2)];
        f_4=(f_2-f_1)/(norm(f_2-f_1,2));
        for n=1:((norm(f_2-f_1,2))/(norm(f_4,2)))+5
            slic_1(uint16((f_4(1)*n+f_1(1))+1)+2,uint16((f_4(2)*n+f_1(2))+1)+2)=1;
            slic_1(uint16((f_4(1)*n+f_1(1))+1)+1,uint16((f_4(2)*n+f_1(2))+1)+2)=1;
            slic_1(uint16((f_4(1)*n+f_1(1))+1)+2,uint16((f_4(2)*n+f_1(2))+1)+1)=1;
            slic_1(uint16((f_4(1)*n+f_1(1))+1)+2,uint16((f_4(2)*n+f_1(2))+1)+3)=1;
        end
    end

    if (mode==1)
        Ifill_2 = uint8(255*not(uint8(255*imfill(slic_1)-255*slic_1)));
    else
        slic_1=logical(slic_1);
        Ifill_2 = uint8(255*(not(uint8(255*(slic_1)))));
    end
elseif (mode==2)
    z=-0.5;
    slic_2=zeros(size(slic_1));
    for m=1:k
         if m<k
                 zz(1,m)=(V_VV(2+2*(m-1),1)-V_VV(1+2*(m-1),1))*(V_VV(2+2*(m),2)-V_VV(1+2*(m),2))...
                     -(V_VV(2+2*(m-1),2)-V_VV(1+2*(m-1),2))*(V_VV(2+2*(m),1)-V_VV(1+2*(m),1));
         end
        if (m==1)
           f_1=[V_VV(1+2*(m-1),1),V_VV(1+2*(m-1),2)];
           f_2=[V_VV(2+2*(m-1),1),V_VV(2+2*(m-1),2)];
           f_4=(f_2-f_1)/(norm(f_2-f_1,2));
           for n=1:((norm(f_2-f_1,2))/(norm(f_4,2)))+5
               slic_2(uint16((f_4(1)*n+f_1(1))+1)+2,uint16((f_4(2)*n+f_1(2))+1)+2)=1;
               slic_2(uint16((f_4(1)*n+f_1(1))+1)+1,uint16((f_4(2)*n+f_1(2))+1)+2)=1;
               slic_2(uint16((f_4(1)*n+f_1(1))+1)+2,uint16((f_4(2)*n+f_1(2))+1)+1)=1;
               slic_2(uint16((f_4(1)*n+f_1(1))+1)+2,uint16((f_4(2)*n+f_1(2))+1)+3)=1;
               slic_2(uint16((f_4(1)*n+f_1(1))+1),uint16((f_4(2)*n+f_1(2)))+1)=1;
           end
        else

            if or(norm([V_VV(1+2*(m-1),1),V_VV(1+2*(m-1),2)]-[V_VV(2+2*(m-2),1),V_VV(2+2*(m-2),2)],2)>5,m==k)
                slic_2=slic_2(1:height,1:width);
                if (z<0)
                    slic_1=slic_1+imfill(slic_2);
                else
                    slic_1=slic_1-imfill(slic_2);
                end
                slic_2=zeros(size(slic_1));

if m<k
                z=(V_VV(2+2*(m-1),1)-V_VV(1+2*(m-1),1))*(V_VV(2+2*(m),2)-V_VV(1+2*(m),2))...
                    -(V_VV(2+2*(m-1),2)-V_VV(1+2*(m-1),2))*(V_VV(2+2*(m),1)-V_VV(1+2*(m),1));
end
                f_1=[V_VV(1+2*(m-1),1),V_VV(1+2*(m-1),2)];
                f_2=[V_VV(2+2*(m-1),1),V_VV(2+2*(m-1),2)];
                f_4=(f_2-f_1)/(norm(f_2-f_1,2)); 
                for n=1:((norm(f_2-f_1,2))/(norm(f_4,2)))+5
                    slic_2(uint16((f_4(1)*n+f_1(1))+1)+2,uint16((f_4(2)*n+f_1(2))+1)+2)=1;
                    slic_2(uint16((f_4(1)*n+f_1(1))+1)+1,uint16((f_4(2)*n+f_1(2))+1)+2)=1;
                    slic_2(uint16((f_4(1)*n+f_1(1))+1)+2,uint16((f_4(2)*n+f_1(2))+1)+1)=1;
                    slic_2(uint16((f_4(1)*n+f_1(1))+1)+2,uint16((f_4(2)*n+f_1(2))+1)+3)=1;
                end
            else 
                f_1=[V_VV(1+2*(m-1),1),V_VV(1+2*(m-1),2)];
                f_2=[V_VV(2+2*(m-1),1),V_VV(2+2*(m-1),2)];
                f_4=(f_2-f_1)/(norm(f_2-f_1,2)); 
                   for n=1:((norm(f_2-f_1,2))/(norm(f_4,2)))+5
                        slic_2(uint16((f_4(1)*n+f_1(1))+1)+2,uint16((f_4(2)*n+f_1(2))+1)+2)=1;
                        slic_2(uint16((f_4(1)*n+f_1(1))+1)+1,uint16((f_4(2)*n+f_1(2))+1)+2)=1;
                        slic_2(uint16((f_4(1)*n+f_1(1))+1)+2,uint16((f_4(2)*n+f_1(2))+1)+1)=1;
                        slic_2(uint16((f_4(1)*n+f_1(1))+1)+2,uint16((f_4(2)*n+f_1(2))+1)+3)=1;
                   end
            end
        end
    end
    Ifill_2 = uint8(255*(not(slic_1)));
end
clear slic_2

%% Slicing
if area_mode==2
   Ifill_2 = Ifill_2(1:height,1:width);
elseif area_mode==1
   Ifill_2 = Ifill_2';
end
imwrite(Ifill_2,[int2str(mod(kk-mod(kk,100),1000)/100),int2str(mod(kk-mod(kk,10),100)/10),num2str(mod(kk,10)),'.bmp']);