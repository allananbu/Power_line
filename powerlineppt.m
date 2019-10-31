  %----------------POWER LINE ANALYSIS----------------------------
clc;
clear all;
close all;
n=0:199;
fs=1000;
ts=1/fs;
%--------- sine wave of 50 HZ--------------------------------
V=sin(2*pi*(50/1000)*n);
x=n/1000;
sprintf('enter your choice 1.spike,2.sag,3.swell,4.momentary interruption,5.harmonics 6.voltage fluctuations 7.DC Offset 8.exit \n\n\n')
C=input('');
if C==1
%----------sine wave of 50 HZ with spike with different variations---------------------
vv1=[V(1:45),V(46:48).*[1.4,0.5,0.01],V(49:200)];
vv11=[V(1:64),[1.4,0.5,0.01].*V(65:67),V(68:200)];
vv111=[V(1:105),[1.4,0.5,0.01].*V(106:108),V(109:200)];
figure(1);
subplot(2,2,1);
plot(x,vv1);
subplot(2,2,2);
plot(x,vv11);
subplot(2,2,3);
plot(x,vv111);
%----------scalogram of sine wave of 50 HZ with spike with different variations---------------------
figure(2)
c1=cwt(vv1,1,'db4','plot');
figure(3)
c11=cwt(vv11,1,'db4','plot');
figure(4)
c111=cwt(vv111,1,'db4','plot');

%-----------------------------------------------------------------------------------
%Measurement details for  sine wave of 50 HZ with spike with different variations
m1= max(c1);m2= max(c11);m3= max(c111);
for i=1:200
  if c1(i)==m1
         s1=i;
  end
 if c11(i)==m2
         s2=i;
 end
 if c111(i)==m3
         s3=i;
 end
end
timespike1=s1*ts;
timespike2=s2*ts; 
timespike3=s3*ts;
sprintf('The starting time position for the spike1 is %f secs',timespike1)
sprintf('The starting time position for the spike2 is %f secs',timespike2)
sprintf('The starting time position for the spike3 is %f secs',timespike3)
%-----------------------------------------------------------------------------------------------
elseif C==2
%---------sine wave of 50 HZ with voltage sag-------------------
vv2=[V(1:66),0.5*V(67:133),V(134:200)];
vv22=[0.5*V(1:66),V(67:133),V(134:200)];
vv222=[V(1:66),V(67:133),0.5*V(134:200)];
figure(1);
subplot(2,2,1);
plot(x,vv2);
subplot(2,2,2);
plot(x,vv22);
subplot(2,2,3);
plot(x,vv222);
%-----------------------------------------------------------------------------------
%---------scalogram of sine wave of 50 HZ with voltage sag(variations)-------------------
figure(2)
c2=cwt(vv2,15,'db4','plot');
figure(3)
c22=cwt(vv22,15,'db4','plot');
figure(4)
c222=cwt(vv222,15,'db4','plot');
%-----------------------------------------------------------------------------------
c2=fix(abs(c2));
c22=fix(abs(c22));
c222=fix(abs(c222));
%kk=0;
j=1;
for i=1:199
    if c2(i)==2 &c2(i+1)<2
        kk(j)=i;j=j+1;
    end
end
for i=1:length(kk)-1
    count(i)=0;
    for j=kk(i):kk(i+1)
         if c2(kk(i))==2 & c2(j+1)<2
            count(i)=count(i)+1;
            end
    end
end
M1=max(count);
for i=1:length(kk)-1
    if M1==count(i)
        depth2=kk(i);
    end
end
%kk=0;
j=1;
for i=1:199
    if c222(i)==2 &c222(i+1)<2
        kkk(j)=i;j=j+1;
    end
end
for i=1:length(kkk)-1
    countp(i)=0;
    for j=kkk(i):kkk(i+1)
         if c222(kkk(i))==2 & c222(j+1)<2
            countp(i)=countp(i)+1;
           
        end
    end
end
M2=max(countp);
for i=1:length(kkk)-1
    if M2==countp(i)
        depth222=kkk(i);
    end
