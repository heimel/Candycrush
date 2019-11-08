function candycrush
%CANDYCRUSH to run the eponymous game
%
% 2019, Alexander Heimel

n_x = 6;
n_y = 8;
n_c = 5;

board = zeros(n_y,n_x,'uint8');

figure

show_board(board,n_c)
changed = true;

while changed
    changed = false;
    [board, changed] = fill_top_row(board,n_c);
    show_board(board,n_c);
    pause(0.2);
end


function [board, changed] = fill_top_row(board,n_c)
changed = false;
for x = 1:size(board,2)
   if board(end,x) == 0
       board(end,x) = randi(n_c);
       changed = true;
   end
end


function show_board(board,n_c)
image(board)
axis equal
set(gca,'ydir','normal');
colormap([0 0 0;hsv(n_c)])
