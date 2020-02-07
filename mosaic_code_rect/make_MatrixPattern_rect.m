function [MatrixPattern]= make_MatrixPattern_rect(Pattern)

[H_pat,W_pat]=size(Pattern);

MatrixPattern_V = reshape(zeros(size(Pattern)),[],6);
MatrixPattern_H_1 = reshape(zeros([H_pat,W_pat-2]),[],12);
MatrixPattern_H_2 = reshape(zeros([H_pat,W_pat-2]),[],12);

for lig = 1:3
    for col = 1:2
        MatrixPattern_V(:,2*(lig-1)+col)=reshape(Pattern(lig:3:end,col:2:end)',[],1);        
    end
    for col = 1:4
%         disp([lig,col])
        MatrixPattern_H_1(:,4*(lig-1)+col)=reshape(Pattern(lig:3:end,col:4:end-2)',[],1);
        MatrixPattern_H_2(:,4*(lig-1)+col)=reshape(Pattern(lig:3:end,col+2:4:end)',[],1);
        
    end
end

MatrixPattern.H = reshape(cat(2,MatrixPattern_H_1,MatrixPattern_H_2)',12,[])';
MatrixPattern.V = MatrixPattern_V;

end
