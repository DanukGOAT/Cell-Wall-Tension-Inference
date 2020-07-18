%author: Danush Chelladurai, danush.chella@gmail.com
%fileName: name of text file that contains the cell sample coordinates
%IndicesArr: list of indices contained in the file
%GoodIndices: indices of the samples the user wants to use
%TC: truncation value
function read_data_snakes(fileName, IndicesArr, GoodIndices, TC, firstRunThrough)
fileID = fopen(fileName);
%Scans the text file into a matrix
A4 = fscanf(fileID,'%f',[5 Inf]);
temp=1;
startindex=1;
position=1;
% maxTC=10^10;
if firstRunThrough==1
    for index = 1:length(IndicesArr)
        ind = IndicesArr(index);
        %Rund through the selected indices until the next one is reached
        while temp<size(A4, 2) && A4(1,temp)==ind
            temp=temp+1;
        end
        temp = temp-1;
        A3 = A4(3:4,startindex:temp);
        startindex=temp+1;
        temp = temp+1;
        
        if ismember(ind, GoodIndices)
            % shift data
            % % Puts the rightmost point at the origin
            A3_shift = ones(2, size(A3, 2));
            A3_shift(1,:) = minus(A3(1,:), max(A3(1,:)));
            tip_index = find(A3_shift(1,:)==0);
            A3_shift(2,:) = A3(2,:)- A3(2,tip_index);
            
            % flip data
            A3_flip_1 = [A3_shift(1,1:tip_index); -A3_shift(2,1:tip_index)];
            A3_flip_2 = [A3_shift(1,end:-1:tip_index); A3_shift(2,end:-1:tip_index)];
            A3_flip_1(2, :) = -A3_flip_1(2, :);
            
%             A3_flip_1(2, :) = -A3_flip_1(2, :);
%             A3_flip_2(2, :) = abs(A3_flip_2(2, :));
%             maxTC = min(maxTC, size(A3_flip_2, 2)-1);
            subplot(ceil(sqrt(size(IndicesArr, 2))), ceil(sqrt(size(IndicesArr, 2))), position)
            sgtitle('Cell Sample Outlines')
            position=position+1;
%                         figure
            plot(A3_flip_1(1, :), A3_flip_1(2, :))
                        hold on;
            plot(A3_flip_2(1, :), A3_flip_2(2, :))
            grid on
            daspect([1 1 1])
            xlabel('z-axis');
            ylabel('r-axis')
            title(['Index ',num2str(ind), ' Max TC ', num2str(min(size(A3_flip_1, 2)-1, size(A3_flip_2, 2)-1))]);
        end
    end
else
    for index = 1:length(IndicesArr)
        ind = IndicesArr(index);
        saveFileName=['ToAvg',num2str(TC),'TC',num2str(ind),'.mat'];
        %Rund through the selected indices until the next one is reached
        while temp<size(A4, 2) && A4(1,temp)==ind
            temp=temp+1;
        end
        temp = temp-1;
        A3 = A4(3:4,startindex:temp);
        startindex=temp+1;
        temp = temp+1;
        
        if ismember(ind, GoodIndices)
            % shift data
            % % Puts the rightmost point at the origin
            A3_shift = ones(2, size(A3, 2));
            A3_shift(1,:) = minus(A3(1,:), max(A3(1,:)));
            tip_index = find(A3_shift(1,:)==0);
            A3_shift(2,:) = A3(2,:)- A3(2,tip_index);
            
            % flip data
            A3_flip_1 = [A3_shift(1,1:tip_index); -A3_shift(2,1:tip_index)];
            A3_flip_2 = [A3_shift(1,end:-1:tip_index); A3_shift(2,end:-1:tip_index)];
            A3_flip_1(2, :) = -A3_flip_1(2, :);
            
            %The following commented lines may be needed based on the order of coordinates given by Image-J 
%             A3_flip_1(2, :) = abs(A3_flip_1(2, :));
%             A3_flip_2(2, :) = abs(A3_flip_2(2, :));
            A3_flip_1(2, :) = -A3_flip_1(2, :);
            
            A3_truncate_1 = A3_flip_1(:,end-TC:end);
            A3_truncate_2 = A3_flip_2(:,end-TC:end);
%             subplot(ceil(sqrt(size(IndicesArr, 2))), ceil(sqrt(size(IndicesArr, 2))), position)
%             position=position+1;
%             %             figure
%             plot(A3_truncate_1(1, :), A3_truncate_1(2, :))
%             %             hold on;
%             plot(A3_truncate_2(1, :), A3_truncate_2(2, :))
%             grid on
%             daspect([1 1 1])
            save(saveFileName, 'A3', 'A3_truncate_1', 'A3_truncate_2')
        end
    end
end

