function [MatchIndices,Occurence, settings] = match_PixIm_Rect_Occur(Images_MeanMatrix,MatrixPattern,H_pattern,W_pattern,NbChoice)

settings = strcat('_rect_occur',num2str(NbChoice));

MatchIndicesK_V = knnsearch(Images_MeanMatrix.V,MatrixPattern.V,'K',NbChoice);
MatchIndicesK_H = knnsearch(Images_MeanMatrix.H ,MatrixPattern.H,'K',NbChoice);


Occurence.V = zeros(length(Images_MeanMatrix.V),1);
Occurence.H = zeros(length(Images_MeanMatrix.H),1);

MatchIndices = cell(H_pattern/3,1);


for ii=1:H_pattern/3
    StripIndices = [];
    Strip_pos = 1;
    while Strip_pos < W_pattern/2-1
        
        lin_ind_H = (W_pattern/2-1)*(ii-1)+Strip_pos;
        lin_ind_V = W_pattern/2*(ii-1)+Strip_pos;
        
        [~,ind]= min(cat(2,Occurence.H(MatchIndicesK_H(lin_ind_H,:)),Occurence.V(MatchIndicesK_V(lin_ind_V,:))));

        if Occurence.V(ind(2)) < Occurence.H(ind(1))
            StripIndices = [StripIndices;[MatchIndicesK_V(lin_ind_V,ind(2)) 2]]; 
            Occurence.V(StripIndices(end,1)) = Occurence.V(StripIndices(end,1))+1;
            Strip_pos = Strip_pos+1;
        else
            StripIndices = [StripIndices;[MatchIndicesK_H(lin_ind_H,ind(1)) 1]]; 
            Occurence.H(StripIndices(end,1)) = Occurence.H(StripIndices(end,1))+1;
            Strip_pos = Strip_pos+2;
        end
        
        if Strip_pos == W_pattern/2-1
            [~,ind]= min(Occurence.V(MatchIndicesK_V(W_pattern/2*ii,:)));
            StripIndices = [StripIndices;[MatchIndicesK_V(lin_ind_V,ind) 2]]; 
            Occurence.V(StripIndices(end,1)) = Occurence.V(StripIndices(end,1))+1;
        end
    end
    MatchIndices{ii} = StripIndices;
end 

end