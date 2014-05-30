function [ nummatches, logoname ] = find_best_logo_match( target_image, logo_path )
%takes in a grey target image and the directory name the logo dir and finds
%best match in terms of num of descriptors

    logoname = '';
    nummatches = 0;

    %grab length of logos
    listofLogoSet = dir([logo_path '*.jpg']);
    logoCount = numel(listofLogoSet);
    
    %get descriptors for target
    targetPoints = detectSURFFeatures(target_image);
    [targetFeatures, targetPoints] = extractFeatures(target_image, targetPoints);
    
    currbest = 0;

    for i=1:logoCount
        information = listofLogoSet(i);
        jpegName = information.name;
        logoName = [logo_path jpegName];
        
        logo_image = rgb2gray(imread(logoName));
        
        %compute number of matches
        logoPoints = detectSURFFeatures(logo_image);
        
        [logoFeatures, logoPoints] = extractFeatures(logo_image, logoPoints);
        matches = matchFeatures(logoFeatures, targetFeatures);
       
        if( size(matches, 1) > nummatches )
            nummatches = size(matches,1);
            logoname = logoName;
        end      
        
    end
    
end

