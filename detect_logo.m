%% Step 1: Read Images
% Read the reference image containing the object of interest.
close all;
clear;
clc;

%step 1: run through logos and try to match one with image
%keep track of logo with highest amount of matches
%if number of matches > 3, remove from image, else do nothing for that
%image

testlogo_path = '/Users/mm71593/delogo/logos/';
testimg_path = '/Users/mm71593/delogo/in/';
output_path = '/Users/mm71593/delogo/out/';

%grab length of images with potential logos
listofImageSet = dir([testimg_path '*.jpg']);
imageCount = numel(listofImageSet);

%loop through logos 
for i=1:imageCount
    
        %read in current target image
        iminfo = listofImageSet(i);
        imName = iminfo.name;
        imageName = [testimg_path imName];
        targetImage = imread(imageName);
        targetgrImage = rgb2gray(targetImage);
        
        bestmatchcount = 0;
        
        %loop through logos and find best match
        [nummatches, logoname] = find_best_logo_match( targetgrImage, testlogo_path);
        keyboard;
    
        if nummatches > 2
            
            %remove logo from image
            remove_logo(targetgrImage, rgb2gray(imread(logoname)));
            
        end
    
end





