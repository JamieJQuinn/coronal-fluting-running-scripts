## Flute instability parameter studies

This is the collection of scripts used to generate parameter studies for my research on the flute instability in coronal loops. The workflow is as follows:

1. Clone repository recursively 

```git clone --recursive```

1a. If the repo is already cloned non-recursively, fetch lare3d manually: 

```git submodule --init --recursive```

2. Create a new param study genertion script or use already existing script
  a. Set output directory
  b. Set parameters to vary/keep constant

3. Run newly created script to generate individual runs (this will copy the version of lare3d many times)

4. Build all newly created copies of lare3d

```./build_param_study.sh results/new_study/*```

5. Submit all runs:

```./submit_param_study.sh results/new_study/*```
- 
