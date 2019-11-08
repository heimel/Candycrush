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
    [board, changedg] = apply_gravity(board);
    [board, changedf] = fill_top_row(board,n_c);
    [board, changedr] = remove_triplets(board);
    changed = changedg | changedf | changedr;
    show_board(board,n_c);
    if changed
        pause(0.2);
    else
        [x0,y0] = getcoordinates;
        x1 = x0;
        y1 = y0;
        while x0 == x1 && y0 == y1
            [x1,y1] = getcoordinates;
            pause(0.001);
        end
        x2 = x1;
        y2 = y1;
        while x2 == x1 && y2 == y1
            [x2,y2] = getcoordinates;
            pause(0.001);
        end
        if (x1-x2)^2 + (y1-y2)^2 == 1
            tempboard = swap(board,x1,y1,x2,y2);
            show_board(tempboard,n_c);
            [~,success] = remove_triplets(tempboard);
            pause(0.2);
            if success
                board = tempboard;
            else
                show_board(board,n_c);
            end
        end
        changed = true;
    end
end

function board = swap(board,x1,y1,x2,y2)
temp = board(y1,x1);
board(y1,x1) = board(y2,x2);
board(y2,x2) = temp;

function [x,y] = getcoordinates
pos = get(gca,'CurrentPoint');
x = round(pos(1,1));
y = round(pos(1,2));




function [newboard,changedr] = remove_triplets(board)
changedr = false;
newboard = board;
% horizontal triplets
for y=1:size(board,1)
    for x=1:(size(board,2)-2)
        if board(y,x) == board(y,x+1) && ...
                board(y,x) == board(y,x+2)
            newboard(y,x) = 0;
            newboard(y,x+1) = 0;
            newboard(y,x+2) = 0;
            changedr = true;
        end
    end
end
% vertical triples
for x=1:size(board,2)
    for y=1:(size(board,1)-2)
        if board(y,x) == board(y+1,x) && ...
                board(y,x) == board(y+2,x)
            newboard(y,x) = 0;
            newboard(y+1,x) = 0;
            newboard(y+2,x) = 0;
            changedr = true;
        end
    end
end


function [board, changed] = apply_gravity(board)
changed = false;
for y = 1:(size(board,1)-1)
   for x = 1:size(board,2)
       if board(y,x) == 0
           board(y,x) = board(y+1,x);
           board(y+1,x) = 0;
           changed = true;
       end
   end
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
axis equal off 
box off
set(gca,'ydir','normal');
colormap([0 0 0;hsv(n_c)])
