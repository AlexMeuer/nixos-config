{ pkgs, inputs, ... }: {
  # https://nixos.wiki/wiki/Fish
  programs.bash = {
  interactiveShellInit = ''if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]; then
  shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
  exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
fi'';
  };
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "grc";
	src = pkgs.fishPlugins.grc.src;
      }
      {
        name = "colored-man-pages";
	src = pkgs.fishPlugins.colored-man-pages.src;
      }
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
          sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
        };
      }
    ];
    functions = {
      fish_greeting = ''echo "Let's fish!" | ${pkgs.lolcat}/bin/lolcat'';
      fish_prompt = ''set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

    if not set -q __fish_git_prompt_show_informative_status
        set -g __fish_git_prompt_show_informative_status 1
    end
    if not set -q __fish_git_prompt_hide_untrackedfiles
        set -g __fish_git_prompt_hide_untrackedfiles 1
    end
    if not set -q __fish_git_prompt_color_branch
        set -g __fish_git_prompt_color_branch magenta --bold
    end
    if not set -q __fish_git_prompt_showupstream
        set -g __fish_git_prompt_showupstream informative
    end
    if not set -q __fish_git_prompt_color_dirtystate
        set -g __fish_git_prompt_color_dirtystate blue
    end
    if not set -q __fish_git_prompt_color_stagedstate
        set -g __fish_git_prompt_color_stagedstate yellow
    end
    if not set -q __fish_git_prompt_color_invalidstate
        set -g __fish_git_prompt_color_invalidstate red
    end
    if not set -q __fish_git_prompt_color_untrackedfiles
        set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
    end
    if not set -q __fish_git_prompt_color_cleanstate
        set -g __fish_git_prompt_color_cleanstate green --bold
    end

    set -l color_cwd
    set -l suffix
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        else
            set color_cwd $fish_color_cwd
        end
        set suffix '#'
    else
        set color_cwd $fish_color_cwd
        set suffix '$'
    end

    # PWD
    set_color $color_cwd
    echo -n (prompt_pwd)
    set_color normal

    printf '%s ' (fish_vcs_prompt)

    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color --bold $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)
    echo -n $prompt_status
    set_color normal

    set -l nix_shell_info (
      if test -n "$IN_NIX_SHELL"
        set_color cyan
        echo -n "<nix-shell> "
	set_color normal
      end
    )

    echo -n "$suffix "'';
    };
  };
}
