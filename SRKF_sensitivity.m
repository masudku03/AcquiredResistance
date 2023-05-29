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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
This script generates figure 4 of the article https://doi.org/10.1016/j.compbiomed.2023.107035
%}
clear
    j=1; Rsample = 100; %\eta = 10000 for the figure 4 of the articel
    radius = 2:1:50;%\xi = radius - 1 = 1 to 49
    RandPop = 300000; %Number of total points (representative of cells)
%% Cellconfig: Random %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %initialize CellConfig
    CellConfig = zeros(1000,1000); 
    %Pick random points
    rRc = randi([1,1000],RandPop,1); cRc = randi([1,1000],RandPop,1);
    %Assign 2 to the points picked
    for ii = 1:1:RandPop
        CellConfig(rRc(ii),cRc(ii)) = 2;
    end
    % color map
    mymap1 =[1 1 1;0.8500 0.3250 0.0980];
    %plot Cellconfig
    subplot(3,3,1)
    im = imagesc(CellConfig);xticks([]); yticks([]);
    colormap(gca,mymap1)
	xlabel('Cell Config: Random');
    %Calculate and plot SRKF
    subplot(3,3,7:8)
    [MRKR, ~,~,~]=SRKF(CellConfig,Rsample,radius);
    plot(radius,MRKR); hold on
%     boxchart(MRK(CellConfig,Rsample,radius)); hold on
%% Cellconfig: 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    %initialize CellConfig
    CellConfig = zeros(1000,1000); 
    %Pick random points
    rRc = randi([201,800],RandPop,1); cRc = randi([201,800],RandPop,1);
    %Assign 2 to the points picked
    for ii = 1:1:RandPop
        CellConfig(rRc(ii),cRc(ii)) = 2;
    end
    % color map
    mymap1 =[1 1 1;0.8500 0.3250 0.0980];
    %plot Cellconfig
    subplot(3,3,2)
    im = imagesc(CellConfig);xticks([]); yticks([]);
    colormap(gca,mymap1)
	xlabel('Cell Config: 1');
    %Calculate and plot SRKF
    subplot(3,3,7:8)
    [MRK1, ~,~,~]=SRKF(CellConfig,Rsample,radius);
    plot(radius,MRK1); hold on
%% Cellconfig: 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %initialize CellConfig
    CellConfig = zeros(1000,1000); 
    %Pick random points
    rRc = randi([1,500],0.15*RandPop,1); cRc = randi([1,500],0.15*RandPop,1);
    rRc = [rRc; randi([501,1000],0.15*RandPop,1)]; cRc = [cRc; randi([501,1000],0.15*RandPop,1)];
    rRc = [rRc; randi([1,500],0.35*RandPop,1)]; cRc = [cRc; randi([501,1000],0.35*RandPop,1)];
    rRc = [rRc; randi([501,1000],0.35*RandPop,1)]; cRc = [cRc; randi([1,500],0.35*RandPop,1)];
    %Assign 2 to the points picked
    for ii = 1:1:RandPop
        CellConfig(rRc(ii),cRc(ii)) = 2;
    end
    % color map
    mymap1 =[1 1 1;0.8500 0.3250 0.0980];
    %plot Cellconfig
    subplot(3,3,3)
    im = imagesc(CellConfig);xticks([]); yticks([]);
    colormap(gca,mymap1)
	xlabel('Cell Config: 2');
    %Calculate and plot SRKF
    subplot(3,3,7:8)
    [MRK2, ~,~,~]=SRKF(CellConfig,Rsample,radius);
    plot(radius,MRK2); hold on
