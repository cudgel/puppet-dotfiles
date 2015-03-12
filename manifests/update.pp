define dotfiles::update(
  $gituser,
  $homedir,
  $cwd,
  $single_pull,
  $rebase,
  $frequency,
  ) {

  if $rebase == true {
    $update_cmd = 'git pull --rebase'
  } else {
    $update_cmd = 'git pull'
  }

  if (!$single_pull) {
    exec { "update ${gituser} dotfiles for ${title}":
      cwd     => $cwd,
      path    => '/usr/bin:/bin',
      command => $update_cmd,
      onlyif  => "[ ! -f .git/FETCH_HEAD ] || [ \"$(( ( $(date +%s) - $(stat -c \"%Y\" .git/FETCH_HEAD) ) / 60 ))\" -ge \"${frequency}\" ]",
      user    => $title,
      require => Package['git'],
    }
  }

}
