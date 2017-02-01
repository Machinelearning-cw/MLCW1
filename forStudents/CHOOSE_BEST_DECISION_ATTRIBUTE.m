function CHOOSE_BEST_DECISION_ATTRIBUTE()
%examples,attributes,binary_targets
   
    binary_targets = [1,1,1,1,1,1,1]
    NumberOfExamples= length(binary_targets)
    % choose the attribute that results in the highest information gain



    NumberOfPositiveExamples = sum(binary_targets == 1)
    NumberOfNegativeExamples = NumberOfExamples - NumberOfPositiveExamples
    EntropyOfExamples = ComputeEntropy(NumberOfPositiveExamples,NumberOfNegativeExamples,NumberOfExamples)

end 
function entropy = ComputeEntropy(NumberOfPositiveExamples,NumberOfNegativeExamples,NumberOfExamples)
    WeightOfPositiveExamples = NumberOfPositiveExamples/NumberOfExamples
    WeightOfNegativeExamples = NumberOfNegativeExamples/NumberOfExamples
    if WeightOfPositiveExamples == 1 || WeightOfNegativeExamples ==1 
        entropy = 0;
    else
        entropy = -(WeightOfPositiveExamples)* log2(WeightOfPositiveExamples) - (WeightOfNegativeExamples)* log2(WeightOfNegativeExamples);
    end
end      



   
   
   
    
  
   