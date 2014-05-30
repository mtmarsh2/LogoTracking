function [ outimg ] = remove_logo( target_image, logo_image )
%takes in 2 images, finds and removes logo image from target image and
%returns image with logo gone

    targetPoints = detectSURFFeatures(target_image);
    [targetFeatures, targetPoints] = extractFeatures(target_image, targetPoints);

    logoPoints = detectSURFFeatures(logo_image);
        
    [logoFeatures, logoPoints] = extractFeatures(logo_image, logoPoints);
    matches = matchFeatures(logoFeatures, targetFeatures);
    matches = remove_overused_matches( matches, 15 );
    
    [m n] = size(matches);
    disp(m);
    disp(n);
    
    if ( size(matches, 1) > 2 )
        %% 
        % Display putatively matched features. 
        matchedBoxPoints = logoPoints(matches(:, 1), :);
        matchedScenePoints = targetPoints(matches(:, 2), :);
        
        figure;
        showMatchedFeatures(logo_image, target_image, matchedBoxPoints, ...
            matchedScenePoints, 'montage');
        title('Putatively Matched Points (Including Outliers)');

        %% Step 5: Locate the Object in the Scene Using Putative Matches
        % |estimateGeometricTransform| calculates the transformation relating the
        % matched points, while eliminating outliers. This transformation allows us
        % to localize the object in the scene.
        [tform, inlierBoxPoints, inlierScenePoints] = ...
            estimateGeometricTransform(matchedBoxPoints, matchedScenePoints, 'affine');

        %%
        % Display the matching point pairs with the outliers removed
        
        figure;
        showMatchedFeatures(logo_image, target_image, inlierBoxPoints, ...
            inlierScenePoints, 'montage');
        title('Matched Points (Inliers Only)');

        %% 
        % Get the bounding polygon of the reference image.
        boxPolygon = [1, 1;...                           % top-left
                size(logo_image, 2), 1;...                 % top-right
                size(logo_image, 2), size(logo_image, 1);... % bottom-right
                1, size(logo_image, 1);...                 % bottom-left
                1, 1];                   % top-left again to close the polygon

        %%
        % Transform the polygon into the coordinate system of the target image.
        % The transformed polygon indicates the location of the object in the
        % scene.
        newBoxPolygon = transformPointsForward(tform, boxPolygon);    


      
       
      
        
        disp(newBoxPolygon);
        disp(newBoxPolygon(:, 1));
        disp(newBoxPolygon(:, 2));
        %%
        % Display the detected object.
        figure; imshow(target_image);
        hold on;
        line(newBoxPolygon(:, 1), newBoxPolygon(:, 2), 'Color', 'g');
        title('Detected Box');
    end
    keyboard;


end

