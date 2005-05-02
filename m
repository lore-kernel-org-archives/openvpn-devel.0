From: Claas Hilbrecht <claas+maillinglists.openvpn@...232...>
Message-ID: <CFAB61A740D152638EA62E71@[192.168.1.22]>
In-Reply-To: <Pine.LNX.4.58.0504301622050.25603@...41...>
References: <Pine.LNX.4.58.0504301622050.25603@...41...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Re: [Openvpn-users] OpenVPN 2.0.1-rc1 released
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon May  2 10:21:29 2005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: James Yonan <jim@...41...>, openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

--Am Samstag, 30. April 2005 16:28 -0600 James Yonan <jim@...41...> 
schrieb:

> Here is a release candidate for 2.0.1, with a few minor patches.  Please
> test, especially if you are using plugins or configurations which use
> multiple --remote options.

Great, the --remote "bugfix" comes very handy right now.

Maybe you could add this patch that adds a --management-writeport option to 
the configuration and enhances --management to accept a "0" as the port 
number. Using "0" as a port number let the os choose a free port for the 
management interface. Setting --management-writeport /var/run/openvpn.mport 
will write the port used for the managment interface to this file. Together 
will my ovpnctrl (netcat like programm) utility you can create a nice 
management console in a web gui.

diff -urN openvpn-2.0.1_rc1/init.c openvpn-2.0.1_rc1.writeport/init.c
--- openvpn-2.0.1_rc1/init.c	2005-04-11 05:43:56.000000000 +0200
+++ openvpn-2.0.1_rc1.writeport/init.c	2005-05-02 12:30:18.282985588 +0200
@@ -2126,6 +2126,7 @@
 	  if (management_open (management,
 			       c->options.management_addr,
 			       c->options.management_port,
+			       c->options.management_writeport,
 			       c->options.management_user_pass,
 			       c->options.mode == MODE_SERVER,
 			       c->options.management_query_passwords,
diff -urN openvpn-2.0.1_rc1/manage.c openvpn-2.0.1_rc1.writeport/manage.c
--- openvpn-2.0.1_rc1/manage.c	2005-04-11 05:43:56.000000000 +0200
+++ openvpn-2.0.1_rc1.writeport/manage.c	2005-05-02 14:24:53.735770992 +0200
@@ -830,6 +830,36 @@

       msg (D_MANAGEMENT, "MANAGEMENT: TCP Socket listening on %s",
 	   print_sockaddr (&man->settings.local, &gc));
+
+      if (man->settings.writeport_file)
+	{
+	  FILE *mportfh;
+
+	  mportfh = fopen (man->settings.writeport_file, "w");
+	  if (NULL != mportfh)
+	    {
+	      int port = man->settings.local.sin_port;
+	      if (0 == port)
+		{
+		  struct sockaddr_in tmpSockAddr;
+		  socklen_t tmpSockAddrBufSize = sizeof(tmpSockAddr);
+
+		  if(getsockname(man->connection.sd_top, (struct sockaddr 
*)&tmpSockAddr, &tmpSockAddrBufSize))
+		    {
+		      msg (M_ERR, "getsockname failed");
+		      port = -1;
+		    }
+		  else
+		    port = tmpSockAddr.sin_port;
+		}
+	      fprintf (mportfh, "%d\n", ntohs (port));
+	      fclose (mportfh);
+	    }
+	  else
+	    {
+	      msg (M_ERR, "Open error on pid file %s", 
man->settings.writeport_file);
+	    }
+	}
     }

 #ifdef WIN32
@@ -1082,6 +1112,7 @@
 man_settings_init (struct man_settings *ms,
 		   const char *addr,
 		   const int port,
+		   const char *writeport_file,
 		   const char *pass_file,
 		   const bool server,
 		   const bool query_passwords,
@@ -1101,6 +1132,12 @@
       ms->server = server;

       /*
+       * Save writeport filename
+       */
+      if (writeport_file)
+	ms->writeport_file = writeport_file;
+
+      /*
        * Get username/password
        */
       if (pass_file)
@@ -1233,6 +1270,7 @@
 management_open (struct management *man,
 		 const char *addr,
 		 const int port,
+		 const char *writeport_file,
 		 const char *pass_file,
 		 const bool server,
 		 const bool query_passwords,
@@ -1250,6 +1288,7 @@
   man_settings_init (&man->settings,
 		     addr,
 		     port,
+		     writeport_file,
 		     pass_file,
 		     server,
 		     query_passwords,
diff -urN openvpn-2.0.1_rc1/manage.h openvpn-2.0.1_rc1.writeport/manage.h
--- openvpn-2.0.1_rc1/manage.h	2005-04-11 05:43:56.000000000 +0200
+++ openvpn-2.0.1_rc1.writeport/manage.h	2005-05-02 14:25:03.282631910 +0200
@@ -194,6 +194,7 @@
   int state_buffer_size;
   bool server;
   bool hold;
+  const char *writeport_file;
 };

 /* up_query modes */
@@ -252,6 +253,7 @@
 bool management_open (struct management *man,
 		      const char *addr,
 		      const int port,
+		      const char *writeport_file,
 		      const char *pass_file,
 		      const bool server,
 		      const bool query_passwords,
diff -urN openvpn-2.0.1_rc1/options.c openvpn-2.0.1_rc1.writeport/options.c
--- openvpn-2.0.1_rc1/options.c	2005-04-30 11:47:22.000000000 +0200
+++ openvpn-2.0.1_rc1.writeport/options.c	2005-05-02 13:28:30.815427629 
+0200
@@ -282,6 +282,8 @@
   "                    of the management interface explicitly starts it.\n"
   "--management-log-cache n : Cache n lines of log file history for 
usage\n"
   "                  by the management channel.\n"
+  "--management-writeport file : Write used port for management 
interface\n"
+  "                  to file.\n"
 #endif
 #ifdef ENABLE_PLUGIN
   "--plugin m [str]: Load plug-in module m passing str as an argument\n"
@@ -1065,6 +1067,7 @@
 #ifdef ENABLE_MANAGEMENT
   SHOW_STR (management_addr);
   SHOW_INT (management_port);
+  SHOW_STR (management_writeport);
   SHOW_STR (management_user_pass);
   SHOW_INT (management_log_history_cache);
   SHOW_INT (management_echo_buffer_size);
@@ -1340,6 +1343,8 @@
       (options->management_query_passwords || options->management_hold
        || options->management_log_history_cache != 
defaults.management_log_history_cache))
     msg (M_USAGE, "--management is not specified, however one or more 
options which modify the behavior of --management were specified");
+  if (options->management_port == 0 && !options->management_writeport)
+    msg (M_USAGE, "--management ip port [pass] uses port=0 to auto-select 
the management port but there is no --management-writeport option to record 
the used port");
 #endif

   /*
@@ -2652,7 +2657,7 @@
       i += 2;
       VERIFY_PERMISSION (OPT_P_GENERAL);
       port = atoi (p[2]);
-      if (!legal_ipv4_port (port))
+      if (port != 0 && !legal_ipv4_port (port))
 	{
 	  msg (msglevel, "port number associated with --management directive is 
out of range");
 	  goto err;
@@ -2666,6 +2671,12 @@
 	  options->management_user_pass = p[3];
 	}
     }
+  else if (streq (p[0], "management-writeport") && p[1])
+    {
+      ++i;
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->management_writeport = p[1];
+    }
   else if (streq (p[0], "management-query-passwords"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff -urN openvpn-2.0.1_rc1/options.h openvpn-2.0.1_rc1.writeport/options.h
--- openvpn-2.0.1_rc1/options.h	2005-04-11 05:43:57.000000000 +0200
+++ openvpn-2.0.1_rc1.writeport/options.h	2005-05-02 14:34:24.017737322 
+0200
@@ -259,6 +259,7 @@
 #ifdef ENABLE_MANAGEMENT
   const char *management_addr;
   int management_port;
+  const char *management_writeport;
   const char *management_user_pass;
   int management_log_history_cache;
   int management_echo_buffer_size;


-- 
 Claas Hilbrecht
 http://www.jucs-kramkiste.de


