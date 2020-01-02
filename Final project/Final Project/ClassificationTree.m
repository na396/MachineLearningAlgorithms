classdef ClassificationTree < ...
        classreg.learning.classif.FullClassificationModel & classreg.learning.classif.CompactClassificationTree
%ClassificationTree Decision tree for classification.
%   ClassificationTree is a decision tree with binary splits for
%   classification. It can predict response for new data. It also stores
%   data used for training and can compute resubstitution predictions.
%
%   An object of this class cannot be created by calling the constructor.
%   Use ClassificationTree.fit to create a ClassificationTree object by
%   fitting the tree to training data.
%
%   This class is derived from CompactClassificationTree.
%
%   ClassificationTree properties:
%       NObservations         - Number of observations.
%       X                     - Matrix of predictors used to train this tree.
%       Y                     - True class labels used to train this tree.
%       W                     - Weights of observations used to train this tree.
%       ModelParams           - Tree parameters.
%       PredictorNames        - Names of predictors used for this tree.
%       CategoricalPredictors - Indices of categorical predictors.
%       ResponseName          - Name of the response variable.
%       ClassNames            - Names of classes in Y.
%       Cost                  - Misclassification costs.
%       Prior                 - Prior class probabilities.
%       ScoreTransform        - Transformation applied to predicted classification scores.
%       CatSplit              - Categorical splits for tree nodes.
%       Children              - Child nodes for tree nodes.
%       ClassCount            - Class counts for tree nodes.
%       ClassProb             - Class probabilities for tree nodes.
%       CutCategories         - Categories for splits on categorical predictors.
%       CutPoint              - Points for splits on continuous predictors.
%       CutType               - Split types (continuous or categorical) for tree nodes.
%       CutVar                - Split predictors for tree nodes.
%       IsBranch              - Branch (non-terminal) nodes.
%       NodeClass             - Majority class per tree node.
%       NodeErr               - Resubstitution error per tree node.
%       NodeProb              - Tree node probability.
%       NodeSize              - Tree node size.
%       NumNodes              - Number of nodes in this tree.
%       Parent                - Parent nodes for tree nodes.
%       PruneList             - Pruning sequence for this tree.
%       Risk                  - Resubstitution risk per tree node.
%       SurrCutCategories     - Categories for surrogate splits on categorical predictors.
%       SurrCutFlip           - Signs of surrogate splits on continuous predictors.
%       SurrCutPoint          - Points for surrogate splits on continuous predictors.
%       SurrCutType           - Surrogate split types (continuous or categorical) for tree nodes.
%       SurrCutVar            - Surrogate split predictors for tree nodes.
%       SurrVarAssoc          - Predictive measures of association for surrogate splits for tree nodes.
%
%   ClassificationTree methods:
%       fit (static)          - Grow a classification tree.
%       template (static)     - Tree template for FITENSEMBLE.
%       compact               - Compact this tree.
%       crossval              - Cross-validate this tree.
%       cvLoss                - Classification loss by cross-validation.
%       edge                  - Classification edge.
%       loss                  - Classification loss.
%       margin                - Classification margins.
%       meanSurrVarAssoc      - Mean predictive measures of association between predictors based on surrogate splits.
%       predict               - Predicted response of this tree.
%       predictorImportance   - Importance of predictors for this tree.
%       prune                 - Prune this tree.
%       resubEdge             - Resubstitution classification edge.
%       resubLoss             - Resubstitution classification loss.
%       resubMargin           - Resubstitution classification margins.
%       resubPredict          - Resubstitution predicted response.
%       view                  - View the tree structure.
%
%   Example: Grow a classification tree for Fisher's iris data.
%       load fisheriris
%       t = ClassificationTree.fit(meas,species,'PredictorNames',{'SL' 'SW' 'PL' 'PW'})
%       view(t)
%
%   See also classreg.learning.classif.CompactClassificationTree.
    
