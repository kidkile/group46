function bleu_score = bleu(candidate, reference)
    sum = 0;
    for i = 1:length(candidate)
        local_count = sum(strcmp(candidate, candidate{i}));
        max_count = sum(strcmp(reference, candidate{i}));
        sum = sum + min(local_count, max_count);
        
    end
    
    precision = contained / length(candidate) / length(candidate);
    
    
    
end