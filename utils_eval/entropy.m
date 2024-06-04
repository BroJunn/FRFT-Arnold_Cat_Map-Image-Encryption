function entropy_value = entropy(img)
    % Compute the histogram
    counts = imhist(img);
    probabilities = counts / sum(counts);
    
    % Compute the entropy
    entropy_value = -sum(probabilities .* log2(probabilities + eps));
end