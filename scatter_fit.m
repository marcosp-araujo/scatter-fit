%% SCATTER PLOT AND REGRESSION LINE FITTING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% This fuction creates a scatter plot and computes a regression line
%%% AUTHOR: Marcos P. Araújo da Silva (https://github.com/marcosp-araujo)
%%% version 1.0, 22 March 2022
%% VARIABLES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% INPUTS (MANDATORY)
    % x = abscissa data (or reference data)
    % y = ordinate data (or predicted data)
%%% INPUTS (OPTIONAL)
    % c   = Samples color code,  c = [] is default. 
    %       To insert a color code in the samples, e.g.: 
    %       scatter_fit(x,y,'c',array_of_colors)       
    % sca = 1(default)/0 -> Do/don't make the scatter plot, e.g.:
    %       scatter_fit(x,y,'sca',0) -> Will not show the scattered
    %       samples
    % ref = 1(default)/0 -> Do/don't plot reference x=y line
    %       scatter_fit(x,y,'ref',0) -> Will not show reference 1:1 line
    % rl  = 1(default)/0 -> Do/don't plot regression line
    %        scatter_fit(x,y,'rl',0) -> Will not show regression line
    % limits = Limits for x- and y-axes -> limits = 'auto'(default) or  
    %          array of two values, e.g.:
    %          scatter_fit(x,y,'limits',[0 1]) -> Will limit 'x' and
    %          'y' axes from 0 to 1.
%%% OUTPUTS
    % gof = goodness of fit
    % p_sca = scatter plot object
    % p_fit = regression line object
    % p_ref = reference x=y line object

%%    
function [gof,p_sca,p_rl,p_ref] = scatter_fit(x,y,options)
   arguments 
       x
       y
       options.c = [];   
       options.sca = 1; 
       options.ref = 1; 
       options.rl  = 1;  
       options.limits = 'auto'    
   end
%%% SYNCHRONIZING NaN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    data(:,1) = x;
    data(:,2) = y;
    indx  = all(~isnan(data),2); %Index of non-NaN
    x = data(indx,1); % x must be a column vector
    y = data(indx,2); % y must be a column vector
    
%%% AXES CONFIGURATION  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if strcmp(options.limits,'auto')
        min_all = min([x,y],[],'all');
        max_all = max([x,y],[],'all');
    else        
        min_all = min(options.limits);
        max_all = max(options.limits);
    end
        xlim([min_all max_all])  %%% Defining axis limits
        ylim([min_all max_all])  %%% Defining axis limits
    box on
    grid on
    set(gca,'fontsize',14,'TickDir','out')
      
%%% SCATTER PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    hold on
    if options.sca == 1 %show scatter plot
        if isempty(options.c) %not using colors code
            p_sca = scatter(x,y,'Marker','.','SizeData',60,...
                                          'MarkerEdgeColor',[0.3 0.3 0.3]);
        else %using colors code
            p_sca = scatter(x,y,[],options.c(indx),'Marker','.',...
                                                            'SizeData',60);
        end
    else
        p_sca = [];
    end
    
%%% LINEAR FITTING  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [lin_model,gof] = fit(x,y,'poly1'); %linear fitting 
    %gor has the goodnes of fitting in relation to the regression line
    N = length(x); %number of samples
    x_fit = linspace(min_all,max_all,N)'; % x-data for regression line
    y_fit = lin_model(x_fit); % y-data for regression line
    gof.slope = lin_model.p1; % Slope
    gof.intercept = lin_model.p2; % Intercept
    gof.r = sqrt(gof.rsquare); % Coefficient of correlation
    
    %%% Goodness of fitting comparing 'x' to 'y' directly
    RMSE = sqrt(mean((y - x).^2));
    gof.RMSE = RMSE;
    
%%% PLOT REFERENCE LINE 1:1 LINE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if options.ref == 1
        p_ref = plot(x_fit,x_fit,'--','color',[0 0.9 0],'LineWidth',1.4);
    end
    
%%% PLOT REGRESSION LINE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if options.rl == 1
        p_rl = plot(x_fit,y_fit,'r-','LineWidth',1.9);
         
    %%% LEGEND SHOWING GOODNESS OF FITTING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        m_str = num2str(gof.slope,'%0.3fx');    %Slope
        n_str = num2str(gof.intercept,'%+0.3f');%Intercept
        rmse_str = num2str(gof.rmse,'%0.3f');   %Root-mean-square error
        rsquare_str = num2str(gof.rsquare,'%0.3f');  %Coefficient of determination
        RMSE_str = num2str(gof.RMSE,'%0.3f');
        N = num2str(sum(~isnan(x))); %Number of samples
        fit_str = strcat(m_str,{' '},n_str,...
                          ', RMSE = ', RMSE_str,...
                          '\newline \rho^2 = ',rsquare_str,...
                          ' (N = ', N,')');

        le = legend(p_rl,fit_str);
        set(le,'FontSize',10,'Location','northwest','Box','off');
    end
    hold off
end
