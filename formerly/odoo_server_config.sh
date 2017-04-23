    Openerp enviroment  
        sudo apt-get install libpq-dev python-passlib    python-dev python-pychart python-werkzeug  python-dateutil python-yaml python-unittest2 python-mock  python-openid python-docutils  python-pip  python-psycopg2  python-decorator python-psutil python-pypdf postgresql -y  
        sudo pip install  Flask-Babel simplejson   mako  pyyaml   
      
    PSQL  
            sudo su postgres  
            createuser xyz -P  	(Assume my current username is xyz)
            psql  
                //create database openerp;  
                //ALTER DEFAULT PRIVILEGES FOR USER openerp GRANT ALL  
                //alter user user_name with password 'new_password';  
                alter role xyz superuser ;  
      
    Openerp configure  
        Always being: odoo[7|8]/debain/openerp-server.conf  
     -----------------------  
            [options]  
            ; This is the password that allows database operations:  
            ; admin_passwd = admin  
            db_host = False  
            db_port = False  
            #!!   make the user to be  current openerp running user,if wrong may come up with "no web module web_kanban" error.  
            db_user = xyz  
            db_password = king  
            #!!!  make sure the directory here include the local module and dev module  
            addons_path = /home/openerp/odoo8/addons,/home/openerp/extra_addons_cdrj    	
        ---------------------  
          
        IF U a develop of openerp,make sure develop menu bee seen to u.  
            Select "setting"->"Users"->username(like Administration)->"Technical Features" ,then reload page.    
      
    Start server  
        #no module named web_kanban  
        # It likes a bug ,shoud use "./openerp-server --addons-path=addons" start but not "./openerp-server"  
        # Because of no configure file was defined
        ./openerp-server --addons-path=addons  
        ./openerp-server --addons-path=addons,addons --log-level=debug  

    Saw the port,than visit with  http://ip:port  .  
-
