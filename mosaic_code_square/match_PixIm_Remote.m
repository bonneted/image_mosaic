function [MatchIndices, settings] = match_PixIm_Remote(Cases_MeanMatrix,MatrixRef,NbChoice,H_pattern)

settings = strcat('_remote_',num2str(NbChoice));

MatchIndicesK = knnsearch(Cases_MeanMatrix,MatrixRef,'K',NbChoice);
MatchIndices = zeros(length(MatchIndicesK),1);
ImLocation = cell(length(MatchIndicesK),1);
ImLocation(:) = {[H_pattern*10 H_pattern*10]};

for ii=1:length(MatchIndicesK)
    
    x = floor((ii-1)/H_pattern)+1;
    y = mod((ii-1), H_pattern)+1;
    pos = [x,y];
    ImDistMin = zeros(1,NbChoice);
    
    for kk=1:NbChoice
        ImDistMin(kk) = norm(ImLocation{MatchIndicesK(kk)}(knnsearch(ImLocation{MatchIndicesK(kk)},pos))-pos);
    end
    
    [~,ind]= max(ImDistMin);
    MatchIndices(ii) = MatchIndicesK(ii,ind); 
    ImLocation{MatchIndices(ii)} = [ImLocation{MatchIndices(ii)};pos];
    disp(cat(2,num2str(ii),' out of ',num2str(length(MatchIndicesK))))
end
end 

