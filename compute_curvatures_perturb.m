function [ ks, kphi,pbks,pbkphi,angle ] = compute_curvatures_perturb(rv,LUT,pbm)

rb = LUT*rv';%boundary vectors
%Compute instantaneous tension vectors
D = sqrt(sum(rb.^2,2)); %Vector of edge lengths.
z = -rb(:,1);%z increment in ptb analysis
r = -rb(:,2);%r increment in ptb analysis

rb(:,1) = rb(:,1)./D;
rb(:,2) = rb(:,2)./D;%director
LUTP = LUT>0;
LUTM = LUT<0;
rb1 = (LUTP+LUTM)*rv(2,:)';%yL+yR 
rm = 0.5*rb1;
rbn = [rb(:,2) -rb(:,1)];%outward normal
%angle1 = -atan(rb(:,2)./rb(:,1));%tangent 
%angle2 = atan(rbn(:,2)./rbn(:,1))%outward normal
angle = pi/2-atan(rb(:,2)./rb(:,1));%outward normal from r axis, equivalent to alpha in the analysis
%alpha = pi+atan(z./r);%alpha in the analysis
ks = ones(1,size(D,1));
kphi = ones(1,size(D,1));
i=1;
%ks(i) = (3*angle2(i)-4*angle2(i+1)+angle2(i+2))./(D(i+1)+0.5*D(i)+0.5*D(i+2));%forward difference, not strictly second order, because D is not uniform
ks(i) = (angle(i+1)+angle(i)-pi)./(2*D(i));
kphi(i) = sin(angle(i))/rm(i);

for i=2:(size(D,1)-1)
    
ks(i) = (angle(i+1)-angle(i-1))./(2*D(i));
kphi(i) = sin(angle(i))/rm(i);

end

i=size(D,1);
%ks(i) = -(3*angle2(i)-4*angle2(i-1)+angle2(i-2))./(D(i-1)+0.5*D(i-2)+0.5*D(i));%backward difference, not strictly second order, because D is not uniform
ks(i) = ((2*pi-angle(i))-angle(i-1))./(2*D(i));
kphi(i) = sin(angle(i))/rm(i);

%compute perturbation
pbalpha = 2*pbm.*(1./abs(z)+1./abs(r)).*tan(angle)./(1+tan(angle).*tan(angle));
pblm = 2*pbm.*(abs(sin(angle))+abs(cos(angle)));
pbrm = pbm;
i=1;
%ks(i) = (3*angle2(i)-4*angle2(i+1)+angle2(i+2))./(D(i+1)+0.5*D(i)+0.5*D(i+2));%forward difference, not strictly second order, because D is not uniform
pbks(i) = (abs(pbalpha(i+1))+abs(pbalpha(i)))./abs(angle(i+1)+angle(i)-pi)+abs(pblm(i))./D(i);
pbkphi(i) = abs(pbalpha(i))./abs(tan(angle(i)))+abs(pbrm)./abs(rm(i));

for i=2:(size(D,1)-1)   
pbks(i) = (abs(pbalpha(i+1))+abs(pbalpha(i-1)))./abs(angle(i+1)-angle(i-1))+abs(pblm(i))./D(i);
pbkphi(i) = abs(pbalpha(i))./abs(tan(angle(i)))+abs(pbrm)./abs(rm(i));
end

i=size(D,1);
%ks(i) = -(3*angle2(i)-4*angle2(i-1)+angle2(i-2))./(D(i-1)+0.5*D(i-2)+0.5*D(i));%backward difference, not strictly second order, because D is not uniform
pbks(i) = (abs(pbalpha(i))+abs(pbalpha(i-1)))./abs((2*pi-angle(i))-angle(i-1))+abs(pblm(i))./D(i);
pbkphi(i) = abs(pbalpha(i))./abs(tan(angle(i)))+abs(pbrm)./abs(rm(i));
end