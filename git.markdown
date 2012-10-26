% Effective versioning with git
% Kévin "Chewie" Sztern and Armand "Marman" Leclercq

# Why use versioning?

## To keep track of the changes in your code

### What I want

* What was the code like in the previous release?
* When did it work for the last time?
* When was that file changed?
* Let's work on a new feature!
* (3 hours later...)
* It's actually crap, scratch that.

## To share your code with others

### What I also want

* Let's work together on a feature!
* A friend just made a change, I want to integrate it.
* Hey world, here is my project!
* Someone wants to contribute to my project! :D
* Who coded that pile of cr\*p?

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

* Written by Linus Torvalds and released in 2005
* Peer to peer approach
* Each client has a repository in its own right
* Can pull and push from/to any other client
* Commiting and sharing are two separate processes

### a word on mercurial

* Released around the same time as git (12 days later!)
* Overall quite similar and as powerful as git
* We won't discuss it, but know that it exists

# Using git

## The git philosophy

### Plumbing and porcelain

* Git provides two sets of commands
* (Ugly) commands that operate on the internals of your repository: the plumbing
* (User friendly) commands using the plumbing: the porcelain
* Don't bother with plumbing unless you're a plumber.

### Three phase commits : the staging area

#### With other VCS

For most VCS, tracked data live in two places: the current working directory,
and what has been committed (the datastore). Committing means adding to the
datastore everything from the working directory that differs from the previous
datastore (Newly tracked data, modified data).

#### With git

For git, there is a third step inbetween: the staging area. A tracked file
being modified will not be commited unless you explicitly stage it. While this
may appear bothersome, it allows for finer granularity and atomic commits.

### Commit early, commit often

#### Rationale

Since git is distributed, a commit stays local until you push it. That means
you don't risk ruining other people's work with a temporary commit.

#### Commits as checkpoints

Commit each time you reach a "checkpoint" in your code, when you want to be
able to return to that state in a future time. When a feature is complete and
you want to share it, push all the commits you made locally.

## The basics

### Creating a repository

~~~
$ mkdir myproject
$ cd myproject
$ git init
Initialized empty Git repository in myproject/.git/
$ ls -a
. .. .git
$ # Start working...
~~~

### Adding files to the repository

~~~
$ vim main.c # Let's create main.c
$ git add main.c # File is untracked, we need to add it
$ git commit -m "Added main.c"
$ vim main.c # We modify main.c
$ git add main.c # We still need to stage it
$ git commit -m "Updated main.c"
~~~

### Checking the state of the three phases

~~~
$ git status # You don't need much else
~~~

I suggest adding the following to your .gitconfig:

~~~
[color]
    ui = true
[pager]
    status = false
~~~

### Viewing the history

~~~
$ git log # View commit history
$ git shortlog -ns # Count number of commits by author
~~~

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
