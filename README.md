# hmm

Find out what you did today with `hmm`.

It lists all your commits from repositories it finds.
Use it to prepare your daily stand-up or to write job logs.

## Installation

### Using Git

You can clone this repository to any directory and add the command to your `PATH`:

```shell
git clone https://github.com/pmeinhardt/hmm.git ~/.hmm
echo 'export PATH="$PATH:$HOME/.hmm/bin"' >> ~/.bashrc # or ~/.zshrc or …
```

Note that `hmm` depends on [`fd`](https://github.com/sharkdp/fd). You will have to install it separately.

### Using Homebrew

You can use [Homebrew](https://github.com/Homebrew/brew) to install `hmm`.

```shell
brew tap pmeinhardt/tools
brew install --HEAD hmm
```

### Vim plugin

There is a Vim plugin for `hmm`. If you use [vim-plug](https://github.com/junegunn/vim-plug), add this line to your Vim configuration file:

```vim
Plug 'pmeinhardt/hmm'
```

To use the plugin, make sure to also install the `hmm` command itself.

See [doc/hmm.txt](./doc/hmm.txt) or `:help hmm` for details about the plugin.

## Usage

When called without arguments, `hmm` will print the summaries of commits authored by you during the last day.

```shell
hmm
```

If you want to go further back in time, you can use:

```shell
hmm --since '2 days ago'
```

Date parsing is handled by [Git](https://git-scm.com/docs/git-log#_commit_limiting), so you can express dates in all kinds of ways: `yesterday`, `2 days ago`, `8:00 AM CEST`, `January 2019`, `2019-01-01` and [more](https://github.com/git/git/blob/master/date.c).

By default, `hmm` will search for Git repositories up to 3 levels down from your current working directory. If you need logs for other directories, simply pass them as arguments:

```shell
hmm ~/projects/x ~/projects/y
```

You can also increase the maximum search depth:

```shell
hmm --max-depth 4
```

You can combine `hmm` with other tools to incorporate it in your workflow:

```shell
hmm | vim -
hmm | fzf --multi
hmm | ruby -e 'print STDIN.readlines.map(&:strip).join(\"; \")' | pbcopy
hmm | curl --request POST --data @- https://…
```
