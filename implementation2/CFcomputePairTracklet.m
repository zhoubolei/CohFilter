function [frameGraph,curAllX,curAllV]=CFcomputePairTracklet(includedSet,curTime,sumFrame,Knn)
%COMPUTEPAIRTRACKLET Summary of this function goes here
%   Detailed explanation goes here
tInterval=0;
frameGraph=cell(2,sumFrame);

allXset=cell(1,sumFrame);
allVset=cell(1,sumFrame);

for i=1:sumFrame
    allXset{1,i}=[];
    allVset{1,i}=[];
end

for i=1:length(includedSet)

    curIndex=find(includedSet(i).t>=curTime);
    curIndex=curIndex(1);       
    curX=[includedSet(i).x(curIndex:curIndex+sumFrame-1)';includedSet(i).y(curIndex:curIndex+sumFrame-1)'];        
    curV=[includedSet(i).x(curIndex+1+tInterval:curIndex+sumFrame+tInterval)'-includedSet(i).x(curIndex:curIndex+sumFrame-1)';includedSet(i).y(curIndex+1+tInterval:curIndex+sumFrame+tInterval)'-includedSet(i).y(curIndex:curIndex+sumFrame-1)'];                
    for j=1:sumFrame                      
        allXset{1,j}=[allXset{1,j},curX(:,j)];           
        allVset{1,j}=[allVset{1,j},curV(:,j)];       
    end

end
for j=1:sumFrame
     curAllX=allXset{1,j};
     curAllV=allVset{1,j};
     [motionGraph distanceGraph]= relationGraph(curAllX,curAllV,Knn);
     frameGraph{1,j}=motionGraph;
     frameGraph{2,j}=distanceGraph;
end
end
