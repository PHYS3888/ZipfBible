
fprintf(1,'Reading the bible...');

fid = fopen('Bible.txt');
% Read all lines & collect in cell array
txt = textscan(fid,'%s','delimiter','\n');
fprintf(1,' Done. Was I fast? How long does it usually take you?\n');
% Convert string to numerical value
str = txt{1} ;
% All text to lower case:
str = lower(str);
fprintf(1,'I am enlightened\n');

% Count unique words:
alldata = str;
buffer = [alldata(:), repmat( {' '}, numel( alldata ), 1 )]';
buffer = strtrim([buffer{:}]);

% Split giant string on white spaces, commas and fullstips
words = strsplit( buffer, {' ',', ','.'} )';
[words_u, ~, idxU] = unique( words );
counts = accumarray(idxU,1);

fprintf(1,'I found %u different words in the bible\n',length(counts));

% - Sort entries by count.
[~, idxS] = sort(counts, 'descend');
words_us = words_u(idxS);
counts_s = counts(idxS);
% - Build cell array of unique words and counts.
result = [words_us, num2cell(counts_s)] ;

%-------------------------------------------------------------------------------
% PLOT:
f = figure('color','w');
xvals = 1:numel(words_us);
loglog(xvals,counts_s,'x')
xlabel('Word rank')
ylabel('Frequency')
set(gca,'FontSize', 18)

%pause
hold on
p = polyfit(log10(xvals'),log10(counts_s),1);
yvals = (10.^p(2)).*xvals.^p(1);

plot(xvals,yvals,'-r')


for tt = 1:5

prompt = 'What word should you search \n';
word=input(prompt,'s');

jid = find(strcmp(word, result));
title({['What is the rank of ', word,'? ', num2str(jid)], ...
    ['And how often is that? ' , num2str(result{jid,2})]});

end
