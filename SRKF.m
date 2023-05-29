%{ 
Developed by:
M A Masud
 
Copyright (c) 2023 M A Masud
 
All rights reserved.
 
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are 
met: 
 
1. Redistributions of source code must retain the above copyright notice,
   this list of conditions and the following disclaimer. 
2. Redistributions in binary form must reproduce the above copyright 
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution. 
 
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS 
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR 
PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR 
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, 
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%}
function [SRKF, RK, colony, colonyN]= SRKF(CellConfig,Rsample,radius)
% This function takes input as the cell configuration (CellConfig) at any instant, sample size (Rsample denoted by \eta), and
% neighborhood radius (radius=\xi+1). 
    sz = size(CellConfig,1); 
    CellConfig(CellConfig==6) = 2;% for all resistant cells (either R-cell (2), or P-cell(6))
    [rRc,cRc] = find(CellConfig==2);  % find location of all resistant cells
    lambda = numel(rRc)/(sz*sz); % density (average density over the whole domain)
    colony = zeros(Rsample,numel(radius)); %initilize size of the clumps
    colonyN = zeros(Rsample,numel(radius)); %initilize size of the clumps normalized with respect to area of the circle
    
    for iradius = 1:1:numel(radius) % for each radius
        for iRsample = 1:1:Rsample % for each sample point (cell)
            index = randi([1 numel(rRc)],1,1);
            xC = rRc(index); 
            yC = cRc(index);
            area = [];%xC,yC+radius-1; xC,yC-radius+1
            % We construct the circle of radius \xi and project it on the
            % cell configuration (CellConfig)
            %Constructing the circle. Construction of circle would be
            %different for three dimensoins and/or different neighborhood
            %setting
            for iy = 1:1:radius(iradius)
                for ix = -iy+1:1:iy-1
                    if (iy == radius(iradius))
                        if (xC+ix>0 && yC-radius(iradius)+iy>0 && xC+ix<=1000 && yC-radius(iradius)+iy<=1000)
                            area = [area; xC+ix, yC-radius(iradius)+iy];
                        end
                    else
                        if (xC+ix>0 && yC+radius(iradius)-iy>0 && xC+ix<=1000 && yC+radius(iradius)-iy<=1000)
                            area = [area; xC+ix, yC+radius(iradius)-iy];
                        end
                        if (xC+ix>0 && yC-radius(iradius)+iy>0 && xC+ix<=1000 && yC-radius(iradius)+iy<=1000)
                            area = [area; xC+ix, yC-radius(iradius)+iy];
                        end
                    end
                end
            end
%           figure
%           plot(area(:,1),area(:,2),'.'); xlim([0 1000]); ylim([0 1000]);
        
        %projection of the circle on the cell configuration
        %   using linear index
            szz = [sz sz];
            ind = sub2ind(szz,area(:,1),area(:,2));
            proj =  CellConfig(ind); %projection of the circle on the cell configuration
        %   the same as in the above block using loop
%             for iarea = 1:1:numel(area)/2
%                 proj(iarea) = CellConfig(area(iarea,1),area(iarea,2));
%             end
        
            colony(iRsample,iradius) = sum(proj==2); % Count number of R-cells or P-cells in the projection (in side the circle)
            colonyN(iRsample,iradius) = sum(proj==2)/numel(proj); % the density of R-cells or P-cells in the projection (in side the circle)
        end
    end

    RK = (1/lambda).*sum(colony)./(Rsample);
    SRKF = (1/lambda).*sum(colonyN)./(Rsample);
end