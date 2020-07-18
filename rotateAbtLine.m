function coordArr = rotateAbtLine(arr, slope)
sintheta = slope/sqrt(slope^2+1);
costheta = 1/sqrt(slope^2+1);
transform = [costheta sintheta; 
    -sintheta costheta];
coordArr = transform*arr;
end