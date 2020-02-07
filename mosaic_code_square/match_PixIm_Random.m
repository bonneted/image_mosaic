function [MatchIndices, settings]= match_PixIm_Random(Cases_MeanMatrix,MatrixRef,NbChoice)

settings = strcat('_random_',num2str(NbChoice));

MatchIndicesK = knnsearch(Cases_MeanMatrix,MatrixRef,'K',NbChoice);
MatchIndices = zeros(length(MatchIndicesK),1);
for ii=1:length(MatchIndicesK)
    MatchIndices(ii) = MatchIndicesK(ii,randi(NbChoice));
end 
end