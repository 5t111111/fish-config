function fish_prompt
  set -l last_command_status $status
  set -l cwd (prompt_pwd)

  # set -l fish     "⋊>"
  set -l ahead    "↑"
  set -l behind   "↓"
  set -l diverged "⥄"
  set -l dirty    "⨯"
  set -l none     "◦"

  set -l normal_color     (set_color normal)
  set -l directory_color  (set_color brown)
  set -l repository_color (set_color green)

  if test $last_command_status -eq 0
    echo -n -s (__random_fish_emoji) $normal_color " "
  else
    echo -n -s 👿 $normal_color " "
  end

  if __git_is_repo
    if test "$theme_short_path" = 'yes'
      set root_folder (command git rev-parse --show-toplevel ^/dev/null)
      set parent_root_folder (dirname $root_folder)
      set cwd (echo $PWD | sed -e "s|$parent_root_folder/||")

      echo -n -s " " $directory_color $cwd $normal_color
    else
      echo -n -s " " $directory_color $cwd $normal_color
    end

    echo -n -s " on " $repository_color (__git_branch_name) $normal_color " "

    if __git_is_touched
      echo -n -s $dirty
    else
      echo -n -s (__git_ahead $ahead $behind $diverged $none)
    end
  else
    echo -n -s " " $directory_color $cwd $normal_color
  end

  echo -n -s " "
end

function __random_fish_emoji
    set -l fish_emojis
    set -l fish_emojis $fish_emojis 🐠
    set -l fish_emojis $fish_emojis 🐟
    set -l fish_emojis $fish_emojis 🐟
    set -l fish_emojis $fish_emojis 🐡
    set -l fish_emojis $fish_emojis 🐬
    set -l fish_emojis $fish_emojis 🐳
    set -l fish_emojis $fish_emojis 🐋
    set -l fish_emojis $fish_emojis 🦀
    set -l fish_emojis $fish_emojis 🐙
    set -l fish_emojis $fish_emojis 🐢

    set -l index (math (math (random)%(count $fish_emojis))+1)
    echo $fish_emojis[$index]
end

function __git_is_repo
    test -d .git; or command git rev-parse --git-dir >/dev/null ^/dev/null
end

function __git_branch_name
    command git symbolic-ref --short HEAD ^/dev/null;
        or command git show-ref --head -s --abbrev | head -n1 ^/dev/null
end

function __git_is_touched
    test -n (echo (command git status --porcelain))
end

function __git_ahead -a ahead behind diverged none
    set -l commit_count (command git rev-list --count --left-right "@{upstream}...HEAD" ^/dev/null)

    switch "$commit_count"
    case ""
      # no upstream
    case "0"\t"0"
      test -n "$none"; and echo "$none"; or echo ""
    case "*"\t"0"
      test -n "$behind"; and echo "$behind"; or echo "-"
    case "0"\t"*"
      test -n "$ahead"; and echo "$ahead"; or echo "+"
    case "*"
      test -n "$diverged"; and echo "$diverged"; or echo "±"
    end
end
