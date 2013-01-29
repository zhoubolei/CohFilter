clc
clear

d=3;
K=15;
lamda=0.6;

load crowdTrk.mat;
ImgfileDir='realdata\';

% ImgfileDir='C:\project\collectiveMotion\new\crowdData\marathon\'
% trks=readTraks('C:\project\collectiveMotion\new\crowdData\marathon_trk.txt');

frames=dir([ImgfileDir '*.jpg']);

%% 
nTrks=length(trks);
nFrame=length(frames);
trkKind=ceil(4*rand(nTrks,1));
trkTime=zeros(2,nTrks);
for i=1:nTrks
    trkTime(1,i)=trks(1,i).t(1);
    trkTime(2,i)=trks(1,i).t(end);
end
%%
figure
for i=1:nFrame
    curFrame=imread([ImgfileDir frames(i).name]);
    %curFrame=rgb2gray(curFrame);
    imshow(curFrame),title(['Frame No.' num2str(i)])
    hold on
    
    curIndex=(find(trkTime(1,:)<=(i) & trkTime(2,:)>=(i)))';    
    includedSet=trks(1,curIndex);
   
    [curAllX,clusterIndex]=CoherentFilter(includedSet,i,d,K,lamda); % coherence filtering clustering
    nCluster=max(clusterIndex);
    
    for j=1:nCluster
        scatter(curAllX(1,find(clusterIndex==j)),curAllX(2,find(clusterIndex==j)),'+');
        hold on
    end
    drawnow
    hold off
   
end