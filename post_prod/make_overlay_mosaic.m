function overlay_mosaic = make_overlay_mosaic(mosaic,pattern_HR,alpha)
overlay_mosaic = (1-alpha)*mosaic + alpha*imresize(pattern_HR,[size(mosaic,1),size(mosaic,2)]);
end