function [MatchIndices] = match_PixIm(Cases_MeanMatrix,MatrixRef,Mode,NbChoice,H_mosaic)

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

if strcmp(Mode,'remote')
    MatchIndicesK = knnsearch(Cases_MeanMatrix,MatrixRef,'K',NbChoice);
    MatchIndices = zeros(length(MatchIndicesK),1);
    ImLocation = cell(length(Cases_MeanMatrix),1);
    ImLocation(:) = {[H_mosaic*10 H_mosaic*10]};

    for ii=1:length(MatchIndicesK)
        x = floor((ii-1)/H_mosaic)+1;
        y = mod((ii-1), H_mosaic)+1;
        pos = [x,y];
        ImDistMin = zeros(1,NbChoice);
        for kk=1:NbChoice
%             disp([ii,kk])
%             disp(size(MatchIndicesK))
%             disp(MatchIndicesK(1,1))
            occ_location = ImLocation{MatchIndicesK(ii,kk)};
            ImDistMin(kk) = norm(occ_location(knnsearch(occ_location,pos),:)-pos);
        end
        [~,ind]= max(ImDistMin);
        MatchIndices(ii) = MatchIndicesK(ii,ind); 
        ImLocation{MatchIndices(ii)} = [ImLocation{MatchIndices(ii)};pos];
        disp(cat(2,num2str(ii),' out of ',num2str(length(MatchIndicesK))))
    end
end

end