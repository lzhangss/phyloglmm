### testing phylog in lme4-verse

### Hooks 
current: target
-include target.mk


##################################################################

# make files and directories

Sources = Makefile .gitignore README.md sub.mk LICENSE.md 
include sub.mk
# include $(ms)/perl.def

# ms.tex
# main.tex
# notes.md
# todo.md
# journal.md

ms.pdf: main.tex phyloglmm_ms.tex
	pdflatex phyloglmm_ms


Makefile:

### debug Morgan's example

debug.Rout: phyloglmm_setup.Rout ./debug_examp/worked_example_phylolmm.rds ./debug_examp/worked_example_phylolmm.R
	$(run-R)


#2, parameters.R
#3, phyloglmm_setup.R

##################################################################

Sources += $(wildcard *.R)

######################################################################

### simulate phylogenetic tree


#parameters.Rout:

phyloglmm_setup.Rout:

simulate_tree.Rout: names.R parameters.R simulate_tree.R
	$(run-R)

simulate_poistree.Rout: parameters.R simulate_poistree.R
	$(run-R)

fit.pois.Rout: simulate_poistree.Rout phyloglmm_setup.R new_phylo_setup.R phyloglmm_pois.R
	$(run-R)

######################################################################


### Single site 

fit.gls.%.Rout: names.R parameters.R simulate_tree.R fit_gls.R
	$(run-R)

fit.gls.large.1.Rout:

### phylolm

fit.phylolm.%.Rout: names.R parameters.R simulate_tree.R fit_phylolm.R
	$(run-R)

fit.phylolm.large.1.Rout:


### lme4 can fit single and multiple sites

fit.lme4.%.Rout: names.R parameters.R simulate_tree.R new_phylo_setup.R phyloglmm.R
	$(run-R)

fit.lme4.large.1.Rout: phyloglmm.R

### pez can only fit multiple sites

fit.pez.%.Rout: names.R parameters.R simulate_tree.R fit_pez.R
	$(run-R)

fit.pez.large.1.Rout:

### Multiple sites compound symmetric case

fit_cs.lme4.%.Rout: names.R parameters.R simulate_tree.R phyloglmm_setup.Rout fit_cs_lme4.R
	$(run-R)

fit_cs.pez.%.Rout: names.R parameters.R simulate_tree.R phyloglmm_setup.Rout fit_cs_pez.R
	$(run-R)

### Collect and plot results

collect.Rout: collect.R
	$(run-R)

plot.Rout: plot.R
	$(run-R)

ssplot.Rout: ssplot.R
	$(run-R)

msplot.Rout: msplot.R
	$(run-R)

csplot.Rout: csplot.R
	$(run-R)

### fitting poisson (NEED TO FIX)

fit_poisson.Rout: parameters.R simulate_poistree.Rout phyloglmm_setup.R phyloglmm_pois.R
	$(run-R)


### Fitting using other platforms (NEED TO FIX/CLEAN)

fit_MCMCglmm.Rout: parameters.Rout simulate_tree.Rout fit_MCMCglmm.R
	$(run-R)

fit_glmmPQL.Rout: parameters.Rout simulate_tree.Rout fit_glmmPQL.R
	$(run-R)


fit_tmb.Rout: parameters.R simulate_tree.Rout phyloglmm_setup.R tmb_setup.R fit_tmb.R
	$(run-R)


#### Li et al 2017 examples

read_data.Rout: hacked_code/data_clean/dune_traits_Z.txt hacked_code/0_pkg_func.R hacked_code/1-data.R
	$(run-R)

phylosig.Rout: read_data.Rout hacked_code/3-phylosig.R
	$(run-R)

forward_selection.Rout: phylosig.Rout get_RE.R hacked_code/0_pkg_func.R hacked_code/2-forward_selection_fixed_first.R
	$(run-R)

analyses.Rout: forward_selection.Rout hacked_code/4-analyses.R
	$(run-R)


### fitting dune's example using lme4

dune_lme4.Rout: phylosig.Rout get_RE.R hacked_code/0_pkg_func.R new_phylo_setup.R hacked_nested.R dune_lme4.R
	$(run-R)

compare_pez.Rout: phylosig.Rout get_RE.R hacked_code/0_pkg_func.R phyloglmm_setup.R hacked_nested.R compare_pez.R
	$(run-R)

compare_pez_lme4.Rout: phylosig.Rout get_RE.R hacked_code/0_pkg_func.R phyloglmm_setup.R hacked_nested.R compare_pez_lme4.R
	$(run-R)


### Makestuff

clean:
	rm .*.RData *.Rout *.wrapR.r *.Rlog *.wrapR.rout

## Change this name to download a new version of the makestuff directory
# Makefile: start.makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk
-include $(ms)/pandoc.mk

-include $(ms)/wrapR.mk
-include $(ms)/flextex.mk


