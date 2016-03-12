function bleu_score = bleu(candidate, ref)
    total = 0;
    for i = 1:length(candidate)
        count = sum(strcmp(candidate, candidate{i}));
        cap = length(strfind(ref, candidate{i}));
        total = total + min(count, cap);
    end
    
    precision = total / length(candidate);
    
    
    
end