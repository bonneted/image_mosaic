function [Cases_MeanMatrix,Cases_Index] = make_ImageBase_4px(AlbumFolder,resolution)
%relative Height and Width case average value
Height_ref = 0.26;
Height_delta = 0.02;
Width_ref = 0.27;
Width_delta = 0.12;

AlbumList = dir(AlbumFolder);
Cases_MeanMatrix  = [];
Cases_Index = {};

for ii=1:length(AlbumList)-2
    album = AlbumList(ii+2);
    disp(cat(2,'Proccessing of ',album.name))
    CasesList = dir(fullfile(album.folder,album.name));
    
    FrontPage = CasesList(3);
    FrontPage_path = fullfile(FrontPage.folder,FrontPage.name);
    info = imfinfo(FrontPage_path);
    Height_ALbum = info.Height;
    Width_Album = info.Width;
    
    for kk=1:length(CasesList)-2
        
        thecase_file = CasesList(kk+2);
        thecase_path = fullfile(thecase_file.folder,thecase_file.name);
        info = imfinfo(thecase_path);
        Height =  info.Height/Height_ALbum;
        Width = info.Width/Width_Album;
        
        if abs(Height-Height_ref) < Height_delta && abs(Width-Width_ref) < Width_delta
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


end