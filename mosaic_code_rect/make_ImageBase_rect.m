 function [Images_MeanMatrix,Images_Index,Settings] = make_ImageBase_rect(ImageFolder,resolution)
Settings = cat(2,'_res_',num2str(resolution));

ImageSubFolder = dir(ImageFolder);
Images_MeanMatrix_H  = [];
Images_MeanMatrix_V  = [];

Images_Index_H = {};
Images_Index_V = {};

for ii=1:length(ImageSubFolder)-2
    album = ImageSubFolder(ii+2);
    disp(cat(2,'Proccessing of ',album.name))
    CasesList = dir(fullfile(album.folder,album.name)); 
    
    for kk=1:length(CasesList)-2
        
        Image_file = CasesList(kk+2);
        Image_path = fullfile(Image_file.folder,Image_file.name);
%         info = imfinfo(Image_path);
%         Height =  info.Height;
%         Width = info.Width;
        Image_raw = rgb2gray(imread(Image_path));
        [Height,Width] = size(Image_raw);
        if Height < Width
            H_resize = resolution;
            W_resize = 4/3*resolution;
            Image = imresize(Image_raw,[H_resize W_resize]);
            MeanMatrix = zeros(1,3*4);
            for lig=1:3
                for col=1:4
                    lig_slice = 1+(lig-1)*H_resize/3:lig*H_resize/3;
                    col_slice = 1+(col-1)*W_resize/4:col*W_resize/4;
                    MeanMatrix(col*(lig-1)+col) =  mean(Image(lig_slice,col_slice),'all');
                end
            end                      
            Images_Index_H{end+1} = Image;
            Images_MeanMatrix_H = [Images_MeanMatrix_H ; MeanMatrix];
            
        else
            H_resize = resolution;
            W_resize = 2/3*resolution;
            Image = imresize(Image_raw,[H_resize W_resize]);
            MeanMatrix = zeros(1,3*2);
            for lig=1:3
                for col=1:2
                    lig_slice = 1+(lig-1)*H_resize/3:lig*H_resize/3;
                    col_slice = 1+(col-1)*W_resize/2:col*W_resize/2;
                    MeanMatrix(col*(lig-1)+col) =  mean(Image(lig_slice,col_slice),'all');
                end
            end                      
            Images_Index_V{end+1} = Image;
            Images_MeanMatrix_V = [Images_MeanMatrix_V ; MeanMatrix];
            
        end
    end
end

max_nb_Im = max(length(Images_Index_H),length(Images_Index_V));
Images_Index = cell(max_nb_Im,2);

Images_Index(1:length(Images_Index_H),1) = Images_Index_H;
Images_Index(1:length(Images_Index_V),2) = Images_Index_V;

Images_MeanMatrix.H = Images_MeanMatrix_H;
Images_MeanMatrix.V = Images_MeanMatrix_V;

end