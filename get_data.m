
function [X,Y]=get_data(data_name)


if data_name==1
    load '..\data\11_Tumor.mat'


    
elseif data_name==2
    load '..\data\9_Tumor.mat'

          
elseif data_name==3
   load '..\data\Brain_Tumor_1.mat'

    
elseif data_name==4
    load '..\data\Brain_Tumor_2.mat'
    
  
    
elseif data_name==5
    load '..\data\DLBCL.mat'
   
elseif data_name==6
    load '..\data\Leukemia_1.mat'
   
elseif  data_name==7
    load '..\data\Leukemia_2.mat'
   
elseif data_name==8
    load '..\data\Leukemia_3.mat'

elseif data_name==9
    load '..\data\Lung_Cancer.mat'
          
elseif data_name==10
   load '..\data\Prostate_Tumor_1.mat'


elseif data_name==11
    load '..\data\GLI_85.mat'
   
elseif data_name==12
    load '..\data\SMK_CAN_187.mat'
    
end













