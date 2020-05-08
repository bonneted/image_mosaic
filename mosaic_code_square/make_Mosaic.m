function mosaic = make_Mosaic(MatchIndices,Cases_Index,H_pattern,W_pattern)
strips = cell(1,W_pattern); 
for ii=0:W_pattern-1
    strips{ii+1} = cat(1,Cases_Index{MatchIndices(ii*H_pattern+[1:H_pattern])});
%     disp(cat(2,num2str(ii),' out of ',num2str(W_pattern)))
end
mosaic = cat(2,strips{:});
end
