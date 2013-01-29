function sampledTrkSet= sampleTrkSet(trkSet,time)
%SAMPLETRKSET Summary of this function goes here
%   Detailed explanation goes here
sampledTrkSet=trkSet;

nDimension=length(fieldnames(trkSet(1,1)))-1;

for i=1:length(trkSet)
    sampledTrkSet(1,i).x=sampledTrkSet(1,i).x(1:time);
    sampledTrkSet(1,i).y=sampledTrkSet(1,i).y(1:time);
    sampledTrkSet(1,i).t=sampledTrkSet(1,i).t(1:time);
    if nDimension==3
        sampledTrkSet(1,i).z=sampledTrkSet(1,i).z(1:time);
    end
end

