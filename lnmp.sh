#!/bin/bash
#Author: liangxu
#Emain: lxlinuxyw
#Date: 2016/2/22
#Funtions： USED SHELL COMPLETE LNMP MANAGER
#Version: 1/1

source=/root/lnmpscripts
dir=/usr/local/lnmp
nginx_pwd=$dir/nginx
mysql_pwd=$dir/mysql
php_pwd=$dir/php

node() {
        ls ${nginx_pwd} &>/dev/null && nginx_node=0 || nginx_node=1
        ls ${mysql_pwd} &>/dev/null && mysql_node=0 || mysql_node=1
        ls ${php_pwd} &>/dev/null && php_node=0 || php_node=1

}

status_list() {
        [ "$nginx_node" -ne "0" ] && echo -e "\033[32m nginx not install \033[0m"|| echo -e "\033[32m nginx instatlled \033[0m"
        [ "$mysql_node" -ne "0" ] && echo -e "\033[31m mysql not install \033[0m" || echo -e "\033[32m mysql intalled \033[0m"
       [ "$php_node" -ne "0" ] && echo -e "\033[33m php not install \033[0m" ||echo -e "\033[33m php installed \033[0m"

}

welcome(){
        echo -e "\033[33m welcome use lnmp manager sofrware \033[0m "

}

