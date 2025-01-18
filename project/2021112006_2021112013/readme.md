# End of Phrase Detection Project

## Project Overview

This project focuses on detecting the end of phrases in Telugu audio files using prosogram analysis. The prosogram is derived from the quantized pitch contour, and the goal is to identify trends that correlate with punctuation marks.

## Project Highlights

- **Challenges:**
  - Variability in prosogram within words posed a challenge.
  - Initial attempt using silence regions was discarded due to potential errors in noisy environments.

- **Data Annotation:**
  - Telugu audio files from PM Modi’s Man ki Baat were manually annotated for punctuation marks.

- **Approaches:**
  1. **Prosogram Analysis:** Extracting features directly from the prosogram, requiring annotated data.
  2. **Adding Vowel Onset Point (VOP) Detection:** Using a VOP detection algorithm with pitch and vowel occurrence constraints.
    - **VOP Detection Algorithm:**
        - Utilized modulation spectrum procedure from the reference paper “Vowel Onset Point Detection for Low Bit Rate Coded Speech.”
        - VOP points are extracted using "VOP_modulation.m" and stored in "csv_files_VOPs" folder.

  3. **Machine Learning Model:**
    - Random Forest regressor was employed to predict punctuation marks.
    - Cross-validation performed due to limited data, achieving around 65% accuracy.
    - Identified key features: prev_sample duration gap and prev_pitch slope.

## Code Structure

1. **Download Data:**
   - Download audio files from this [link](https://iiitaphyd-my.sharepoint.com/:u:/g/personal/srihari_bandarupalli_research_iiit_ac_in/ESfSN50M76xCgWiB2H9l1QMBth4c3DxeOJTi0f-olzQvdw?e=LA6dPe) and store them in `./code/wav_files/`.

2. **Prosogram Generation:**
   - `prosogram.ipynb` generates the prosogram using praat and quantizes pitch values.

3. **Pre-processing:**
   - Run `0_pre_process.ipynb` to obtain manually annotated timestamps for punctuation marks.
   - **Dataset Creation:** Generates `dataset.csv` with quantized pitch values, punctuation labels, and various features.
    
5. **Analysis:**
   - Run `1_analyse.ipynb` to visualize the impact of each feature on punctuation.

6. **Machine Learning Model:**
   - Build and analyze a Random Forest classifier using `2_ML_model.ipynb`.

## Further Plans

1. **Feature Expansion:** Explore additional features for better predictions.

2. **Dataset Expansion:** Aim to build a larger dataset for improved model training.

## References

- Tanmai Khanna, Ganesh Mirishkar, Dipti M. Sharma, Anil K. Vuppala. Exploring the role of pitch in predicting clause and sentence boundaries. R & D Showcase 2020.

## Contributors

- Srihari Bandarupalli
    - srihari.bandarupalli@research.iiit.ac.in
    - 2021112006
- Jalluri Ram Gopal
    - jalluri.gopal@students.iiit.ac.in
    - 2021102013

