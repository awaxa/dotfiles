# dotfiles - [github:awaxa/dotfiles](git://github.com/awaxa/dotfiles.git "git://github.com/awaxa/dotfiles.git")
---
### my dotfiles, including:
* [the **king** of dotfiles install/update scripts](https://github.com/awaxa/dotfiles/blob/master/bin/dotfiles.sh "https://github.com/awaxa/dotfiles/blob/master/bin/dotfiles.sh")
  * [raw:dotfiles.sh](https://raw.github.com/awaxa/dotfiles/master/bin/dotfiles.sh "https://raw.github.com/awaxa/dotfiles/master/bin/dotfiles.sh") auto install/update script
  * **THIS COMMAND WON'T PROMPT YOU BEFORE MODIFYING DOTFILES IN $HOME**
  
  ```shell
  curl https://raw.github.com/awaxa/dotfiles/master/bin/dotfiles.sh | bash
  ```
  
  * but this would:
  
  ```shell
  curl https://raw.github.com/awaxa/dotfiles/master/bin/dotfiles.sh > /tmp/dotfiles.sh
  chmod +x /tmp/dotfiles.sh
  /tmp/dotfiles.sh
  ```
    
  * tested on Debian stable/squeeze, Raspbian, and OS X 10.8.2

* distribution specific branches
* ***bonus surprise*** instances of unnecessarily Debian specific stuff interspersed in [branch:master](https://github.com/awaxa/dotfiles/tree/master "github:awaxa/dotfiles/tree/master") rather than [branch:debian](https://github.com/awaxa/dotfiles/tree/debian "github:awaxa/dotfiles/tree/debian") that has no effect on non-Debian systems as far as I've noticed
