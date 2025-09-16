function egg_animation(traj_func, starting_point, end_time, egg_params, y_ground, wall_dist)

    t_vals = 0:0.01:end_time;
    s_perimeter = linspace(0, 1, 100);

    %define location and filename where video will be stored
    fname='egg_animation.avi';
    %create a videowriter, which will write frames to the animation file
    writerObj = VideoWriter(fname);
    %must call open before writing any frames
    writerObj.Quality = 100;
    open(writerObj);

    
    animation_fig = figure();


    xlim([-1, wall_dist*1.2])
    ylim([y_ground-1, 10])
    xline(wall_dist)
    yline(y_ground)
    title("Traj-EGG-tory")
    hold on

    time_display = text(0.8, 0.95, 't = 0.00 s', ...
    'Units', 'normalized', ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'top', ...
    'FontSize', 12, ...
    'Color', 'r', ...
    'FontWeight', 'bold');


    [V_vals, ~] = egg_func(s_perimeter,starting_point(1),starting_point(2),starting_point(3),egg_params); 

    egg_outline = plot(V_vals(1, :), V_vals(2, :), 'k.');
    [xmin, xmax, ymin, ymax] = find_bounding_box(starting_point(1), starting_point(2), starting_point(3), egg_params);
    bounding_box = rectangle('Position', [xmin, ymin, xmax-xmin, ymax-ymin], 'EdgeColor','r');
    
    pause(1)
    
    % at each moment in time, look at egg
    for t =t_vals

    
        % where is the egg?
        x = double(subs(traj_func(1), t));
        y = double(subs(traj_func(2), t));
        theta = double(subs(traj_func(3), t));
    
    
        % plot the egg
        [V_vals, ~] = egg_func(s_perimeter,x,y,theta,egg_params);  
        set(egg_outline, 'XData', V_vals(1,:), 'YData', V_vals(2,:), 'Color', 'k', 'Marker', '.');

        % plot path of egg
        plot(x, y, 'k.', 'MarkerSize', 2)
    
        % find and plot the bounding box
        [xmin, xmax, ymin, ymax] = find_bounding_box(x,y,theta,egg_params);
        set(bounding_box, 'Position', [xmin, ymin, (xmax-xmin), (ymax-ymin)])

        % update time to equal t
        set(time_display, 'String', sprintf('t = %.2f s', t));

    
        % update animation
        drawnow;


        %capture a frame (what is currently plotted)
        current_frame = getframe(animation_fig);
        %write the frame to the video
        writeVideo(writerObj,current_frame);
        
        % is bounding box in contact with wall or ground?
        if ymin < y_ground
            break;
        elseif xmax > wall_dist
            break;
        end
    
    
    end

    
    close(writerObj)

end