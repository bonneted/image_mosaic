function [MatchIndices, settings] = match_PixIm_LimitOccur(Cases_MeanMatrix,MatrixRef,NbChoice)

settings = strcat('_limitoccur_',num2str(NbChoice));

MatchIndicesK = knnsearch(Cases_MeanMatrix,MatrixRef,'K',NbChoice);
MatchIndices = zeros(length(MatchIndicesK),1);
Occurence = zeros(length(MatchIndicesK),1);
for ii=1:length(MatchIndicesK)
    [~,ind]= min(Occurence(MatchIndicesK(ii,:)));
    MatchIndices(ii) = MatchIndicesK(ii,ind); 
    Occurence(MatchIndices(ii)) = Occurence(MatchIndices(ii)) + 1;
    
end 

end