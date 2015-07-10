_mix()
{
  local cur prev opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  if [[ -f ./mix.exs ]] && [[ ! -f /tmp/__elixir_autocomplete_mix_completion_`basename $(pwd)`_ ]]; then
    opts=$(for i in `mix help | grep -ve "current:" | grep -ve "iex" | awk '{ print $2" " }'`; do echo $i; done);
    echo $opts > /tmp/__elixir_autocomplete_mix_completion_`basename $(pwd)`_;
  elif [[ -f ./mix.exs ]]; then
    opts=$(cat /tmp/__elixir_autocomplete_mix_completion_`basename $(pwd)`_);
  elif [[ ! -f ./mix.exs ]] && [[ ! -f /tmp/__elixir_autocomplete_mix_completion__ ]]; then
    opts=$(for i in `mix help | grep -ve "current:" | grep -ve "iex" | awk '{ print $2" " }'`; do echo $i; done);
    echo $opts > /tmp/__elixir_autocomplete_mix_completion__;
  else
    opts=$(cat /tmp/__elixir_autocomplete_mix_completion__);
  fi
  if [[ ${prev} == mix ]] ; then
    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) );
    return 0;
  fi
}

_iex()
{
  local cur prev opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  if [[ ! -f /tmp/__elixir_autocomplete_iex_completion__ ]]; then
    opts=$(for i in `iex --help  2>&1 >/dev/null | grep -e '^ *-' | awk '{ print $1 }'`; do echo $i; done);
    echo $opts > /tmp/__elixir_autocomplete_iex_completion__;
  else
    opts=$(cat /tmp/__elixir_autocomplete_iex_completion__);
  fi
  if [[ ${prev} == iex ]] ; then
    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) );
    return 0;
  fi
}

_elixir()
{
  local cur prev opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  if [[ ! -f /tmp/__elixir_autocomplete_elixir_completion__ ]]; then
    opts=$(for i in `elixir --help  2>&1 >/dev/null | grep -e '^ *-' | awk '{ print $1 }'`; do echo $i; done);
    echo $opts > /tmp/__elixir_autocomplete_elixir_completion__;
  else
    opts=$(cat /tmp/__elixir_autocomplete_elixir_completion__);
  fi
  if [[ ${prev} == elixir ]] ; then
    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) );
    return 0;
  fi
}

complete -F _mix mix
complete -F _elixir elixir
complete -F _iex iex
