function occurence_stat(Occurence,saveFile,pattern_name,settings)

figure('Name','Horizontal')
histogram(Occurence.H)
figure('Name','Vertical')
histogram(Occurence.V)
disp(cat(2,'Vertical missed : ',num2str(sum(Occurence.V==0))))
disp(cat(2,'Horizontal missed : ',num2str(sum(Occurence.H==0))))

% fileID = fopen(saveFile,'w');
dlmwrite(saveFile,[],'-append','newline','pc')
dlmwrite(saveFile,strcat(pattern_name,settings),'-append','newline','pc')
dlmwrite(saveFile,strcat('V:',num2str(sum(Occurence.V==0))),'-append','newline','pc')
dlmwrite(saveFile,strcat('H:',num2str(sum(Occurence.H==0))),'-append','newline','pc')

% fprintf(fileID,strcat('-----------',pattern_name,settings,'.jpg-----------\n'));
% fprintf(fileID,strcat('Vertical missed : ',num2str(sum(Occurence.V==0)),'\n'));
% fprintf(fileID,strcat('Horizontal missed :',num2str(sum(Occurence.H==0)),'\n'));
% fclose(fileID);
end