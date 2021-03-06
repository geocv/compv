% This script tries to find the translation of 3D a rigid body given known
% rotation

% Get the rigid body
X = rigid_body(2);

P = get_camera();

% Generate rotation and translation
%R = rotate_y(30*pi/180) * rotate_z(45*pi/180);
R = rotate_z(45*pi/180);
t = translate(0, 0, 5);

T = t * R;

% Transformed coorindates in 3D (homogeneous form)
Y = (T * [X ones(size(X,1),1)]')';

% Project Y to camera
Xb = (P * Y')';

Xb = Xb ./ Xb(:,3);

figure(1);
hold off;
scatter(X(:,1), X(:,2), 'b');
hold on;
scatter(Xb(:,1), Xb(:,2), 'g');

% verify
global verify = 0;
if verify
  % expecting pr = 1.00
  identity_test = pdf_point_cloud_2d(X, X(1,:))
  identity_test = pdf_point_cloud_2d(X, X(2,:))
  identity_test = pdf_point_cloud_2d(X, X(3,:))
  identity_test = pdf_point_cloud_2d(X, X(4,:))
endif

Ts = solve_unmatched(X, Xb, R, P);
fprintf("Solved Transform\n")
Ts

Yf = (Ts * [X ones(size(X,1),1)]')';
Xf = (P * Yf')';
Xf = Xf ./ Xf(:,3);
figure(1);
hold on;
scatter(Xf(:,1), Xf(:,2), 'r');

fprintf("Applied Transform\n")
T
