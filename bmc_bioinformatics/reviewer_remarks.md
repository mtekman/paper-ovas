# Main points

## Editor
 * Comparison of new existing tools.
 
## Rev1
 * Move software into supplemental
 * Set up a webserver
 * More than one case study, and a study showing how inheritance filter is applied


## Rev2
 * Explain what novel features are compared to existing
 * Explain that large data over the internet is hard, slow transfer speeds, genomewide, streamlined
 * Explain how public domain databases are used
 * 90% TN filtered out discarded on what measure?
 * Explain the functional meaning of each module
 * Explain how the web-interface abstracts the user, a local web server.
 * Justify not using docker, snakemake, cite Leipzig
 * "conservative" -> "relaxed", words.

****

# Specific points

> Editor Comments:
> There are a number of concerns regarding your manuscript and contribution to the field. If you choose to resubmit your work, please ensure that you include a full comparison against existing tools (the most often used and the newest tools), and please emphasise the contribution of your work. 

A wider comparison of existing tools can now be found in the Discussion (pageX, columnX).


## Reviewer reports
>Reviewer 1: Overview
>
>This paper described a new variant analysis tool. It consists of the basic components of variant analysis pipeline, including annotation/mapping and filtering. Recent advances in genome sequencing technologies have led to a thriving development of analysis tools. Hundreds of variant analysis tools are available from previous researches. This tool (OVAS) identifies a subset of variants of interests under an inheritance context. From the aspect of implementation, it emphasizes on transparent methods and in-situ service.
>
>Detailed Comments
>
>This is a research paper, which should focus on the methods and experiments, but [the author described the software and web interface in too much details]. For example, section 0.1 could move to the supplementary file or the README file for the software.

The Implementation section has now been reduced to emphasize only that pipeline can be initiated via web browser or commandline (page 2, column 2). Section 0.1 "Pipeline Modules" has also been significantly shortened to provide a more concise overview of what OVAS can provide. More detailed implementation remarks has been moved to the README.md within the main software repository, and pipeline module specifics have been moved to MANUAL.md provided in the software repository as well as supplementary data.

> The author made good arguments about cloud-based services. But I suggest the author to build a web service as well to benefit users by accessing the internet, as the majority of users will have access to the internet. A simple scenario is that the user wants to test their data by typing some parameters in the web browser before actually using it, and doesn't want to go through the complicated installation process on their local computer.

Hosting OVAS as a global web server is readily achievable (see the main software repository for deployment specifics), but undermines the overall ethos of the pipeline as a secure standalone bootable environment. 

> In the results section, the author showed one example about HIPKD, and didn't put much discussion on the trait-penetrance modeling as it highlighting in the title. It would be more convincing to show more examples to support the conclusion.

[Talk to Robert about more data]

> Reviewer 2: Summary
> Mozere et al. present an open-source variant analysis suite called OVAS. From the description it is not clear to me what the novel features and contributions of this analysis suite compared to the plethora of existing ones is here. The main contribution seems to be that this suite is a standalone pipeline and is operatable offline compared to cloud-based tools. This, however, is achieved via a complete, bootable system distribution, or - alternatively - via extensive system requirements. The authors say that this "can provide a safer and more accessible environment […] especially in circumstances where continuous internet usage is limited". This might be true for less extensive data where one does not need a cloud or larger servers. Still, I do not see the benefit compared to existing non-cloud-based pipelines.

The discussion has been altered to cite a recent review highlighting the difficulties of running genomic analyses in Africa. A comparison of non-cloud based pipelines has also been included in the section following.

> Major comments
> [Content/contribution]
> Although the authors are very detailed in the description of their implementation, they are not precise in the functional description of their tool. For example, p.2 the authors say "OVAS is rooted firmly in trusted public domain databases such as RefGene, dbSNP, UniProt […] UCSC Genome Browser." Do the authors use these databases within their pipeline? Do they use the same algorithms? 

