classdef StiffnessMatrixTest < TestComputer

    methods (Access = private)
        function loadData(obj)
            load('stiffnessMatrixData.mat','KG');
            obj.loadedData = KG;
        end
        function storeActualData(obj)
            obj.actualData = obj.KG;
        end
    end

    methods(Access = public)
        function obj = StiffnessMatrixTest(cParams)
            obj.init(cParams);
            obj.initParams(cParams);
            obj.loadData();
            obj.storeActualData();
        end
    end
end
