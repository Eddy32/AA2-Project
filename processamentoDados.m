load('/Users/frito/Downloads/wiki.mat')

DOB=[wiki(1:1).dob];
foto=[wiki(1:1).photo_taken];
genero=[wiki(1:1).gender];
location=[wiki(1:1).full_path];


for i=1:length(DOB)
    data=datetime(DOB(i),'ConvertFrom','datenum');
    ano=year(data);
    %idade(i,1)=i;
    idade(i,1)=foto(i)-ano;
    idade(i,2)=genero(i);
    %idade(i,4)=(location(i));
    %location = (face_location(2):face_location(4),face_location(1):face_location(3))
end
%idade(:,4)=(location(:));
%csvwrite("wiki.csv",idade)


%location2=location(1:5)
result=[location',num2cell(idade)];
%csvwrite("wiki.csv",result)


%%
cell2csv('result.csv',result)


%%

load('/Users/frito/Downloads/wiki.mat')

DOB=[wiki(1:1).dob];
foto=[wiki(1:1).photo_taken];
genero=[wiki(1:1).gender];
location=[wiki(1:1).full_path];


for i=1:5%length(DOB)
    data=datetime(DOB(i),'ConvertFrom','datenum');
    ano=year(data);
    idade(i,1)=i;
    idade(i,2)=foto(i)-ano;
    idade(i,3)=genero(i);
    %idade(i,4)=(location(i));
    %location = (face_location(2):face_location(4),face_location(1):face_location(3))
end
%idade(:,4)=string(location(:));
%csvwrite("wiki.csv",idade)


location2=location(1:5)
result=[idade,string(location2)',]
csvwrite("wiki.csv",result)
