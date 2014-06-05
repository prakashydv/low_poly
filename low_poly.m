%% low poly designer
% madary 2014-06-05
% select three points to colour the mean color between the three points.

im=imread('/home/tonbo/Pictures/image.png');
figure
imshow(im),hold on
while 1
    [x1,y1]=ginput(1);
    [x2,y2]=ginput(1);
    [x3,y3]=ginput(1);

    if x1<5
        break
    end
    minx=min([x1,x2,x3]);
    miny=min([y1,y2,y3]);
    maxx=max([x1,x2,x3]);
    maxy=max([y1,y2,y3]);
    listt=zeros(1,5);
    Atotal=area_triangle(x1,y1,x2,y2,x3,y3);
    pts=0;
    for i=minx:maxx
        for j=miny:maxy
            Aa=area_triangle(x1,y1,x2,y2,i,j);
            Ab=area_triangle(x2,y2,x3,y3,i,j);
            Ac=area_triangle(x1,y1,x3,y3,i,j);
            
            if(abs(Atotal-Aa-Ab-Ac) < 0.000001)
                pts=pts+1;
                try
                    listt(pts,3:5)=im(uint16(j),uint16(i),:);
                catch err
                    size(im)
                    fprintf('(%d,%d)\n',uint16(j),uint16(i));
                    throw(err)
                end
                listt(pts,1:2)=[uint16(i),uint16(j)];
            end
        end
    end
    
    R=0;B=0;G=0;
    for i=1:pts
        try 
            R=R+double(im(listt(i,2),listt(i,1),1));
            G=G+double(im(listt(i,2),listt(i,1),2));
            B=B+double(im(listt(i,2),listt(i,1),3));
        catch err
            size(im)
            fprintf('%d: (%d,%d)\n',uint16(i),listt(i,2),listt(i,1));
            throw(err)
        end
    end
  R=R/pts;
  G=G/pts;
  B=B/pts;
   
    for i=1:pts
        im(listt(i,2),listt(i,1),:)=[R,G,B];
    end
    imshow(im)
    
end
hold off
