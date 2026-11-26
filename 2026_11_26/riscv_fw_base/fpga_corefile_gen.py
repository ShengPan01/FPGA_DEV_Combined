

% 生成.coe文件
fid=fopen('sp_ram_256x8.coe','w+');
fprintf(fid,'memory_initialization_radix=10;\n');    % rom写入数值的进制数
fprintf(fid,'memory_initialization_vector= \n');    % rom的向量数值
for i=1:N
    if i == N
        fprintf(fid,'%d; ',fix_p_sin_data(i));    % 这里不能换行，每个数值用英文逗号隔开
    else
        fprintf(fid,'%d, ',fix_p_sin_data(i));
    end
end