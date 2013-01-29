function displayTrks(trkSet,groundtruthIndex,time,pointer)
%DISPLAYTRKS Summary of this function goes here
%   Detailed explanation goes here
nCluster=max(groundtruthIndex);
if pointer=='2D'
    allTrkX=zeros(time,length(trkSet));
    allTrkY=zeros(time,length(trkSet));
    for j=1:length(trkSet)           
        allTrkX(:,j)=trkSet(1,j).x(1:time);
        allTrkY(:,j)=trkSet(1,j).y(1:time);   
    end
    for i=1:time
        hold off
        for j=1:nCluster
            
            scatter(allTrkX(i,find(groundtruthIndex==j)),allTrkY(i,find(groundtruthIndex==j)),'.');
            hold on
        end
        drawnow
        pause(0.2)
    end
else
    allTrkX=zeros(time,length(trkSet));
    allTrkY=zeros(time,length(trkSet));
    allTrkZ=zeros(time,length(trkSet));
    for j=1:length(trkSet)           
        allTrkX(:,j)=trkSet(1,j).x(1:time);
        allTrkY(:,j)=trkSet(1,j).y(1:time);   
        allTrkZ(:,j)=trkSet(1,j).z(1:time);  
    end
    for i=1:time
        hold off
        for j=1:nCluster
            
            scatter3(allTrkX(i,find(groundtruthIndex==j)),allTrkY(i,find(groundtruthIndex==j)),allTrkZ(i,find(groundtruthIndex==j)),'.');
            hold on
        end
        drawnow
        pause(0.2)
    end
end

