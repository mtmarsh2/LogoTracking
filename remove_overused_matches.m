function [ matches_out ] = remove_overused_matches( matches_in, threshold )
%takes in n x 2 matrix and a threshold, and removes matches that occur with
%the 2nd point more than threshold times
%   Detailed explanation goes here


%create matrix of unique points in target image
unique_pts = unique(matches_in(:,2));


%get frequency of all those pts
count_unique = histc(matches_in(:,2), unique_pts);

matches_out = 0;

end

