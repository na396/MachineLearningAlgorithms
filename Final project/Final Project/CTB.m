function seqbinary = CTB(seq)
    j=1;
    seqconverted = [];
    for i=1 : size(seq,2)
        switch seq(i)
            case 'A'
                seqconverted(j)=0;
                seqconverted(j+1)=0;
                j= j+2;
            case 'C'
                seqconverted(j)=0;
                seqconverted(j+1)=1;
                j=j+2;
            case 'G'
                seqconverted(j)=1;
                seqconverted(j+1)=0;
                j=j+2;
            case 'T'
                seqconverted(j)=1;
                seqconverted(j+1)=1;
                j=j+2;
        end
    end
    seqbinary =seqconverted;
end