function [curXset,curVset,existIndex] = CFtrk2VX(trks,curTime,trkTime)
%CFTRK2VX Summary of this function goes here
%   Detailed explanation goes here
nTrks=length(trks);
curXset=zeros(2,nTrks);
curVset=zeros(2,nTrks);
existIndex=zeros(1,nTrks);

curIndex=find(trkTime(1,:)<=(curTime) & trkTime(2,:)>(curTime))';
for i=1:length(curIndex)
    curTrk=trks(1,curIndex(i));
    pointIndex=find(curTrk.t==curTime);
    curXset(1,curIndex(i))=curTrk.x(pointIndex);
    curXset(2,curIndex(i))=curTrk.y(pointIndex);
    curVset(1,curIndex(i))=curTrk.x(pointIndex+1)-curTrk.x(pointIndex);
    curVset(2,curIndex(i))=curTrk.y(pointIndex+1)-curTrk.y(pointIndex);
    existIndex(1,curIndex(i))=1;
end

end

