function [Cases_MeanMatrix,Cases_Index] = make_ImageBase_4px(RessourceFolder,resolution)
%relative Height and Width case average value

FolderList = dir(RessourceFolder);
Cases_MeanMatrix  = [];
Cases_Index = {};

for ii=1:length(FolderList)-2
    album = FolderList(ii+2);
    disp(cat(2,'Proccessing of ',album.name))
    CasesList = dir(fullfile(album.folder,album.name));
    
    
    for kk=1:length(CasesList)-2
        
        thecase_file = CasesList(kk+2);
        thecase_path = fullfile(thecase_file.folder,thecase_file.name);
        
        thecase = imresize(imread(thecase_path),[resolution resolution]);
        div = resolution/2;
        mean1 = squeeze(mean(thecase(1:div,1:div,:),[1 2]))';
        mean2 = squeeze(mean(thecase(1:div,div:end,:),[1 2]))';
        mean3 = squeeze(mean(thecase(div:end,1:div,:),[1 2]))';
        mean4 = squeeze(mean(thecase(div:end,div:end,:),[1 2]))';
        Cases_Index{end+1} = thecase;
        Cases_MeanMatrix = [Cases_MeanMatrix ; [mean1 mean2 mean3 mean4]];

    end

end


end