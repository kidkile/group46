%
% evalAlign
%
%  This is simply the script (not the function) that you use to perform your evaluations in 
%  Task 5. 

% some of your definitions
trainDir     = '/u/cs401/A2_SMT/data/Hansard/Training';
testDir      = '/u/cs401/A2_SMT/data/Hansard/Testing';
fr_to_trans  = '/u/cs401/A2 SMT/data/Hansard/Testing/Task5.f';
en_to_trans  = '/u/cs401/A2 SMT/data/Hansard/Testing/Task5.e';
fn_LME       = 'trainLm_en.mat';
fn_LMF       = 'trainLM_fr.mat';
lm_type      = 'smooth';
delta        = 0.5;
numSentences = 10;
maxIter = 100;
fn_AM25 = 'alignment25.mat';
fn_AM1000 ='alignment1k.mat';
fn_AM10000 ='alignment10k.mat';
fn_AM15000 ='alignment15k.mat';
fn_AM30000 ='alignment30k.mat';

vocabulary = fieldnames(LM.uni);
vocabSize  = length(vocabulary); 

%Train your language models. This is task 2 which makes use of task 1
LME = lm_train( trainDir, 'e', fn_LME );
LMF = lm_train( trainDir, 'f', fn_LMF );

% Train your alignment model of French, given English 
AME_25 = align_ibm1(trainDir, 25, maxIter, fn_AM25);
AME_1000 = align_ibm1(trainDir, 1000, maxIter, fn_AM1000);
AME_100000 = align_ibm1(trainDir, 10000, maxIter, fn_AM10000);
AME_15000 = align_ibm1(trainDir, 15000, maxIter, fn_AM15000);
AME_30000 = align_ibm1(trainDir, 30000, maxIter, fn_AM30000);
% ... TODO: more 
trans_e = textread(en_to_trans, '%s', 'delimiter', '\n');
trans_f = textread(fr_to_trans, '%s', 'delimiter', '\n');
len_esent = length(trans_e);
len_fsent = length(trans_f);
eng_sentence = 'eng_sentence';
fre_sentence = 'fre_sentence';
% TODO: a bit more work to grab the English and French sentences. 
%       You can probably reuse your previous code for this  
for i=1:len_fsent
    fre = (preprocess(sentence_e{i}, 'e'));
    %decoding
    for w=[1000,10000,15000,30000]
        prosd_f = preprocess(char(trans_f(i)), 'f');
        Am_f = strcat('AME_',num2str(w));
        strcat(eng_sentence,num2str(w)) = decode(prosd_f, LME, Am_f, '', delta, vocabSize);
    end
    
end

    
% Decode the test sentence 'fre'
eng = decode( fre, LME, AMFE, 'smooth', delta, vocabSize );

% TODO: perform some analysis
% add BlueMix code here 
url = '';
username = '';
password = '';

[status, result] = unix('')
