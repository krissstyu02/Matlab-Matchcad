%вычисление ошибки
output = y;
Target=vpa(Target,3);

s1=0;
s2=0;
for(i=1:25)
	s1=s1+((Target(i)-output(i))^2);
	s2=s2+(Target(i)^2);
end
s1=s1^(1/2);
d=s1/(s2^(1/2));
ans=d