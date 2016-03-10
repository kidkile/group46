function AM = align_ibm1(trainDir, numSentences, maxIter, fn_AM)
%
%  align_ibm1
% 
%  This function implements the training of the IBM-1 word alignment algorithm. 
%  We assume that we are implementing P(foreign|english)
%
%  INPUTS:
%
%       dataDir      : (directory name) The top-level directory containing 
%                                       data from which to train or decode
%                                       e.g., '/u/cs401/A2_SMT/data/Toy/'
%       numSentences : (integer) The maximum number of training sentences to
%                                consider. 
%       maxIter      : (integer) The maximum number of iterations of the EM 
%                                algorithm.
%       fn_AM        : (filename) the location to save the alignment model,
%                                 once trained.
%
%  OUTPUT:
%       AM           : (variable) a specialized alignment model structure
%
%
%  The file fn_AM must contain the data structure called 'AM', which is a 
%  structure of structures where AM.(english_word).(foreign_word) is the
%  computed expectation that foreign_word is produced by english_word
%
%       e.g., LM.house.maison = 0.5       % TODO
% 
% Template (c) 2011 Jackie C.K. Cheung and Frank Rudzicz
  
  global CSC401_A2_DEFNS
  
  AM = struct();
  
  % Read in the training data
  [eng, fre] = read_hansard(trainDir, numSentences);

  % Initialize AM uniformly 
  AM = initialize(eng, fre);

  % Iterate between E and M steps
  for iter=1:maxIter,
    AM = em_step(AM, eng, fre);
  end

  % Save the alignment model
  save( fn_AM, 'AM', '-mat'); 

  end





% --------------------------------------------------------------------------------
% 
%  Support functions
%
% --------------------------------------------------------------------------------

function [eng, fre] = read_hansard(mydir, numSentences)
%
% Read 'numSentences' parallel sentences from texts in the 'dir' directory.
%
% Important: Be sure to preprocess those texts!
%
% Remember that the i^th line in fubar.e corresponds to the i^th line in fubar.f
% You can decide what form variables 'eng' and 'fre' take, although it may be easiest
% if both 'eng' and 'fre' are cell-arrays of cell-arrays, where the i^th element of 
% 'eng', for example, is a cell-array of words that you can produce with
%
%         eng{i} = strsplit(' ', preprocess(english_sentence, 'e'));
%
  eng = {};
  fre = {};

  % TODO: your code goes here.
  DD_e = dir( [mydir, filesep, '*','e'] );
  DD_f = dir( [mydir, filesep, '*','f'] );
  count = 1;
  for iFile=1:length(DD_e)
      eng_lines = textread([mydir, filesep, DD_e(iFile).name], '%s','delimiter','\n');
      fr_line = textread([mydir, filesep, DD_f(iFile).name], '%s','delimiter','\n');
      for i=1: length(eng_lines)        
          preprocessed_eng = preprocess(char(eng_lines(i)), 'e');
          preprocessed_fre = preprocess(char(fr_line(i)), 'f');
          eng{count} = strsplit(' ', preprocessed_eng);
          fre{count} = strsplit(' ', preprocessed_fre);
          count = count + 1;
          if count > numSentences
              return
          end
      end
  end
end

function AM = initialize(eng, fre)
%
% Initialize alignment model uniformly.
% Only set non-zero probabilities where word pairs appear in corresponding sentences.
%
    AM = {}; % AM.(english_word).(foreign_word)

    % TODO: your code goes here
    % given english word, find probability of aligned french word
    for i=1: length(eng)
        eng_lines = eng{i};
        fre_lines = fre{i};
        for e_word=1: length(eng_lines)
            eng_word = eng_lines{e_word};
            for f_word=1:length(fre_lines)
                fre_word = fre_lines{f_word};
                AM.(eng_word).(fre_word) = 1;
            end
        end
    end
    %pls solve it why there is a red line for eng fields
    eng_fields = fieldnames(AM);
    for eField=1: length(eng_fields)
        fre_fields = fieldnames(AM.(eng_fields{eField}));
        for fField=1: length(fre_fields)
            AM.(eng_fields{eField}).(fre_fields{fField})= 1/length(fre_fields);
        end
    AM.SENTSTART.SENTSTART = 1;
    AM.SENTEND.SENTEND = 1;
    end
end

function t = em_step(t, eng, fre)
% 
% One step in the EM algorithm.
%
  
  % TODO: your code goes here
  english_words = fieldnames(t)
  french_words = {}
  for i=1:length(english_words)
      french_words = [french_words; fieldnames(t.(english_words{i}))]
  
end


