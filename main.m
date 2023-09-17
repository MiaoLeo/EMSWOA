clear all
warning off
clc


SearchAgents_no=100; % Number of search agents

Max_iteration=100; % Maximum numbef of iterations

[X,Y]=get_data(5);

cloumn=size(X,2);

dim=cloumn;

fun=@fobj_select;

woa_feature=[];
acc=[];
predict_label=[];
curve=[];
fit=[];
for i=1:1
    
    %
    [Leader_acc,woa_Selection_knn , woa_SelectionValue,cg_curve,iter_fsnum,iter_acc]=EMSWOA(SearchAgents_no,Max_iteration,dim,fun,X,Y);
    % hold on;
    plot(cg_curve);
    hold on;
    select_index=[woa_Selection_knn,woa_SelectionValue];
    acc=Leader_acc;
    feature_num=sum(woa_Selection_knn);
    
    if isempty (woa_feature)
        
        woa_feature=[woa_Selection_knn acc feature_num  woa_SelectionValue];
        curve=cg_curve;
      
    else
        ru_a=[woa_Selection_knn acc feature_num  woa_SelectionValue];
        woa_feature=[woa_feature;ru_a];
        curve=[curve;cg_curve];
      
    end
    
end
marks_index=dim+1;
result_best=max(woa_feature(:,marks_index));%best
result_worst=min(woa_feature(:,marks_index));%worst
result_mean=mean(woa_feature(:,marks_index));%'avg'
result_std=std(woa_feature(:,marks_index));%'std'
rs=[result_best,result_worst,result_mean,result_std];

emswoa_rs={woa_feature;rs;curve};


