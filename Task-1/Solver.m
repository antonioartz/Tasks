classdef Solver < handle

    properties (Access = public)
        x
    end
    properties (Access = protected)
        LHS
        RHS
        solverType
    end

    methods (Static, Access = public)
        function obj = create(cParams)

            switch cParams.solverType
            case {'Direct'}
                obj = DirectSolver(cParams);

            case {'Iterative'}
                obj = IterativeSolver(cParams);

            otherwise
                error('Invalid solver type')
            end
        end
    end

    methods (Access = protected)
        function init(obj,cParams)
            obj.LHS = cParams.LHS;
            obj.RHS = cParams.RHS;
            obj.solverType = cParams.solverType;
        end
    end
end