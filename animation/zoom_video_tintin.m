mosaic_path = 'C:\Users\Damien\Documents\mosaic\mosaic_tintin\results\licorne_zoom2_random_50_4px.jpg';
mosaic = imread(mosaic_path);


v = VideoWriter('zoom_mosaic.mp4','MPEG-4');
v.Quality = 100;
open(v);


figure('units','normalized','outerposition',[0 0 0.5625 1])
image(mosaic2);
set(gca,'LooseInset',get(gca,'TightInset'));
axis equal
axis off


    
for k=1:103
    zoom(1.05)
    frame = getframe(gcf);
    writeVideo(v,frame);
    writeVideo(v,frame);

end

zoom(1.03)
frame = getframe(gcf);
writeVideo(v,frame);
writeVideo(v,frame);

close(v);