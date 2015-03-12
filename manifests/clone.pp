define dotfiles::clone(
    $gituser,
    $homedir,
    $creates,
    $giturl  = 'git://github.com',
    $project = 'dotfiles',
    $branch  = 'master'
  ) {
  exec { "clone ${gituser} dotfiles for ${title}":
    cwd     => $homedir,
    command => "git clone ${giturl}/${gituser}/${project}.git --branch ${branch}",
    path    => '/usr/bin',
    creates => $creates,
    user    => $title,
    require => Package['git'],
  }
}
