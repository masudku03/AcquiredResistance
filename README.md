# Acquired Resistance
The code ("ModelGrid.java") is developed using HAL platform(https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1007635) and can be used to simulate the model proposed in the articel https://doi.org/10.1016/j.compbiomed.2023.107035. To simulate the model following steps would work.

1. Install HAL(https://github.com/MathOnco/HAL).
2. Make a folder "ResistanceSymmetric" in the directory "C:\HAL-master".
3. Copy all the files in the directory "C:\HAL-master\ResistanceSymmetric".
4. Provide the "input_x1000_t14000.csv" file as input file in line 268.
5. Set the output file name and directory in line 302.
6. Set the parameter values in lines 194-204 and 255-256.
7. Run "ModelGrid.java"


To quantify spatial distribution or sparseness of resistant cells at an instant over the tumor domain, we presented a modified version "Sampled Ripley's K-function (SRKF)" of Rilpey's K-function, applicable to von Neumann neighborhood setting. The function SRKF.m calculates the statistic SRKF following the algorithm presented in [section 2.5.3]([url](https://www.sciencedirect.com/science/article/pii/S0010482523005000#sec2.5.3)) of the article. The sensitivity of SRKF to different spatial distributions is calculated in SRKF_sensitivity.m. Please refer to the "Materials and methods" section of  https://doi.org/10.1016/j.compbiomed.2023.107035 for technical details. 
