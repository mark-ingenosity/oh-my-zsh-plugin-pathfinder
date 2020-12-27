# Path Finder plugin (macOS)

This plugin provides some shortcuts to make life easier whilst working with Path Finder from the command line on macOS.

To start using it, add the `pfinder` plugin to your plugins array in `~/.zshrc`:

```zsh
plugins=(... pfinder)
```

## Commands

| Command  | Description                                                  |
| :------- | :----------------------------------------------------------- |
| `pcd`    | Change the Path Finder directory to the current terminal working directory |
| `cdp`    | Change the terminal working directory to the current Path Finder window or selected folder |
| `pushdp` | Push the terminal working directory to the current Path Finder window or selected folder |
| `ppd`    | Return the path of the current Path Finder window            |
| `psl`    | Return a list of the current Path Finder selections          |
| `psc`    | Copy a single line list of quoted Path Finder selections to the clipboard |
| `lnpt`   | Create symbolic links in Path Finder from files/folders specified on the command line |
| `lnpf`   | Create symbolic links from Path Finder selections at the directory specified on the terminal command line. If no directory is specified, the symlinks will be created in the current working directory. If the specified directory does not exist, it will automatically be created in the current working directory. |
| `thp`    | Toggles viewing hidden files in Path Finder                  |

## Usage

### cdp and pushdp

The `cdp`and `pushdp`commands are all about rapid navigation, providing some enhancements over basic function. In addition to the expected cd/pushd behavior, these commands will additionally navigate to a folder selection in Path Finder if one exists. This behavior is primarily useful whilst navigating folders in `list` or `column` modes in Path Finder by making it unnecessary to have to first dive into the path of interest before executing a cdp or pushdp operation. While in list or column mode, simply make a folder selection in the Path Finder folder hierarchy before executing the command, and whalla, you're there. (One caveat: if more than one folder is selected in Path Finder, the command will only operate on the first folder in the selection. This could lead to some confusion, so make sure that only one folder is selected in Path Finder.)

###### cdp or pushup

1. Open the desired folder in Pathfinder, or make a folder selection in `list` of `column` mode.
2. Execute `cdp` or `pushdp` to change directory to that Path Finder location

### lnpt and lnpf

These commands are effectively mirror opposites. `lnpt` creates symlinks at the active Path Finder location from files/folders specified on the command line and `lnpf` creates symlinks at a  location specified on the command line from selections made in Path Finder.

###### lnpt

1.  Open a folder in Path Finder as the target for the symlinks.
2. Run `lnpt` \<file1\> \<file2\>... to create symlinks at the target in Path Finder from the files/folders specified on the command line.

###### lnpf

1.  Make desired file/folder selections in Path Finder.
2. Run `lnpf` \<dir\> to create symlinks from selections made in Path Finder at the \<dir\> specified on the command line. If no directory is specified, the symlinks will be created in the current working directory. If the specified directory does not exist, it will automatically be created in the current working directory..

## Acknowledgements

This plugin was inspired by the [osx](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/osx) plugin.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## GitHub

[Path Finder plugin (macOS)](https://github.com/mark-ingenosity/oh-my-zsh-plugin-pathfinder.git)

