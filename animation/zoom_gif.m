
mosaic_path = 'P:\Montage photo\save the date\results\std_temlpate_3_remote_15_HR.jpg';
center_image_path = 'P:\Montage photo\save the date\source\recadree\IMG20200822155645.jpg';
gif_path = 'C:\Users\Damien\Documents\mosaic\mosaic_tintin\results\licorne_zoom2_zoom3.gif';
mosaic = mosaic2;%imread(mosaic_path);
center_image = imread(center_image_path); 
resol = 500;
strip = mosaic(13*resol+1:14*resol,:,:);
strip2 = cat(2,strip(:,1:12*resol,:),imresize(center_image,[resol resol]),strip(:,13*resol+1:end,:));
mosaic3 = cat(1,mosaic(1:13*resol,:,:),strip2,mosaic(14*resol+1:end,:,:));
figure('units','normalized','outerposition',[0 0 0.7 1])
image(mosaic3);
axis equal
axis off
zoom(1.05^5)

gif(gif_path)

for k=1:102
    zoom(1.05)
    gif
end