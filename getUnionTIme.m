clear all; close all;
load('locArr.mat')
% date = datestr(latlong(1,3)/86400000 + datenum(1970,1,1))


% top left
% 42.7301181,-73.6768781,21
% bottem left
 % 42.729777, -73.677114
 
 % bottem right
  % 42.729645, -73.676393
  % top right
  % 42.730165, -73.676223
  
latLow =  42.729645*10000000;
latHigh = 42.730165*10000000;
longLow=-73.677114*10000000;
longHigh=-73.676223*10000000;

startUnion=1; % 1 for not start, 2 for start
timeInUnion=0;
timeLast=0;
timeAddArr=[];
  
lenV=length(latlong(:,1));
lenV=416666;
c1=clock;
dateTimeArr=[];
%mainArr=[];
conk=1;
dayTimeAdd=0;
fprintf('Start time %d/%d/%d, %d:%d:%.3f\n',c1(3),c1(2),c1(1),c1(4),c1(5),c1(6));
  for i=1:lenV
      if latlong(i,2)>longLow && latlong(i,2) <longHigh
        if latlong(i,1)>latLow && latlong(i,1) <latHigh
            if startUnion==1
                startUnion=2;
                timeLast=latlong(i,3);
            else
                dNum= datetime( latlong(i,3)/1000, 'ConvertFrom', 'posixtime') - hours(6); %add 2 hours for gmt +2
                dateTimeArr=[dateTimeArr,dNum];
                if length(dateTimeArr)>2
                    if day(dNum)~=day(dateTimeArr(end-1))
                        mainArr(conk,1)=dayTimeAdd;
                        conk=conk+1;
                        dayTimeAdd=0;
                        %disp(dNum)
                        %disp(dateTimeArr(end-1))
                        %pause;
                    else
                        mainArr(conk,2)=day(dNum);
                    end
                end
                timeAdd=(latlong(i,3)-timeLast)/1000; % in seconds
                timeInUnion=timeInUnion+timeAdd;
                timeLast=latlong(i,3);
                timeAddArr=[timeAddArr,timeAdd];
                dayTimeAdd=dayTimeAdd+(-1*timeAdd);
                
            end
        else
            startUnion=1;
        end
      else
          startUnion=1;
      end
      if mod(i,10000)==0
            fprintf('%d of %d, ',i,lenV);
            c2=clock;
            %{
            fprintf('time %d/%d/%d, %d:%d:%.1f, ',c2(3),c2(2),c2(1),c2(4),c2(5),c2(6));
            rt=(c2(6)+c2(5)*60+c2(4)*60*60)-(c1(6)+c1(5)*60+c1(4)*60*60);
            rts=mod(rt,60); rtm=floor(rt/60);
            fprintf('rt = %d min, %.1f sec, ',rtm,rts);
            t2f=rt/(i/lenV);
            t2fs=mod(t2f,60); t2fm=floor(t2f/60);
            fprintf('tf = %d min, %.1f sec, ',t2fm,t2fs);
            %}
            avgTA=sum(timeAddArr)/length(timeAddArr);
            fprintf('avg tA = %.3e,',avgTA);
            fprintf('sf %.3e hrs',timeInUnion/(60*60));
            
            fprintf('\n')
      end
      
  end
  timeInUnion=-1*timeInUnion;
  rts=mod(timeInUnion,60); rtm=floor(timeInUnion/60);
  %save('timeUnionwksp')
secPerDay=mainArr(:,1);
secPerDay=flip(secPerDay);
hourPerDay=secPerDay./(60*60);
dayArr=1:1:length(hourPerDay);
figure
plot(dayArr,hourPerDay)


                
                