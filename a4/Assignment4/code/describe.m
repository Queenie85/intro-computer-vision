% location description

function describe(imCenters, centerLabels)
carCenters = zeros(1,3);
peopleCenters = zeros(1,3);
bikeCenters = zeros(1,3);
d = max(max(imCenters)) + 50;
dLabel = 0;
cars = 0;
people = 0;
bikes = 0;
numCenters = size(imCenters,1);
for i = 1:numCenters
    center = imCenters(i);
    label = centerLabels(i);
    centerDist = norm(center);
    if centerDist < d
        d = centerDist;
        dLabel = label;
    end
    switch label
        case 1
            cars = cars + 1;
            carCenters(cars,:) = center;
        case 2 
            people = people + 1;
            peopleCenters(people,:) = center;
        case 3 
            bikes = bikes + 1;
            bikeCenters(bikes,:) = center;
        otherwise
            cars = cars + 0;
    end
    
end

switch dLabel
    case 1
        dLabel = 'car';
    case 2
        dLabel = ' person';
    case 3
        dLabel = ' bike';
    otherwise
        dLabel = 'n unidentified object';
end


fprintf("In the scene, there are %d cars, %d people, and %d bikes.\n",cars,people,bikes);
fprintf("The closest object to you is a %s.\n", dLabel);
fprintf("It is %0.1f meters away.\n",d);

numCars = size(carCenters,1); numPeople = size(peopleCenters); numBikes = size(bikeCenters,1);

for c = 1:numCars
    carC = carCenters(c);
    carX = carC(1);
    dirText = 0;
    if carX >= 0
        dirText = 'left';
    else
        dirText = 'right';
    end
    distance = norm(carC);
    fprintf("There is a car %0.1f meters away to your %s.\n",distance,dirText);
end

for p = 1:numPeople
    peepC = peopleCenters(p);
    peepX = peepC(1);
    dirText = 0;
    if peepX >= 0
        dirText = 'left';
    else
        dirText = 'right';
    end
    distance = norm(peepC);
    fprintf("There is a person %0.1f meters away to your %s.\n",distance, dirText);
end

for b = 1:numBikes
    bkC = bikeCenters(c);
    bkX = bkC(1);
    dirText = 0;
    if bkX >= 0
        dirText = 'left';
    else
        dirText = 'right';
    end
    distance = norm(bkC);
    fprintf("There is a bicycle %0.1f meters away to your %s.\n",distance, dirText);
end

end

