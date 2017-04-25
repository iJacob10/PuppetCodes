class install_java::javacode
{
        $rpm = "jdk-8u121-linux-x64.rpm"
        file{"$rpm":
                        path =>"/opt/software/$rpm",
                        source=>"puppet:///modules/installjava/$rpm",
                        ensure=>present,
        }
        exec{"rpm -ivh /opt/software/$rpm":
			command=>'rpm -ivh /opt/software/$rpm',
                        cwd=>'/usr/',
                        creates=>'/usr/java/jdk1.8.0_121',
                        path=>['/usr/bin','/usr/sbin',],
        }
}


