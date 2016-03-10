%
% evalAlign
%
%  This is simply the script (not the function) that you use to perform your evaluations in 
%  Task 5. 

% some of your definitions
trainDir     = '/u/cs401/A2_SMT/data/Hansard/Training';
testDir      = '/u/cs401/A2_SMT/data/Hansard/Testing';
fr_to_trans  = '/u/cs401/A2 SMT/data/Hansard/Testing/Task5.f';
en_to_trans  = '/u/cs401/A2 SMT/data/Hansard/Testing/Task5.f';
fn_LME       = 'trainLm_en.mat';
fn_LMF       = 'trainLM_fr.mat';
lm_type      = 'smooth';
delta        = 0.5;
numSentences = 10;
maxIter ='';
fn_AM ='alignment.mat';
vocabulary = fieldnames(LM.uni);
vocabSize  = length(vocabulary); 

% Train your language models. This is task 2 which makes use of task 1
LME = lm_train( trainDir, 'e', fn_LME );
LMF = lm_train( trainDir, 'f', fn_LMF );

% Train your alignment model of French, given English 
AMFE = align_ibm1( trainDir, numSentences, maxIter, fn_AM );
% ... TODO: more 

% TODO: a bit more work to grab the English and French sentences. 
%       You can probably reuse your previous code for this  

% translate the 25 French sentence
for line =1:25
    
    
end
    
% Decode the test sentence 'fre'
eng = decode( fre, LME, AMFE, 'smooth', delta, vocabSize );

% TODO: perform some analysis
% add BlueMix code here 
url = '';
username = '';
password = '';

[status, result] = unix('')
