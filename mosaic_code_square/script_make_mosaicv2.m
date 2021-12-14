%% Settings
RessourceFolder = uigetdir('P:\Montage photo\','Select the ressource folder');
[pattern_name,pattern_folder] = uigetfile('P:\Montage photo\','Select the pattern of the mosaic');
pattern_path = fullfile(pattern_folder,pattern_name);
[~,pattern_name,~] = fileparts(pattern_path);
tic
resolution = 200; %resolution (pixel) of the small images
W_mosaic = 100; %number of images in the width of the mosaic -> 75 for 1m width after printing (1,3cm width for small images)
Mode = 'remote'; %matching method
NbChoice = 25;
alpha = 0.1; %transparency of the overlay mosaic
%% Translating settings
addpath(genpath('C:\Users\Damien\Documents\code_perso\image_mosaic'))
pattern_HR = imread(pattern_path);
[H_pattern,W_pattern,~] = size(pattern_HR);

H_mosaic = round(W_mosaic*H_pattern/W_pattern);
pattern_LR = imresize(pattern_HR,[H_mosaic*2,W_mosaic*2]); %*2 factor because each image fits to 4 pixels

mosaic_path = fullfile(pattern_folder,'..','results');

if ~exist(mosaic_path,'dir')
    mkdir(mosaic_path)
end

FileName = fullfile(mosaic_path,strcat(pattern_name,'_',Mode,'_',num2str(NbChoice)));

%% Preparing image data base...
disp('Preparing image data base...')
[Cases_MeanMatrix,Cases_Index] = make_ImageBase_4px(RessourceFolder,resolution);

%% Preparing pattern...
disp(' Preparing pattern...')
MatrixRef = make_MatrixPattern_4px(pattern_LR);
%% Matching image and pixels
disp('Matching image and pixels...')
MatchIndices = match_PixIm(Cases_MeanMatrix,MatrixRef,Mode,NbChoice,H_mosaic);
%% Making mosaic
disp('Making mosaic...')
mosaic = make_Mosaic(MatchIndices,Cases_Index,H_mosaic,W_mosaic);

%% Exporting image
disp('Exporting image...')
imwrite(mosaic,strcat(FileName,'_LR.jpg'),'Quality',40);
imwrite(mosaic,strcat(FileName,'_HR.jpg'),'Quality',75);
%% Making overlay image
disp('Making overlay image...')
overlay_mosaic = make_overlay_mosaic(mosaic,pattern_HR,alpha);
imwrite(overlay_mosaic,strcat(FileName,'_overlay_LR.jpg'),'Quality',40);
imwrite(overlay_mosaic,strcat(FileName,'_overlay_HR.jpg'),'Quality',75);
%% Making zoom video
disp('Making zoom video...')
VideoName = strcat(FileName,'_zoom2.mp4');
make_zoom_video(overlay_mosaic,VideoName);
%% Open results directory
disp('Open results directory...')
winopen(mosaic_path)

toc