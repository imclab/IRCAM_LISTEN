figure(2), clf, cla, hold on
xlabel('x')
ylabel('y')
zlabel('z'),
axis('square')
grid('on')
for i = 1 : 187
    rad = 1.95;
    theta = pi/2.0 - deg2rad(l_eq_hrir_S.elev_v(i));
    phi = deg2rad(l_eq_hrir_S.azim_v(i));
    
    x = rad*sin(theta)*cos(phi);
    y = rad*sin(theta)*sin(phi);
    z = rad*cos(theta);
    
    plot3(x, y, z, 'k*','MarkerSize',10);
    line('XData', [0 x], 'YData', [0 y], 'ZData', [0 z]);
end

%plot3(0, 0, 0, 'r*','MarkerSize',30);

hold off