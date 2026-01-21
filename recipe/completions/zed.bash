_zed_completions()
{
    local cur opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"

    opts="
        -w --wait
        -a --add
        -n --new
        --user-data-dir
        -v --version
        --foreground
        --zed
        --dev-server-token
        --system-specs
        --diff
        -h --help
    "

    if [[ "$cur" == -* ]]; then
        COMPREPLY=( $(compgen -W "${opts}" -- "$cur") )
    fi
}

complete -F _zed_completions zed
