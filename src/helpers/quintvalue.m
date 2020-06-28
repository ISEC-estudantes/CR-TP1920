function [baixoDir,...
        segtopEsq, segtop, segtopDir,...
        terctopEsq, terctop, terctopDir,...
        quartotopEsq, quartotop, quartotopDir,...
        altoEsq ] = quintvalue(alto, baixo, offset)
    segtop = (alto - baixo)/4 + baixo;
    terctop = (alto - baixo)/4 + segtop;
    quartotop = (alto - baixo)/4 + terctop;
    baixoDir = baixo + offset;
    segtopEsq = segtop - offset;
    segtopDir = segtop + offset;
    terctopEsq = terctop - offset;
    terctopDir = terctop + offset;
    quartotopEsq = quartotop - offset;
    quartotopDir = quartotop + offset;
    altoEsq = alto - offset;
end