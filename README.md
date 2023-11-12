# signal_flowcytometry_analysis

A program for detecting cells based on fluorescent tagging from custom portable flow cytometry platform. 

# General info

This project is developed for immunofluorescence detection of rare blood typing using the portable flow cytometry. It includes signal processing for quantifying the signal from cells 
and the visualization of assay development comparison between standard agglutination, commercial flow cytometry, and custom flow cytometry.

# Technologies
This project created with:

1. Python version >=3.6 for visualization
2. MATLAB 2017a with signal processing tool box.

# Run
Installation the program under MATLAB environment.

# Signal processing work chart
<img width="747" alt="Screenshot 2023-11-12 at 6 57 28 pm" src="https://github.com/aradahir/signal_flowcytometry_analysis/assets/53826717/d7885f45-3a65-4b73-a5a8-f66f87afe70e">

The assay developed for multi-channel single cell analysis, Therefore, the algorithm consists of single cell event detection and multi-channel overlapping. Both requires the implement of digital filtering on the slices of windowing through signal to remove possible noise. Single cells were identified by the singlet cells that have only one peak on the
50 percent area of peak threshold. Picture belowed indicates the single event characterisitics.

<img width="755" alt="Screenshot 2023-11-12 at 6 57 43 pm" src="https://github.com/aradahir/signal_flowcytometry_analysis/assets/53826717/3b869659-14c8-4570-9197-74326e3e6696">

Multi-channel single cells were called when the assay performed with multiple blood typing. We experimentally used Red, Blue, and Green fluorescence for each antibody tagging. The selected fluorophores were adjust for minimize spill overs phenomenin. Since there is the time lagging between laser, we identified single-cells by the overlapping signal between channels.

<img width="753" alt="Screenshot 2023-11-12 at 6 57 51 pm" src="https://github.com/aradahir/signal_flowcytometry_analysis/assets/53826717/73e9dcbe-d7e4-4d30-ba20-e65468c84c8e">

 # Performance

 The performance were tested using ROC compared to commertial flow cytometry platforms. AUC score shows potential successfully detection at 0.95. The cell population mean fluorescent intensity look similar with a little bit different in individual values.

 <img width="615" alt="Screenshot 2023-11-12 at 6 58 41 pm" src="https://github.com/aradahir/signal_flowcytometry_analysis/assets/53826717/4b328a6c-4a1c-4d14-a635-6d9b8e949950">

# Example results

<img width="225" alt="Screenshot 2023-11-12 at 6 58 49 pm" src="https://github.com/aradahir/signal_flowcytometry_analysis/assets/53826717/9c9fb669-7415-46dd-8f13-a5b037f20879">

# Warning

Before running the experiment, it is still required to test the calibration beads to ensure there is clear microfluidic channels. In algorithm side, the bead calibration will be fitted with Guassian mixture model clustering for identifying seperation between bead intensities.

# Acknowledgement

This project is done under the funded from Thailand Science Research and Innovation funding.
