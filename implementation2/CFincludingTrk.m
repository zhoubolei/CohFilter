function [includedTrk,includeIndex] = CFincludingTrk(trks,trkTime,curTime,sumFrame)
%CFINCLUDINGTRK get online trks from trk set
%  

includeIndex=find(trkTime(1,:)<curTime & trkTime(2,:)>(curTime+sumFrame));
includedTrk=trks(1,includeIndex);

end

