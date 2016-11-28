%script_qPCR_SC

%Input: Results.csv and rawdata.xlsx


%Calculate cfus for standard curve
rawCFU = readtable('Results.csv', 'Delimiter', ';');
headers = {'Bs' 'Ec' 'St' 'Bf' 'Bt'};
A = zeros(3,5);
j = 3;
for i = 1:length(headers)
    A(:,i) = table2array(rawCFU(j-2:j,5));
    j = j+3;
end
rawCFU_organized = [headers;num2cell(A)];
meanCFUs_corr = mean(A)./50;
for i = 1:6
   meanCFUs_corr(i+1,:) = meanCFUs_corr(i,:)./10 
end

