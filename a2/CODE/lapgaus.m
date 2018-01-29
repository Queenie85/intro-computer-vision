% laplacian of gaussian

img = imread('synthetic.png');
img = double(img);
img = mean(img,3);

imgS = img; 
cnt = 1;
clear responseLoG
k = 1.1;
sigma = 2.0;
s = k.^(1:30)*sigma;
responseLoG = zeros(size(img,1),size(img,2),length(s));

for si = 1:length(s)
    sL = s(si);
    hs= max(25,min(floor(sL*3),128));
    HL = fspecial('log',[hs hs],sL);
    imgFiltL = conv2(imgS,HL,'same');
    %Compute the LoG
    responseLoG(:,:,si)  = (sL^2)*imgFiltL;
end
fg = figure;imagesc(img);axis image;hold on;colormap gray;
drawnow;

for x = 1:size(img,1)
    for y = 1:size(img,2)
        f = squeeze(responseLoG(y,x,:));
        [fMax,fmaxLocs] = findpeaks(f);%maxima
        [fMin,fminLocs] = findpeaks(-f);%minima
        for i = 1:numel(fmaxLocs)
            sc = s(fmaxLocs(i));
            %Draw a circle
            figure(fg);
            xc = sc*sin(0:0.1:2*pi)+x;
            yc = sc*cos(0:0.1:2*pi)+y;
            plot(xc,yc,'r');
            drawnow;
           
            [nx,ny,nz] = meshgrid(x-1:x+1,y-1:y+1,fmaxLocs(i));
            inds = sub2ind(size(responseLoG),ny,nx,nz);
            df = responseLoG(inds(5))-responseLoG(inds);
            df(5)=[];%don't compare to itself
            if(min(df)>=0)
                plot(xc,yc,'r-o');
                drawnow;
            end
        end
    end
end

drawnow;






