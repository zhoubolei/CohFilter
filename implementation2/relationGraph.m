function [motionGraph distanceGraph]= relationGraph(allX,allV,K)
allPointX=allX;
allPointV=allV;


nPoint=size(allPointX,2);
motionGraph=zeros(nPoint,nPoint);
distanceGraph=zeros(nPoint,nPoint);
for i=1:nPoint
    curX=allPointX(:,i);
    distance=repmat(curX,[1 nPoint])-allPointX;
    distance=sqrt(sum(distance.^2));
    [B,IX] = sort(distance,'ascend');
    %nearIndex=IX(2:min(K+1,length(IX)));
    %nearIndex=IX(2:end);
    for j=1:min(K,length(IX)-1)
        
        if sqrt(sum(allPointV(:,i).^2))>0 || sqrt(sum(allPointV(:,IX(j+1)).^2)) %&&B(j+1)<15
            
            coefficient=allPointV(:,i)'*allPointV(:,IX(j+1));
            
            coefficient=coefficient/((sqrt(sum(allPointV(:,i).^2))+eps)*(sqrt(sum(allPointV(:,IX(j+1)).^2))+eps));
            %degree=abs(acos(coefficient));
            motionGraph(i,IX(j+1))=coefficient;%degree; 
            distanceGraph(i,IX(j+1))=B(j+1);
        end
        %coefficient=allPointV(:,i)'*allPointV(:,IX(j+1));
       
        
        
    end
end
end
