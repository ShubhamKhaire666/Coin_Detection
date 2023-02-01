clc
clear all
close all

B_mean = imread("Mean_Images\B_mean.JPG");
D_mean = imread("Mean_Images\D_mean.JPG");
F_mean = imread("Mean_Images\F_mean.JPG");

correctCoinValues = Correct_Coin_Values;
incorrect = 0;

for i = 1:12
    name = strcat(num2str(i),'.JPG');
    R = imread("Measurements\"+name);
   
    estimatedValue{i} = estim_coins(R,B_mean, D_mean, F_mean)
    correct{i} = flip(correctCoinValues(i,:))
    
    diff = cell2mat(estimatedValue(i))-cell2mat(correct(i));
    
    incorrect = sum(abs(diff))+incorrect;

end


function coins = Correct_Coin_Values
    coins = [
        1,1,1,1,1,1;
        3,1,0,1,0,0;
        1,0,0,5,1,1;
        0,0,0,3,1,3;
        0,1,0,4,1,3;
        0,3,0,1,0,2;
        0,1,0,3,0,0;
        0,0,1,4,0,3;
        0,0,0,0,1,3;
        0,0,1,4,0,0;
        0,3,1,5,0,0;
        0,3,1,1,0,0;
    ];
end
