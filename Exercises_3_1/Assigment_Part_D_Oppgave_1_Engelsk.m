% Assignment_Part_D_Task_1_Simplified.m
% Script to evaluate the FIS on the IRIS dataset and display results per row and per class.
clear; clc; close all;

%% 1) Read in IRIS.csv
% Expected header: sepal_length, sepal_width, petal_length, petal_width, species
data = readtable('IRIS.csv', 'Delimiter', ',');

%% 2) Extract columns
inputs = [data.sepal_length, data.sepal_width, data.petal_length, data.petal_width];
trueLabels = string(data.species);

%% 3) Read in the FIS file and evaluate the FIS
fis = readfis('Assignment_Part_D_Iris.fis');
outputs = evalfis(fis, inputs);

%% 4) Map FIS output to class names
% Iris-setosa:     trimf with [0.5 1 1.5]   -> output < 1.5
% Iris-versicolor: trimf with [1.5 2 2.5]   -> 1.5 <= output < 2.5
% Iris-virginica:  trimf with [2.5 3 3.5]   -> output >= 2.5
predictedLabels = strings(length(outputs),1);
for i = 1:length(outputs)
    if outputs(i) < 1.5
        predictedLabels(i) = "Iris-setosa";
    elseif outputs(i) < 2.5
        predictedLabels(i) = "Iris-versicolor";
    else
        predictedLabels(i) = "Iris-virginica";
    end
end

%% 5) Create a comparison table
resultsTable = table(data.sepal_length, data.sepal_width, data.petal_length, data.petal_width, ...
    trueLabels, predictedLabels, outputs, ...
    'VariableNames',{'sepal_length','sepal_width','petal_length','petal_width','True_Species','Predicted_Species','FIS_Output'});
disp('Results Table:');
disp(resultsTable);

%% 6) Compute accuracy
% Overall accuracy
correctPredictions = sum(strcmp(predictedLabels, trueLabels));
overallAccuracy = correctPredictions / length(trueLabels) * 100;
fprintf('\nOverall classification accuracy: %.2f%%\n', overallAccuracy);

% Accuracy per class
classes = unique(trueLabels);
fprintf('\nAccuracy per class:\n');
for i = 1:length(classes)
    idx = (trueLabels == classes(i));
    totalForClass = sum(idx);
    correctForClass = sum(predictedLabels(idx) == classes(i));
    classAccuracy = correctForClass / totalForClass * 100;
    fprintf('%s: %d out of %d correct (%.2f%%)\n', classes(i), correctForClass, totalForClass, classAccuracy);
end
