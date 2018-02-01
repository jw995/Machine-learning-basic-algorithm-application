classdef DecisionTreeNode < handle
    %DecisionTreeNode class: Nodes of entropy-based binary decision tree.
    % For 24787, you will need to fill in the missing pieces in this file.
    
    properties
        decision_attrib;        % the index of the attrib where split occurs
        available_attribs;      % the indices of available attributes
        decision;               % the class for all input data, if no split occours
        left_node;              % handle to the left leaf
        right_node;             % handle to the right leaf
        parent_node;            % handle to the parent leaf
    end
    
    methods
        function this = DecisionTreeNode()
            this.decision_attrib = -1;
            this.decision = -1;
            this.parent_node = [];
            this.available_attribs = [];
        end
        
        %% 24787 students: fill in the missing parts of this function
        function find_decision_attrib(this, attrib, class)

            h = DecisionTreeNode.entropy_of_class(class);
            info_gain = zeros(size(this.available_attribs));
            
%            From available_attribs, you want to find the attribute that 
%            best splits the data with maximum info gain. 
%            You will need to split the data per each available attribute.
%            You may the following functions:
%                   DecisionTreeNode.entropy_of_class()
%                   DecisionTreeNode.entropy()
%                      
            % Write your code below
            for i=1:1:size(this.available_attribs,2)
            extract=attrib(:,i);
            attrib_s=size(extract);
            attrib_size=attrib_s(1);
            attrib_1_index=sum(extract(:)==1);
            attrib_0_index=sum(extract(:)==0);
            p1=attrib_1_index/attrib_size;
            p0=attrib_0_index/attrib_size;
            
            class_s= size(class);
            class_size=class_s(1);
            sum_yx0=0;
            sum_yx1=0;
            for j=1:1:class_size
                if ((extract(j,1)==0) && (class(j,1)==1))
                    sum_yx0=sum_yx0+1;
                end
                if ((extract(j,1)==1)&&(class(j,1)==1))
                    sum_yx1=sum_yx1+1;
                end
            end
            
            cond_p01=sum_yx0/attrib_0_index;
            cond_p00=1-cond_p01;
            cond_p0=[cond_p01  cond_p00];
            cond_p11=sum_yx1/attrib_1_index;
            cond_p10=1-cond_p11;
            cond_p1=[cond_p11  cond_p10];
            info_gain(i) =  h-p0*DecisionTreeNode.entropy(cond_p0)-...
                                        p1*DecisionTreeNode.entropy(cond_p1);
            end
            [~, best_attrib]=max(info_gain);     %best_attribute is the index of the attribute
            this.decision_attrib=best_attrib;
            %  this.decision_attrib=attrib(:,best_attrib);  %the best
            %  attribute vector
            
        end
        
        %% 24787 students: fill in the missing parts of this function
        function train(this, attrib, class)
            % hint: this will be a recurvise function
            
            %if examples are all positive or all negative then the data is
            %perfectly split. Hence assign the 'classification' and return
            %from this node.
            % Write your code below
              
            
            if (length(class)==sum(class)) 
                this.decision=1;
                return;
            end
            
             if (sum(class)==0)
                this.decision=0;
                return;
             end
           
            
            %check if there is any available (i.e. unused) attribute
            %if no available attribs remain, but still some + and - examples
            %use the MAJORITY VOTE
            %that is, if #of +'ve examples > #of -'ve examples
            %then set this node's classification to be 1 else 0.
            % Write your code below        
            if (isempty(this.available_attribs)&& (length(class)~=sum(class))&&(sum(class)~=0))
                        if (sum(class)<=500)
                            this.decision=0;
                        else
                            this.decision=1;
                        end
           
                   
                        
            
            %if the program runs here,then there are still some available attribs
            %and some positive and negative examples.
            %Hence choose the attribute that splits the data the best,
            %split the dataset and initiate the recursion.
            % Write your code below        
            else 
                            %this.parent_node=this;
                            this.find_decision_attrib(attrib, class);
                            this.available_attribs(this.decision_attrib)=[];
                            index_1 = attrib(:, this.decision_attrib) == 1;  
                            index_0 = attrib(:, this.decision_attrib) == 0;
                             
                            sub_attrib_1=attrib(index_1 , :);
                            sub_attrib_0=attrib(index_0 , :);
                            subclass_1= class(index_1 , :);
                            subclass_0=class(index_0, :);
                            
                            this.left_node=DecisionTreeNode();
                            this.left_node.parent_node=this;
                            this.right_node=DecisionTreeNode();
                            this.right_node.parent_node=this;
                            %this.classify(attrib);
                            
                            
                           
                            this.left_node.available_attribs=this.available_attribs;
                            this.right_node.available_attribs=this.available_attribs;
                            attrib= sub_attrib_1;
                            class = subclass_1;
                            this.left_node.train(attrib, class);
                           
                            
                            attrib= sub_attrib_0;
                            class = subclass_0;                 
                            this.right_node.train(attrib, class);
                     
      

           end
            
            
    
        end
        
        %% 24787 students: study the recursive structure of this function
        % and use it elsewhere in this file
        function class = classify(this, attrib)
            % initialize class labels to -1
            class = -1 * ones(size(attrib, 1), 1);
            
            if this.decision_attrib == -1
                % we are at a leaf node.
                % no split needed. then assign node's decision to all data
                class = this.decision * ones(size(attrib, 1), 1);
            else % recursively classify all data
                % split samples into two sets


                attrib_0_samples_idx = attrib(:, this.decision_attrib) == 0;
                
                % if decision_attrib=0 then idx=1
                attrib_1_samples_idx = attrib(:, this.decision_attrib) == 1;

                %  if decision_attrib=1 then idx=1

                
                class(attrib_1_samples_idx, :) = this.left_node.classify(attrib(attrib_1_samples_idx,:));
                class(attrib_0_samples_idx, :) = this.right_node.classify(attrib(attrib_0_samples_idx,:));
            end  
        end
    end
    
    % Static member functions can be called without object instantiation.
    % Namely, you should call DecisionTreeNode.entropy(), rather than
    % my_dt.entropy()    
    methods (Static)
        %% 24787 students: fill in the missing parts of this function
		% p is a vector of two elements, each being the probability of class = 1 and class = 0
        function h = entropy(p)
              if (p(1)==0 || p(2)==0)
                h=0;
              else
                h=-p(1)*log2(p(1))-p(2)*log2(p(2));
              end
                
		
        end
        
        %% 24787 students: fill in the missing parts of this function
		% class is a binary vector, in which Joy = 1 and Despair = 0
        function h = entropy_of_class(class)
            class_s= size(class);
            class_size=class_s(1);
            class_1_index=sum(class(:)==1);
            class_0_index=sum(class(:)==0);
            p1=class_1_index/class_size;
            p0=class_0_index/class_size;
            if (p0==0 || p1==0)
                h=0;
            else
            h=-p1*log2(p1)-p0*log2(p0);
            end
            
        end
    end
end