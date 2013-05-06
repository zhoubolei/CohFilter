function [removedPointIndex,clusterIndex]= selectClusterFromGraph(frameGraph,K,threshold)
%SELECTCLUSTERFROMGRAPH searh connected components from the graph

sampleGraph=frameGraph{1,1};
nPoint=size(sampleGraph,1);
sumGraph=zeros(nPoint);
nFrame=size(frameGraph,2);
for j=1:nFrame
    sumGraph=frameGraph{1,j}+sumGraph;
end
meanGraph=sumGraph./nFrame;

meanGraph(find(meanGraph==0))=-100;
pairIndex=ones(2,1);pairCov=zeros(1,1);
for i=1:nPoint-1   
    [B,IX] = sort(meanGraph(i,i+1:end),'descend');
    IX=IX+i;
    for j=1:min(K,length(IX))    
        if meanGraph(i,IX(j))>0.1
            pairIndex=[pairIndex [i;IX(j)]];            
        	pairCov=[pairCov meanGraph(i,IX(j))];
        end
    end
end

pairIndex_chosen=find(pairCov>threshold);
pairwiseData=pairIndex(:,pairIndex_chosen);


%% to find clusters from pairwise relationship data
pointPointer=zeros(1,nPoint);
for i=1:size(pairwiseData,2)
    curPair=pairwiseData(:,i);
    a1=pairwiseData(:,find(pairwiseData(1,:)==curPair(1,1)));  
    a2=pairwiseData(:,find(pairwiseData(2,:)==curPair(2,1)));
    aSet=[a1 a2];
    curCluster=unique(aSet(:));
    if length(curCluster)>13
        pointPointer(1,curCluster)=1;
    end
end
removedPointIndex=find(pointPointer==1);
totalNum=nPoint;
clusterIndex=pairCluster(pairwiseData,totalNum);

end


function clusterIndex=pairCluster(pairwiseData,totalNum)

clusterNum=0;
clusterIndex=zeros(1,totalNum);

for i=1:size(pairwiseData,2)
    curPair=pairwiseData(:,i);
    curPairAlabel=clusterIndex(1,curPair(1));
    curPairBlabel=clusterIndex(1,curPair(2));
    
    if curPairAlabel==0 && curPairBlabel==0
        clusterNum=clusterNum+1;
        curPairLabel=clusterNum;
        clusterIndex(1,curPair(1))=curPairLabel;
        clusterIndex(1,curPair(2))=curPairLabel;
    elseif curPairAlabel~=0 && curPairBlabel==0
        clusterIndex(1,curPair(2))=curPairAlabel;
    elseif curPairBlabel~=0 && curPairAlabel==0
        clusterIndex(1,curPair(1))=curPairBlabel;
    else
        combineLabel=min(curPairAlabel,curPairBlabel);
        clusterIndex(1,find(clusterIndex==curPairAlabel))=combineLabel;
        clusterIndex(1,find(clusterIndex==curPairBlabel))=combineLabel;
    end
    

end

newClusterNum=0;
for i=1:max(clusterNum)
    curClusterIndex=find(clusterIndex==i);
    if length(curClusterIndex)<5
        clusterIndex(curClusterIndex)=0;
   
    else
        newClusterNum=newClusterNum+1;
        clusterIndex(curClusterIndex)=newClusterNum;
    end
end
    

end

