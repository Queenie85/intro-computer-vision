function showboxes2(im, boxes1, boxes2, boxes3, col1, col2, col3)
% Draw bounding boxes on top of an image.
%   showboxes(im, boxes, out)
%
%   If out is given, a pdf of the image is generated (requires export_fig).
if nargin < 3
    col1 = 'r';
    col2 = 'b';
    col3 = 'g';
end;
print = false;
cwidth = 2;


image(im); 
axis image;
axis off;
set(gcf, 'Color', 'white');

if ~isempty(boxes1)
  numfilters = floor(size(boxes1, 2)/4);
  if print
    % if printing, increase the contrast around the boxes
    % by printing a white box under each color box
    for i = 1:numfilters
      x1 = boxes1(:,1+(i-1)*4);
      y1 = boxes1(:,2+(i-1)*4);
      x2 = boxes1(:,3+(i-1)*4);
      y2 = boxes1(:,4+(i-1)*4);
      % remove unused filters
      del = find(((x1 == 0) .* (x2 == 0) .* (y1 == 0) .* (y2 == 0)) == 1);
      x1(del) = [];
      x2(del) = [];
      y1(del) = [];
      y2(del) = [];
      if i == 1
        w = wwidth;
      else
        w = wwidth;
      end

%      if i ==  13+1 || i == 14+1
%        c = 'k';
%        w = cwidth + 0.5;
%      else
        c = 'w';
%      end

      line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]', 'color', c, 'linewidth', w);
    end
  end
  % draw the boxes with the detection window on top (reverse order)

  if 1
  %for i = numfilters:-1:1
  for i = 1:1
    x1 = boxes1(:,1+(i-1)*4);
    y1 = boxes1(:,2+(i-1)*4);
    x2 = boxes1(:,3+(i-1)*4);
    y2 = boxes1(:,4+(i-1)*4);
    % remove unused filters
    del = find(((x1 == 0) .* (x2 == 0) .* (y1 == 0) .* (y2 == 0)) == 1);
    x1(del) = [];
    x2(del) = [];
    y1(del) = [];
    y2(del) = [];
    if i == 1
      c = col1; %[160/255 0 0];
      s = '-';
%    elseif i ==  13+1 || i == 14+1
%      c = 'c';
%      s = '--';
    else
      c = 'b';
      s = '-';
    end
    line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]', 'color', c, 'linewidth', cwidth, 'linestyle', s);
  end
  end
end

if ~isempty(boxes2)
  numfilters = floor(size(boxes2, 2)/4);
  if print
    % if printing, increase the contrast around the boxes
    % by printing a white box under each color box
    for i = 1:numfilters
      x1 = boxes2(:,1+(i-1)*4);
      y1 = boxes2(:,2+(i-1)*4);
      x2 = boxes2(:,3+(i-1)*4);
      y2 = boxes2(:,4+(i-1)*4);
      % remove unused filters
      del = find(((x1 == 0) .* (x2 == 0) .* (y1 == 0) .* (y2 == 0)) == 1);
      x1(del) = [];
      x2(del) = [];
      y1(del) = [];
      y2(del) = [];
      if i == 1
        w = wwidth;
      else
        w = wwidth;
      end

%      if i ==  13+1 || i == 14+1
%        c = 'k';
%        w = cwidth + 0.5;
%      else
        c = 'w';
%      end

      line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]', 'color', c, 'linewidth', w);
    end
  end
  % draw the boxes with the detection window on top (reverse order)

  if 1
  %for i = numfilters:-1:1
  for i = 1:1
    x1 = boxes2(:,1+(i-1)*4);
    y1 = boxes2(:,2+(i-1)*4);
    x2 = boxes2(:,3+(i-1)*4);
    y2 = boxes2(:,4+(i-1)*4);
    % remove unused filters
    del = find(((x1 == 0) .* (x2 == 0) .* (y1 == 0) .* (y2 == 0)) == 1);
    x1(del) = [];
    x2(del) = [];
    y1(del) = [];
    y2(del) = [];
    if i == 1
      c = col2; %[160/255 0 0];
      s = '-';
%    elseif i ==  13+1 || i == 14+1
%      c = 'c';
%      s = '--';
    else
      c = 'b';
      s = '-';
    end
    line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]', 'color', c, 'linewidth', cwidth, 'linestyle', s);
  end
  end
end

if ~isempty(boxes3)
  numfilters = floor(size(boxes3, 2)/4);
  if print
    % if printing, increase the contrast around the boxes
    % by printing a white box under each color box
    for i = 1:numfilters
      x1 = boxes3(:,1+(i-1)*4);
      y1 = boxes3(:,2+(i-1)*4);
      x2 = boxes3(:,3+(i-1)*4);
      y2 = boxes3(:,4+(i-1)*4);
      % remove unused filters
      del = find(((x1 == 0) .* (x2 == 0) .* (y1 == 0) .* (y2 == 0)) == 1);
      x1(del) = [];
      x2(del) = [];
      y1(del) = [];
      y2(del) = [];
      if i == 1
        w = wwidth;
      else
        w = wwidth;
      end

%      if i ==  13+1 || i == 14+1
%        c = 'k';
%        w = cwidth + 0.5;
%      else
        c = 'w';
%      end

      line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]', 'color', c, 'linewidth', w);
    end
  end
  % draw the boxes with the detection window on top (reverse order)

  if 1
  %for i = numfilters:-1:1
  for i = 1:1
    x1 = boxes3(:,1+(i-1)*4);
    y1 = boxes3(:,2+(i-1)*4);
    x2 = boxes3(:,3+(i-1)*4);
    y2 = boxes3(:,4+(i-1)*4);
    % remove unused filters
    del = find(((x1 == 0) .* (x2 == 0) .* (y1 == 0) .* (y2 == 0)) == 1);
    x1(del) = [];
    x2(del) = [];
    y1(del) = [];
    y2(del) = [];
    if i == 1
      c = col3; %[160/255 0 0];
      s = '-';
%    elseif i ==  13+1 || i == 14+1
%      c = 'c';
%      s = '--';
    else
      c = 'b';
      s = '-';
    end
    line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]', 'color', c, 'linewidth', cwidth, 'linestyle', s);
  end
  end
end

% save to pdf
if print
  % requires export_fig from http://www.mathworks.com/matlabcentral/fileexchange/23629-exportfig
  export_fig([out]);
end
