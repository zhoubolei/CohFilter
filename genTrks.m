function [trkSet,groundtruthIndex]= genTrks(pointer)
%% generate 2D or 3D dataset.

if pointer=='2D'
    display('generating 2D dataset...'); 
    time=500;
    trkSet1 =noiseTrk(55,time,3000);
    trkSet2= parabolaTrk(time,500);
    trkSet3=circleTrk(time,15,300,[15;-15]);
    trkSet4=lineTrk(time,200,-2,[20;10]);
    trkSet5= RealCircleTrk(time,15,300,[-25;-20]);
    
    trkSet=[trkSet1 trkSet2 trkSet3 trkSet4 trkSet5];
    groundtruthIndex=[1*ones(1,length(trkSet1)) 2*ones(1,length(trkSet2)) 3*ones(1,length(trkSet3)) 4*ones(1,length(trkSet4)) 5*ones(1,length(trkSet5))];
    display('2D dataset is finished.  4 coherent motion patterns + Brownian Noise');
else
    display('generating 3D dataset...'); %
    time=500;
    trkSet1 =noiseTrk3D(40,time,3000);
    trkSet2= helixTrk(time,15,300,[0;10;0],1);
    trkSet3= faceCurveTrk(time,600,[0;-25;0]);   
    trkSet=[trkSet1 trkSet2 trkSet3];
    groundtruthIndex=[1*ones(1,length(trkSet1)) 2*ones(1,length(trkSet2)) 3*ones(1,length(trkSet3)) ];
    display('3D dataset is finished.  2 coherent motion patterns + Brownian Noise');
end
end


function trkSet = circleTrk(ctime,R,num,intervalX)
%CIRCLETRK Summary of this function goes here
%   Detailed explanation goes here
para=R;
time=ctime/2;
t=[1:time];
t2=-[time:-1:1];
T=[t2 t]./30;

trk.x=(para.*cos(T))'+intervalX(1,1);
trk.y=(para.*sin(T))'+intervalX(2,1);
trk.t=(1:ctime)';
%figure,scatter(trk.x,trk.y)
trkSet=trk;
for i=1:num-1
    Xrand=randn([2,1])*1;

    tRand=round(length(T)*rand([1,1]));
    curTrk.x=trk.x+Xrand(1,1);
    curTrk.y=trk.y+Xrand(2,1);
    tempX=curTrk.x(1:tRand);
    curTrk.x(1:end-tRand)=curTrk.x(tRand+1:end);
    curTrk.x(end-tRand+1:end)=tempX;
    curTrk.t=trk.t;
    tempY=curTrk.y(1:tRand);
    curTrk.y(1:end-tRand)=curTrk.y(tRand+1:end);
    curTrk.y(end-tRand+1:end)=tempY;
    curTrk.x=curTrk.x+intervalX(1,1);
    curTrk.y=curTrk.y+intervalX(2,1);
    trkSet=[trkSet curTrk];
end

end

function trkSet = lineTrk(ctime,num,xielv,intervalX)
%LINETRK Summary of this function goes here
%   Detailed explanation goes here
para=xielv;
time=ctime/2;
t=[1:time];
t2=-[time:-1:1];
T=[t2 t]./20;

trk.x=T'+intervalX(1,1);
trk.y=para*T'+intervalX(2,1);
trk.t=(1:ctime)';
%figure,scatter(trk.x,trk.y)
trkSet=trk;
for i=1:num-1
    Xrand=randn([2,1])*2;

    tRand=round(length(T)*rand([1,1]));
    curTrk.x=trk.x+Xrand(1,1);
    curTrk.y=trk.y+Xrand(2,1);
    tempX=curTrk.x(1:tRand);
    curTrk.x(1:end-tRand)=curTrk.x(tRand+1:end);
    curTrk.x(end-tRand+1:end)=tempX;
    curTrk.t=trk.t;
    tempY=curTrk.y(1:tRand);
    curTrk.y(1:end-tRand)=curTrk.y(tRand+1:end);
    curTrk.y(end-tRand+1:end)=tempY;
    curTrk.x=curTrk.x+intervalX(1,1);
    curTrk.y=curTrk.y+intervalX(2,1);
    trkSet=[trkSet curTrk];
