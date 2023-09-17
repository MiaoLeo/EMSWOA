function [Leader_acc,Leader_pos,Leader_score,Convergence_curve,iter_fsnum,iter_acc]=EMSWOA(SearchAgents_no,Max_iter,dim,fun,train_data,train_labels)

Leader_pos=zeros(1,dim);
Leader_score=inf; 
Leader_acc=inf; 
Leader_trans=zeros(1,dim);
ub=5;lb=-5;

%Initialize the positions of search agents
Positions=initialization(SearchAgents_no,dim,ub,lb)>0;
Positions_trans=zeros(SearchAgents_no,dim);

Convergence_curve=zeros(1,Max_iter);
iter_fsnum= zeros(1, Max_iter);
iter_acc=zeros(1, Max_iter);
t=1;


for ii=1:SearchAgents_no
    Positions(ii,:)>0;
    Positions(ii,:)=checkempty(Positions(ii,:),dim);
    [fitness(ii),cu_acc]=fun(train_labels,train_data(:,Positions(ii,:)),t,dim);
    if fitness(ii)<Leader_score 
        Leader_score=fitness(ii); 
        Leader_pos=Positions(ii,:);
        Leader_acc=cu_acc;
    end
end

eco=Positions;
leader_fsnum=sum(Leader_pos>0);
[fitness,index]=sort(fitness);
Positions=Positions(index,:);


maxgroup=20;
mingroup=1;
groups= sort(round(mingroup+rand(1,Max_iter)*(maxgroup-mingroup)),'descend');
groups(end-10:end)=1;

