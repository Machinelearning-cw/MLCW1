function DECISION_TREE_LEARNING(examples,attributes,binary_target)
% function DECISION-TREE-LEARNING(examples,attributes,binary_target) returns a decision tree for a given target label

    %define the tree structure
    tree=struct('op',[],'kids',[],'class',[]);
    tree.kids=cell(1,2);
    
    % calculate the height and width of the matrix examples
    N=length(examples(:,1)); 
    n_attributes=length(attributes);
    
    % if all examples have the same value of binary_target
    % then return a leaf node with this value
    if max(binary_target)==min(binary_target)
       tree.class=max(binary_target);
       return
       
    % else if attributes is empty
    % then return a leaf node with value = MAJORITY-VALUE(binary_targets)
    elseif isempty(attributes)
            tree.class=MAJORITY_VALUE(binary_targets);
            return
        
        else
        % best attribute <-- CHOOSE-BEST-DECISION-ATTRIBUTE(examples,attributes,binary_targets)    
        best_attribute=CHOOSE_BEST_DECISION_ATTRIBUTE(examples,attributes,binary_targets);
        
        % tree <-- a new decision tree with root as best_attribute
        tree.op=best_attribute;
        
        % for each possible value ui of best_attribute do (note that there are 2 values: 0 and 1)
        % add a branch to tree corresponding to best_attribute = ui
        % {examples i, binary_targets i} <-- {elements of examples with best_attribute = ui and the corresponding binary_targets i}
        examplei=[];
        binary_targetsi=[];
        for vi=0:1
            for i=1:N
                if examples(i,best.attribute)==vi
                    examplei=[examplei;examples(i,:)];
                    binary_targetsi=[binary_targetsi;binary_target(i)];
                end
            end
            C={examplei,binary_targetsi};
            
            % if examples i is empty
            if isempty(examplei)
                % then return a leaf node with value = MAJORITY-VALUE(binary_targets)
                tree.class=MAJORITY_VALUE(binary_targetsi);
                
            % else subtree <-- DECISION-TREE-LEARNING(examples i,attributes-{best_attribute},binary_target i)
            else
                attributes(attributes==best_attribute)=[];            
                tree.kids{vi+1}=DECISION_TREE_LEARNING(examplei,attributes,binary_targetsi);
            end
        end
    end
    % return tree