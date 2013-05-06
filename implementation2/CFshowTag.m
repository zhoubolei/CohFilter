function colorTag = CFshowTag(value, colorSet)
% CFSHOWTAG Summary of this function goes here
%   Detailed explanation goes here
%colorSet={'y', 'm', 'c', 'r', 'g', 'b','w'};


% colorNumeric={[187 255 255],[0 245 255], ...
%     [193 255 193],[100 149 237],[0 255 0],...
%     [154 205 50],[255 246 143],[255 215 0],...
%     [205 92 92],[238 99 99],[178 34 34],[139 101 8],[255 165 0],[255 48 48],[255 105 180],[255 0 0],[255 181 197],[224 238 224],[105 89 205],[144 238 144]};
% for i=1:length(colorNumeric)
%     colorNumeric{1,i}=colorNumeric{1,i}./255;
% end
% randNum=randperm(length(colorNumeric));
% colorSet=cell(1,length(colorNumeric));
% for i=1:length(colorNumeric)
%     colorSet{1,i}=colorNumeric{1,randNum(i)};
% end


% colorNumeric={[144 238 144],[139 0 0],[139 0 139],[0 139 139],[255 0 255],[224 238 224],[255 69 0],[255 255 0],[127 255 0],[0 255 255]}
% for i=1:length(colorNumeric)
%     colorNumeric{1,i}=colorNumeric{1,i}./255;
% end
% randNum=randperm(length(colorNumeric));
% colorSet=cell(1,length(colorNumeric));
% for i=1:length(colorNumeric)
%     colorSet{1,i}=colorNumeric{1,randNum(i)};
% end


colorTag=colorSet{1,mod(value,length(colorSet))+1};


end

