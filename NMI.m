function Y = NMI(C1,C2)

% Y = NMI(C1,C2)
% normalized mutual information
% C1, C2 - two cluster vectors for the same data set
% Y - the value of normalized mutual information
% 0 =< Y =< 1, the larger Y, the more similar of C1 and C2
% NMI(C1,C2)=I(C1,C2)/sqrt(H(C1)*H(C2))

Y = MyMutInf(C1,C2) / sqrt(MyEntropy(MyHist(C1))*MyEntropy(MyHist(C2)));

function H = MyEntropy(X)

X = X + eps;
H = sum(-X .* log2(X));

function Y = MyMutInf(C1,C2)

% C1 - obtained cluster vector
% C2 - true cluster vector
% Y - mutual information of C1 and C2

Y = 0;
Npts = length(C1); % number of points
u1 = unique(C1);
u2 = unique(C2);
k1 = length(u1);
k2 = length(u2);
p1 = MyHist(C1);
p2 = MyHist(C2);
p = zeros(k1,k2);
for i = 1 : k1
    idx1 = find(C1==u1(i));
    for j = 1 : k2
        idx2 = find(C2==u2(j));
        p(i,j) = sum(ismember(idx1,idx2))/Npts;
        if p(i,j) > 0
            Y = Y + p(i,j)*log2(p(i,j)/(p1(i)*p2(j)));
        end
    end
end

function X = MyHist(C)

% C - cluster vector
% X - probabilistic distribution

Npts = length(C); % number of points

u = unique(C);
k = length(u); % number of clusters

X = zeros(k,1);
for i = 1 : k
    X(i) = sum(C==u(i)); % number of points in i-th cluster
end

X = X/Npts; % 
