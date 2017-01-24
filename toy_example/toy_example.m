 clear all
 clc

 %1 2 3 4 5 6 7
 As{1} = [
  0 1 0 0 0 0 0 %1
  1 0 1 0 1 1 1 %2
  0 1 0 0 0 0 0 %3
  0 0 0 0 0 0 0 %4
  0 1 0 0 0 1 0 %5
  0 1 0 0 1 0 0 %6
  0 1 0 0 0 0 0]; %7

 %1 2 3 4 5 6 7
 As{2} = [
  0 0 0 0 0 0 0 %1
  0 0 1 1 1 1 1 %2
  0 1 0 1 0 0 0 %3
  0 1 1 0 0 1 1 %4
  0 1 0 0 0 1 0 %5
  0 1 0 1 1 0 0 %6
  0 1 0 1 0 0 0]; %7

 %1 2 3 4 5 6 7
 As{3} = [
  0 1 0 0 0 0 0 %1
  1 0 1 1 0 0 1 %2
  0 1 0 1 0 0 0 %3
  0 1 1 0 0 0 1 %4
  0 0 0 0 0 0 0 %5
  0 0 0 0 0 0 0 %6
  0 1 0 1 0 0 0]; %7

 Bs{1} = [
  0 0 1 1 1 1 1 %1
  0 0 0 0 0 0 0 %2
  1 0 0 0 1 0 0 %3
  1 0 0 0 0 0 0 %4
  1 0 1 0 0 0 1 %5
  1 0 0 0 0 0 0 %6
  1 0 0 0 1 0 0]; %7

 %1 2 3 4 5 6 7
 Bs{2} = [
  0 1 1 0 1 1 1 %1
  1 0 1 0 1 1 0 %2
  1 1 0 0 1 1 0 %3
  0 0 0 0 0 0 0 %4
  1 1 1 0 0 1 1 %5
  1 1 1 0 1 0 0 %6
  1 0 0 0 1 0 0]; %7

 %1 2 3 4 5 6 7
 Bs{3} = [
  0 1 1 1 0 0 0 %1
  1 0 1 0 0 1 0 %2
  1 1 0 0 0 1 0 %3
  1 0 0 0 0 0 0 %4
  0 0 0 0 0 0 0 %5
  0 1 1 0 0 0 0 %6
  0 0 0 0 0 0 0]; %7

M = make_multimodal(As);
N = make_multimodal(Bs);

input_modes = 1:3;
alpha = 0.9;
iters = 10;

% [U,V,multimodal1,multimodal2] = compute_UV(M,N,input_modes,alpha,iters);
% nnodes = 7
% nmodes = 3
% [M1,MM1,sz1] = create_multimodal_network_3(nnodes,nmodes,M,input_modes);
% [N1,NN1,sz2] = create_multimodal_network_3(nnodes,nmodes,N,input_modes);
%%

[ma,mb,score,total_score,As,Bs] = ...
    align_multimodal_network(M,N,'bp',1:3,0.9,10);
score_multimodal = score

% nnodes = 7;
% nmodes = 3;
% [M1,MM1,sz1] = create_multimodal_network(nnodes,nmodes,M);
% [N1,NN1,sz2] = create_multimodal_network(nnodes,nmodes,N);