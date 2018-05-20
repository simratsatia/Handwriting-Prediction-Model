function solution_set = predictdigit(Theta1, Theta2, X)




Number_of_training_examples = size(X, 1);
output_units = size(Theta2, 1);


solution_set = zeros(size(X, 1), 1);


X = [ones(Number_of_training_examples, 1) X];

Layer_two=sigmoid(X*Theta1');

Layer_two=[ones(Number_of_training_examples,1),Layer_two];


Layer_three=sigmoid(Layer_two*Theta2');


[temp, solution_set] = max(Layer_three, [], 2);




end
