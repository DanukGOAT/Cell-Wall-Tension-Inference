%author: Danush Chelladurai, danush.chella@gmail.com

%Follow the instructions in the README file to fill out the prompts
fileName = input('Enter the filename of the file given by ImageJ: ', 's');
% Snakes_caulonema_control.txt
Indices = input('Enter the indices of the samples contained in the text file: ');

%     IndicesArr = [2:10, 12, 13, 15];
%     GoodIndices = [5, 7, 15];
tc=0;
read_data_snakes(fileName, Indices, Indices, tc, 1)
GoodIndices = input('Enter the indices of samples you would like to use: ');
tc = input('Choose the truncation value: ');
read_data_snakes(fileName, Indices, GoodIndices, tc, 0)
disc = input('Choose the discretization value ds: ');
% disc = ceil((tc+1)/numSegs);
PolyDegree = input('Choose the degree of the polynomial you would like to fit the code: ')
ReadData(tc, disc, GoodIndices)
Figure_data_stablizing_strategy(GoodIndices, tc, disc, PolyDegree)