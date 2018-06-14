%file name: Demo_LogisticRegression_DataGeneration.m
% Author: Leming Qu, 
%         Departmen of Mathematics
%         Boise State University
%         lqu@boisestate.edu
% generate simulated data for logistic regression model with count data
% Date last modified: May 21, 2018

n = 500; p = 3;
z1min = -1, z1max = 1; 
z2min = -1, z2max = 1;
z1fit = linspace(z1min, z1max, 100);
z2fit = linspace(z2min, z2max, 100);
[Z1FIT,Z2FIT] = meshgrid(z1fit,z2fit);

randn('seed', 8)
%beta = [-2 2 4]'+ 0.5*randn(p,1);
beta = [-2 2 4]';
z1 = z1min + (z1max-z1min)*rand(n,1);
z2 = z2min + (z2max-z2min)*rand(n,1);
Z = [ones(n,1) z1 z2]; % the first column is for the intercept term
pi = 1./(1+exp(-Z*beta));
m = randsample(100, n, true);
y = binornd(m, pi);

% Visulize the observed data and the true model
figure
scatter3(z1,z2,y./m,'filled')
hold on
YFIT = 1./(1+exp(-(beta(1)+beta(2)*Z1FIT+beta(2)*Z2FIT))); 
mesh(Z1FIT,Z2FIT,YFIT)
xlabel('z_1')
ylabel('z_2')
zlabel('\pi')
view(50,10)
hold off
    
%% generate simulated data for logistic regression model with binary data under the same model
y_binary = []; z1_binary=[]; z2_binary=[];
for i = 1:n
 y_binary = [y_binary; binornd(1, pi(i), [m(i),1])];
 z1_binary = [z1_binary; z1(i).*ones(m(i),1)];
 z2_binary = [z2_binary; z2(i).*ones(m(i),1)];
end

%% save the binomial data [y,m,z1,z2] for later use
savefile = 'logistic_count_data.mat';
save(savefile, 'y', 'm', 'z1', 'z2');

