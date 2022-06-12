clear all
close all

load CLIVE.mat

numberOfSplits = 100;

SROCC = zeros(1,100); KROCC = zeros(1,100);

numberOfImages = size(AllMOS_release,2);
Features = zeros(numberOfImages, 93); 

path = 'C:\Users\Public\QualityAssessment\ChallengeDB_release\Images';

disp('Feature extraction');
parfor i=1:numberOfImages
    if(mod(i,100)==0)
        disp(i);
    end
    img = imread( strcat(path, filesep, AllImages_release{i}) );
    Features(i,:) = getFeatures(img);
end

parfor i=1:numberOfSplits
    if(mod(i,10)==0)
        disp(i);
    end
    p = randperm(numberOfImages);
    
    Data = Features(p,:);
    Target = AllMOS_release(p);
    
    Train = Data(1:round(numberOfImages*0.8),:);
    TrainLabel = Target(1:round(numberOfImages*0.8));
    
    Test  = Data(round(numberOfImages*0.8)+1:end,:);
    TestLabel = Target(round(numberOfImages*0.8)+1:end);
    
    Mdl = fitrgp(Train, TrainLabel', 'KernelFunction', 'rationalquadratic', 'Standardize', true);
    
    Pred = predict(Mdl,Test);
    
    SROCC(i)= corr(Pred,TestLabel','Type','Spearman');
    KROCC(i)= corr(Pred,TestLabel','Type','Kendall');
end

disp(round(median(SROCC),3));
disp(round(median(KROCC),3));
