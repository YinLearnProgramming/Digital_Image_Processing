%f = imread('quad.png');% first part
%f = imread('diamond.png'); % second step
f =  imread('input.png'); %last step

[R,C] = size(f);% making all one matrix
allOne = ones(R,C);

processList = [1]; % create process List
T = 20; % the T value from assignment
regionNumber = 1; % start allOne number with 1
% quad T=100, diamond T = 20, input T = 10,20

while (numel(processList)>0)
    firstElement = processList(1);% get the first element
    processList = [processList(2:end)]; % move to next
    
    %calcuate the SD
    [R,C] = find(allOne == firstElement);
    %SD = std2(f);% not work
    SD =  std2(f(R(1):R(end),C(1):C(end)));
    
    if(SD>T)
        [R, C] = find(allOne==firstElement);
        rowStart = uint32(R(1));
        colStart = uint32(C(1));
        rowEnd = uint32(R(end));
        colEnd = uint32(C(end));
        
        sizeOfAllOne = allOne(rowStart:rowEnd,colStart:colEnd);
        checkTopRight = allOne(rowStart:(rowStart + rowEnd)/2,colStart:(colStart + colEnd)/2);%done
        checkBottomRight = allOne(rowStart:(rowStart + rowEnd)/2,(colStart + colEnd)/2 + 1 : colEnd);%done
        checkTopLeft = allOne((rowStart + rowEnd)/2 + 1: rowEnd,colStart:(colStart + colEnd)/2);%done
        checkBottomLeft = allOne((rowStart + rowEnd)/2+1 : rowEnd,(colStart + colEnd)/2+1 : colEnd);%done
        
        if (isempty(checkTopRight) ~=1 && sum( size(checkTopRight) ~= size(sizeOfAllOne))~=0)
            regionNumber = regionNumber + 1;
            allOne(rowStart:(rowStart+rowEnd)/2,colStart:(colStart+colEnd)/2) = regionNumber;
            processList = [processList regionNumber];
        end
        if (isempty(checkBottomRight) ~=1 && sum( size(checkBottomRight) ~= size(sizeOfAllOne))~=0)
            regionNumber = regionNumber+1;
            allOne(rowStart:(rowStart+rowEnd)/2,(colStart+colEnd)/2+1:colEnd) = regionNumber;
            processList = [processList regionNumber];
        end
        if (isempty(checkTopLeft) ~=1 && sum( size(checkTopLeft) ~= size(sizeOfAllOne))~=0)
            regionNumber = regionNumber+1;
            allOne((rowStart+rowEnd)/2+1:rowEnd,colStart:(colStart+colEnd)/2) = regionNumber;
            processList = [processList regionNumber];
        end
        if (isempty(checkBottomLeft) ~=1 && sum( size(checkBottomLeft) ~= size(sizeOfAllOne))~=0)
            regionNumber = regionNumber+1;
            allOne((rowStart+rowEnd)/2+1:rowEnd,(colStart+colEnd)/2+1:colEnd) = regionNumber;
            processList = [processList regionNumber];
        end
    end
end
visualize_sp(f,allOne);
