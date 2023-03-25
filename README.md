# scatter-fit
This MATLAB function creates a scatter plot and computes the linear regression.

%Example 01 - The most simple call

    scatter_fit(x,y);
  
![example_01](https://user-images.githubusercontent.com/88653954/227738600-f323373e-5e13-4e48-b559-6b11a97313b0.png)

%Example 02 - Setting the same limits to x and y axes 

    scatter_fit(x,y,'limits',[4 18]);
    
![example_02](https://user-images.githubusercontent.com/88653954/227738602-7f18171e-8eac-4448-bc16-56c2c014d53f.png)

%Example 03 - Same limits with reference 1:1 (x==y) line

    scatter_fit(x,y,'limits',[4 18],'reference',1);
  
![example_03](https://user-images.githubusercontent.com/88653954/227738603-01f0d5a0-4f76-4eaa-896c-96a6d44d0be6.png)

%Example 04 - Including color code to the scattered samples

    scatter_fit(x,y,'limits',[4 18],'reference',1,'color',y);
    
![example_04](https://user-images.githubusercontent.com/88653954/227738604-f534a6b0-4084-4798-a198-f48783194469.png)
