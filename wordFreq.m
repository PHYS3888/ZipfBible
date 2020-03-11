%-------------------------------------------------------------------------------
% Count words in the Bible:
[words,counts] = ReadTheBible();

%-------------------------------------------------------------------------------
% PLOT:
f = figure('color','w');

xvals = 1:length(words);
loglog(xvals,counts,'x')
xlabel('Word rank')
ylabel('Frequency')
set(gca,'FontSize', 18)

% Fit linear in log-log:
hold('on')
p = polyfit(log10(xvals'),log10(counts),1);
yvals = (10.^p(2)).*xvals.^p(1);
plot(xvals,yvals,'-r','LineWidth',2)

% Fit Gaussian:
doGaussian = false;
if doGaussian
    [muhat,sigmahat] = normfit(counts);
    normPDF = normpdf(xvals,muhat,sigmahat);
    p = polyfit(normPDF,counts',1);
    plot(xvals,p(1)*normPDF,'-g','LineWidth',2)
end

%-------------------------------------------------------------------------------
% Word search:
%-------------------------------------------------------------------------------
% - Build cell array of unique words and counts.
% result = [words_us, num2cell(counts_s)];
%
% for tt = 1:5
%
%     prompt = 'What word should you search: \n';
%     word = input(prompt,'s');
%
%     jid = find(strcmp(word, result));
%     title({['What is the rank of ', word,'? ', num2str(jid)], ...
%         ['And how often is that? ' , num2str(result{jid,2})]});
%
% end
