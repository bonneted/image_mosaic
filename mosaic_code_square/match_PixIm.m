function [MatchIndices] = match_PixIm(Cases_MeanMatrix,MatrixRef,Mode,NbChoice)

if strcmp(Mode,'occurence')
    MatchIndicesK = knnsearch(Cases_MeanMatrix,MatrixRef,'K',NbChoice);
    MatchIndices = zeros(length(MatchIndicesK),1);
    Occurence = zeros(length(MatchIndicesK),1);
    for ii=1:length(MatchIndicesK)
        [~,ind]= min(Occurence(MatchIndicesK(ii,:)));
        MatchIndices(ii) = MatchIndicesK(ii,ind); 
        Occurence(MatchIndices(ii)) = Occurence(MatchIndices(ii)) + 1;

    end 
end

if strcmp(Mode,'random')
    MatchIndicesK = knnsearch(Cases_MeanMatrix,MatrixRef,'K',NbChoice);
    MatchIndices = zeros(length(MatchIndicesK),1);
    for ii=1:length(MatchIndicesK)
        MatchIndices(ii) = MatchIndicesK(ii,randi(NbChoice));
    end 
end

end