first_list(){
        welcome
        node
        status_list
        echo -e "\033[34m lnmp main menu  \033[0m
                
                \033[31m i :install software \033[0m
                \033[32m r :remove software \033[0m
                \033[33m s :services manager \033[0m
                \033[35m e :exit \033[0m

"
}
first_op(){
         
       
                read -p "please input your choice [i r s e]: " n
                if [ "$n" == "i" ];then
                        install_list
                        lnmp_install
                elif [ "$n" == "r" ];then
			remove_list
                        lnmp_remove
		elif [ "$n" == "s" ];then
			services_list
                        services_manage
                elif [ "$n" == "e" ];then
                        exit 0
                else
                        echo -e "\033[33m Usage please  input [i r s e ]：\033[0m"
                        first_op
                fi
        
}

install_list()
{
        status_list
        echo -e "\033[31m installation choice\033[0m
                 \033[33m n : install nginx \033[0m
                \033[34m m : install mysql \033[0m
                \033[35m p : install php \033[0m
                \033[36m b : back menu \033[0m
                \033[37m e : exit \033[0m
                "
}

lnmp_install()
{
	read -p " wlecome install software, please input your install choose [n  m p b e ]" n
	
	if [ "$n" == "n" ];then
                nginx_install
                
        elif [ "$n" == "m" ];then
                mysql_install
        elif [ "$n" == "p" ];then
                php_install
        elif [ "$n" == "e" ];then
	
                exit 0
	elif [ "$n" == "b" ];then
		first_list
		first_op	
        else
                echo -e "\033[33m Usage please input [ n m p e b ]：\033[0m"
                lnmp_install
        fi

}
nginx_install(){
        echo -e "\033[31m    Nginx is installing 
    ###############[0%] \033[0m"
        cd "$source"
        tar zxf nginx-1.6.2.tar.gz
        echo -e "\033[31m    Nginx is installing
    ###############[10%] \033[0m"
        yum install gcc pcre-devel openssl-devel -y &> /dev/null
        echo -e "\033[31m    Nginx is installing
    ###############[30%] \033[0m"
        cd nginx-1.6.2
        ./configure --prefix=${nginx_pwd} --with-http_ssl_module --with-http_stub_status_module &>/dev/null
        echo -e "\033[31m    Nginx is installing
    ###############[50%] \033[0m"
        make &>/dev/null&& make install &>/dev/null
        echo -e "\033[31m    Nginx is installing
    ###############[90%] \033[0m"
        grep nginx /etc/group &> /dev/null||groupadd -g 27 nginx
        id nginx &>/dev/null||useradd -u 27 -g 27 -d ${nginx_pwd} -M nginx
        ln -s ${nginx_pwd}/sbin/nginx /bin
        sed '2i user  nginx nginx;' ${nginx_pwd}/conf/nginx.conf -i
        sed -i '14i use epoll;' ${nginx_pwd}/conf/nginx.conf
             nginx_node=0
        echo -e "\033[31m    Installed is ok!
    ###############[100%] \033[0m"
		install_list
		lnmp_install
}

mysql_install(){
        echo -e "\033[32m    Mysql is installing
    ###############[0%] \033[0m"
	cd "$source"
        tar zxf mysql-5.5.12.tar.gz
        echo -e "\033[32m    Mysql is installing
    ###############[10%] \033[0m"
        cd mysql-5.5.12
        yum install -y gcc gcc-c++ make ncurses-devel bison openssl-devel zlib-devel cmake &> /dev/null
        echo -e "\033[32m    Mysql is installing
    ###############[30%] \033[0m"
        cmake -DCMAKE_INSTALL_PREFIX=${mysql_pwd} -DMYSQL_DATADIR=${mysql_pwd}/data -DMYSQL_UNIX_ADDR=${mysql_pwd}/data/mysql.sock -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DEXTRA_CHARSETS=all &> /dev/null
        echo -e "\033[32m    Mysql is installing
    ###############[50%] \033[0m"
        make &> /dev/null &&make install &> /dev/null
        echo -e "\033[32m    Mysql is installing
    ###############[80%] \033[0m"
        echo "PATH=\$PATH:\$HOME:/usr/local/lnmp/mysql/bin" >> /etc/profile
        source /etc/profile
        grep mysql /etc/group &> /dev/null||groupadd -g 28 mysql &>/dev/null
        useradd -u 28 -g 28 -d ${mysql_pwd} -M mysql &> /dev/null
        chown mysql.mysql ${mysql_pwd} -R
        cd ${mysql_pwd}/scripts/ ; ./mysql_install_db --user=mysql --basedir=${mysql_pwd} --datadir=${mysql_pwd}/data/ &>/dev/null
        cp ${mysql_pwd}/support-files/mysql.server /etc/init.d/mysqld
        cp ${mysql_pwd}/support-files/my-medium.cnf /etc/my.cnf 
        echo -e "\033[32m    Mysql is installing
    ###############[90%] \033[0m"
        mysql_node=0
        echo -e "\033[32m    Installed is ok! 
    ###############[100%] \033[0m"
        install_list
        lnmp_install

}

php_install(){
        echo -e "\033[33m    Php is installing 
    ###############[0%] \033[0m"
        cd "$source"
        tar jxf php-5.4.36.tar.bz2
        yum install libmcrypt-2.5.8-9.el6.x86_64.rpm libmcrypt-devel-2.5.8-9.el6.x86_64.rpm gd-devel-2.0.35-11.el6.x86_64.rpm -y &>/dev/null
        echo -e "\033[33m    Php is installing
    ###############[10%] \033[0m"
        cd php-5.4.36
        yum install net-snmp-devel libcurl-devel libxml2-devel libpng-devel libjpeg-turbo-devel-1.2.1-1.el6.x86_64 openssl-devel  freetype-devel gmp-devel openldap-devel -y &> /dev/null
        yum install gcc-c++ make ncurses-devel bison openssl-devel zlib-devel libxml2-devel easy-devel libcurl-devel-7.19.7-37.el6_4.x86_64 libjpeg-turbo-devel-1.2.1-1.el6.x86_64 gd-devel-2.0.35-11.el6.x86_64.rpm gmp-devel-4.3.1-7.el6_2.2.x86_64 net-snmp-devel expect php-pear.noarch -y &> /dev/null
        echo -e "\033[33m    Php is installing
    ###############[20%] \033[0m"
        ./configure --prefix=${php_pwd} --with-config-file-path=${php_pwd}/etc --with-mysql=${mysql_pwd} --with-openssl --with-snmp --with-gd --with-zlib --with-curl --with-libxml-dir --with-png-dir --with-jpeg-dir --with-freetype-dir --with-pear --with-gettext --with-gmp --enable-inline-optimization --enable-soap --enable-ftp --enable-sockets --enable-mbstring --with-mysqli=${mysql_pwd}/bin/mysql_config --enable-fpm --with-fpm-user=nginx --with-fpm-group=nginx --with-ldap-sasl --with-mcrypt --with-mhash &>/dev/null
        echo -e "\033[33m    Php is installing
    ###############[50%] \033[0m"
        make &> /dev/null && make install &>/dev/null
        echo -e "\033[33m    Php is installing
    ###############[80%] \033[0m"
        /usr/bin/expect  &>/dev/null <<EOF
        spawn ${php_pwd}/bin/php ${tar_pwd}/go-pear.phar
        send "\n"
        send "\n"
        expect eof
        exit
EOF
        cp ~/lnmpscripts/php-5.4.36/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
        echo -e "\033[33m    Php is installing
    ###############[90%] \033[0m"
        chmod +x /etc/init.d/php-fpm
        nginx
        cp ~/lnmpscripts/php-5.4.36/php.ini-production ${php_pwd}/etc/php.ini
        sed '909i date.timezone = Asia/Shanghai' ${php_pwd}/etc/php.ini -i
        cp ${php_pwd}/etc/php-fpm.conf.default ${php_pwd}/etc/php-fpm.conf
        sed '25i pid = run/php-fpm.pid' ${php_pwd}/etc/php-fpm.conf -i
        sed -i '66,73s/#//g' ${nginx_pwd}/conf/nginx.conf
        sed -i 's/fastcgi_params/fastcgi.conf/g' ${nginx_pwd}/conf/nginx.conf
        echo "<?php
phpinfo();
?>" > ${nginx_pwd}/html/index.php
        /etc/init.d/php-fpm start
        echo -e "\033[33m    Php is installing 
    ###############[95%] \033[0m"
        #nginx -s reload
        php_node=0
        echo -e "\033[33m    Installed is ok
    ###############[100%] \033[0m"
		install_list
    	lnmp_install

}

remove_list()
{	status_list
	echo -e "\033[32m remove software menu \033[0m
		\033[33m a : remove all lnmp software \033[0m
		\033[34m n : remove nginx \033[0m
		\033[35m m : remove mysql \033[0m
		\033[36m p : remove php \033[0m
		\033[39m c : show lnmp status \033[0m
		\033[37m b : main menu \033[0m
		\033[38m e : exit \033[0m"


}


lnmp_remove() {
        read -p "please input your choice  [ a n m p c b e ]：" n
	if [ "$n" == "a" ];then
                nginx -s stop &> /dev/null
                rm -f /bin/nginx &> /dev/null
                rm -rf "$nginx_pwd" &> /dev/null
                nginx_node=1
                sed -i '79d' /etc/profile
                source /etc/profile &>/dev/null
                /etc/init.d/mysqld stop &> /dev/null
                rm -f /etc/my.cnf /etc/init.d/mysqld "$mysql_pwd" &> /dev/null
                rm -rf "$mysql_pwd" &> /dev/null
                mysql_node=1
                /etc/init.d/php-fpm stop &>/dev/null
                sed -i '66,73d' ${nginx_pwd}/conf/nginx.conf &>/dev/null
                rm -f /etc/php.ini /etc/php-fpm.conf &> /dev/null
                rm -rf "$php_pwd" &> /dev/null
                php_node=1

        elif [ "$nginx_node" = "0" -a "$n" = "n" ];then
                nginx -s stop &> /dev/null
                rm -f /bin/nginx &> /dev/null
           
     		rm -rf "$nginx_pwd" &> /dev/null && echo "remove complete" || echo "remove error"
                nginx_node=1
		lnmp_remove
        elif [ "$mysql_node" = "0" -a "$n" = "m" ];then
                sed -i '79d' /etc/profile
                source /etc/profile &>/dev/null
                /etc/init.d/mysqld stop &> /dev/null
                rm -f /etc/my.cnf /etc/init.d/mysqld "$mysql_pwd" &> /dev/null
                rm -rf "$mysql_pwd" &> /dev/null
                mysql_node=1
        elif [ "$php_node" = "0" -a "$n" = "p" ];then
                /etc/init.d/php-fpm stop &>/dev/null
                sed -i '66,73d' "$nginx_pwd"/conf/nginx.conf &>/dev/null
                rm -f /etc/php.ini /etc/php-fpm.conf &> /dev/null
                rm -rf "$php_pwd" &> /dev/null
                php_node=1
	elif [ "$n" == "c" ];then
		status_list
		lnmp_remove
        elif [ "$n" == "b" ];then
		first_list
		first_op
		
	elif [ "$n" == "e" ];then
		exit 0
	else
		echo "Usage : please input n|m|p|b|e"
		
		lnmp_remove
	fi
}
services_list(){
	echo -e "\033[31m services mananger choice \033[0m
		
		\033[32m n : manangement nginx\033[0m
		\033[33m m : manangement mysql\033[0m
		\033[34m p : manangement php \033[0mm
		\033[35m b : return main menu \033[0m
		\033[36m e : exit \033[0m "
}
services_manage(){
	read -p "please input your choice [ n m p b e ]" n
	case "$n" in
		"n")
		nginx_service_list
		nginx_service_manage
		;;
		"m")
		mysql_service_list
		mysql_service_manage		
		;;
		"p")
		php_service_list
		php_service_manage
		;;
		"b")
		first_list
		first_op
		;;
		"e")
		exit 0
		;;
		*)
		echo -e "\033[32m Usage please input [ n m p b e ]"
		services_manage
		;;
		esac
}

nginx_service_list() {
        echo -e " \033[31m nginx service mananger choice \033[0m
                
                \033[32m k : start nginx\033[0m
                \033[33m g : stop nginx \033[0m
                \033[34m r : again reload nginx \033[0m
                \033[35m b : return main menu \033[0m
		\033[38m h : return  service manage \033[0m
                \033[36m e : exit \033[0m "
	        number=`netstat -antlp | grep 80 | wc -l`
        	if [ $number -eq 1 ];then
			echo -e "\033[32m nginx is running \033[0m"
		else
			echo -e "\033[34m nginx is stoped \033[0mi"
		fi	
}
nginx_service_manage() {
	read -p "please input choice [ k g r b h e ]" n
	if [ "$n" = "k" ];then
		nginx  && echo "nginx start success" || echo "nginx start error"
		services_list
		services_manage
	elif [ "$n" = "g" ]; then
		nginx -s stop && echo "nginx stop success " || echo "nginx stop error"
		services_list
		services_manage
	elif [ "$n" = "r" ]; then
		nginx -s reload && echo "nginx reload success" || "nginx reload error"
	elif [ "$n" = "b" ]; then
		first_list
		first_op
	elif [ "$n" = "h" ];then
		services_list
		services_manage
	elif [ "$n" = "e" ];then
		exit 0
	else 
		echo "Usage please input [ k g r b h e ]"
		nginx_service_manage
	fi
}

first_list
first_op
