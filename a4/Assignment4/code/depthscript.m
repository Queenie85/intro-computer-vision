% depth script

images = getData([],'test','list');
ids = images.ids(1:3);

depthImg1 = depth(ids{1},'test');
depthImg2 = depth(ids{2},'test');
depthImg3 = depth(ids{3},'test');

infs1 = find(depthImg1==Inf);
infs2 = find(depthImg2==Inf);
infs3 = find(depthImg3==Inf);

depthImg1(infs1) = max(max(depthImg1))+5;
depthImg2(infs2) = max(max(depthImg2))+5;
depthImg3(infs3) = max(max(depthImg3))+5;

image(depthImg3)


