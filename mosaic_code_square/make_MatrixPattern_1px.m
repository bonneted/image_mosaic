function [MatrixPattern,settings] = make_MatrixPattern_1px(Pattern)
settings = '1_px';
MatrixPattern = squeeze(reshape(Pattern,[],1,3));
end