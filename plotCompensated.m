% Ele	Azi   Points
% -45	 15	    24
% -30	 15	    24
% -15	 15	    24
% 0	     15	    24
% 15	 15	    24
% 30	 15	    24
% 45	 15	    24
% 60	 30	    12
% 75	 60	     6
% 90	360	     1


% l_eq_hrir_S = 
% 
%          elev_v: [187x1 double]
%          azim_v: [187x1 double]
%          type_s: 'FIR'
%     sampling_hz: 44100
%       content_m: [187x512 double]

figure(1)
for i = 1 : 187
    hold on
    s = sprintf('elev: %d, azi: %d', l_eq_hrir_S.elev_v(i), l_eq_hrir_S.azim_v(i));
    title(s) 
    subplot(1,2,1), cla
    plot(l_eq_hrir_S.content_m(i,:));
    subplot(1,2,2), cla
    plot(abs(fft(l_eq_hrir_S.content_m(i,:))));
    hold off
    pause
end
