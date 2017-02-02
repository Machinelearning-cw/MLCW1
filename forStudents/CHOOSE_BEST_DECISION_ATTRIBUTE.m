function CHOOSE_BEST_DECISION_ATTRIBUTE()
%examples,attributes,binary_targets
    examples = [1 0 1 ; 1 1 0 ; 1 0 1 ];
    binary_targets = [1,0,1];
    [NumberOfExamples,NumberOfAttributes] = size(examples);
    % choose the attribute that results in the highest information gain
    NumberOfPositiveExamples = sum(binary_targets == 1);
    NumberOfNegativeExamples = NumberOfExamples - NumberOfPositiveExamples;
    EntropyOfExamples = ComputeEntropy(NumberOfPositiveExamples,NumberOfNegativeExamples,NumberOfExamples);
    %disp(NumberOfAtttributes)
    BestAttributePos = 0;
    MaximumGain = 0;
    for theAttribute = 1 : NumberOfAttributes 
        CurrentGain = InfoGain(theAttribute,EntropyOfExamples,NumberOfExamples,examples,binary_targets);
        fprintf('CurrentGain = %d\n', CurrentGain);
        if CurrentGain > MaximumGain
           MaximumGain = CurrentGain;
           BestAttributePos = theAttribute;
           fprintf('BestAttributePos = %d\n',BestAttributePos );
           fprintf('MaximumGain = %d\n', MaximumGain);
        end
        
    end
    

end 

function gain = InfoGain(theAttribute,EntropyOfExamples,NumberOfExamples,examples,binary_targets)
    AUContractedPos = 0;
    AUContractedNeg = 0;
    AURelaxedPos = 0;
    AURelaxedNeg = 0;
    for example = 1 : NumberOfExamples
        if examples(example,theAttribute) ==1 && binary_targets(example)==1  
            AUContractedPos = AUContractedPos +1;
        elseif examples(example,theAttribute) ==1 && binary_targets(example)==0
            AUContractedNeg = AUContractedNeg +1;
        elseif examples(example,theAttribute) ==0 && binary_targets(example)==1
            AURelaxedPos = AURelaxedPos+1;
        else
            AURelaxedNeg = AURelaxedNeg+1;
        end
    end
    NumberOfAUContracted = AUContractedPos + AUContractedNeg;
    NumberOfAURelaxed = AURelaxedPos + AURelaxedNeg; 
    
    EntropyAUConstracted = ComputeEntropy(AUContractedPos,AUContractedNeg,NumberOfAUContracted);
    EntropyAURelaxed = ComputeEntropy(AURelaxedPos,AURelaxedNeg,NumberOfAURelaxed);
    
    gain = EntropyOfExamples - (NumberOfAUContracted/NumberOfExamples * EntropyAUConstracted) - (NumberOfAURelaxed/NumberOfExamples * EntropyAURelaxed);
    
end


function entropy = ComputeEntropy(NumberOfPositiveExamples,NumberOfNegativeExamples,NumberOfExamples)
    WeightOfPositiveExamples = NumberOfPositiveExamples/NumberOfExamples;
    WeightOfNegativeExamples = NumberOfNegativeExamples/NumberOfExamples;
    if WeightOfPositiveExamples == 1 || WeightOfNegativeExamples ==1 
        entropy = 0;
    else
        entropy = -(WeightOfPositiveExamples)* log2(WeightOfPositiveExamples) - (WeightOfNegativeExamples)* log2(WeightOfNegativeExamples);
    end
end      



   
   
   
    
  
   