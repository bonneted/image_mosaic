function make_zoom_video(mosaic,VideoName)


v = VideoWriter(VideoName,'MPEG-4');
v.Quality = 75;
open(v);

figure('units','normalized','outerposition',[0 0 0.5625 1],'visible','off')
axis equal;axis off;
set(axes, 'Units', 'normalized', 'Position', [0, 0, 1, 1]);
image(mosaic)

zoom(1.03^140)
  
for k=1:140
    zoom(1/1.03)
    frame = getframe(gcf);
    writeVideo(v,frame);
    writeVideo(v,frame);

end

for i =1:10
frame = getframe(gcf);
writeVideo(v,frame);
end

close(v);