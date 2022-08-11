function [a, b] = sodar2mat(sodarFid)
%%%%%%%%%%%%% Description:
%
% 2022 Nicholas Stoll <nicholasstoll@vt.edu>
%
% This code takes a SODAR .dat file to output two 3D matrices, a and b,
% parsed from all data recorded by the SODAR. All matrices are recorded by
% the SODAR at a 5 minute interval.
%
%%%%%%%%%%%%% Inputs:
%
% Unmodified SODAR .dat file formatted as 'NAME.dat'
%
%%%%%%%%%%%%% Outputs:
%
% a: 19 x 11 x n matrix
%       Each row represents the data measured at an altitude increasing 
%       from 0 (bottom row) to 200 (top row)
%       Column 1: ALT
%       Column 2: CT
%       Column 3: SPEED [
%       Column 4: DIR
%       Column 5: W
%       Column 6: SW
%       Column 7: SU
%       Column 8: SV
%       Column 9: U'V'
%       Column 10: U'W'
%       Column 11: ETAM
%
% b: 4 x 10 x n matrix:
%       Each row contains a different set of data (shown separated by 
%       commas), the columns do not represent a consistent set of 
%       measurements
%       Row 1: GPS LAT, GPS LONG, ROLL, PITCH AZIMUT, T IN, PmBARS, T OUT, 
%       RH%
%       Row 2: BL#, MONTH, DAY, YEAR, HOUR, MIN, VAL1, VAL2, VAL3, VAL4
%       Row 3: SPU1, SPU2, SPU3, SPU4, NOIS1, NOIS2, NOIS3, NOIS4, FEMAX, 
%       SOFTW
%       Row 4: FE11, FE12, FE21, FE22, SNR1, SNR2, SNR3, SNR4, CHECK, JAM
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % initialize two blank matrices with the correct dimensions
    a = zeros(19, 11, 1);
    b = zeros(4, 10, 1);

    existsNextCell = true;
    % establish index for each 2d "cell"
    current2DMatIndex = 1;
    % increment for which lines should be read for each progressive cell
    lineInc = 0;

    while existsNextCell

        % read needed sections of the .dat file in range [startRow, 
        % startCol, endRow, endCol], "cells" defined as one 2D matrix
        % to be inserted into a and b
        cellA = readmatrix(sodarFid, 'Range', [16 + lineInc, 1, 34 + lineInc, 11]);
        cellB = readmatrix(sodarFid, 'Range', [3 + lineInc , 1, 12 + lineInc, 10]);
         
        % continue only if the end of the file has not been reached
        if size(cellA, 1) > 0     
            % because there is text between values needed for the b matrix,
            % only collect the needed lines
            matBCurrentRow = 1;
            for i = 1 : 4
                % assign each desired line to the b matrix at the current
                % 3D index
                b(i, :, current2DMatIndex) = cellB(matBCurrentRow, :);
                matBCurrentRow = matBCurrentRow + 2;
            end
                
            % assign the desired cell to the b matrix at the current 3D
            % index
            a(:, :, current2DMatIndex) = cellA;
            
           
            current2DMatIndex = current2DMatIndex + 1;
            % data repeats in the .dat file every 35 lines
            lineInc = lineInc + 35;

        else
            existsNextCell = false;
        end
    end
end
