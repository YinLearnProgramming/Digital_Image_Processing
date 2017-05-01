%Shows figures with bounding boxes
visualizer=false;

folder_name = 'data/';

inputImageN0 = 1;
inputImageN1 = 25;

%Time limit
timeLimitSec = 60;

%Start the timer
tStart = tic;

%Load ground truth
fn = sprintf ( '%struth.csv%', folder_name, i );
    gt = csvread ( fn );

%Initialize points
total_points = 0;

%Turn the warning for polybool off to reduce spam
warning('off', 'map:polygon:noExternalContours');

for i = inputImageN0:inputImageN1
    
    %Load input image
    fn = sprintf ( '%sinput_%02d.jpg%', folder_name, i);
    f = imread ( fn );

    %Run auto_crop
    [SX0, SY0, SX1, SY1, SX2, SY2, SX3, SY3] = auto_crop(f);
    %Values for Student BoundingBox 
    studentBoundBox = [SX0, SY0, SX1, SY1, SX2, SY2, SX3, SY3];
    studentXBoundBox = [SX0, SX1, SX2, SX3];
    studentYBoundBox = [SY0, SY1, SY2, SY3]; 
    
    %Load ground truth for this image
    X0 = gt(i,1);
    Y0 = gt(i,2);
    X1 = gt(i,3);
    Y1 = gt(i,4);
    X2 = gt(i,5);
    Y2 = gt(i,6);
    X3 = gt(i,7);
    Y3 = gt(i,8);
    %Values for Ground Truth Bounding Box
    trueBoundBox = [X0, Y0, X1, Y1, X2, Y2, X3, Y3];
    trueXBoundBox = [X0, X1, X2, X3];
    trueYBoundBox =[Y0, Y1, Y2, Y3];
    
    %Compute polygon that is the intersection of Student and Ground Truth
    %Bounding Box
    %NOTE: Ordered pairs must be given in clockwise order to be considered
    %an external contour
    Ro = size(f, 1);
    Co = size(f, 2);
    [xa, ya] = polybool('intersection', trueXBoundBox, trueYBoundBox, studentXBoundBox, studentYBoundBox);
    
    %Compute Percentage of overlap between the two
    areaOverlap = polyarea(xa,ya);
    areaTotal = polyarea(trueXBoundBox, trueYBoundBox);
    overlapRatio = areaOverlap/areaTotal*100;
    if polyarea(studentXBoundBox, studentYBoundBox) > areaTotal
        areaError = polyarea(studentXBoundBox, studentYBoundBox) - areaOverlap;
        overlapRatio = areaOverlap/(areaTotal+areaError)*100;
    end
    
    %Show results
    if(visualizer)
        figure(i)
        RGB = insertShape(f,'Polygon',{trueBoundBox, studentBoundBox},'Color',{'green', 'red'});
        imshow(RGB)
        patch(xa, ya, 1, 'FaceColor', 'Yellow');
    end
    
    %Time elapsed
    elapsedTime = toc(tStart);
    
    %Check time limit
    if ( elapsedTime >= timeLimitSec )
            fprintf ( 'Total Points = %i\n', total_points );
            return;
    else
        %Calculate points
        % If overlap is 80% correct then give 2 pts, or 1 pt if 50% correct
        if(overlapRatio >= 80)
            total_points = total_points+2;
        elseif(overlapRatio >= 50)
            total_points = total_points+1;
        end
    end
    fprintf ( 'Image[%.0i]-Overlap Ratio[%.1f%%]-Total Points[%.2i]-Time[%.3f sec]\n', i, overlapRatio, total_points, elapsedTime  );
end

fprintf ( 'Total Points = %.0i\n', total_points );