end


end

function trkSet= parabolaTrk(ctime,num)
%PARABOLATRK Summary of this function goes here
%   Detailed explanation goes here
para=2;
time=ctime/2;
t=[1:time];
t2=-[time:-1:1];
T=[t2 t]./55;

trk.x=(2*para.*T)';
trk.y=(para.*T.*T)';
trk.t=(1:ctime)';
%figure,scatter(trk.x,trk.y)
trkSet=trk;
for i=1:num-1
    Xrand=randn([2,1])*2;

    tRand=round(length(T)*rand([1,1]));
    curTrk.x=trk.x+Xrand(1,1);
    curTrk.y=trk.y+Xrand(2,1);
    tempX=curTrk.x(1:tRand);
    curTrk.x(1:end-tRand)=curTrk.x(tRand+1:end);
    curTrk.x(end-tRand+1:end)=tempX;
    curTrk.t=trk.t;
    tempY=curTrk.y(1:tRand);
    curTrk.y(1:end-tRand)=curTrk.y(tRand+1:end);
    curTrk.y(end-tRand+1:end)=tempY;
    trkSet=[trkSet curTrk];
end
end

function trkSet= RealCircleTrk(ctime,R,sampleDensityControl,intervalX)
%initialX: starting point of the real circle
%time: is the length of the trk
%intervalX: how to move the curve
time=ctime;
X0=-R+R*2*rand([2,sampleDensityControl]);
distance=sqrt(X0(1,:).^2+X0(2,:).^2);
foreIndex=find(distance<R);
foreX=X0(:,foreIndex);


trkSet=[];
for i=1:length(foreX); 
curTrkX=zeros(3,ctime);
curTrkX(1:2,1)=foreX(:,i);
curTrkX(3,1)=1;
for j=2:time
   curTrkX(1,j)=curTrkX(1,j-1)+curTrkX(2,j-1)*0.1;% here can change the direction of movement of the cricle
   curTrkX(2,j)=curTrkX(2,j-1)-curTrkX(1,j-1)*0.1;
   curTrkX(3,j)=j;
end
trk.x=curTrkX(1,:)'+intervalX(1,1);
trk.y=curTrkX(2,:)'+intervalX(2,1);
trk.t=curTrkX(3,:)';
trkSet=[trkSet trk];
end

end

function trkSet = noiseTrk(W,time,num)
%NOISETRK Summary of this function goes here
%   Detailed explanation goes here

noiseX=-W+round(W*2*[rand([2,num])]);

trkSet=[];

for i=1:length(noiseX)
    curTrkX=zeros(3,time);
    curTrkX(1:2,1)=noiseX(:,i);
    curTrkX(3,1)=1;
    for j=2:time
        curTrkX(1:2,j)=curTrkX(1:2,j-1)+randn([2,1])*1.2;        
        curTrkX(3,j)=j;
    end
    curTrk.x=curTrkX(1,:)';
    curTrk.y=curTrkX(2,:)';
    curTrk.t=curTrkX(3,:)';
    trkSet=[trkSet curTrk];
end


end

function trkSet= faceCurveTrk(ctime,num,intervalX)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

t=[1:ctime];

T=t./30;

trk.x=(2.*T.*cos(T))'+intervalX(1,1);
trk.y=ones(length(T),1)+intervalX(2,1);
trk.z=(2.*T.*sin(T))'+intervalX(3,1);
trk.t=t';

