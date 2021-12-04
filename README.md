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

4. Build all newly created copies of lare3d:

```./build_param_study.sh results/new_study/*```

This script must be edited to include machine-specific compilers/makefile options. Currently this loads intel+MPI and compiles with anisotropic viscosity *only if the folder-name contains the string "-switching"*.

5. Submit all runs:

```./submit_param_study.sh results/new_study/*```

Again, this script is custom to the submission environment. It is currently set up to submit to UCL's cluster Myriad.

### Restarting runs

To restart runs from an existing snapshot, edit the variables in `config_restart_param_study.sh` to choose

- restart point
- new dt between snapshots
- new final time

and run

```./config_restart_param_study.sh results/new_study/*```

before building & submitting again (steps 4 and 5 above).
