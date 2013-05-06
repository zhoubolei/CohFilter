%% a dirty implementation of Coherent Filtering
% 
% algorithm for detecting coherent motion patterns
% algorithm for associating coherent motion clusters over time

% Bolei Zhou
% May 6, 2013.

% Reference:
% Bolei Zhou, Xiaoou Tang, and Xiaogang Wang. "Coherent Filtering :Detecting Coherent Motions from Crowd Clutters." 
% Proceedings of 12th European Conference on Computer Vision (ECCV 2012) 

clear,clc
load('colorSet.mat');

trks = readTraks('traffic_china\klt_3000_10_trk.txt');
ImgfileDir = 'traffic_china\';
frames = dir([ImgfileDir '*.jpg']);

%% algorithm parameter
sumFrame = 5;
Knn = 5;
threshold = 0.8;

%% load trajectories set and label their starting and ending time
nTrks = length(trks);
trkTime = zeros(2,nTrks);
for i=1:nTrks
    trkTime(1,i) = trks(1,i).t(1);
    trkTime(2,i) = trks(1,i).t(end);
end
trkTimeLine = zeros(nTrks,max(trkTime(:)));
for i=1:nTrks
    trkTimeLine(i,trkTime(1,i):trkTime(2,i)) = 1;
end

trkClusterTimeLine(nTrks,max(trkTime(:))) = 0;

%% extract cluster index at each frame
for curTime = 1 : max(trkTime(:))   
    [includedSet,curIndex] = CFincludingTrk(trks,trkTime,curTime,sumFrame);
    [frameGraph,curAllX,curAllV] = CFcomputePairTracklet(includedSet,curTime,sumFrame,Knn);
    [removedPointIndex,clusterIndex] = selectClusterFromGraph(frameGraph,Knn,threshold);
    nCluster = max(clusterIndex);
    dotForeLabel = find(clusterIndex~=0); 
    dotBackLabel = find(clusterIndex==0);
    if ~isempty(dotForeLabel)
        trkClusterTimeLine(curIndex(dotForeLabel'),curTime) = clusterIndex(dotForeLabel)';
    end
    display(['current processing frame No.' num2str(num2str(curTime))])
end

figure, imshow(trkTimeLine);
figure, imshow(trkClusterTimeLine);
    

%% associating clusters over all the frames
clusterLabelEachtime = CFunifyClusterEachtime(trkTimeLine,trkClusterTimeLine);

%% visualize the clustering & associating results
figure
for curTime = 1:max(trkTime(:))
    curFrame = imread([ImgfileDir frames(curTime).name]);
	[curXset,curVset,existIndex] = CFtrk2VX(trks,curTime,trkTime);  
    curClusterIndex = clusterLabelEachtime(:,curTime);
    hold off
    imshow(curFrame),
    title(['current Frame. No' num2str(curTime)]);
    set(gcf,'color',[0,0,0]) 
    set(gca,'position',[0 0 1 1])
    hold on
    %scatter(curXset(1,:),curXset(2,:),'+');
    clusterValue=unique(curClusterIndex);
    if clusterValue(1)==0
        clusterValue=clusterValue(2:end);
    end    
    for jj=1:length(clusterValue)
        
        curClusterTrkIndex=find(curClusterIndex==clusterValue(jj));         
        curClusterX=curXset(1,curClusterTrkIndex);
        curClusterY=curXset(2,curClusterTrkIndex);
        scatter(curClusterX',curClusterY',[],repmat(CFshowTag(clusterValue(jj), colorSet),[size(curClusterX,2) 1]),'filled'),  

        hold on
     end     

    drawnow
    hold off
%     f=getframe(gcf);
%     resultName=[sprintf('a%06d',curTime) '.jpg'];
%     imwrite(f.cdata,[resultPath,resultName])
    
end
