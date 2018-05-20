function [Cost_function grad] = CostFunction(All_parameters, ...
                                   layer_one_size, ...
                                   layer_two_size, ...
                                   output_units, ...
                                   X, y, lambda)

                                   
                                   
                                  
                                   

Theta_layer_one = reshape(All_parameters(1:layer_two_size * (layer_one_size + 1)), ...
                 layer_two_size, (layer_one_size + 1));

Theta_layer_two = reshape(All_parameters((1 + (layer_two_size * (layer_one_size + 1))):end), ...
                 output_units, (layer_two_size + 1));


m = size(X, 1);
         


Theta1_grad = zeros(size(Theta_layer_one));
Theta2_grad = zeros(size(Theta_layer_two));


Layer_one = [ones(m, 1) X];


z2 = Layer_one * Theta_layer_one';

Layer_two = sigmoid(z2);

Layer_two = [ones(m, 1) Layer_two];

z3 = Layer_two * Theta_layer_two';
 
Layer_three= sigmoid(z3);

Cost_function = 0;




for j = 1:output_units
    yj = y == j;
    
    cost_function_temp = 1 / m * sum(-yj .* log(Layer_three(:,j)) - (1 - yj) .* log(1 - Layer_three(:,j)));
    Cost_function= Cost_function + cost_function_temp;
end


    
    
    
Error_regularization = lambda / (2 * m) * (sum(sum(Theta_layer_one(:, 2:end) .^ 2)) + sum(sum(Theta_layer_two(:, 2:end) .^ 2)));
Cost_function = Cost_function + Error_regularization;





for t = 1:m
    for j = 1:output_units
        yj = y(t) == j;
        Error_in_third_layer(j) = Layer_three(t, j) - yj;
    end
    Error_in_second_layer = Theta_layer_two' * Error_in_third_layer' .* sigmoidGradient([1, z2(t, :)])';
    Error_in_second_layer = Error_in_second_layer(2:end);
    Theta1_grad = Theta1_grad + Error_in_second_layer * Layer_one(t, :);
    Theta2_grad = Theta2_grad + Error_in_third_layer' * Layer_two(t, :);
end

Theta1_grad = Theta1_grad / m;
Theta2_grad = Theta2_grad / m;


Theta1_grad(:, 2:end) = Theta1_grad(:, 2:end) + lambda / m * Theta_layer_one(:, 2:end);
Theta2_grad(:, 2:end) = Theta2_grad(:, 2:end) + lambda / m * Theta_layer_two(:, 2:end);







grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
