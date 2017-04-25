class mysql_install::mysqlcode
{
$bin="mysql-community-client-5.6.35-2.el7.x86_64.rpm"
$bin2="mysql-community-common-5.6.35-2.el7.x86_64.rpm"
$bin3="mysql-community-libs-5.6.35-2.el7.x86_64.rpm"
$bin4="mysql-community-server-5.6.35-2.el7.x86_64.rpm"

	        file { '/opt/software/mysql/':
                        ensure => 'directory',
                        mode   => '0750',
                }

		 file{"$bin":
                        path =>"/opt/software/mysql/$bin",
                        source=>"puppet:///modules/mysql_install/$bin",
                        ensure=>present,
                        mode=>755,
       		 }

		file{"$bin2":
                        path =>"/opt/software/mysql/$bin2",
                        source=>"puppet:///modules/mysql_install/$bin2",
                        ensure=>present,
                        mode=>755,
                 }

		file{"$bin3":
                        path =>"/opt/software/mysql/$bin3",
                        source=>"puppet:///modules/mysql_install/$bin3",
                        ensure=>present,
                        mode=>755,
                 }
		file{"$bin4":
                        path =>"/opt/software/mysql/$bin4",
                        source=>"puppet:///modules/mysql_install/$bin4",
                        ensure=>present,
                        mode=>755,
                 }

		exec{"installing":
                        cwd=>'/opt/software/mysql/',
                        command=>'yum localinstall *.rpm -y -y',
                        path=>['/usr/bin/','/usr/sbin/',],
        }

service {'mysqld':
require => Exec["installing"],
start => "service mysqld start",
ensure => 'running',
}

file {'/tmp/my.sh':
require => Service["mysqld"],
ensure => 'file',
source => 'puppet:///modules/mysql_install/my.sh',
mode => '0755',
}

exec {"script":
require => File["/tmp/my.sh"],
path => ["/usr/bin/","/usr/sbin/","/bin/bash/","/bin/","/usr/local/bin/"],
command => "/tmp/my.sh",
}

}

