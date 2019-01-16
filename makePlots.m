clear all; close all;
%% CHANGE THIS LOAD
load('timeUnionwksp3.mat')
mainArrOld=mainArr;
%mainArr=mainArr(26:137,:);
%mainArr=mainArr(30:137,:);
%% ALTER THESE NUMBERS
mainArr=[mainArr(30:51,:); mainArr(58:67,:); mainArr(72:137,:)];
%secPerDay=mainArr(:,1);
secPerDay=mainArr;
secPerDay=flip(secPerDay);
hourPerDay=secPerDay(:,1)./(60*60);
dayArr=1:1:length(hourPerDay);
tickArr=secPerDay(:,2);
ticCell={tickArr};
figure
plot(dayArr,hourPerDay,'-+')

 set(gca,'xtick',1:length(tickArr),...
 'xticklabel',ticCell)
grid on
xtickangle(90)
%137
% 26


cnk=2;
LDOM(1)=secPerDay(1,2);
for i=2:length(secPerDay(:,1))
    if secPerDay(i,2)<secPerDay(i-1,2)
        LDOM(cnk)=i-1;
        cnk=cnk+1;
    end
end
LDOM(cnk)=i;
figure;
hold on

for i=1:length(LDOM)-1
    plot(dayArr(LDOM(i):LDOM(i+1)),hourPerDay(LDOM(i):LDOM(i+1)),'-s')
end


set(gca,'xtick',1:length(tickArr),...
 'xticklabel',ticCell)
grid on
xtickangle(90)

ylim([0 10])
legend('Sep','Oct','Nov','Dec','location','northwest')
xlabel('Day of Month')
ylabel('Hours Spent in Union')