function [words_us,counts_s] = ReadTheBible()

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

end
