
enableservice('AutomationServer',true);
%Manually import TMOR data as numeric matrix, regularly TMOR data file has 20 rows.
%Data file structure:
%row1: Period
%row2: Tmean
%row3: Nmean
%row4: Re(alpha)
%row5: Im(alpha)

%empty lines based on Re(alpha) are deleted
s0=length(TDATA);
i=s0;
k=0;
while i>0
    if TDATA(i,5)==0
    TDATA(i,:)=[];  
    end
    i=i-1
end


s=length(TDATA);
i=0;
j=0;
freq=0;
%means=zeros(72,6);

%% 60s 35°C
TDATA60=zeros(1,5);
Data_summary=zeros(1,5);
jj=1;
for freq=1:1:600
    for i=1:s       

        if TDATA(i,1)==freq
        j=j+1;
        TDATA60(j,:)=TDATA(i,:);
        end

    end
    if j>1
        i=0;
        j=0;
        l=0;
        ss=length(TDATA60);
        TDATA60_35=zeros(1,5);
        for k=130:-0.5:-12
            kk=k*2;
            for i=1:ss
                if TDATA60(i,2)<k+0.0002 & TDATA60(i,2)>k-0.0002 %tempearture equilibration check
                j=j+1;
                TDATA60_35(j,:)=TDATA60(i,:);
                %temp_var = strcat('TDATA_DGEBA_Pripol_TBD_',num2str(freq),'_',num2str(k*10));
                %variable.(temp_var) = TDATA60_35;
                end
            end
            A=exist('TDATA60_35');
                if A~=0
                Data_summary(jj,:)=mean(TDATA60_35(:,:)); %Average of data after temperature equlibration
                %writematrix(variable.(temp_var),temp_var);
                clear TDATA60_35;
                j=0;
                jj=jj+1;
                end
                A=0;
        end
    end
    clear TDATA60;
    ss=0;
end
