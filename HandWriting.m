clear ; close all; clc


first_layer_size  = 400;
second_layer_size = 25;
output_units = 10;             
                          
                          
                          
                          
fprintf('Loading The data into our project \n')
load('data_set.mat');
fprintf('Displaying the elements of our data set \n');
displayData(X);
fprintf('Press enter to move forward.\n');


pause;



fprintf('\nIf you want to predict a digit using previosuly trained Parameters press p\n');
fprintf('\n');
fprintf('\nIf you want to predict a digit and train paramters yourself press n\n');
fprintf('\n');



New_char = input('Press enter your choice ','New_char');
fprintf('\n');



if New_char == 'p'
    fprintf('\nLoading Parameters For Our Neural Network\n')
    fprintf('\n');
    load('weights_trained.mat');
    
    Number_of_training_examples = size(X, 1);
    
    fprintf('Now We have Randomly Permuted Our Training set\n');
    fprintf('\n');
    rp = randperm(Number_of_training_examples);

    for i = 1:Number_of_training_examples
      
        displayData(X(rp(i), :));
        predicted_value = predictdigit(Theta1, Theta2, X(rp(i),:));
        fprintf('The Prediction According to Nueral Network is clearly digit %d \n',mod(predicted_value, 10));
        fprintf('\n');
        
        
        New_char = input('Press enter To Check for next Digit And Press e to exit:','New_char');
        fprintf('\n');
        if New_char == 'e'
          break
        end
    end

elseif New_char =='n'

    fprintf('\nLoading Parameters For Our Neural Network\n')
    fprintf('\n');
    load('weights_untrained.mat');
    
    %All_parameters = [Theta1(:) ; Theta2(:)];
    %lambda = 1;
    
    %Total_cost = CostFunction(All_parameters, first_layer_size, second_layer_size, ...
    %              output_units, X, y, lambda);
                   
    fprintf('\nInitializing Neural Network Parameters\n');
    fprintf('\n');

    initial_Theta_layer_one = randweight(first_layer_size, second_layer_size);
    initial_Theta_layer_two = randweight(second_layer_size, output_units);


    initial_parameters = [initial_Theta_layer_one(:) ; initial_Theta_layer_two(:)];


    fprintf('\nTraining Our Neural Network To find Paramaters.\n')
    fprintf('\n');


    options = optimset('MaxIter', 15);


    lambda = 1;

    costFunction = @(p)CostFunction(p, ...
                                       first_layer_size, ...
                                       second_layer_size, ...
                                       output_units, X, y, lambda);
    [All_parameters, cost] = fmincg(costFunction, initial_parameters, options);

    Theta1 = reshape(All_parameters(1:second_layer_size * (first_layer_size + 1)), ...
                     second_layer_size, (first_layer_size + 1));

    Theta2 = reshape(All_parameters((1 + (second_layer_size * (first_layer_size + 1))):end), ...
                     output_units, (second_layer_size + 1));
                     
                     
    Number_of_training_examples = size(X, 1);

    for i = 500:Number_of_training_examples
  
        displayData(X(i, :));
        predicted_value = predictdigit(Theta1, Theta2, (X(i, :)));
        
        fprintf('The Prediction According to Nueral Network is clearly digit %d \n',mod(predicted_value, 10));
        fprintf('\n');
        
        
        New_char = input('Press enter To Check for next Digit And Press e to exit:','New_char');
        fprintf('\n');
        if New_char == 'e'
          break
        end
     end



    fprintf('Now We have Randomly Permuted Our Training set\n');
    fprintf('\n');

    rp = randperm(Number_of_training_examples);



    for i = 1:Number_of_training_examples
      
        displayData(X(rp(i), :));
        predicted_value = predictdigit(Theta1, Theta2, X(rp(i),:));
        
        fprintf('The Prediction According to Nueral Network is clearly digit %d \n',mod(predicted_value, 10));
        fprintf('\n');
        
        New_char = input('Press enter To Check for next Digit And Press e to exit:','New_char');
        fprintf('\n');
        if New_char == 'e'
          break
        end
    end

end