The implementation section has now been altered to better clarify that OVAS pulls and utilizes data from public domain databases via UCSC Genome Browser's MySQL database portal. The algorithms used by UCSC to maintain their database, or to perform their own annotation/analyses are not used by OVAS, which relies only upon the data content which it stores locally as a compressed plain-text file to be used later by its own algorithms to annotate VCF files.

> Why do we need their tool, if there is a "beneficial accordance"?

UCSC actively curates and collates data from upstream databases, maintaining an excellent repository of data consolidated in a single extremely accessible database. However, their variant annotation software is not yet fully-developed; for example, though their annotator is able to take VCF files as input, it does not maintain the format with the resulting output, and gene isoforms bisecting the same variant are printed on adjacent lines. This is expanded in section <blah>.

> Another example, on p.4 "The annotation stages of the pipeline then prime the variants with relevant metadata […]". What metadata, i.e. is it user provided or is it a certain database? Especially since the authors then say that "the annotation stage is the only mandatory stage, and a great portion of filtering occurs at these stages too, with up to 90% of true negatives being discarded." Based on what are up to 90% TN discarded? Overall, I am not able to determine the functional meaning of the modules and hence, the contribution of the tool to the user. 

VCF files make use of extensive headers that describe the main data within the file. The format is versatile enough to allow these headers allude to anything from genome build, to copy number variation definitions, to external format identifiers. OVAS happens to use custom format identifiers to declare annotations for gene/isoform names, variant type, bisecting exon/intron number, and much more. The decleration of these format identifiers are paramount to downstream modules which is why VCF files must be initially primed as such.

> [Comparison to other tools]
> Unfortunately, a comparison to other tools is completely missing. Since there are existing tools/pipelines (205 according to Pabinger et al.), I would expect a comparison, even if they are cloud based? Without this, the contribution of the tool to the large community is not assessable. 

The comparison section covers cloud-based tools only if their methods are transparent. A wider range of non cloud-based tools are compared in terms of the four main key deliverables that OVAS offers: transparency, security, deployability, and inheritance modelling.

> [Usability/Dependencies/Software]
> The usability of the tool is also questionable:
> The authors say that their tool is a standalone/offline pipeline but then write "Users can upload their data either through the web-interface or by manual file placement […]". This sentence is irritating since it implies that I would really upload data to some server through the internet. Since I have to place my data "somewhere" in my system to be able to "upload" it, I can just directly place it. I do not understand the meaning behind this or of what use this would be. 

Agreed, this has now been better clarified -  OVAS runs as a local web server in a live environment, giving the impression of familiar upload/download dialogs whilst data is only shifted from folder to folder in the background and does not leave the environment in any concievable way.

> The authors use "a series of inter-connecting Bash shell scripts which serve as necessary framework to accommodate wrapper […]".  There is a reason why sophisticated frameworks such as Snakemake have been developed (I recommend the review by Leipzig - A review of bioinformatics pipeline frameworks): (Bash shell) scripts are often not robust enough when change of computing environment or updated tool/package/bash versions come to mind. I find the use - especially of bash scripts - highly critical in published bioinformatic software.

This is an excellent review, and a few of the suggested frameworks were initially considered but at the time constrained the (then unknown) workflow of the pipeline. A paragraph has been added to section [X] in the discussion on this topic.

> # Specific remarks
> p.2 "Optimistic filtering measures will produce a smaller set with the drawback of missing key causative variants, and conservative filtering measures will produce too many false positives." I believe this should be the other way around, usually being conservative means to be more specific and hence have less false positives. There are many words that do not make sense or do not fit the context, e.g. p.3 "groundwork, "programmatically", "overridden".

The initial remark on P2 has been appropriately switched, the remarks of P3 have been removed as that section has been re-written to be more concise.



TODO:
 X- Squash pipeline modules
 X   -> move detailed data to manual or README
 X - Fix specific remarks
 X - Defend offline standalone -- cite africa
 X - Defend Arch over docker
   - Compare with other pipelines
