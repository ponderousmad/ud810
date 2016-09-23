% ps1
pkg load image;  % Octave only

%% 1-a
img = imread(fullfile('input', 'ps1-input0.png'));  % already grayscale
[img_edges threshold] = edge(img, 'Canny', [], 1);
imwrite(img_edges, fullfile('output', 'ps1-1-a-1.png'));  % save as output/ps1-1-a-1.png

%% 2-a
[H, theta, rho] = hough_lines_acc(img_edges);  % defined in hough_lines_acc.m
img_h = cast(255 * (H / max(H(:))), 'uint8');
imwrite(img_h, fullfile('output', 'ps1-2-a-1.png'));

imshow(imadjust(mat2gray(H)),'XData',theta,'YData',rho);
title('Hough transform of ps1-input0.png');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca,hot);

%% 2-b
peaks = hough_peaks(H, 10);  % defined in hough_peaks.m
%% TODO: Highlight peak locations on accumulator array, save as output/ps1-2-b-1.png

color_H = repmat(img_h,[1,1,3]);
disp(peaks);

for p = peaks'
    color_H(p(1), p(2), 1:2) = 0;
end
imwrite(color_H, fullfile('output', 'ps1-2-b-1.png'));
%% TODO: Rest of your code here
