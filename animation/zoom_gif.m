
mosaic_path = 'C:\Users\Damien\Documents\mosaic\mosaic_tintin\results\licorne_zoom2_random_50_4px.jpg';
gif_path = 'C:\Users\Damien\Documents\mosaic\mosaic_tintin\results\licorne_zoom2_zoom3.gif';
mosaic = imread(mosaic_path);

strip = mosaic(74*150+1:75*150,:,:);
strip2 = cat(2,strip(:,1:74*150,:),imresize(mosaic,[150 150]),strip(:,75*150+1:end,:));
mosaic2 = cat(1,mosaic(1:74*150,:,:),strip2,mosaic(75*150+1:end,:,:));
figure('units','normalized','outerposition',[0 0 0.7 1])
image(mosaic2);
axis equal
axis off
zoom(1.05^5)

gif(gif_path)

for k=1:102
    zoom(1.05)
    gif
end