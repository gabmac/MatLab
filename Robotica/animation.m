function [  ] = animation( A, vars, Q , T, createGIF, filename)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

    if filename(end-3:end) == '.gif'
    else
        filename = strcat(filename, '.gif');
    end

    n_juncoes = size(vars, 1);
    XYZ = sym(zeros(3, n_juncoes+1));
    for i=1:n_juncoes
        XYZ(:,i+1) = A(1:3,4,i);
    end
    XYZP = eval(subs(XYZ, vars, Q(1,:)'));

    figure1 = figure('Color',[1 1 1], 'position',[800 150 800 500]);
    axes1 = axes('Parent',figure1,'Layer','top','XAxisLocation','bottom','FontSize',12,'FontName','Times New Roman');
    box(axes1,'on');
    hold(axes1,'all');
    set(gcf,'Renderer','OpenGL'); 
    hold on
    box on
    grid on

    lines = plot3 (XYZP(1,:),XYZP(2,:),XYZP(3,:) ,'k','linewidth',2);
    dots = plot3 (XYZP(1,:),XYZP(2,:),XYZP(3,:) ,'.y','linewidth',2,'MarkerSize',10,'Marker','*');

    view(axes1,[45 45]);
    xlim([-1.5,1.5]);
    ylim([-1.5,1.5]);

    t0 = 0;
    for i=1:size(Q,1)
        XYZP = eval(subs(XYZ, vars, Q(i,:)'));

        set(lines,'XData',XYZP(1,:));
        set(lines,'YData',XYZP(2,:));
        set(lines,'ZData',XYZP(3,:));
        set(dots,'XData',XYZP(1,:));
        set(dots,'YData',XYZP(2,:));
        set(dots,'ZData',XYZP(3,:));

        drawnow;

        if createGIF
            % Capture the plot as an image 
            frame = getframe(figure1); 
            im = frame2im(frame); 
            [imind,cm] = rgb2ind(im,256); 

            % Write to the GIF File 
            if i == 1 
              imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',T(i)-t0); 
            else 
              imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',T(i)-t0); 
            end 
        end
      
        %pause(T(i)-t0);
        t0 = T(i);
    end


end

