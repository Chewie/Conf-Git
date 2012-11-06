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

* You can have as many remotes as you like!
* By default, the remote you cloned from is called `origin`
* One super command: `git remote`

~~~
$ git remote # Show my remotes
github
bitbucket
$ git remote add acu <url> # Add a new remote
$ git remote rename acu ACU # Change remote name
$ git remote rm bitbucket # Remove a remote
~~~

### Cloning

Cloning is a shortcut for the following actions:

* Initiliaze an empty git repository
* Create a remote called origin from the cloned repo
* Create remote tracking branches for each branch in origin
* Checkout an initial branch forked from the active branch in origin

### Pulling

* Incorporate commits from a remote into the current branch
* Syntax: `git pull [options] [remote] [refspec]`
* Refspec can be a remote branch
* For now, juste remember the remote argument

### Pushing

* Update commits from your repo to a remote
* Syntax is complicated, just remember this:
* `git push [remote [branch]]`

### Resolving conflicts

* Don't fear the conflicts! (you can take my hand...)
* Conflicts happen when a file has been modified by two people at the same time
* Git modifies each file with a conflict to show both versions
* Just edit the files then add them with `git add`
* Resolve the conflict with `git commit`
* That's all!

### Tagging a commit

* Git has the ability to mark certains commits as important
* Typically, release versions like `v1.0`
* Two types of tags: lightweight and annotated
* Syntax: `git tag <tagname> [commit] [-m <message>] [fuckload of options]`
* Tags must be pushed explicitly with `git push --tags`

## Branches

### What are branches?

* Branches allow you to split the history of commits
* You can work on a feature without messing up everybody's work
* After your feature is completed, you can merge branches together

~~~
      *----*---*--
     /            \
-------------------*-----*--
             \          /
              *--*---*--
~~~

### Branches are cheap

* Git's branching model is its killer feature
* Before git, branching was a big deal
* With git, a common workflow involves several merges per day

### Creating and switching to branches

~~~
$ git branch feature1
$ git checkout feature1
Switched to branch 'feature1'
$ # Remember this shortcut:
$ git checkout -b feature2
Switched to a new branch 'feature2'
~~~

### Tracking branches

* A remote branch can be synchronized to a local branch
* When on a tracking branch, `git push` and `git pull` work without arguments
* A branch created from a remote branch is tracking by default
* When creating a remote branch from a local branch, you need to track
  explicitly

~~~
$ git checkout feature1 # We have a local branch feature1
Switched to branch 'feature1'
$ git push -u origin feature1
[...]
To origin
 * [new branch]      feature1 -> feature1
 Branch feature1 set up to track remote branch feature1 from origin.
~~~

### Merging branches

~~~
$ git checkout master # We merge *into* master
$ git merge feature1
$ # If no conflict, great! Else, go resolve them!
~~~

### Deleting branches

* `git branch -d` will only delete a branch if the branch you're deleting from
  is already past it, e.g. you already merged it
* `git branch -D` if you want to delete and discard everything from a branch

## Conclusion

### What you've learned

* As always, don't just learn the syntax, try to understand the meaning
* `git help` is your friend

### Ressources

* http://gitimmersion.com/
* http://git-scm.com/book
* http://gitref.org/
