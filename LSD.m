function entropy = LSD(fitness)
    len = length(fitness);
    entropy = zeros(1, len);
    l = (fitness(3:len)-fitness(1:len-2));
    L = [l(1) l l(end)];
    L = L/(fitness(end) - fitness(1));
    L = L/max(L);
    
    l1 = (fitness(2:len-1)-fitness(1:len-2))./l;
    l1(2,:) = (fitness(3:len)-fitness(2:len-1))./l;
    l2 = sort(l1);
    x = l2(1,:)./l2(2,:);
    entropy(1) = 0;
    entropy(end) = 0;
    entropy(2:len-1) = x;
    entropy = entropy/max(entropy);
    entropy = entropy.*L;
end

