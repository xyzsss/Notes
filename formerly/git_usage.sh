## This file Updating at time: 2015-9-8

===Graph Analysis===
█████Remote reponsitory█████
┆       ┆       ↑
┆       ┆fetch  ┆push
┆pull   ↓       ┆
■─-- → ████Local reposity████
┆   ┆           ↑commit
┆   ┆   ███ index(cache)███
┆   ┆checkout   ↑add
↓   ↓   HEAD        ┆
█████Working directory █████

#Part 1
#How to configure my github , connect it,then donwload code of mine the update it to github.
#show the config

# git config details
git config  --list
git config --global --edit
git config  --global user.name 'exuxu'
git config  --global user.email 'exuxu50@gmail.com'
git config --global merge.tool vimdiff 
git config --system core.editor <editor>
git config  --global alias.<alias-name> <git-command>

#Ahth github configuration
ssh-keygen -t rsa -C "exuxu50@gmail.com"
cat .ssh/id_rsa.pub (Add it to github/setting/SSH keys)
ssh git@github.com

cd github
git init 
git init <directory>        #Create new folder and new ".git" directo 
git clone https://github.com/exuxu/exuxu.github.io.git
git clone <repo> <directory>

vi 404.md 
git add 404.md 
git commit -a -m 'mod some wor	ds'
git push  origin master 	(with input account and pass)

#more git
git revert
git reset
git clean
git stash   #back to last commit status 

#git saving changes
git add <file>
git add <directory>
git add *

git commit                                          (will launch a text editor)
git commit -m "<message>"
git commit -am  "<message>"                         (working space all changes)

# git status && git log
git status

git log
git log --oneline                                   (every log content for one line)
git log --stat                                      (git file change status)
git log -p                                          (git change details)
git log -n <limit>
git log --graph
git log --graph --decorate --oneline                (git log colors)
"git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset'\'' --abbrev-commit --date=relative"

#Git sync
git remote
git remote -v
git remote add <name> <url>
git remote rm/remove  <name>
git remote rename <old-name> <new-name>

git fetch <remote>
git fetch <remote> <branch>

git pull <remote>
git push <remote> <branch>
git push <remote> --force
git push <remote> --all
git push <remote> --tags

#Git branch 
git branch -a               #view all branches
git branch -d <branch>
git branch -D <branch>      #borce delete
git branch -m <branch>      #branch rename

#if on master of branch
git push -u origin master
#if on branch_name of branch
git push -u origin branch_name 

#Part 2
#How to download github codes,   modify and merge it.
    #mkdir to keep code
mkdir tmp 
    #change dir to codes
cd tmp 
    #init git local warehouse
git init 
    #add remote warehouse ,origin can be changed and be second remote git hub.
git remote add origin https://github.com/exuxu/orenviro.git 
	#show remote origin
git remote show origin
	#remove remote git origin
git remote rm origin
    #download remote code
git pull origin master
    #local operate
    #after modify or add file(if delete ,may use "git rm file_name")
git add *
    #commit before push code
git commit -am 'commit first'
    #update to remote 
git push -u origin master
    #then,back to github page to merge  the updates

#Part 3 
Github push ways
1.use https(with username and passwords)
    git remote add origin https://github.com/exuxu/orenviro.git 
    //after commit
    git push -u origin master

2.use git(with configured github ssh-keygen before,without username and passwords)
    # a github project https and git will be:
    #    https://github.com/<Username>/<Project>.git
    #    git@github.com:<Username>/<Project>.git
    # so,change push ways with the origin first.
    git remote set-url origin git@github.com:<Username>/<Project>.git
    git push -u origin master

3.Update git branch ,then psuh to github remote
    git checkout branch_name
    # do something here 
    git add * 
    git commit -am 'say something for your operation'
    git push origin branch_name

4.Remove remote git branch 
    git push origin --delete <branchName>
    git push origin :<branchName>

5.Show difference between git local and remote .
    git diff origin/master -- 

6.Change git comments
    git commit --amend 

7.Git push all branch 
    git fetch origin            #Get all branch
    git push --all origin       #This will push tags and branches.
8.Cancel git merge just now
    git reset --merge
    git merge --abort
    git stash
    git stash pop
#Part 4 
Git Ignore 
     gitconfig file sample: https://gist.github.com/pksunkara/988716

----------eg------------
#ignore python buid file
*.pyc
#ignore python temp file
*.py~
------------------------

Git ignore level setting
    /etc/gitconfig  (system level with all users, --system)
    ~/.gitconfig    (user level, --global)
    */.git/config   (project configuration)
1) Ignore for all users of the repository:
 root of working copy
    git add .gitignore
    git commit -am 'add ignorefile'

2) Ignore for only your copy of the repository:
Add/Edit the file $GIT_DIR/info/exclude (*/.git/info/exclude ) in your working copy

3) Ignore in all situations, on your system:
~/.gitglobalignore
vim ~/.gitconfig
    [core]
        excludesfile = ~/.gitglobalignore