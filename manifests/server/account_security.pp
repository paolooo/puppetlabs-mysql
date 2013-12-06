class mysql::server::account_security {

  mysql_user {
    [ 'root@127.0.0.1',
      'root@::1',
      "@${::fqdn}",
      '@%']:
    ensure  => 'absent',
    require => Anchor['mysql::server::end'],
  }

  if ($::fqdn != 'localhost') {
    mysql_user {
      [ "root@${::fqdn}",
        '@localhost']:
      ensure  => 'absent',
      require => Anchor['mysql::server::end'],
    }
  }

  if ($::fqdn != $::hostname) {
    mysql_user { ["root@${::hostname}", "@${::hostname}"]:
      ensure  => 'absent',
      require => Anchor['mysql::server::end'],
    }
  }
  mysql_database { 'test':
    ensure  => 'absent',
    require => Anchor['mysql::server::end'],
  }
}
