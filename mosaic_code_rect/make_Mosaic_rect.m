function mosaic = make_Mosaic_rect(MatchIndices,Images_Index,H_pattern)
strips = cell(H_pattern/3,1); 
for ii=1:H_pattern/3
    stripCell = cell(1,length(MatchIndices{ii,1}));
    for kk=1:length(MatchIndices{ii,1})
    stripCell{kk} = Images_Index{MatchIndices{ii,1}(kk,1),MatchIndices{ii,1}(kk,2)};
    end
    strips{ii} = cat(2, stripCell{:});
%     disp(cat(2,num2str(ii),' out of ',num2str(H_pattern/3)))
end
mosaic = cat(1,strips{:});
end
