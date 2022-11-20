classdef ForceVectorComputer < handle

    properties (Access = public)
        Fext
    end

    properties (Access = private)
        dim
        fdata
    end

        methods (Access = public)
            function obj = ForceVectorComputer(cParams)
                obj.init(cParams);
            end

            function compute(obj)
                obj.forceVectorComputation();
            end
        end
        
        methods (Access = private)
            function init(obj,cParams)
                obj.dim = cParams.dim;
                obj.fdata = cParams.data.fdata;
            end
            function forceVectorComputation(obj)
                forceData = obj.fdata;
                ndof = obj.dim.ndof;
                ni = obj.dim.ni;
                Fe = zeros(ndof,1);
                for i = 1:height(forceData)
                    Fe((ni*forceData(i,1)) - forceData(i,2),1) = forceData(i,3);
                end
                obj.Fext = Fe;
            end
        end
end