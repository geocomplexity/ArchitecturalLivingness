# Code

Analysis scripts and notebooks supporting the manuscript
*"Neural Encoding of Architectural Livingness in Human Perceptual Systems"*.

## Scripts

| File | Language | Description |
|------|----------|-------------|
| `livingness_score_reliability.ipynb` | Python | Reliability analysis of the AI-generated livingness scores (intraclass correlation, Cronbach's α). Reported in Methods and Supplementary Material S5. |
| `RSA_analysis.m` | MATLAB | Representational similarity analysis on fMRI beta maps. Reported in Results and Supplementary Material S6. |
| `searchlight_decoding.m` | MATLAB | Multivariate searchlight decoding (linear SVR) of continuous livingness ratings from fMRI activity. Implemented with The Decoding Toolbox (TDT). Reported in Results and Supplementary Material S6. |
| `generate_figures.ipynb` | Python | Generates Figures 2–5 of the manuscript. |

## Pipeline order

The scripts are not strictly sequential — neuroimaging and behavioral analyses
operate on independent data — but a typical reproduction order is:

1. `livingness_score_reliability.ipynb` — verify AI-score reliability (Methods, SI S5)
2. `RSA_analysis.m` and `searchlight_decoding.m` — fMRI analyses (Results, SI S6)
3. `generate_figures.ipynb` — figure generation

## Requirements

### Python
- Python 3.10.11
- Standard scientific stack: `pandas`, `numpy`, `scipy`, `matplotlib`
- See main repository README for full version list

### MATLAB
- MATLAB R2022b or later
- SPM12 (https://www.fil.ion.ucl.ac.uk/spm/)
- The Decoding Toolbox (TDT; https://sites.google.com/site/tdtdecodingtoolbox/)
  for `searchlight_decoding.m`

## Notes

- All file paths in scripts are relative to the repository root.
  Run scripts from the repository root, not from inside the `Code/` folder.
- Notebook outputs have been cleared before commit; rerunning will regenerate them.
- For analyses that depend on neuroimaging data not included in this repository,
  see the main README's Data Availability section.
