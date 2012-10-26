% Effective versioning with git
% Kévin "Chewie" Sztern and Armand "Marman" Leclercq

# A brief (non exhaustive) history of versioning

## In the beginning...

### cpold
* A really simple syntax
* A really simple concept
* Really simple to put into action
    * `cp myFile.c myFile.c.old`
    * `cp myFile.c myFile.c.OLD`
* Really simple to improve
    * `cp myFile.c myFile.c.2012-10-..`
    * `tar cvjf project.old *.c`

### diff and patch
* An improvment from `cpold` method
* Create a patch from the difference between the old and the new file.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff oldFile newFile > file.patch
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


* Apply it when given directly from a collaborator

~~~~~~~~~~~~~~~~~~~~~~~~~~~
patch oldFile -i file.patch
~~~~~~~~~~~~~~~~~~~~~~~~~~~

### SCCS and RCS

* First tools to keep track of different versions of your code.
* Store versions as deltas of previous versions
* Local only tool, all work must be on the same computer
* Essentially wrappers around diff (not really, but you get my point)

## Then : centralized versioning

### cvs

* Versionning tool written in 1986
* Originally built on RCS: Store tracked files as RCS files
* Client/server approach
* A single shared repository
* Clients work on the latest revision

### svn

* Improvement of cvs released in 2000
* Originally stored files in a Berkeley DB, now in FSFS
* Atomic commits
* Support for renaming/moving tracked files
* Was king for a long time

## Now : distributed versioning

### git

### a word on mercurial

# Using git

## The git philosophy

### Plumbing and porcelain

### Three phase commits : the staging area

## The basics

### Creating a repository

### Adding files to the repository

### Viewing the history

## Working with other people

### Remote repositories

### Cloning

### Pulling

### Pushing

### Resolving conflicts

### Tagging a commit

## Branches

### Branches are cheap

### Creating and switching to branches

### Tracking branches

### Merging branches

### Deleting branches
