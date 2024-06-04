function write_metrics_to_file(filename, average_time, average_psnr, average_ssim, ...
    average_corr_coeff, average_entropy, average_avalanche_effect, purtub_factor)

    % Open file for writing
    fileID = fopen(filename, 'w');
    
    % Write metrics to the file
    fprintf(fileID, 'Performance Metrics:\n');
    fprintf(fileID, '--------------------\n');
    fprintf(fileID, 'Time: %.2f seconds\n', average_time);
    fprintf(fileID, '--------------------\n');
    fprintf(fileID, 'Average PSNR: %.2f dB\n', average_psnr);
    fprintf(fileID, 'Average SSIM: %.2f\n', average_ssim);
    fprintf(fileID, '--------------------\n');
    fprintf(fileID, 'Average Correlation Coefficient: %.2f\n', average_corr_coeff);
    fprintf(fileID, 'Average Entropy: %.2f\n', average_entropy);
    fprintf(fileID, '--------------------\n');
    fprintf(fileID, 'Purtubation Factor: %.2f\n', purtub_factor);
    fprintf(fileID, 'Average Avalanche Effect: %.2f\n', average_avalanche_effect);
    
    % Close the file
    fclose(fileID);
end
