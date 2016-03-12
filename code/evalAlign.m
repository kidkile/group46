%
% evalAlign
%
%  This is simply the script (not the function) that you use to perform your evaluations in 
%  Task 5. 

% some of your definitions
trainDir     = '/Users/tarang/Documents/CSC401/group46/data/Hansard/Training';
testDir      = '/Users/tarang/Documents/CSC401/group46/data/Hansard/Testing';
fr_file      = '/Users/tarang/Documents/CSC401/group46/data/Hansard/Testing/Task5.f';
en_file      = '/Users/tarang/Documents/CSC401/group46/data/Hansard/Testing/Task5.e';
goog_en_file = '/Users/tarang/Documents/CSC401/group46/data/Hansard/Testing/Task5.google.e';
fn_LME       = 'trainLM_en.mat';
fn_LMF       = 'trainLM_fr.mat';
lm_type      = 'smooth';
delta        = 0.001; 

numSentences = 10;
maxIter      = 10;

%Train your language models. This is task 2 which makes use of task 1
% if the LM models are already available in the folder, we don't need to
% retrain
if exist(fn_LME, 'file') == 2
    LME = load(fn_LME);
    LME = LME.LM;
else
    LME = lm_train( trainDir, 'e', fn_LME );
end
if exist(fn_LMF, 'file') == 2
    LMF = load(fn_LMF);
    LMF = LMF.LM;
else
    LMF = lm_train( trainDir, 'f', fn_LMF );
end

vocabSize    = length(fieldnames(LME.uni));

% Train your alignment model of French, given English

% UNCOMMENT BEFORE SUBMITTING
AM_files = {'alignment1K.mat', 'alignment10K.mat', 'alignment15K.mat', 'alignment30K.mat'};
count = 0;
for i = 1:length(AM_files)
    count = count + exist(AM_files{i}, 'file');
end
if count == 2 * length(AM_files)
    AME_1000 = load('alignment1k.mat');
    AME_1000 = AME_1000.AM;
    
    AME_10000 = load('alignment10k.mat');
    AME_10000 = AME_10000.AM;
    
    AME_15000 = load('alignment15k.mat');
    AME_15000 = AME_15000.AM;
    
    AME_30000 = load('alignment30k.mat');
    AME_30000 = AME_30000.AM;
else
    AME_1000 = align_ibm1(trainDir, 1000, maxIter, 'alignment1k.mat');
    AME_10000 = align_ibm1(trainDir, 10000, maxIter, 'alignment10k.mat');
    AME_15000 = align_ibm1(trainDir, 15000, maxIter, 'alignment15k.mat');
    AME_30000 = align_ibm1(trainDir, 30000, maxIter, 'alignment30k.mat');
end
disp('All AMs loaded')
fr_text = textread(fr_file, '%s', 'delimiter', '\n');
en_text = textread(en_file, '%s', 'delimiter', '\n');
goog_en_text = textread(goog_en_file, '%s', 'delimiter', '\n');

TODO: a bit more work to grab the English and French sentences. 
      You can probably reuse your previous code for this 

For testing purposes, use this premade AM
AM_test = load('alignment30k.mat');
AM_test = AM_test.AM;

[trans1K, trans10K, trans15K, trans30K] = deal({});
for i = 1:length(fr_text)
    fre_sent = preprocess(fr_text{i}, 'f');
    sent_trans1K = decode(fre_sent, LME, AME_1000, lm_type, delta, vocabSize);
    sent_trans10K = decode(fre_sent, LME, AME_10000, lm_type, delta, vocabSize);
    sent_trans15K = decode(fre_sent, LME, AME_15000, lm_type, delta, vocabSize);
    sent_trans30K = decode(fre_sent, LME, AME_30000, lm_type, delta, vocabSize);
    
    trans1K = [trans1K; strjoin(sent_trans1K, ' ')];
    trans10K = [trans10K; strjoin(sent_trans10K, ' ')];
    trans15K = [trans15K; strjoin(sent_trans15K, ' ')];
    trans30K = [trans30K; strjoin(sent_trans30K, ' ')];
end

    
% TODO: perform some analysis
% add BlueMix code here 
url = 'https://gateway.watsonplatform.net/language-translation/api/v2/translate';
username = '7a759335-d327-41fb-ba35-57464cc84f67';
password='Vz4JICAyT5iq';

watson_translation = {};
for i = 1:length(fr_text)
    sentence_in = fr_text{i};
    curl = ['curl -u ' username ':' password...
        ' -X POST'...
        ' -F "text=' sentence_in '"'...
        ' -F "source=fr" -F "target=en" '...
        '"' url '"'];

    [status, sentence_out] = unix(curl);
    watson_translation = [watson_translation; sentence_out];
    
end

