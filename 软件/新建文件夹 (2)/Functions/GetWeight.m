function [ Weight ] = GetWeight( Array,xlabel,ylabel,zlabel )
%GetWeight 获取信号的质心
%   Array:待求数组
%   xlabel:
%   ylabel:
%   zlabel:


if nargin==1
    [N1,N2,N3]=size(Array);
    if N3<=1
        xlabel=1:N2;
        TempLabel=repmat(xlabel,N1,1);
        Weight=sum(Array.*TempLabel,2)./sum(Array,2);
    else
        Weight=zeros(N3,2);
        [xlabel,ylabel]=meshgrid(1:N2,1:N1);
        TempLabelX=repmat(xlabel,1,1,N3);
        TempLabelY=repmat(ylabel,1,1,N3);
        Weight(:,1)=sum(Array(:).*TempLabelX(:))/sum(Array(:));
        Weight(:,2)=sum(Array(:).*TempLabelY(:))/sum(Array(:));
    end
end

if nargin==2
    [N1,~,N3]=size(Array);
    if N3<=1
        TempLabel=repmat(xlabel,N1,1);
        Weight=sum(Array.*TempLabel,2)./sum(Array,2);
    else
        Weight=zeros(N3,2);
        [xlabel,ylabel]=meshgrid(xlabel,1:N1);
        TempLabelX=repmat(xlabel,1,1,N3);
        TempLabelY=repmat(ylabel,1,1,N3);
        Weight(:,1)=sum(sum(Array.*TempLabelX))/sum(sum(Array));
        Weight(:,2)=sum(sum(Array.*TempLabelY))/sum(sum(Array));
    end
end

if nargin==3
    [~,~,N3]=size(Array);
    [xlabel,ylabel]=meshgrid(xlabel,ylabel);
    if N3==1
        Weight(1)=sum(sum(Array.*xlabel))/sum(sum(Array));
        Weight(2)=sum(sum(Array.*ylabel))/sum(sum(Array));
    else
        Weight=zeros(N3,2);
        TempLabelX=repmat(xlabel,1,1,N3);
        TempLabelY=repmat(ylabel,1,1,N3);
        Weight(:,1)=sum(sum(Array.*TempLabelX))/sum(sum(Array));
        Weight(:,2)=sum(sum(Array.*TempLabelY))/sum(sum(Array));
    end
end

if nargin==4
    [xlabel,ylabel,zlabel]=meshgrid(xlabel,ylabel,zlabel);
    Weight(1)=sum(Array(:).*xlabel(:))/sum(Array(:));
    Weight(2)=sum(Array(:).*ylabel(:))/sum(Array(:));
    Weight(3)=sum(Array(:).*zlabel(:))/sum(Array(:));

end

