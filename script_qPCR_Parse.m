%script_qPCR_Parse

Plate1 = load('plate5.mat');
Plate2 = load('plate6.mat');

plateALL = {zeros(15,12); zeros(15,12); zeros(15,12); zeros(15,12); zeros(15,12)};

for i = 1:length(Plate1.CFUs)
plateALL{i} = [Plate1.CFUs{i}; Plate2.CFUs{i}(1:7,:)]
end


conditionALL = {};

for i = 1:9
conditionALL{i} = [plateALL{1}(:,i+3).';plateALL{2}(:,i+3).';plateALL{3}(:,i+3).';plateALL{4}(:,i+3).';plateALL{5}(:,i+3).']

end


save('condition_001x.mat', 'conditionALL');