trkSet=trk;
for i=1:num-1
    %Xrand=randn([3,1])*1;
    tRand=round(length(T)*rand([1,1]));
    curTrk.x=trk.x;%+Xrand(1,1);
    curTrk.y=trk.y;%+Xrand(2,1);
    curTrk.z=trk.z;%+Xrand(3,1);
    tempX=curTrk.x(1:tRand);
    
    curTrk.x(1:end-tRand)=curTrk.x(tRand+1:end);
    curTrk.x(end-tRand+1:end)=tempX;
    curTrk.t=trk.t;
    
    tempY=curTrk.y(1:tRand);
    curTrk.y(1:end-tRand)=curTrk.y(tRand+1:end);
    curTrk.y(end-tRand+1:end)=tempY;
    tempZ=curTrk.z(1:tRand);
    
    curTrk.z(1:end-tRand)=curTrk.z(tRand+1:end);
    curTrk.z(end-tRand+1:end)=tempZ;    
    
    curTrk.x=curTrk.x+intervalX(1,1);
    curTrk.z=curTrk.z+intervalX(3,1);
    curTrk.y=ones(length(curTrk.x),1).*ceil(18*rand)+intervalX(2,1);
    trkSet=[trkSet curTrk];
    
end

end

function trkSet= helixTrk(ctime,R,num,intervalX,pointer)
%HELIXTRK Summary of this function goes here
%   Detailed explanation goes here
para=R;
para2=4;
time=ctime/2;
t=[1:time];
t2=-[time:-1:1];
T=[t2 t]./30;
if pointer==1
    
    trk.x=(para.*cos(T))'+intervalX(1,1);
    trk.y=(para.*sin(T))'+intervalX(2,1);
    trk.z=(para2.*T)'+intervalX(3,1);
    trk.t=t';
else
    trk.y=(para.*cos(-T))'+intervalX(1,1);
    trk.x=(para.*sin(-T))'+intervalX(2,1);
    trk.z=(para2.*(-T))'+intervalX(3,1);
    trk.t=t';
end
%figure,scatter(trk.x,trk.y)
trkSet=trk;
for i=1:num-1
    Xrand=randn([3,1])*1;
    tRand=round(length(T)*rand([1,1]));
    curTrk.x=trk.x+Xrand(1,1);
    curTrk.y=trk.y+Xrand(2,1);
    curTrk.z=trk.z+Xrand(3,1);
    tempX=curTrk.x(1:tRand);
    curTrk.x(1:end-tRand)=curTrk.x(tRand+1:end);
    curTrk.x(end-tRand+1:end)=tempX;
    curTrk.t=trk.t;
    tempY=curTrk.y(1:tRand);
    curTrk.y(1:end-tRand)=curTrk.y(tRand+1:end);
    curTrk.y(end-tRand+1:end)=tempY;
    tempZ=curTrk.z(1:tRand);
    curTrk.z(1:end-tRand)=curTrk.z(tRand+1:end);
    curTrk.z(end-tRand+1:end)=tempZ;
    
    curTrk.x=curTrk.x+intervalX(1,1);
    curTrk.y=curTrk.y+intervalX(2,1);
    curTrk.z=curTrk.z+intervalX(3,1);
    trkSet=[trkSet curTrk];
end
end

function trkSet = noiseTrk3D(W,time,num)
%NOISETRK Summary of this function goes here
%   Detailed explanation goes here

noiseX=-W+round(W*2*[rand([3,num])]);

trkSet=[];

for i=1:length(noiseX)
    curTrkX=zeros(4,time);
    curTrkX(1:3,1)=noiseX(:,i);
    curTrkX(4,1)=1;
    for j=2:time
        curTrkX(1:3,j)=curTrkX(1:3,j-1)+randn([3,1])*0.8;
        curTrkX(4,j)=j;
    end
    curTrk.x=curTrkX(1,:)';
    curTrk.y=curTrkX(2,:)';
    curTrk.z=curTrkX(3,:)';
    curTrk.t=curTrkX(4,:)';
    trkSet=[trkSet curTrk];
end


end


