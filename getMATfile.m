close all; clear all;
fname = 'Location History.json'; 
fid = fopen(fname); 
raw = fread(fid,inf); 
str = char(raw'); 
fclose(fid); 
val = jsondecode(str);

save('locMat.mat','val');