%   Copyright 2010-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.11.2.1 $  $Date: 2011/12/21 20:56:01 $ 
  
    methods(Hidden)
        function this = ClassificationTree(X,Y,W,modelParams,...
                dataSummary,classSummary,scoreTransform)
            if nargin~=7 || ischar(W)
                error(message('stats:ClassificationTree:ClassificationTree:DoNotUseConstructor'));
            end
            this = this@classreg.learning.classif.FullClassificationModel(...
                X,Y,W,modelParams,dataSummary,classSummary,scoreTransform);
            this = this@classreg.learning.classif.CompactClassificationTree(...
                dataSummary,classSummary,scoreTransform);
            this = fitTree(this);
        end
    end

    methods(Static)
        function this = fit(X,Y,varargin)
        %FIT Fit a classification decision tree.
        %   TREE=CLASSIFICATIONTREE.FIT(X,Y) returns a classification decision tree
        %   for predictors X and class labels Y.
        %
        %   X must be an N-by-P matrix of predictors with one row per observation
        %   and one column per predictor. Y must be an array of N class labels. Y
        %   can be a categorical array (nominal or ordinal), character array,
        %   logical vector, numeric vector, or cell array of strings. If Y is a
        %   character array, it must have one class label per row.
        %
        %   TREE is a classification tree with binary splits. If you use one of the
        %   following five options, TREE is of class
        %   ClassificationPartitionedModel: 'crossval', 'kfold', 'holdout',
        %   'leaveout' or 'cvpartition'. Otherwise, TREE is of class
        %   ClassificationTree.
        %
        %   TREE=CLASSIFICATIONTREE.FIT(X,Y,'PARAM1',val1,'PARAM2',val2,...)
        %   specifies optional parameter name/value pairs:
        %       'CategoricalPredictors' - List of categorical predictors. Pass
        %                                 'CategoricalPredictors' as one of:
        %                                   * A numeric vector with indices between
        %                                     1 and P, where P is the number of
        %                                     columns of X.
        %                                   * A logical vector of length P, where a
        %                                     true entry means that the
        %                                     corresponding column of X is a
        %                                     categorical variable.
        %                                   * 'all', meaning all predictors are
        %                                     categorical.
        %                                   * A cell array of strings, where each
        %                                     element in the array is the name of a
        %                                     predictor variable. The names must
        %                                     match entries in 'PredictorNames'
        %                                     values.
        %                                   * A character matrix, where each row of
        %                                     the matrix is a name of a predictor
        %                                     variable. The names must match
        %                                     entries in 'PredictorNames' values.
        %                                     Pad the names with extra blanks so
        %                                     each row of the character matrix has
        %                                     the same length.
        %                                 Default: []
        %       'ClassNames'            - Array of class names. Use the data type
        %                                 that exists in Y. You can use this
        %                                 argument to order the classes or select a
        %                                 subset of classes for training. Default:
        %                                 The class names that exist in Y.
        %       'cost'                  - Square matrix, where COST(I,J) is the
        %                                 cost of classifying a point into class J
        %                                 if its true class is I. Alternatively,
        %                                 COST can be a structure S having two
        %                                 fields: S.ClassificationCosts containing
        %                                 the cost matrix C, and S.ClassNames
        %                                 containing the class names and defining
        %                                 the ordering of classes used for the rows
        %                                 and columns of the cost matrix. For
        %                                 S.ClassNames use the data type that
        %                                 exists in Y. Default: COST(I,J)=1 if
        %                                 I~=J, and COST(I,J)=0 if I=J.
        %       'crossval'              - If 'on', grows a cross-validated
        %                                 tree with 10 folds. You can use 'kfold',
        %                                 'holdout', 'leaveout' and 'cvpartition'
        %                                 parameters to override this
        %                                 cross-validation setting. You can only
        %                                 use one of these four options ('kfold',
        %                                 'holdout', 'leaveout' and 'cvpartition')
        %                                 at a time when creating a cross-validated
        %                                 tree. As an alternative, you can
        %                                 cross-validate later using CROSSVAL
        %                                 method for tree TREE. Default: 'off'
        %       'cvpartition'           - A partition created with CVPARTITION to
        %                                 use in cross-validated tree. 
        %       'holdout'               - Holdout validation uses the specified
        %                                 fraction of the data for test, and uses
        %                                 the rest of the data for training.
        %                                 Specify a numeric scalar between 0 and 1.
        %       'kfold'                 - Number of folds to use in cross-validated
        %                                 tree, a positive integer. Default: 10
        %       'leaveout'              - Use leave-one-out cross-validation by
        %                                 setting to 'on'. 
        %       'MergeLeaves'           - When 'on', ClassificationTree.fit merges
        %                                 leaves that originate from the same
        %                                 parent node, and that give a sum of risk
        %                                 values greater or equal to the risk
        %                                 associated with the parent node. When
        %                                 'off', ClassificationTree.fit does not
        %                                 merge leaves. Default: 'on'
        %       'MinLeaf'               - Each leaf has at least 'MinLeaf'
        %                                 observations per tree leaf. If you supply
        %                                 both 'MinParent' and 'MinLeaf',
        %                                 ClassificationTree.fit uses the setting
        %                                 that gives larger leaves: MinParent =
        %                                 max(MinParent,2*MinLeaf). Default: 1
        %       'MinParent'             - Each splitting node in the tree has at
        %                                 least 'MinParent' observations. If you
        %                                 supply both 'MinParent' and 'MinLeaf',
        %                                 ClassificationTree.fit uses the setting
        %                                 that gives larger leaves: MinParent =
        %                                 max(MinParent,2*MinLeaf). Default: 10
        %       'NVarToSample'          - Number of predictors to select at random
        %                                 for each split. Can be a positive integer
        %                                 or 'all'; 'all' means use all available
        %                                 predictors. Default: 'all'
        %       'PredictorNames'        - A cell array of names for the predictor
        %                                 variables, in the order in which they
        %                                 appear in X. Default: {'x1','x2',...}
        %       'prior'                 - Prior probabilities for each class.
        %                                 Specify as one of:
        %                                   * A string:
        %                                     - 'empirical' determines class
        %                                       probabilities from class
        %                                       frequencies in Y
        %                                     - 'uniform' sets all class
        %                                       probabilities equal
        %                                   * A vector (one scalar value for each
        %                                     class)
        %                                   * A structure S with two fields:
        %                                     S.ClassProbs containing a vector of
        %                                     class probabilities, and S.ClassNames
        %                                     containing the class names and
        %                                     defining the ordering of classes used
        %                                     for the elements of this vector.
        %                                 If you pass numeric values,
        %                                 ClassificationTree.fit normalizes them to
        %                                 add up to one. Default: 'empirical'
        %       'prune'                 - When 'on', ClassificationTree.fit grows
        %                                 the unpruned tree and computes the
        %                                 optimal sequence of pruned subtrees.
        %                                 When 'off' ClassificationTree.fit grows
        %                                 the tree without pruning. Default: 'on'
        %       'PruneCriterion'        - String with the pruning criterion, either
        %                                 'error' or 'impurity'. Default: 'error'
        %       'ResponseName'          - Name of the response variable Y, a
        %                                 string. Default: 'Y'
        %       'ScoreTransform'        - Function handle for transforming scores,
        %                                 or string representing a built-in
        %                                 transformation function. Available
        %                                 functions: 'symmetric', 'invlogit',
        %                                 'ismax', 'symmetricismax', 'none',
        %                                 'logit', 'doublelogit', 'symmetriclogit',
        %                                 and 'sign'. Default: 'none'
        %       'SplitCriterion'        - Criterion for choosing a split. One of
        %                                 'gdi' (Gini's diversity index), 'twoing'
        %                                 for the twoing rule, or 'deviance' for
        %                                 maximum deviance reduction (also known as
        %                                 cross-entropy). Default: 'gdi'
        %       'surrogate'             - When 'on', ClassificationTree.fit finds
        %                                 surrogate splits at each branch node.
        %                                 This setting can use much time and
        %                                 memory. You can use it to improve the
        %                                 tree accuracy for data with missing
        %                                 values. You can also use it to compute
        %                                 measures of predictive association
        %                                 between predictors. Default: 'off'
        %       'weights'               - Vector of observation weights, one weight
        %                                 per observation. ClassificationTree.fit
        %                                 normalizes the weights to add up to the
        %                                 value of the prior probability in the
        %                                 respective class. Default:
        %                                 ones(size(X,1),1)
        %
        %   See also ClassificationTree,
        %   classreg.learning.partition.ClassificationPartitionedModel. 

            temp = ClassificationTree.template(varargin{:});
            this = fit(temp,X,Y);
        end
        
        function temp = template(varargin)
        %TEMPLATE Create a classification template.
        %   T=CLASSIFICATIONTREE.TEMPLATE() returns a tree template suitable for
        %   use in the FITENSEMBLE function.
        %
        %   T=CLASSIFICATIONTREE.TEMPLATE('PARAM1',val1,'PARAM2',val2,...)
        %   specifies optional parameter name/value pairs:
        %       'MergeLeaves'           - When 'on', ClassificationTree merges
        %                                 leaves that originate from the same
        %                                 parent node, and that give a sum of risk
        %                                 values greater or equal to the risk
        %                                 associated with the parent node. When
        %                                 'off', ClassificationTree does not merge
        %                                 leaves. Default for ensemble fitting:
        %                                 'off'
        %       'MinLeaf'               - Each leaf has at least 'MinLeaf'
        %                                 observations per tree leaf. If you supply
        %                                 both 'MinParent' and 'MinLeaf',
        %                                 ClassificationTree uses the setting that
        %                                 gives larger leaves: MinParent =
        %                                 max(MinParent,2*MinLeaf). Default for
        %                                 ensemble fitting: 1
        %       'MinParent'             - Each splitting node in the tree has at
        %                                 least 'MinParent' observations. If you
        %                                 supply both 'MinParent' and 'MinLeaf',
        %                                 ClassificationTree uses the setting that
        %                                 gives larger leaves: MinParent =
        %                                 max(MinParent,2*MinLeaf). Default for
        %                                 ensemble fitting: number of
        %                                 training observations for boosting and
        %                                 two for bagging.
        %       'NVarToSample'          - Number of predictors to select at random
        %                                 for each split. Can be a positive integer
        %                                 or 'all'; 'all' means use all available
        %                                 predictors. Default for ensemble fitting:
        %                                 'all' for boosting and square root of the
        %                                 number of predictors for bagging.
        %       'prune'                 - When 'on', ClassificationTree grows the
        %                                 unpruned tree and computes the optimal
        %                                 sequence of pruned subtrees.  When 'off'
        %                                 ClassificationTree grows the tree without
        %                                 pruning. Default for ensemble fitting:
        %                                 'off'
        %       'PruneCriterion'        - String with the pruning criterion, either
        %                                 'error' or 'impurity'. Default for
        %                                 ensemble fitting: 'error'
        %       'SplitCriterion'        - Criterion for choosing a split. One of
        %                                 'gdi' (Gini's diversity index), 'twoing'
        %                                 for the twoing rule, or 'deviance' for
        %                                 maximum deviance reduction (also known as
        %                                 cross-entropy). Default for ensemble
        %                                 fitting: 'gdi'
        %       'surrogate'             - When 'on', ClassificationTree finds
        %                                 surrogate splits at each branch node.
        %                                 This setting can use much time and
        %                                 memory. You can use it to improve the
        %                                 tree accuracy for data with missing
        %                                 values. You can also use it to compute
        %                                 measures of predictive association
        %                                 between predictors. Default for ensemble
        %                                 fitting: 'off'
        %
        %   See also ClassificationTree, fitensemble, ClassificationTree.fit.

            classreg.learning.FitTemplate.catchType(varargin{:});
            temp = classreg.learning.FitTemplate.make('Tree','type','classification',varargin{:});
        end
    end

    methods(Access=protected)
        function this = fitTree(this)
            cost.group = cellstr(this.ClassSummary.NonzeroProbClasses);
            cost.cost = this.ClassSummary.Cost;
            prior.group = cost.group;
            prior.prob = this.ClassSummary.Prior;
            if strcmpi(this.ModelParams.MinParent,'OneSplit')
                minparent = size(this.X,1);
            else
                minparent = this.ModelParams.MinParent;
            end
            tree = classregtree(this.X,cellstr(this.PrivY),'weights',this.W,...
                'method','classification',...
                'priorprob',prior,'cost',cost,...
                'names',this.DataSummary.PredictorNames,...
                'categorical',this.DataSummary.CategoricalPredictors,...
                'splitcriterion',this.ModelParams.SplitCriterion,...
                'minparent',minparent,...
                'minleaf',this.ModelParams.MinLeaf,...
                'nvartosample',this.ModelParams.NVarToSample,...
                'mergeleaves',this.ModelParams.MergeLeaves,...
                'prune',this.ModelParams.Prune,...
                'surrogate',this.ModelParams.Surrogate,...
                'skipchecks',true);
            this.Impl = classreg.learning.impl.CompactTreeImpl(tree);
        end
        
        function s = propsForDisp(this,s)
            s = propsForDisp@classreg.learning.classif.CompactClassificationTree(this,s);
            s = propsForDisp@classreg.learning.classif.FullClassificationModel(this,s);
        end
    end
       
    methods
        function cmp = compact(this)
        %COMPACT Compact tree.
        %   CMP=COMPACT(TREE) returns an object of class CompactClassificationTree
        %   holding the structure of the trained tree. The compact object does not
        %   contain X and Y used for training.
        %
        %   See also ClassificationTree,
        %   classreg.learning.classif.CompactClassificationTree.
            
            cmp = classreg.learning.classif.CompactClassificationTree(...
                this.DataSummary,this.ClassSummary,this.PrivScoreTransform);
            cmp.Impl = this.Impl;
        end
        
        function this = prune(this,varargin)
        %PRUNE Produce a sequence of subtrees by pruning.
        %   T2=PRUNE(T1) computes the pruning sequence for decision tree T1 and
        %   returns a decision tree T2 with the pruning sequence filled in. Trees
        %   are pruned based on an optimal pruning scheme that first prunes
        %   branches giving less improvement in error cost. Subsequent calls to
        %   PRUNE can use this pruning sequence to reduce the tree by turning some
        %   branch nodes into leaf nodes, and removing the leaf nodes under the
        %   original branch.
        %
        %   T2=PRUNE(T1,'criterion','error') or T2=PRUNE(T1,'criterion','impurity')
        %   prunes nodes using resubstitution error (default) or impurity for the
        %   pruning criterion. If 'error' option is chosen, the cost of each node
        %   is the resubstitution error for this node multiplied by the probability
        %   for this node. For trees grown using impurity (Gini index or deviance),
        %   the cost of each node is impurity for this node multiplied by the
        %   probability for this node if 'impurity' option is chosen.
        %
        %   T2=PRUNE(...,'PARAM1',val1,'PARAM2',val2,...) specifies optional
        %   parameter name/value pairs. You can use only one option at a time.
        %       'level'     - A numeric scalar between 0 (no pruning) and the
        %                     largest pruning level of this tree MAX(T1.PruneList).
        %                     PRUNE returns the tree pruned to this level.
        %       'nodes'     - A numeric vector with elements between 1 and
        %                     T1.NumNodes. Any T1 branch nodes listed in NODES
        %                     become leaf nodes in T2, unless their parent nodes
        %                     are also pruned.
        %       'alpha'     - A numeric positive scalar. PRUNE prunes T1 to the
        %                     specified value of the pruning cost.
        %
        %     T2=PRUNE(T1) returns the decision tree T2 that is the full, unpruned
        %     T1, but with optimal pruning information added.  This is useful only
        %     if you created T1 by pruning another tree, or by using the
        %     ClassificationTree.fit with pruning set 'off'.  If you plan to prune
        %     a tree multiple times along the optimal pruning sequence, it is more
        %     efficient to create the optimal pruning sequence first.
        %
        %     Example:  Display full tree for Fisher's iris data, as well as
        %     the next largest tree from the optimal pruning sequence.
        %        load fisheriris;
        %        varnames = {'SL' 'SW' 'PL' 'PW'};
        %        t1 = ClassificationTree.fit(meas,species,'minparent',5,'predictornames',varnames);
        %        view(t1,'mode','graph');
        %        t2 = prune(t1,'level',1);
        %        view(t2,'mode','graph');
        %
        %   See also ClassificationTree,
            
            this.Impl = classreg.learning.impl.CompactTreeImpl(...
                prune(this.Impl.Tree,'criterion',...
                this.ModelParams.PruneCriterion,varargin{:}));
        end
        
        function [varargout] = resubPredict(this,varargin)
        %RESUBPREDICT Predict resubstitution response of the tree.
        %   [LABEL,POSTERIOR,NODE,CNUM]=RESUBPREDICT(TREE) returns predicted class
        %   labels LABEL, posterior class probabilities POSTERIOR, node numbers
        %   NODE and class numbers CNUM for classification tree TREE and training
        %   data TREE.X. Classification labels LABEL have the same type as Y used
        %   for training. Posterior class probabilities POSTERIOR are an N-by-K
        %   numeric matrix for N observations and K classes. NODE is a numeric
        %   vector of length N. CNUM is a numeric vector of length N with classes
        %   coded as integer numbers given by the order of classes in the
        %   ClassNames property.
        %
        %   [LABEL,POSTERIOR,NODE,CNUM]=RESUBPREDICT(TREE,'PARAM1',val1,'PARAM2',val2,...)
        %   specifies optional parameter name/value pairs:
        %       'subtrees'    -  Vector SUBTREES of pruning levels, with 0
        %                        representing the full, unpruned tree. TREE must
        %                        include a pruning sequence as created either by
        %                        the ClassificationTree.fit with 'prune' set to
        %                        'on', or by the PRUNE method. If SUBTREES has M
        %                        elements and TREE.X has N rows, then the output
        %                        LABEL is an N-by-M matrix, with the I-th column
        %                        containing the fitted values produced by the
        %                        SUBTREES(I) subtree. Similarly, POSTERIOR is an
        %                        N-by-K-by-M matrix, and NODE and CNUM are N-by-M
        %                        matrices. SUBTREES must be sorted in ascending
        %                        order.
        %
        %   See also ClassificationTree, predict.
            
            [varargout{1:nargout}] = ...
                resubPredict@classreg.learning.classif.FullClassificationModel(this,varargin{:});
        end
                
        function [varargout] = resubLoss(this,varargin)
        %RESUBLOSS Classification error by resubstitution.
        %   L=RESUBLOSS(TREE) returns resubstitution classification cost for tree
        %   TREE.
        %
        %   L=RESUBLOSS(TREE,'PARAM1',val1,'PARAM2',val2,...) specifies optional
        %   parameter name/value pairs:
        %       'lossfun'   - Function handle for loss, or string representing a
        %                     built-in loss function. Available loss functions for
        %                     classification: 'binodeviance', 'classiferror',
        %                     'exponential', and 'mincost'. If you pass a function
        %                     handle FUN, LOSS calls it as shown below:
        %                          FUN(C,S,W,COST)
        %                     where C is an N-by-K logical matrix for N rows in X
        %                     and K classes in the ClassNames property, S is an
        %                     N-by-K numeric matrix, W is a numeric vector with N
        %                     elements, and COST is a K-by-K numeric matrix. C has
        %                     one true per row for the true class. S is a matrix of
        %                     posterior probabilities for classes with one row per
        %                     observation, similar to POSTERIOR output from
        %                     PREDICT. W is a vector of observation weights. COST
        %                     is a matrix of misclassification costs. Default:
        %                     'mincost'
        %
        %   [E,SE,NLEAF,BESTLEVEL]=RESUBLOSS(TREE,'SUBTREES',SUBTREES) returns
        %   resubstitution cost E, its standard error SE, number of leaves
        %   (terminal nodes) and the optimal pruning level for trees included in
        %   the pruning sequence SUBTREES. SUBTREES must be a vector with integer
        %   values between 0 (full unpruned tree) and the maximal pruning level
        %   MAX(TREE.PruneList). E, SE and NLEAF are vectors of the same length as
        %   SUBTREES, and BESTLEVEL is a scalar. By default SUBTREES is set to 0.
        %   If you set SUBTREES to 'all', LOSS uses the entire pruning sequence.
        %
        %   [...]=RESUBLOSS(TREE,X,Y,'SUBTREES',SUBTREES,'PARAM1',val1,'PARAM2',val2,...)
        %   specifies optional parameter name/value pairs:
        %      'treesize'   - Either 'se' (the default) to choose the smallest
        %                     tree whose cost is within one standard error of the
        %                     minimum cost, or 'min' to choose the minimal cost
        %                     tree.
        %
        %   See also ClassificationTree, loss.
            
            [varargout{1:nargout}] = ...
                resubLoss@classreg.learning.classif.FullClassificationModel(this,varargin{:});
        end
        
        function [varargout] = cvLoss(this,varargin)
        %CVLOSS Classification error by cross-validation.
        %   [E,SE,NLEAF,BESTLEVEL]=CVLOSS(TREE) returns cross-validated
        %   classification cost E, its standard error SE, number of leaves
        %   (terminal nodes) NLEAF and the optimal pruning level BESTLEVEL for tree
        %   TREE.
        %
        %   [E,SE,NLEAF,BESTLEVEL]=CVLOSS(TREE,'PARAM1',val1,'PARAM2',val2,...)
        %   specifies optional parameter name/value pairs:
        %       'subtrees'    -  Vector SUBTREES of pruning levels, with 0
        %                        representing the full, unpruned tree. TREE must
        %                        include a pruning sequence as created either by
        %                        the ClassificationTree.fit with 'prune' set to
        %                        'on', or by the PRUNE method. The returned E, SE
        %                        and NLEAF are vectors of the same length as
        %                        SUBTREES, and BESTLEVEL is a scalar. By default
        %                        SUBTREES is set to 0.  If you set SUBTREES to
        %                        'all', the entire pruning sequence will be used.
        %      'treesize'     -  If you choose 'se' (the default), CVLOSS returns
        %                        BESTLEVEL that corresponds to the smallest tree
        %                        whose cost is within one standard error of the
        %                        minimum cost. If you choose 'min', CVLOSS returns
        %                        BESTLEVEL that corresponds to the minimal cost
        %                        tree.
        %      'kfold'        -  Number of cross-validation samples (default 10).
        %
        %   See also ClassificationTree, loss.
        
            % Get input args
            classreg.learning.FullClassificationRegressionModel.catchWeights(varargin{:});
            args = {'subtrees' 'kfold' 'treesize'};
            defs = {         0      10       'se'};
            [subtrees,kfold,treesize] = ...
                internal.stats.parseArgs(args,defs,varargin{:});
            
            % Check input args
            subtrees = processSubtrees(this.Impl,subtrees);
            
            % Call classregtree/test
            [varargout{1:nargout}] = loss(this.Impl,this.X,cellstr(this.PrivY),...
                'crossvalidate',subtrees,treesize,'nsamples',kfold,'weights',this.W);
        end
    end
    
    methods(Static,Hidden)
        function [X,Y,C,WC,Wj,prior,cost,nonzeroClassNames] = ...
                removeZeroPriorAndCost(X,Y,C,WC,Wj,prior,cost,nonzeroClassNames)
            prior(Wj==0) = 0;
            zeroprior = prior==0;
            if all(zeroprior)
                error(message('stats:ClassificationTree:removeZeroPriorAndCost:ZeroPrior'));
            end
            zerocost = false(1,numel(prior));
            if numel(cost)>1
                zerocost = all(cost==0,2)';
            end
            
            toremove = zeroprior | zerocost;
            if all(toremove)
                error(message('stats:ClassificationTree:removeZeroPriorAndCost:ZeroPriorOrZeroCost'));
            end
            
            if any(toremove)
                t = any(C(:,toremove),2);
                Y(t) = [];
                X(t,:) = [];
                C(t,:) = [];
                WC(t,:) = [];
                WC(:,toremove) = [];
                Wj(toremove) = [];
                nonzeroClassNames(toremove) = [];
                prior(toremove) = [];
                cost(toremove,:) = [];
                cost(:,toremove) = [];
            end
        end
        
        function [X,Y,W,dataSummary,classSummary,scoreTransform] = ...
                prepareData(X,Y,varargin)
            % Process input args
            args = {'classnames' 'cost' 'prior' 'scoretransform'};
            defs = {          []     []      []               []};
            [userClassNames,cost,prior,transformer,~,crArgs] = ...
                internal.stats.parseArgs(args,defs,varargin{:});
            
            % Get class names before any rows might be removed
            allClassNames = levels(classreg.learning.internal.ClassLabel(Y));
            if isempty(allClassNames)
                error(message('stats:ClassificationTree:prepareData:EmptyClassNames'));
            end
            
            % Pre-process
            [X,Y,W,dataSummary] = ...
                classreg.learning.FullClassificationRegressionModel.prepareDataCR(...
                X,classreg.learning.internal.ClassLabel(Y),crArgs{:});
            
            % Process class names
            [X,Y,W,userClassNames,nonzeroClassNames] = ...
                classreg.learning.classif.FullClassificationModel.processClassNames(...
                X,Y,W,userClassNames,allClassNames);

            % Remove missing values
            [X,Y,W] = classreg.learning.classif.FullClassificationModel.removeMissingVals(X,Y,W);
                       
            % Get matrix of class weights
            C = classreg.learning.internal.classCount(nonzeroClassNames,Y);
            WC = bsxfun(@times,C,W);
            Wj = sum(WC,1);
                      
            % Check prior
            prior = classreg.learning.classif.FullClassificationModel.processPrior(...
                prior,Wj,userClassNames,nonzeroClassNames);

            % Get costs
            cost = classreg.learning.classif.FullClassificationModel.processCost(...
                cost,prior,userClassNames,nonzeroClassNames);
        
            % Remove observations for classes with zero prior probabilities
            [X,Y,~,WC,Wj,prior,cost,nonzeroClassNames] = ...
                ClassificationTree.removeZeroPriorAndCost(...
                X,Y,C,WC,Wj,prior,cost,nonzeroClassNames);
            
            % Normalize priors in such a way that the priors in present
            % classes add up to one.  Normalize weights to add up to the
            % prior in the respective class.
            prior = prior/sum(prior);
            W = sum(bsxfun(@times,WC,prior./Wj),2);
    
            % Put processed values into summary structure
            classSummary.ClassNames = userClassNames;
            classSummary.NonzeroProbClasses = nonzeroClassNames;
            classSummary.Prior = prior;
            classSummary.Cost = cost;
            
            % Make output score transformation
            scoreTransform = ...
                classreg.learning.classif.FullClassificationModel.processScoreTransform(transformer);
        end        
    end
end
