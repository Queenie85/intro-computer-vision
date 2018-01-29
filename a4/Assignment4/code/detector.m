% detection function

function [ds, bs] = detector(imName, detectionType, resize, imThresh)

    data = getData([], [], detectionType);
    model = data.model;
    col = 'r';
    
    imdata = getData(imName, 'test', 'left');
    im = imdata.im;
    imr = imresize(im,resize); % if we resize, it works better for small objects
    
    % detect objects
    fprintf('running the detector, may take a few seconds...\n');
    tic;
    %[ds, bs] = imgdetect(imr, model, model.thresh); % you may need to reduce the threshold if you want more detections
    [ds, bs] = imgdetect(imr, model, imThresh);
    e = toc;
    fprintf('finished! (took: %0.4f seconds)\n', e);
    top = nms(ds, 0.5);
    % if model.type == model_types.Grammar
    %   bs = [ds(:,1:4) bs];
    % end
    
    if ~isempty(ds)
        % resize back
        ds(:, 1:end-2) = ds(:, 1:end-2)/resize;
        bs(:, 1:end-2) = bs(:, 1:end-2)/resize;
    end
   
    showboxesMy(im, reduceboxes(model, bs(top,:)), col);
    fprintf('detections:\n');
    ds = ds(top, :);
    bs = bs(top, :);
end

