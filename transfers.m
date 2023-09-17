function [xnew,Positions_trans]=transfers(a,eco,dim,flags,t)
ss=0;
ecos=eco;
Positions_trans=zeros(1,dim);
% t=1;
for j=1:dim
%     if a(j)>=0
        
        if flags==1
            ss=1./(1+exp(-2*a(j)/t)); %S1 transfer function
        end
        if flags==2
            ss=1./(1+exp(-a(j)/t));   %S2 transfer function
        end
        if flags==3
            ss=1./(1+exp(-a(j)/(2*t))); %S3 transfer function
        end
        if flags==4
            ss=1./(1+exp(-a(j)/(3*t)));  %S4 transfer function
        end
        
        if flags<=4 %S-shaped transfer functions
               Positions_trans(j) =ss;
            if rand<ss % Equation (4) and (8)
                eco(j)=1;
            else
                eco(j)=0;
            end
        end
        
        if flags==5
            if a(j)<=0
                ss=1-2/(1+exp(-2*a(j)/t));%V1
            else
                ss=2/(1+exp(-2*a(j)/t))-1;
            end
           
        end
        if flags==6
            if a(j)<=0
                ss=1-2/(1+exp(-a(j)/t));%V2
            else
                ss=2/(1+exp(-a(j)/t))-1;
            end
        end
        if flags==7
            if a(j)<=0
                ss=1-2/(1+exp(-a(j)/(2*t)));%V3
            else
                ss=2/(1+exp(-a(j)/(2*t)))-1;
            end
        end
        if flags==8
            if a(j)<=0
                ss=1-2/(1+exp(-a(j)/(3*t)));%V4
            else
                ss=2/(1+exp(-a(j)/(3*t)))-1;
            end
            
        end
        
        if flags>4 && flags<=8 %V-shaped transfer functions
            Positions_trans(j) =ss;
            if rand<ss 
                eco(j)=1;
            else
                eco(j)=0;
            end
        end
        
end

xnew=logical(eco);
end


