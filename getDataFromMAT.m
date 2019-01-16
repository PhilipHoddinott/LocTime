close all; clear all;
load('locMat.mat')
value=val;
lenV=length(value.locations);
c1=clock;
fprintf('Start time %d/%d/%d, %d:%d:%.3f\n',c1(3),c1(2),c1(1),c1(4),c1(5),c1(6));

for i=1:lenV
    latlong(i,1)=value.locations{i,1}.latitudeE7;
    latlong(i,2)=value.locations{i,1}.longitudeE7;
    latlong(i,3)=str2num(value.locations{i,1}.timestampMs);
    if isfield(value.locations{i,1},'accuracy')
        latlong(i,4)=value.locations{i,1}.accuracy;
    end
    %else
    %    latlong(i,4)=0;
    %end
    if isfield(value.locations{i,1},'altitude')
        latlong(i,5)=value.locations{i,1}.altitude;
    end
    %else
    %    latlong(i,5)
    if mod(i,10000)==0
        fprintf('%d of %d done, ',i,lenV);
        c2=clock;
        fprintf('time %d/%d/%d, %d:%d:%.1f, ',c2(3),c2(2),c2(1),c2(4),c2(5),c2(6));
        rt=(c2(6)+c2(5)*60+c2(4)*60*60)-(c1(6)+c1(5)*60+c1(4)*60*60);
        rts=mod(rt,60); rtm=floor(rt/60);
        fprintf('Run time = %d min, %.1f sec, ',rtm,rts);
        t2f=rt/(i/lenV);
        t2fs=mod(t2f,60); t2fm=floor(t2f/60);
        fprintf('to finish = %d min, %.1f sec\n',t2fm,t2fs);

    end
end

save('locArr.mat','latlong');
