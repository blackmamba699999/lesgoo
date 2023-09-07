function int16Data = binaryToInt16(binaryData)
    % Determine the number of elements in the binary data
    numElements = numel(binaryData);
    
    % Ensure the number of elements is divisible by 2
    if mod(numElements, 2) ~= 0
        error('Invalid binary data size.');
    end
    
    % Determine the number of int16 elements based on the size of the binary data
    numInt16Elements = numElements / 2;
    
    % Reshape the binary data into a 2-by-N matrix to match int16 data format
    reshapedData = reshape(binaryData, 2, numInt16Elements)';
    
    % Convert the reshaped data to int16 using typecast
    int16Data = typecast(reshapedData, 'int16');
end