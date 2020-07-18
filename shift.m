%Shifts the data based on the tip point (if needed)
function newMat = shift(oldMat)
newMat = ones(2, size(oldMat, 2));
newMat(1,:) = minus(oldMat(1,:), oldMat(1,end));
% tip_index = find(newMat(1,:)==0);
newMat(2,:) = minus(oldMat(2,:), oldMat(2,end));
end