%% Cellconfig: 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %initialize CellConfig
    CellConfig = zeros(1000,1000); 
    %Pick random points
    rRc = randi([1,250],0.04*RandPop,1); cRc = randi([1,250],0.04*RandPop,1);
    rRc = [rRc; randi([251,500],0.04*RandPop,1)]; cRc = [cRc; randi([251,500],0.04*RandPop,1)];
    rRc = [rRc; randi([501,750],0.04*RandPop,1)]; cRc = [cRc; randi([501,750],0.04*RandPop,1)];
    rRc = [rRc; randi([751,1000],0.04*RandPop,1)]; cRc = [cRc; randi([751,1000],0.04*RandPop,1)];

    rRc = [rRc; randi([251,500],0.08*RandPop,1)]; cRc = [cRc; randi([1,250],0.08*RandPop,1)];
    rRc = [rRc; randi([501,750],0.08*RandPop,1)]; cRc = [cRc; randi([251,500],0.08*RandPop,1)];
    rRc = [rRc; randi([751,1000],0.08*RandPop,1)]; cRc = [cRc; randi([501,750],0.08*RandPop,1)];
    rRc = [rRc; randi([1,250],0.08*RandPop,1)]; cRc = [cRc; randi([251,500],0.08*RandPop,1)];
    rRc = [rRc; randi([251,500],0.08*RandPop,1)]; cRc = [cRc; randi([501,750],0.08*RandPop,1)];
    rRc = [rRc; randi([501,750],0.08*RandPop,1)]; cRc = [cRc; randi([751,1000],0.08*RandPop,1)];

    rRc = [rRc; randi([501,750],0.05*RandPop,1)]; cRc = [cRc; randi([1,250],0.05*RandPop,1)];
    rRc = [rRc; randi([751,1000],0.05*RandPop,1)]; cRc = [cRc; randi([251,500],0.05*RandPop,1)];
    rRc = [rRc; randi([1,250],0.05*RandPop,1)]; cRc = [cRc; randi([501,750],0.05*RandPop,1)];
    rRc = [rRc; randi([251,500],0.05*RandPop,1)]; cRc = [cRc; randi([751,1000],0.05*RandPop,1)];

    rRc = [rRc; randi([1,250],0.08*RandPop,1)]; cRc = [cRc; randi([751,1000],0.08*RandPop,1)];
    rRc = [rRc; randi([751,1000],0.08*RandPop,1)]; cRc = [cRc; randi([1,250],0.08*RandPop,1)];
    %Assign 2 to the points picked
    for ii = 1:1:RandPop
        CellConfig(rRc(ii),cRc(ii)) = 2;
    end
    % color map
    mymap1 =[1 1 1;0.8500 0.3250 0.0980];
    %plot Cellconfig
    subplot(3,3,4)
    im = imagesc(CellConfig);xticks([]); yticks([]);
    colormap(gca,mymap1)
	xlabel('Cell Config: 3');
    %Calculate and plot SRKF
    subplot(3,3,7:8)
    [MRK3, ~,~,~]=SRKF(CellConfig,Rsample,radius);
    plot(radius,MRK3); hold on
%% Cellconfig: 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %initialize CellConfig
    CellConfig = zeros(1000,1000); 
    %Pick random points
    rRc = randi([1,250],0.01*RandPop,1); cRc = randi([1,250],0.01*RandPop,1);
    rRc = [rRc; randi([251,500],0.01*RandPop,1)]; cRc = [cRc; randi([251,500],0.01*RandPop,1)];
    rRc = [rRc; randi([501,750],0.01*RandPop,1)]; cRc = [cRc; randi([501,750],0.01*RandPop,1)];
    rRc = [rRc; randi([751,1000],0.01*RandPop,1)]; cRc = [cRc; randi([751,1000],0.01*RandPop,1)];

    rRc = [rRc; randi([251,500],0.12*RandPop,1)]; cRc = [cRc; randi([1,250],0.12*RandPop,1)];
    rRc = [rRc; randi([501,750],0.12*RandPop,1)]; cRc = [cRc; randi([251,500],0.12*RandPop,1)];
    rRc = [rRc; randi([751,1000],0.12*RandPop,1)]; cRc = [cRc; randi([501,750],0.12*RandPop,1)];
    rRc = [rRc; randi([1,250],0.12*RandPop,1)]; cRc = [cRc; randi([251,500],0.12*RandPop,1)];
    rRc = [rRc; randi([251,500],0.11*RandPop,1)]; cRc = [cRc; randi([501,750],0.11*RandPop,1)];
    rRc = [rRc; randi([501,750],0.11*RandPop,1)]; cRc = [cRc; randi([751,1000],0.11*RandPop,1)];

    rRc = [rRc; randi([501,750],0.01*RandPop,1)]; cRc = [cRc; randi([1,250],0.01*RandPop,1)];
    rRc = [rRc; randi([751,1000],0.01*RandPop,1)]; cRc = [cRc; randi([251,500],0.01*RandPop,1)];
    rRc = [rRc; randi([1,250],0.01*RandPop,1)]; cRc = [cRc; randi([501,750],0.01*RandPop,1)];
    rRc = [rRc; randi([251,500],0.01*RandPop,1)]; cRc = [cRc; randi([751,1000],0.01*RandPop,1)];

    rRc = [rRc; randi([1,250],0.11*RandPop,1)]; cRc = [cRc; randi([751,1000],0.11*RandPop,1)];
    rRc = [rRc; randi([751,1000],0.11*RandPop,1)]; cRc = [cRc; randi([1,250],0.11*RandPop,1)];
    %Assign 2 to the points picked
    for ii = 1:1:RandPop
        CellConfig(rRc(ii),cRc(ii)) = 2;
    end
    % color map
    mymap1 =[1 1 1;0.8500 0.3250 0.0980];
    %plot Cellconfig
    subplot(3,3,5)
    im = imagesc(CellConfig);xticks([]); yticks([]);
    colormap(gca,mymap1)
	xlabel('Cell Config: 4');
    %Calculate and plot SRKF
    subplot(3,3,7:8)
    [MRK4, ~,~,~]=SRKF(CellConfig,Rsample,radius);
    plot(radius,MRK4); hold on
