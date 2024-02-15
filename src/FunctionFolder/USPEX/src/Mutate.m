function output = Mutate(point, vector, input, R_angle)
r = input-point;
vector = vector/norm(vector);  
mu = cross(vector, [0 0 1]);
mu = -mu/norm(mu); 
angle = acos(dot([0 0 1],vector)/norm(vector));    
M(1,:)=[cos(angle)+mu(1)^2*(1-cos(angle)), mu(1)*mu(2)*(1-cos(angle))-mu(3)*sin(angle), mu(1)*mu(3)*(1-cos(angle))+mu(2)*sin(angle)];
M(2,:)=[mu(1)*mu(2)*(1-cos(angle))+mu(3)*sin(angle), cos(angle)+mu(2)^2*(1-cos(angle)), mu(2)*mu(3)*(1-cos(angle))-mu(1)*sin(angle)];
M(3,:)=[mu(3)*mu(1)*(1-cos(angle))-mu(2)*sin(angle), mu(3)*mu(2)*(1-cos(angle))+mu(1)*sin(angle), cos(angle)+mu(3)^2*(1-cos(angle))];
vectorX = [1 0 0];
vectorXN = vectorX*M;
Pvector = cross(vector, vectorXN);
d = dot(r, Pvector);
theta = acos(dot(r,vector)/norm(r));
phi = asin(d/(norm(r)*sin(theta))) + R_angle;
coorN(3)=norm(r)*cos(theta);
coorN(2)=norm(r)*sin(theta)*sin(phi);
coorN(1)=norm(r)*sin(theta)*cos(phi);
output = coorN/M;
output = output+point;
