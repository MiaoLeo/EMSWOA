function [group_value] = D_Grouping(groupnum,Npop,eco)
    init_index = 1 : Npop;
    n=floor(Npop/groupnum)-1;
    cn = 1;
    while cn <= groupnum
        len = length(init_index);
        pos = sort(randperm(len,n));  
        group_value{cn,1} = init_index(pos);  
        init_index(pos) = [];   
        cn = cn + 1;
    end
    
    %centroid distance metric
    lens = length(init_index);
    temp_dist=inf;
    while lens>0
        for i=1:groupnum
         temp_eco=eco(group_value{i,1},:);
         center=mean(temp_eco);
         dist=pdist2(double(center),double(temp_eco));
         temp_dist(i)=max(dist);
         
        end
        [temp_dist,dist_index]=sort(temp_dist,'descend');
        zhong=ceil(rand*groupnum); 
        if zhong<1
            zhong=1;
        end
        
        j=1;
        while lens>0 && j<=zhong
        len = length(init_index);

        ind=randperm(len,1);
        group_value{dist_index(j),1}=[group_value{dist_index(j),1},init_index(ind)];
        init_index(ind) = []; 
        
        j=j+1;
         lens = length(init_index);
        end
        lens = length(init_index);
    end
    
    for k=1:groupnum
        group_value{k,1}=sort(group_value{k,1});
    end
end

