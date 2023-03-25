# scatter-fit
This MATLAB function creates a scatter plot and computes the linear regression.

%Example 01 - The most simple call
    scatter_fit(x,y);
  
![example_01](https://user-images.githubusercontent.com/88653954/227737292-f26ecbb3-aad6-4e66-84ef-36e644d571af.png)

%Example 02 - Setting the same limits to x and y axes 
    scatter_fit(x,y,'limits',[4 18]);
    
![example_02](https://user-images.githubusercontent.com/88653954/227737468-0cf52092-c3a0-481c-88b8-6bc347fcb38c.png)

%Example 03 - Same limits with reference 1:1 (x==y) line
    scatter_fit(x,y,'limits',[4 18],'reference',1);
  
![example_03](https://user-images.githubusercontent.com/88653954/227737470-c7ca81e2-417e-44dd-875c-154390eada69.png)

%Example 04 - Including color code to the scattered samples
    scatter_fit(x,y,'limits',[4 18],'reference',1,'color',y);
    
![example_04](https://user-images.githubusercontent.com/88653954/227737471-5f514dad-cad3-4c6e-81a0-7043b5c040a6.png)
