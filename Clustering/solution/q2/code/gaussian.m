function y= gaussian(data,i,j,sigma)
m=(data(i,1)-data(j,1))^2+(data(i,2)-data(j,2))^2;
y=exp(-m/(2*sigma^2));
end