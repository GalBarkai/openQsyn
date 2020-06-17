function obj = lead(Phase,Freq,Damping)
%LEAD returns a QCTRL lead compensator
%
% Usage:
%
% clead = QCTRL.LEAD(Phase,W)  returns a 1st oreder lead compensator
% with a given phase-lead at frequeny W.
%
% clead = QCTRL.LEAD(Phase,W,damping) returns a 2nd order lead compensator
% with a given phase-lead at frequeny W and specified damping
%

wm = Freq;
Pm = Phase*pi/180;
if nargin==2 % order=1
    z = wm*(1-sin(Pm))/cos(Pm);
    p = wm*(1+sin(Pm))/cos(Pm);
    obj = qctrl(z,p,p/z);
elseif nargin==3 % order=2
    zeta=Damping;
    if zeta>=1 || zeta<=0
        error('damping ratio must be between 0 and 1')
    end
    wz = wm*(-zeta*tan(Pm)+sqrt(zeta^2)*tan(Pm)^2+1);
    wp = wm*(zeta*tan(Pm)+sqrt(zeta^2)*tan(Pm)^2+1);
    z = [-zeta*wz+1j*wz*sqrt(1-zeta^2) -zeta*wz-1j*wz*sqrt(1-zeta^2)];
    p = [-zeta*wp+1j*wp*sqrt(1-zeta^2) -zeta*wp-1j*wp*sqrt(1-zeta^2)];
    obj = qctrl(z,p,wp^2/wz^2);
else
    error('incorrect number of arguments')
end
end