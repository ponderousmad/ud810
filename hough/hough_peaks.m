function peaks = hough_peaks(H, varargin)
    % Find peaks in a Hough accumulator array.
    %
    % Threshold (optional): Threshold at which values of H are considered to be peaks
    % NHoodSize (optional): Size of the suppression neighborhood, [M N]
    %
    % Please see the Matlab documentation for houghpeaks():
    % http://www.mathworks.com/help/images/ref/houghpeaks.html
    % Your code should imitate the matlab implementation.

    %% Parse input arguments
    p = inputParser;
    p.addOptional('numpeaks', 1, @isnumeric);
    p.addParamValue('Threshold', 0.5 * max(H(:)));
    p.addParamValue('NHoodSize', floor(size(H) / 100.0) * 2 + 1);  % odd values >= size(H)/50
    p.parse(varargin{:});

    numpeaks = p.Results.numpeaks;
    threshold = p.Results.Threshold;
    nHoodSize = p.Results.NHoodSize;
    
    %% Find maximum values
    [sortedH indices] = sort(H(:), 'descend');
    
    peaks = [];    
    for i = indices'
        value = H(i);
        
        % Filter by threshold
        if value < threshold
            break
        end
        
        % Filter by neighborhood
        [row column] =  ind2sub(size(H), i);
        skip = false;
        for j = 1:size(peaks,1)
            if abs(row-peaks(j,1)) <= nHoodSize'
                skip = true;
                break
            elseif abs(column-peaks(j,2)) <= nHoodSize
                skip = true;
                break
            end
        end
        peaks = [peaks; [row column]];
        
        % Filter by numpeaks
        if size(peaks,1) >= numpeaks
            break
        end
    end
endfunction
