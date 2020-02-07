%% Import data
PhotosFolder = 'C:\Users\Damien\Documents\mosaique_famille\photos';
pattern_path = 'C:\Users\Damien\Documents\mosaique_famille\pattern\daron_LR.jpg';
StatFile = 'C:\Users\Damien\Documents\mosaique_famille\pattern\Stat_occurence.txt';
[pattern_folder,pattern_name,~] = fileparts(pattern_path);
pattern = rgb2gray(imread(pattern_path));
[H_pattern,W_pattern,~] = size(pattern);
mosaic_path = fullfile(pattern_folder,'mosaic');

if ~exist(mosaic_path,'dir')
    mkdir(mosaic_path)
end

%% Preparing image data base...
disp('Preparing image data base...')
[Images_MeanMatrix,Images_Index,settings_res] = make_ImageBase_rect(PhotosFolder,201);   

%% Preparing pattern...
disp('Preparing pattern...')
[MatrixPattern]= make_MatrixPattern_rect(pattern);
%% Matching image and pixels
disp('Matching image and pixels...')
[MatchIndices,Occurence,settings_fit] = match_PixIm_Rect_Occur(Images_MeanMatrix,MatrixPattern,H_pattern,W_pattern,50);
%% Occurence statistic
occurence_stat(Occurence,StatFile,pattern_name,settings_fit)
%% Making mosaic
disp('Making mosaic...')
mosaic = make_Mosaic_rect(MatchIndices,Images_Index,H_pattern);

%% Exporting image
disp('Exporting image...')
FileName = fullfile(mosaic_path,strcat(pattern_name,settings_fit,settings_res,'.jpg'));
imwrite(mosaic,FileName);