gt=1;
% Main loop
while t<=Max_iter


    pre_Leader_pos=Leader_pos;
    pre_Leader_score=Leader_score;
    pre_Leader_trans=Leader_trans;

    %%Dynamic multi-swarm mechanism based on centroid distance
    if gt==t
        groupnum=groups(t);
        [converg_group] = D_Grouping(groupnum, SearchAgents_no,Positions);
        gt=gt+10;
    end

    crowding = LSD(fitness);
    [~, index_crowding] = sort(crowding);


    losers = zeros(1,SearchAgents_no);
    con_winners = zeros(1,SearchAgents_no);
    div_winners = zeros(1,SearchAgents_no);
    cn = 1;
    count = 1;
    while cn <= groupnum
        temp_list = converg_group{cn,1};
        temp_list(temp_list == 0) = [];
        computing_size = length(temp_list);
        k = 2;
        while k <= computing_size
            pos_in_entropy = find(index_crowding == temp_list(k));

            if  pos_in_entropy <= (0.5+rand)*SearchAgents_no
                losers(count) = temp_list(k);
                [~,inss]=min(fitness(temp_list));
                con_winners(count) = temp_list(inss);
                div_winners(count) = index_crowding(pos_in_entropy + ceil(rand*(SearchAgents_no - pos_in_entropy)));
                count = count + 1;
            end
            k = k + 1;
        end
        cn = cn + 1;
    end
    losers(losers == 0) = [];
    con_winners(con_winners == 0) = [];
    div_winners(div_winners == 0) = [];
    lenloser = length(losers);
    con_exemplar = Positions(con_winners,:);
    div_exemplar = Positions(div_winners,:);
    at=1*(1-(t/Max_iter));
    a=2-t*((2)/Max_iter);
    a2=-1+t*((-1)/Max_iter);

    mdex=1;
    for i=losers
        r1=rand();
        r2=rand();
        A=2*a*r1-a;
        C=2*r2;
        b=1;
        l=(a2-1)*rand()+1;
        p = rand();

        for j=1:dim
            if p<0.5
                if abs(A)>=1
                    rand_leader_index = floor(SearchAgents_no*rand()+1);
                    X_rand = Positions(rand_leader_index, :);
                    D_X_rand=abs(C*div_exemplar(mdex,j)-Positions(i,j));
                    Positions(i,j)=X_rand(j)-A*D_X_rand;
                elseif abs(A)<1
                    D_Leader=abs(C*con_exemplar(mdex,j)-Positions(i,j));
                    Positions(i,j)=con_exemplar(mdex,j)-A*D_Leader;
                end
            elseif p>=0.5
                distance2Leader=abs(con_exemplar(mdex,j)-Positions(i,j));
                Positions(i,j)=distance2Leader*exp(b.*l).*cos(l.*2*pi)+con_exemplar(mdex,j);
            end
        end
        mdex=mdex+1;
    end


    for i=losers

        % Return back the search agents that go beyond the boundaries of the search space
        Flag4ub=Positions(i,:)>ub;
        Flag4lb=Positions(i,:)<lb;
        Positions(i,:)=(Positions(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;

        % Calculate objective function for each search agent
        [Positions(i,:),Positions_trans(i,:)]=transfers(Positions(i,:),Positions(i,:),dim,5,1);
        Positions(i,:)=checkempty(Positions(i,:),dim);
        [fitness(i),cu_acc]=fun(train_labels,train_data(:,Positions(i,:)>0),1,dim);

        % Update the leader
        if fitness(i)<Leader_score %
            Leader_score=fitness(i);
            Leader_pos=Positions(i,:);
            Leader_trans=Positions_trans(i,:);
            Leader_acc=cu_acc;
            leader_fsnum=sum(Leader_pos>0);

        end

        %%Elite tuning strategy

        for jjj=1:dim
            if Leader_pos(jjj)==pre_Leader_pos(jjj) && Leader_pos(jjj)==1
                if Positions(i,jjj)==0
                    Positions(i,jjj)=rand>0.45;
                end

            elseif Leader_pos(jjj)==pre_Leader_pos(jjj) && Leader_pos(jjj)==0
                if Positions(i,jjj)~=0
                    Positions(i,jjj)=rand>0.2+(sum(Leader_pos>0)/dim);
                end

            elseif Leader_pos(jjj)~=pre_Leader_pos(jjj) && Leader_pos(jjj)==1

                if Leader_trans(jjj)<Positions_trans(i,jjj) && Positions(i,jjj)==0
                    Positions_trans(i,jjj)=Positions_trans(i,jjj)+rand*(Leader_trans(jjj)-pre_Leader_trans(jjj));

                    if rand<Positions_trans(i,jjj)
                        Positions(i,jjj)=1;
                    else
                        Positions(i,jjj)=0;
                    end

                elseif Leader_trans(jjj)>Positions_trans(i,jjj) && Positions(i,jjj)==0
                    Positions(i,jjj)=Positions(i,jjj)+rand*(at/(1+exp(Leader_trans(jjj)-Positions_trans(i,jjj))))*abs(Leader_pos(jjj)-Positions(i,jjj));
                    [Positions(i,jjj),Positions_trans(i,jjj)]=transfers(Positions(i,jjj),Positions(i,jjj),1,5,1);
                end


            end

        end


        % Calculate objective function for each search agent
        [Positions(i,:),Positions_trans(i,:)]=transfers(Positions(i,:),Positions(i,:),dim,5,1);
        Positions(i,:)=checkempty(Positions(i,:),dim);
        [fitness(i),cu_acc]=fun(train_labels,train_data(:,Positions(i,:)>0),1,dim);


        % Update the leader
        if fitness(i)<Leader_score
            Leader_score=fitness(i);
            Leader_pos=Positions(i,:);
            Leader_trans=Positions_trans(i,:);
            Leader_acc=cu_acc;
            leader_fsnum=sum(Leader_pos>0);

        end
    end
    [fitness, index] = sort(fitness);
    Positions = Positions(index,:);
    Positions_trans=Positions_trans(index,:);

    fprintf('Iteration:%d, acc:%d, Fmin:%d, fnum:%d\n',t,Leader_acc, Leader_score,leader_fsnum);
    Convergence_curve(t)=Leader_score;
    iter_acc(t)=Leader_acc;
    iter_fsnum(t)=leader_fsnum;
    t=t+1;

end
end

function [dist]=distance(vec1,vec2)
dist=0;
for i=1:size(vec1,2)
    dist=dist+((vec1(i)-vec2(i))^2);
end
dist=sqrt(dist);
end

