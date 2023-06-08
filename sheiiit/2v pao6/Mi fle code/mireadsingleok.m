function [data, header] = mireadsingle(file)

f = fopen (file,'r');

if f == -1          %if this bad boi is not openable, blank array is the wae.
    data = [];
    header = [];
    return
end
 
buf=fread(f, 'uchar=>uint8')';

% The line buf = fread(f, 'uchar=>uint8')'; reads the contents of the opened file (f) using the fread function. The function reads the file as unsigned 8-bit characters ('uchar') and stores them as unsigned 8-bit integers ('uint8'). The resulting data is initially a column
% vector, but the transposition (') operator is used to convert it into a row vector (').

ind = findstr(buf, 'data');

% The line ind = findstr(buf, 'data'); searches for the substring 'data' within the buf vector using the findstr function. The function returns the starting [[[index]]] of each occurrence of 'data' in the buf vector and stores them in the ind variable.

cut = find(buf(ind:end)==10,1,'first');

% The code finds the [[[[index]]]] of the first newline character after the occurrence of 'data' in the buf vector using cut = find(buf(ind:end) == 10, 1, 'first'). It searches for the ASCII value 10, which represents the newline character, starting from the ind
% index within buf. The result is stored in cut.

c = textscan(char(buf(1:ind+cut-1))', '%14s%s','Delimiter','\n','Whitespace','');   % basically ends up avoiding the red question mark thingy of the data. 

% The code uses the textscan function to parse the data and header information from the buf vector. It extracts specific data using c = textscan(char(buf(1:ind+cut-1))', '%14s%s','Delimiter','\n','Whitespace',''). This line reads the data from buf up to the
% position just before the first occurrence of the newline character after 'data'. It uses the delimiter '\n' to split the data into columns and stores the results in c.

header = makestruct(c);

% yeah the function definition is at the end. why must you.
% The function makestruct is called with c as an input argument to convert the parsed data into a structured format. The makestruct function processes the data and returns a header structure (header)

nbufs = size(header.bufferLabel,1)-1;

% The code determines the number of data buffers (nbufs) based on the size of the header.bufferLabel array.  ????
% this thing prolly finds the size of the attribute of 'bufferlabel' thingy in that mi file?
% yeah, seems like it.

if strcmpi(header.fileType,'Spectroscopy')     %returns 1 when attribute of 'fileType' is spectroscopy (case insensitive)
    if header.DataPoints == 0
        data = zeros(0,3,nbufs);
        return
    end
    
    if strcmpi(header.data, 'BINARY')
        %data = convchars2float(buf(ind+cut:end));              
        data = convchar(buf(ind+cut:end),'single');
        nd = numel(data);
        
        pts=[0;header.chunk(:,2)];
        cpts=cumsum(pts);
        
        if nd ~= cpts(end) || nd~= header.DataPoints
            data = nan;
            header = nan;
        end

        t=zeros(cpts(end),1);
        x=t;
        
        for k=1:length(pts) - 1 
            ind = cpts(k) + (1:pts(k+1));
            t(ind) = header.chunk(k,3) + (0:header.chunk(k,2)-1)*header.chunk(k,4);
            x(ind) = header.chunk(k,5) + (0:header.chunk(k,2)-1)*header.chunk(k,6);
        end
        
        data = reshape (data, [nd/nbufs, 1, nbufs]);
        data = cat(2, repmat(x, [1, 1, nbufs]), data, repmat(t, [1,1,nbufs]));        
    elseif strcmpi(header.data, 'ASCII')
        c = textscan(char(buf(ind+cut:end))','%n%n%n');
        t = reshape(c{1}, [numel(c{1})/nbufs, 1, nbufs]);
        x = reshape(c{2}, [numel(c{2})/nbufs, 1, nbufs]);
        data = reshape(c{3}, [numel(c{3})/nbufs, 1, nbufs]);
        data = cat(2, x, data, t);
    else
        data = nan;
        header = nan;
        return
    end    



elseif strcmpi(header.fileType,'Image'). % now this thing is of our interest.  if attribute of 'filetype' is image, then it proceeds this way. 

    if strcmpi(header.data,'BINARY')  % of course, in the files it is BINARY_32, so this is prolly the thingy
                                      % that we will have to change. or just add another elseif clause with the same things.

                                      % this is boutta get real spicy.


        % data = convchars2int32(buf(ind+cut:end));

        data = convchar(buf(ind+cut:end), 'int16');  %converts all the binary shit at the end to int16 datatype (signed 16bit integer)

    elseif strcmpi(header.data,'ASCII')
        data = textscan (char(buf(ind+cut:end))','%n');
        data = data{1};
    else
        data = nan;
        header = nan;
        return;
    end
    
    data = reshape(data, header.xPixels, header.yPixels, []);
    data = permute (data, [2 1 3]);
    data = data(end:-1:1,:,:);
end

fclose(f);
    
function header=makestruct(c)

header=struct;
for k=1:length(c{1})
    if strncmpi(c{1}{k},'color',5)
        continue
    end
    tmp=str2num(c{2}{k}); %#ok<ST2NM>
    if isempty(tmp)
        tmp=deblank(c{2}{k});
    end
    field = deblank(c{1}{k});
    if ~isfield(header, field)
        header.(field)=tmp;
    else
        if ischar(tmp)
            header.(field)=strvcat(header.(field), tmp); %#ok<VCAT>
        else
            header.(field)=cat(1, header.(field), tmp);
        end
    end
end