%% Cellconfig: 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %initialize CellConfig
    CellConfig = zeros(1000,1000); 
    %Pick random points
    rRc = randi([1,250],0.125*RandPop,1); cRc = randi([1,250],0.125*RandPop,1);
    rRc = [rRc; randi([251,500],0.125*RandPop,1)]; cRc = [cRc; randi([251,500],0.125*RandPop,1)];
    rRc = [rRc; randi([501,750],0.125*RandPop,1)]; cRc = [cRc; randi([501,750],0.125*RandPop,1)];
    rRc = [rRc; randi([751,1000],0.125*RandPop,1)]; cRc = [cRc; randi([751,1000],0.125*RandPop,1)];

    rRc = [rRc; randi([501,750],0.125*RandPop,1)]; cRc = [cRc; randi([1,250],0.125*RandPop,1)];
    rRc = [rRc; randi([751,1000],0.125*RandPop,1)]; cRc = [cRc; randi([251,500],0.125*RandPop,1)];
    rRc = [rRc; randi([1,250],0.125*RandPop,1)]; cRc = [cRc; randi([501,750],0.125*RandPop,1)];
    rRc = [rRc; randi([251,500],0.125*RandPop,1)]; cRc = [cRc; randi([751,1000],0.125*RandPop,1)];
    %Assign 2 to the points picked
    for ii = 1:1:RandPop
        CellConfig(rRc(ii),cRc(ii)) = 2;
    end
    % color map
    mymap1 =[1 1 1;0.8500 0.3250 0.0980];
    %    load('Rsample10000Radius2to50MRKsensitivity.mat')
    %plot Cellconfig
    subplot(3,3,6)
    im = imagesc(CellConfig);xticks([]); yticks([]);
    colormap(gca,mymap1)
	xlabel('Cell Config: 5');
    %Calculate and plot SRKF
    subplot(3,3,7:8)
    [MRK5, ~,~,~]=SRKF(CellConfig,Rsample,radius);
    plot(radius,MRK5); hold on
    ylabel('$\bar{K}(\xi)$','Interpreter','latex'); xlabel('\xi'); 
    legend('Cell Config: Random','Cell Config: 1','Cell Config: 2','Cell Config: 3','Cell Config: 4','Cell Config: 5');
%% Correlation test %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    relativeDensity = [3/10, 3/3.6, 3*0.7/5, 3*0.64/5, 3*0.92/5, 3*1/5]./0.3;
    pltindex = [4];
    subplot(3,3,9)
    for ii = 1:1:numel(pltindex)
        mdl = fitlm(relativeDensity,[MRKR(pltindex(ii)), MRK1(pltindex(ii)), MRK2(pltindex(ii)), MRK3(pltindex(ii)), MRK4(pltindex(ii)), MRK5(pltindex(ii))])
        plot(mdl);
%         plot(relativeDensity,[MRKR(pltindex(ii)), MRK1(pltindex(ii)), MRK2(pltindex(ii)), MRK3(pltindex(ii)), MRK4(pltindex(ii)), MRK5(pltindex(ii))],'o');
        hold on
    end
    title('C');  ylabel('$\bar{K}(\xi)$','Interpreter','latex'); xlabel('$\frac{density}{\lambda}$','Interpreter','latex'); 
