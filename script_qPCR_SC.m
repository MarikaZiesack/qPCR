%script_qPCR_SC

%Input: Results.csv and rawdata.xlsx
%


%Calculate cfus for standard curve and put into meanCFUs_corr
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


%parse Cq values (1/Cq) and put into matrix stack (Cqs)
rawCq = readtable('C:\Users\Wyss User\Dropbox\Uni\PhD\LAB\PROJECT_FILES\Consortium\Experiments\Consortium_2\20161129_5plex_plate6.csv');
%Wells = rawCq(20:end,1);
Cqs = {zeros(8,12); zeros(8,12); zeros(8,12); zeros(8,12); zeros(8,12)}
l = 1;
for k = 20:96:length(table2array(rawCq(20:end,6)))
    Cq_vector = 1./str2double(table2array(rawCq(k:k+95,6))); %I have set this as 1/Cq here, can be changed
    j = 1;
    for i = 1:12:96
     Cqs{l}(j, 1:12) = Cq_vector(i:i+11,1).'; 
     j = j+1;
     i
    end
    l = l+1
 
end



CFUs = {zeros(8,12); zeros(8,12); zeros(8,12); zeros(8,12); zeros(8,12)}
for i = 1:length(Cqs)
%generate standard curve for Ec alone at this point
EcCFU = log10(meanCFUs_corr(1:5,1));
EcCqs_standard = mean(Cqs{i}(1:5,1:3),2);
p = polyfit(EcCFU, EcCqs_standard, 1);
curve = p(1)*EcCFU+p(2)
figure;
plot(EcCFU, EcCqs_standard, '.');
hold on;
plot(EcCFU, curve, '-')

CFUs{i} = 10.^((Cqs{i}-p(2))./p(1));

end


save('plate6.mat', 'CFUs');