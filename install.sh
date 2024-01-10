#!/usr/bin/env bash
if ! command -v emacs &> /dev/null; then
    echo "could not find an installation of emacs!"
    exit 1
else
    #> should check version?
    :
fi

if [[ -d "$HOME/.emacs.d" ]]; then
    if ! [[ -f $HOME/.emacs.d/bin/doom ]]; then
        #> not a doom installation => backup
        echo "backing up ~/.emacs.d to ~/.emacs.d.bak ..."
        mv $HOME/.emacs.d $HOME/.emacs.d.bak
    fi
fi

if ! [[ -f "$HOME/.emacs.d/bin/doom" ]]; then
    git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
    ~/.emacs.d/bin/doom install
    if [[ -d "$HOME/bin" ]]; then
        ln -s $HOME/.emacs.d/bin/doom doom
    else
        echo "no $HOME/bin folder: did not create a symbolic link to 'doom'"
    fi
fi

if [[ -d "$HOME/.doom.d" ]]; then
    echo "found existing doom confiuration at '$HOME/.doom.d'"
    read -r -p "backup & proceed? [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY])
            mv $HOME/.doom.d $HOME/.doom.d.bak
            # rm -rf $HOME/.doom.d
            ;;
        *)
            exit 0
            ;;
    esac
fi

mkdir $HOME/.doom.d
for cfg in config.el custom.el init.el packages.el; do
    ln -s ${cfg} $HOME/.doom.d/${cfg}
done
