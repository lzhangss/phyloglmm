### testing phylog in lme4-verse

### Hooks 
current: target
-include target.mk


##################################################################

# make files and directories

Sources = Makefile .gitignore README.md sub.mk LICENSE.md 
include sub.mk
# include $(ms)/perl.def

Makefile:

##################################################################

Sources += $(wildcard *.R)

######################################################################

### simulate phylogenetic tree

simulate_tree.Rout: parameters.R simulate_tree.R
	$(run-R)

simulate_poistree.Rout: parameters.R simulate_poistree.R
	$(run-R)

fit_poisson.Rout: parameters.R simulate_poistree.Rout phyloglmm_setup.R phyloglmm_pois.R
	$(run-R)

### Fitting

fit_pez.Rout: parameters.R simulate_tree.Rout fit_pez.R
	$(run-R)

fit_lme4.Rout: parameters.R simulate_tree.Rout phyloglmm_setup.R phyloglmm.R
	$(run-R)

lme4_simtest.Rout: parameters.R phyloglmm_setup.R lme4_simtest.R
	$(run-R)

fit_MCMCglmm.Rout: parameters.R simulate_tree.Rout fit_MCMCglmm.R
	$(run-R)

fit_glmmPQL.Rout: parameters.R simulate_tree.Rout fit_glmmPQL.R
	$(run-R)

fit_gls.Rout: parameters.R simulate_tree.Rout fit_gls.R
	$(run-R)

fit_tmb.Rout: parameters.R simulate_tree.Rout phyloglmm_setup.R tmb_setup.R fit_tmb.R
	$(run-R)


#### Li et al 2017 examples

read_data.Rout: hacked_code/data_clean/dune_traits_Z.txt hacked_code/0_pkg_func.R hacked_code/1-data.R
	$(run-R)

phylosig.Rout: read_data.Rout hacked_code/3-phylosig.R
	$(run-R)

forward_selection.Rout: phylosig.Rout hacked_code/0_pkg_func.R hacked_code/2-forward_selection_fixed_first.R
	$(run-R)

### Makestuff



## Change this name to download a new version of the makestuff directory
# Makefile: start.makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk
-include $(ms)/pandoc.mk

-include $(ms)/wrapR.mk
-include $(ms)/flextex.mk


