
function [X,Y]=get_data(data_name)


if data_name==1
    %%Australian
    load 'D:\MATLABWorkSpace\PHD\High_Dim_FS\data\11_Tumor.mat'
%     data=Australian;

    
elseif data_name==2
    %%Breast cancer tissue
    load 'D:\MATLABWorkSpace\PHD\High_Dim_FS\data\9_Tumor.mat'
%     data=Breast_cancer_tissue;
          
elseif data_name==3
    %%%-Climate
   load 'D:\MATLABWorkSpace\PHD\High_Dim_FS\data\Brain_Tumor_1.mat'
%     data=Climate;

    
elseif data_name==4
    %% fri_c0_500_10
    load 'D:\MATLABWorkSpace\PHD\High_Dim_FS\data\Brain_Tumor_2.mat'
%     data=fri_c0_500_10;
    
  
    
elseif data_name==5
    load 'D:\MATLABWorkSpace\PHD\High_Dim_FS\data\DLBCL.mat'
   
elseif data_name==6
    %%IonosphereEW
    load 'D:\MATLABWorkSpace\PHD\High_Dim_FS\data\Leukemia_1.mat'
%     data=IonosphereEW;   
   
elseif  data_name==7
    %%Kc1
    load 'D:\MATLABWorkSpace\PHD\High_Dim_FS\data\Leukemia_2.mat'
%     data=kc1;
   
elseif data_name==8
    %%Kc2
    load 'D:\MATLABWorkSpace\PHD\High_Dim_FS\data\Leukemia_3.mat'
%     data=kc2;  

elseif data_name==9
    %%Page blocks
    load 'D:\MATLABWorkSpace\PHD\High_Dim_FS\data\Lung_Cancer.mat'
%     data=page_blocks;
          
elseif data_name==10
    %%%-Parkinsons
   load 'D:\MATLABWorkSpace\PHD\High_Dim_FS\data\Prostate_Tumor_1.mat'
%     data=Parkinsons;


elseif data_name==11
    %%%-GLI_85
    load 'D:\MATLABWorkSpace\PHD\High_Dim_FS\data\GLI_85.mat'
   
elseif data_name==12
    %%%-GLI_85
    load 'D:\MATLABWorkSpace\PHD\High_Dim_FS\data\SMK_CAN_187.mat'
    

end













