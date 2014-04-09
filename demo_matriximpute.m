%% generate a random matrix with missing entries

clear;

s = RandStream('mt19937ar','Seed',2014);  % Reset random seed
RandStream.setGlobalStream(s);

p1 = 1500;
p2 = 1500;
r = 10;

M = randn(p1,r) * randn(r,p2) + randn(p1,p2); %+ randn(p1,p2);
display(rank(M));

missingprop = 0.99;
missingidx = rand(p1,p2)<missingprop;

Mobs = M;
Mobs(missingidx) = nan;

%% find max lambda for nuclear norm regularization

%[~,stats] = matrix_impute_Nesterov(Mobs,inf);
[~,stats] = matrix_impute_MM(Mobs,inf);
maxlambda = stats.maxlambda;
disp(maxlambda);

%%
gridpts = 5;
%lambdas = exp(log(maxlambda)/gridpts*(gridpts:-1:1));
lambdas = maxlambda-3*(1:1:gridpts);

display('structure_svt');
% solution path by warm start
tic;
%profile on;
for i=1:gridpts
    if (i==1)
        Y0 = [];
    else
        Y0 = Z;
    end
    %[Z,stats] = matrix_impute_Nesterov(Mobs,lambdas(i),'Y0',Y0,'Display','off');
    [Z,stats] = MatrixCompletion_MM(Mobs,lambdas(i),'Y0',Y0,'Display','off');
    
    if i >= 3
        display(['Grid point ' num2str(i) ', rank=' num2str(stats.rank)]);
    end
end
%profile viewer;
toc;

%% generate a random matrix with missing entries
clear;

s = RandStream('mt19937ar','Seed',2014);  % Reset random seed
RandStream.setGlobalStream(s);

p1 = 1000;
p2 = 1000;
r = 100;

M = randn(p1,r) * randn(r,p2); %+ randn(p1,p2);
display(rank(M));

missingprop = 0.95;
missingidx = rand(p1,p2)<missingprop;

Mobs = M;
Mobs(missingidx) = nan;

%% find max lambda for nuclear norm regularization

%[~,stats] = matrix_impute_Nesterov(Mobs,inf);
[~,stats] = matrix_impute_MM(Mobs,inf);
maxlambda = stats.maxlambda;
disp(maxlambda);

%%
gridpts = 5;
%lambdas = exp(log(maxlambda)/gridpts*(gridpts:-1:1));
lambdas = maxlambda-3*(1:1:gridpts);

display('svt');
tic;
%profile on;
for i=1:gridpts
    if (i==1)
        Y0 = [];
    else
        Y0 = Z;
    end
    %[Z,stats] = matrix_impute_Nesterov(Mobs,lambdas(i),'Y0',Y0,'Display','off');
    [Z,stats] = MatrixCompletion_MM(Mobs,lambdas(i),'Y0',Y0,'Display','off',...
    'method','svt');
    
    if i >= 3
        display(['Grid point ' num2str(i) ', rank=' num2str(stats.rank)]);
    end
end
%profile viewer;
toc;

%% generate a random matrix with missing entries
clear;

s = RandStream('mt19937ar','Seed',2014);  % Reset random seed
RandStream.setGlobalStream(s);

p1 = 1000;
p2 = 1000;
r = 100;

M = randn(p1,r) * randn(r,p2); %+ randn(p1,p2);
display(rank(M));

missingprop = 0.95;
missingidx = rand(p1,p2)<missingprop;

Mobs = M;
Mobs(missingidx) = nan;

%% find max lambda for nuclear norm regularization

%[~,stats] = matrix_impute_Nesterov(Mobs,inf);
[~,stats] = matrix_impute_MM(Mobs,inf);
maxlambda = stats.maxlambda;
disp(maxlambda);

%%
gridpts = 5;
%lambdas = exp(log(maxlambda)/gridpts*(gridpts:-1:1));
lambdas = maxlambda-3*(1:1:gridpts);

display('full_svt');
tic;
%profile on;
for i=1:gridpts
    if (i==1)
        Y0 = [];
    else
        Y0 = Z;
    end
    %[Z,stats] = matrix_impute_Nesterov(Mobs,lambdas(i),'Y0',Y0,'Display','off');
    [Z,stats] = MatrixCompletion_MM(Mobs,lambdas(i),'Y0',Y0,'Display','off',...
        'method','full');
    
    if i >= 3
        display(['Grid point ' num2str(i) ', rank=' num2str(stats.rank)]);
    end
end
%profile viewer;
toc;