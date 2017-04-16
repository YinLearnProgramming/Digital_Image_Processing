function [r,c] = i_spy ( object_im, big_im, x )

    rOfSmallImage = size(object_im, 1); 
    cOfSmallImage = size(object_im, 2); 
    rOfBigImage = size(big_im, 1); 
    cOfBigImage = size(big_im, 2);
    
    smallImage = int32(object_im);
    bigImage = int32(big_im);

    for row=1 : (rOfBigImage-rOfSmallImage)
        for column=1 : (cOfBigImage-cOfSmallImage)
            
            if(smallImage(1,1,1)==bigImage(row,column,1))%compare origin
                if(smallImage(rOfSmallImage,1,1)==bigImage(row+rOfSmallImage-1,column,1))%compare top right
                    if(smallImage(1,cOfSmallImage,1)==bigImage(row,column+cOfSmallImage-1,1)) % button left
                        if(smallImage(rOfSmallImage,cOfSmallImage,1)==bigImage(row+rOfSmallImage-1,column+cOfSmallImage-1,1))% button right
                            r = row;
                            c = column;
                        else
                            break;
                        end
                    else
                        
                    end
                else
                    
                end
            end
            
        end %second for loop end
    end %first for loop end
end %function end
%[rows, columns, numberOfColorChannels]
%r = row;
%c = column;