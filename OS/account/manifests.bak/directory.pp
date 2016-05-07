class account::file (
  $path = split('/cffex/temp/path1/path2', '/')
){

  $filename = 'test.c'

  $length = size($path)
  $pathname = inline_template('<% for i in 1..length-1 do -%><%= "/"+path[1..i].join("/")+"," %><% end -%>')

  $pathlist = split($pathname, '[,]')

  validate_array($pathlist)

  each($pathlist) |$value| {
    file { "${value}":
      ensure => directory,
    }

  }

  notify { 'message':
    message => size($pathlist),
  }

}