end
elseif C==3
%---------sine wave of 50 HZ with voltage swell-------------------
vv3=[V(1:66),1.6*V(67:133),V(134:200)];
vv33=[1.6*V(1:66),V(67:133),V(134:200)];
vv333=[V(1:66),V(67:133),1.6*V(134:200)];
figure(1);
subplot(2,2,1);
plot(x,vv3);
subplot(2,2,2);
plot(x,vv33);
subplot(2,2,3);
plot(x,vv333);
%-----------------------------------------------------------------------------------
%---------scalogram of sine wave of 50 HZ with voltage swell(variations)-------------------
figure(2)
c3=cwt(vv3,11,'db4','plot');
figure(3)
c33=cwt(vv33,11,'db4','plot');
figure(4)
c333=cwt(vv333,11,'db4','plot');
%-----------------------------------------------------------------------------------
%---------Measurement details for  sine wave of 50 HZ with voltage swell(variations)--------
c3=fix(abs(c3));
c33=fix(abs(c33));
c333=fix(abs(c333));
for i=1:199
    if c3(i) <=3 & c3(i+1)==3
      vss1=i+1;break;
  end
end
 for i=199:-1:1
    if c3(i)<3 & c3(i-1)==3
      vse1=i-1;break;
  end
end
 for i=1:199
    if c33(i)<=3 & c33(i+1)==3
      vss2=i+1;break;
  end
end
 for i=199:-1:1
    if c33(i)<3 & c33(i-1)==3
      vse2=i-1;break;
  end
end   
for i=1:199
    if c333(i)<=3 & c333(i+1)==3
      vss3=i+1;break;
  end
end
 for i=199:-1:1
    if c333(i)<3 & c333(i-1)==3
      vse3=i-1;break;
  end
end 
tswe1=vss1*ts;tswe11=vse1*ts;
tswe2=vss2*ts;tswe22=vse2*ts;
tswe3=vss3*ts;tswe33=vse3*ts;
sprintf('The starting time position for the 1st swell is %f secs',tswe1)
sprintf('The ending time position for the 1st swell is %f secs',tswe11)
sprintf('The starting time position for the 2nd swell is %f secs',tswe2)
sprintf('The ending time position for the 2nd swell is %f secs',tswe22)
sprintf('The starting time position for the 3rd swell is %f secs',tswe3)
sprintf('The ending time position for the 3rd swell is %f secs',tswe33)
%--------------------------------------------------------------------------------------------
elseif C==4
%---------sine wave of 50 HZ with momentary interruption-------------------
vv4=[V(1:66),0*V(67:133),[0.2,0.01,0].*V(134:136),V(137:200)];
vv44=[0*V(1:66),[0.2,0.01,0].*V(67:69),V(70:200)];
vv444=[V(1:66),0*V(67:197),[0.2,0.01,0].*V(198:200)];
figure(1);
subplot(2,2,1);
plot(x,vv4);
subplot(2,2,2);
plot(x,vv44);
subplot(2,2,3);
plot(x,vv444);
%-----------------------------------------------------------------------------------
%---------scalogram of sine wave of 50 HZ with momentary interruption(variations)-------------------
figure(2)
c4=cwt(vv4,1,'db4','plot');
figure(3)
c44=cwt(vv44,1,'db4','plot');
figure(4)
c444=cwt(vv444,1,'db4','plot');
%-----------------------------------------------------------------------------------
%---------Measurement details for  sine wave of 50 HZ with momentary interruption-------------------
 count1=0;count2=0;count3=0;
for i=1:200
    if c4(i)==0
     count1=count1+1;
 end
 
end
for i=1:199
    if c4(i)==0 & c4(i+1)==0
     k1=i;break;
     
 end
end
for i=1:200
    if c44(i)==0
     count2=count2+1;
 end
 
end
for i=1:199
    if c44(i)==0 & c44(i+1)==0
     k2=i;break;
     
 end
end
for i=1:200
    if c444(i)==0
     count3=count3+1;
 end
 
end
for i=1:199
    if c444(i)==0 & c444(i+1)==0
     k3=i;break;
 end
