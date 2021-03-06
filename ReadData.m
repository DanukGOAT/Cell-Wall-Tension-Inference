%author: Danush Chelladurai, danush.chella@gmail.com
%TC: truncation value
%disc: discretization value
%usables: indices of the samples the user wants to use
function ReadData(TC, disc, usables)
rv_max = 0;
rv_min = inf;
numElts = ceil((TC+1)/disc);
rv = zeros(2, numElts);
startInd = mod((TC), disc)+1;
figure
for fileInd = usables
    
        saveFileName=['ToAvg',num2str(TC),'TC',num2str(fileInd),'.mat'];
        load(saveFileName);
        %Rotates and discretizes the data
        fullCell = [A3_truncate_1 flip([A3_truncate_2(1, :); -A3_truncate_2(2, :)], 2)];
        [Rotated1, Rotated2, fullCellRotated] = rotated(A3_truncate_1, A3_truncate_2, fullCell);
        A3_truncate_1=Rotated1(:, startInd:disc:end);
        A3_truncate_2=[Rotated2(1, 1:disc:end); -Rotated2(2, 1:disc:end)];
        rv = rv+A3_truncate_1;
        rv = rv+A3_truncate_2;
        %running extremum computation
        rv_max = max(rv_max, max(A3_truncate_1(2,:),A3_truncate_2(2,:)));
        rv_min = min(rv_min, min(A3_truncate_1(2,:),A3_truncate_2(2,:)));
        pbm_data = rv_max-rv_min;
        %Plotting cell on positive side of z-axis
        hold on;
        plot(A3_truncate_1(1,:)+TC*ones(size(A3_truncate_1(1,:))),A3_truncate_1(2,:),'LineWidth',3);
        hold on;
        plot(A3_truncate_2(1,:)+TC*ones(size(A3_truncate_2(1,:))),A3_truncate_2(2,:),'LineWidth',3);
    
end
grid on
daspect([1 1 1])
%Compute and save the average cell configuration
rv = rv/(size(usables, 2)*2);
save('Avg.mat', 'rv')


xlabel('z-axis','FontSize',24);
ylabel('r-axis','FontSize',24)
set(gca,'FontSize',24)
title('Cell outlines','FontSize',20);
