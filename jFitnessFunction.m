%-------------------------------------------------------------------------%
%  Fitness Function (Error Rate) source codes demo version                %
%                                                                         %
%  Programmer: Jingwei Too                                                %
%                                                                         %
%  E-Mail: jamesjames868@gmail.com                                        %
%-------------------------------------------------------------------------%  

function fitness=jFitnessFunction(feat,label)
% Parameter setting for k-value of KNN
k=5; 
% Parameter setting for number of cross-validation
kfold=10;
% Error rate
fitness=jwrapperKNN(feat,label,k,kfold);
end

% Perform KNN with k-folds cross-validation
function ER=jwrapperKNN(feat,label,k,kfold)
Model=fitcknn(feat,label,'NumNeighbors',k,'Distance','euclidean'); 
C=crossval(Model,'KFold',kfold);
% Error rate 
ER=kfoldLoss(C);


end







