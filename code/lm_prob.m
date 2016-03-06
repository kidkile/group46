function logProb = lm_prob(sentence, LM, type, delta, vocabSize)
%
%  lm_prob
% 
%  This function computes the LOG probability of a sentence, given a 
%  language model and whether or not to apply add-delta smoothing
%
%  INPUTS:
%
%       sentence  : (string) The sentence whose probability we wish
%                            to compute
%       LM        : (variable) the LM structure (not the filename)
%       type      : (string) either '' (default) or 'smooth' for add-delta smoothing
%       delta     : (float) smoothing parameter where 0<delta<=1 
%       vocabSize : (integer) the number of words in the vocabulary
%
% Template (c) 2011 Frank Rudzicz

  logProb = -Inf;

  % some rudimentary parameter checking
  if (nargin < 2)
    disp( 'lm_prob takes at least 2 parameters');
    return;
  elseif nargin == 2
    type = '';
    delta = 0;
    vocabSize = length(fieldnames(LM.uni));
  end
  if (isempty(type))
    delta = 0;
    vocabSize = length(fieldnames(LM.uni));
  elseif strcmp(type, 'smooth')
    if (nargin < 5)  
      disp( 'lm_prob: if you specify smoothing, you need all 5 parameters');
      return;
    end
    if (delta <= 0) or (delta > 1.0)
      disp( 'lm_prob: you must specify 0 < delta <= 1.0');
      return;
    end
  else
    disp( 'type must be either '''' or ''smooth''' );
    return;
  end

  words = strsplit(' ', sentence);

  % TODO: the student implements the following
  % TODO: once upon a time there was a curmudgeonly orangutan named Jub-Jub.
  probability =0 ;
  for i=2:length(words)-1
      word = words(i);
      word_prev = words(i-1);
      numerator = bicount(LM, word_prev, word);
      denominator = unicount(LM,word_prev);
      probability = probability + (numerator / denominator);
  end

  
  

  %logProb = logProb + log2((LM.bi.field.field_next) + delta) / (LM.uni.field + delta * vocabSize);
return


function count_uni = unicount(LM,word)
        if isfield(LM.uni, word)
            count_uni = LM.uni.(word)
        end
return                
     
  
function count_bi = bicount(LM,word,word_next)
    if isfield(LM.bi.(word)) && isfield(LM.bi.(word).(word_next))
        count_bi = LM.bi.(word).(word_next)
    end
return    
