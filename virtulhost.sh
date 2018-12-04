#!/bin/bash


welcomemsg() { \
	dialog --title "bienvenido!" --msgbox "bienvenido al superscript creador de virtualhost by gatodex \n  /\_/\ \n ( o.o ) \n  > ^ <" 10 60
	}

getdir() { \
	dir=$(dialog --inputbox "ingrese nombre del directorio ejem: /var/www/[dominio.com] (sin signos raros no sea idiota) \n trate que sea igual al dominio" 10 60 3>&1 1>&2 2>&3 3>&1) || exit
	 }	
	
initialcheck() { apt-get install dialog tree || { echo "correlo como root o tu sistema no es ubuntu "; exit; } ;}

mkdirs() { \
mkdir /var/www/$dir
chown -R $USER:$USER /var/www/$dir
chmod -R 755 /var/www
touch /etc/apache2/sites-available/$dir.conf
}

editconf() { \
echo "<VirtualHost *:80> 
    ServerAdmin admin@$dir 
    ServerName  $dir 
    ServerAlias www.$dir 
    DocumentRoot /var/www/$dir 
    ErrorLog ${APACHE_LOG_DIR}/error.log 
    CustomLog ${APACHE_LOG_DIR}/access.log combined 
</VirtualHost>  " > /etc/apache2/sites-available/$dir.conf
}

installconf() { \
dialog --title "instalando" --msgbox "se esta instalando la nueva configuracion y reiniciando apache2 \n !!para desabilitar default.conf descomentar script  \n  /\_/\ \n ( o.o ) \n  > ^ <" 10 60
a2ensite $dir.conf	
#a2dissite 000-default.conf
systemctl restart apache2
service apache2 restart
	}


echo "############################"
echo "#                          #"
echo "# instale todo para        #"
echo "#   que funcione           #"
echo "#                          #"
echo "############################"


#cheque si esta dialog
initialcheck


# Welcome user.
welcomemsg || { clear; exit; }

getdir 

# ejecuta la creacion del directorio de virtualhost
mkdirs  

editconf

installconf
