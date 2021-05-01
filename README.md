# wine-quality
Quality of Various Red Wines

This application allows the user to examine the properties of various red wines, and their eventual rating on a scale of 1-10. The user can run a simple linear regression with any variable, or pick two variables to examine correlation and multiple linear regression with them.

# Running the Application
The app can be run in R by using the command `runGitHub("wine-quality", "gdr10")` in R. Ensure that you have the shiny, shinythemes, and ggplots2 libraries installed, otherwise the application is not guaranteed to work. You can also visit a web-hosted version at https://gdr10.shinyapps.io/Wine-Quality/.

The first page does not have any interactive elements, simply showing the raw data that the application is using. This data comes from a study done of Portuguese red and white wines, although this application focuses on the red wines. The data can be found at https://archive.ics.uci.edu/ml/datasets/wine+quality.

The second page, Simple Linear, allows the user to perform a simple linear regression test. On the left select a variable from the dropdown menu, and in the main panel a graph will be created of the selected variable against the quality rating. The graph also displays the generated linear regression line. Underneath the graph the actual math for the linear regression is displayed, showing all related quantities. 

The third page, Multiple Linear, allows the user to examine pairs of variables to find ones that are correlated, and perform a multiple regression test with them if the user desires. On the left select two variables, and the plot of the two will show on the right with the first variable on the x-axis and the second variable on the y-axis. The correlation test will be displayed below the plot. Once a correlation is found, click the box underneath the variable selection and the multiple linear regression test will be performed, replacing the correlation test. If you change variables, you will need to unselect the checkbox to see the correlation test.

# Citation for the data:
P. Cortez, A. Cerdeira, F. Almeida, T. Matos and J. Reis.
Modeling wine preferences by data mining from physicochemical properties. In Decision Support Systems, Elsevier, 47(4):547-553, 2009.
