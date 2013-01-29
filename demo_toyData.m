clc
clear
%% parameters
d=5;
K=15;
lamda=0.7;

datasetIndex='2D';
%datasetIndex='3D';

%% Show the coherent motion patterns

[trkSet,groundtruthIndex]= genTrks(datasetIndex); % to generate synthetic data
figure
nFrame=15;
display(['show ' num2str(nFrame) ' frames of the synthetic coherent motion patterns'])
displayTrks(trkSet,groundtruthIndex,nFrame,datasetIndex);
title(['Groundtruth. Total dots:' num2str(length(trkSet)) ' Coherent dots/Total dots:' num2str(length(find(groundtruthIndex~=1))/length(trkSet))])
drawnow
sampledTrkSet= sampleTrkSet(trkSet,d+2); % input for the algorithm

%% Coherent Filtering 
display('-----------------------------------------')
display('begin Coherent Filtering Clustering...')
[curAllX,clusterIndex]=CoherentFilter(sampledTrkSet,2,d,K,lamda);

%% NMI score
NMI_score=NMI(groundtruthIndex,clusterIndex);
display(['NMI score=' num2str(NMI_score)]);

%% show the clustering results.
figure
nCluster=max(clusterIndex);
for i=1:nCluster   
    if datasetIndex=='2D'
        scatter(curAllX(1,find(clusterIndex==i)),curAllX(2,find(clusterIndex==i)),'.'),  
        hold on
    else  
        scatter3(curAllX(1,find(clusterIndex==i)),curAllX(2,find(clusterIndex==i)),curAllX(3,find(clusterIndex==i)),'.'),  
        hold on
    end
    
end
title(['Results   Number of detected coherent motion patterns: ' num2str(nCluster)])
display('Clustering Done!')