end
time1=ts*k1;
time11=ts*(k1+count1);
time2=ts*k2;
time22=ts*(k2+count2);
time3=ts*k3;
time33=ts*(k3+count3);
sprintf('The starting time position for the dc1 is %f secs',time1)
sprintf('The ending time position for the dc1 is %f secs',time11)
sprintf('The starting time position for the dc2 is %f secs',time2)
sprintf('The ending time position for the dc2 is %f secs',time22)
sprintf('The starting time position for the dc3 is %f secs',time3)
sprintf('The ending time position for the dc3 is %f secs',time33)
%---------------------------------------------------------------------------------------------
elseif C==5
%---------sine wave of 50 HZ with 3rd and 5th harmonics-------------------
S1=sin(2*pi*(1*50/1000)*n);
S3=sin(2*pi*(3*50/1000)*n);
S5=sin(2*pi*(5*50/1000)*n);
S=S1+S3+S5;
figure(1);
plot(x,S);
%-----------------------------------------------------------------------------------
%-------------------------scalogram for sine wave of 50 HZ with 3rd and 5th harmonics--------------
 [a,b,c]=specgram(S);
 %c=1:200;
 figure(2);imagesc(c,b,abs(a)); colormap(hot); colorbar
 %------------------------------------------------------------------------------------------------
 %---------------sine wave with voltage fluctuations -----------------------
elseif C==6
    n=200;
    k=0;
vv5=[1*V(1:40),0.8*V(41:60),1*V(61:120),1.2*V(121:150),0.8*V(151:170),1.1*V(171:200)];
figure(1);
plot(x,vv5);
figure(2)
c3=cwt(vv5,07,'db4','plot');
for i=1:n
    if(vv5(i)~=1)
        k=1;
    end
end
if(k==1)
    disp('voltage fluctuations occur')
end

%---------------sine with dc offset---------------------------------------------
elseif C==7
    count1=0;
    count2=0;
    count3=0;
    n=200;
    h=max(V)
for i=1:n
    if((i>=25)&(i<=99))
        V(i)=V(i)+1
    end
    if((i>=100)&(i<=139))
        V(i)=V(i)+2
    end
     if((i>=140)&(i<=200))
        V(i)=V(i)+3
    end
end
figure(1);
plot(x,V);
xlabel('t')
ylabel('amplitude')
title('DC offset')
figure(2)
c3=cwt(V,02,'db4','plot');
for i=1:n
    if(V(i)>h)
        k1=i;
        if((V(i+1)-V(i))<0)
        g=V(i)
        break;
        end
    end
end
for i=k1:n
    if(V(i)>g)
        count1=(i-k1);
        k2=i;
        break;
    else
        count1=i;
    end
end
for i=k2:n
    if(V(i)>g)
        if((V(i+1)-V(i))<0)
        g=V(i);
        break;
        end
    end
end
for i=k2:n
    if(V(i)>g)
        count2=(i-k2);
        k3=i;
        g=V(i);
        break;
    else
        count2=i;
    end
end
for i=k3:n
    if(V(i)>g)
        if((V(i+1)-V(i))<0)
        g=V(i);
        break;
        end
    end
end
for i=k3:n
    if(V(i)>g)
        count3=(i-k3)
        k4=i;
        g=V(i);
        break
    else
        count3=(i-k3)
    end
end
ti=ts*k1;
k=k1+count1;
ti1=ts*k;
sprintf('The starting time position for the DC offset1 is %f secs',ti)
sprintf('The ending time position for the DC offset1 is %f secs',ti1)
ti=ts*k2;
k=k2+count2;
ti1=ts*k;
sprintf('The starting time position for the DC offset1 is %f secs',ti)
sprintf('The ending time position for the DC offset1 is %f secs',ti1)
ti=ts*k3;
k=k3+count3;
ti1=ts*k;
sprintf('The starting time position for the DC offset1 is %f secs',ti)
sprintf('The ending time position for the DC offset1 is %f secs',ti1)
elseif C==8
    break;
end        

       


