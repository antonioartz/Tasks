classdef TestComputer < handle

    properties (Access = public)
        KG
        Fext
        u
    end
    properties (Access = private)  
        tolerance
        desiredTest
    end
    properties (Access = protected)
        actualData
        loadedData 
    end

    methods (Static, Access = public)

        function obj = testSelector(cParams)
            switch cParams.desiredTest
                case{'StiffnessMatrix'}
                    obj = StiffnessMatrixTest(cParams);
                case{'ForceVector'}
                    obj = ForceVectorTest(cParams);
                case{'Displacements'}
                    obj = DisplacementsTest(cParams);
                otherwise
                    error('Invalid test type')
            end
        end
    end

    methods (Access = public)
        function check(obj)
            maxDifference = obj.computeMaxDifference();
            if maxDifference > obj.tolerance
                pass = 0;
            else
                pass = 1;
            end
            obj.result(pass);
        end
    end

    methods (Access = protected)
        function result(obj,pass)
            switch pass
                case{1}
                    fprintf(obj.desiredTest); fprintf(' test passed \n');
                case{0}
                    fprintf(obj.desiredTest); fprintf(' test failed \n');
            end
        end

        function init(obj,cParams)
            solveFEM = FEMComputer(cParams);
            solveFEM.compute();
            obj.KG = solveFEM.KG;
            obj.Fext = solveFEM.Fext;
            obj.u = solveFEM.u;
        end
        function initParams(obj,cParams)
            obj.tolerance = cParams.tolerance;
            obj.desiredTest = cParams.desiredTest;
        end
    end

    methods (Access = private)
        function maxDifference = computeMaxDifference(obj)
            difference = obj.computeDifference();
            maxDifference = max(max(difference));
        end

        function difference = computeDifference(obj)
            difference = abs(obj.actualData - obj.loadedData);
        end
    end
end