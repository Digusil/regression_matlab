%test_testfunction

inputs_test = [1;4];
targets_test = [2;8];

theta = [2;2];

hypothesis = @(inputs_test, theta) inputs_test.*theta;


r2 = testfunction(data, hypothesis, theta)
