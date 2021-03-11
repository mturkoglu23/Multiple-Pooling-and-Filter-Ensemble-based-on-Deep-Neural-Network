clc;clear;

layer='fc1000';
net=resnet101;


imds = imageDatastore('...\','IncludeSubfolders',true,'LabelSource','FolderNames');
uzunluk=numel(imds.Labels);

%% Pre-processing and Feature Extraction Phase 
                      
 for i=1:uzunluk
 
    img=readimage(imds,i);
     
 im=meanpool(img);
 imm=maxpool(img);

    res101_Feats_mean(:,i) = activations(net,im,layer);   
    res101_Feats_max(:,i) = activations(net,imm,layer);
    
end
labels=imds.Labels; 

feats=[res101_Feats_mean;res101_Feats_max]';

%% Classification Phase 

options = statset('UseParallel',true);
t = templateSVM(...
    'KernelFunction', 'polynomial', ...
    'PolynomialOrder',3, ...
    'KernelScale', 'auto', ...
    'BoxConstraint', 1, ...
    'Standardize', true);
Md1 = fitcecoc(feats,double(labels),'Learners',t,'Coding', 'onevsall','Options',options);
CVMd1=crossval(Md1,'KFold',10,'Options',options);
accuracy=1-kfoldLoss(CVMd1)
