function [H, theta, rho] = hough_lines_acc(BW, varargin)
    % Compute Hough accumulator array for finding lines.
    %
    % BW: Binary (black and white) image containing edge pixels
    % RhoResolution (optional): Difference between successive rho values, in pixels
    % Theta (optional): Vector of theta values to use, in degrees
    %
    % Please see the Matlab documentation for hough():
    % http://www.mathworks.com/help/images/ref/hough.html
    % Your code should imitate the Matlab implementation.
    %
    % Pay close attention to the coordinate system specified in the assignment.
    % Note: Rows of H should correspond to values of rho, columns those of theta.

    %% Parse input arguments
    p = inputParser();
    p.addParamValue('RhoResolution', 1);
    p.addParamValue('Theta', linspace(-90, 89, 180));
    p.parse(varargin{:});

    rhoStep = p.Results.RhoResolution;
    theta = p.Results.Theta;
    maxDistance = ceil(sqrt(sum(power(size(BW), 2))));
    rho = -maxDistance:maxDistance;
 
    H = zeros(size(rho,2),size(theta,2));

    [rows cols] = find(BW);
    edgePixels = [rows cols];
    
    function d = distance(pixel, t)
        d = pixel(1) * cos(t) + pixel(2) * sin(t);
    endfunction
    
    function computeDistances(pixel)
        for t = 1:size(theta,2)
            r = floor(maxDistance + distance(pixel, theta(t)));
            H(r, t) += 1;
        end
    endfunction
    
    arrayfun(@(n) computeDistances(edgePixels(n,:)), 1:size(edgePixels,1));
endfunction
