From: Gabriel Corona <gabriel.corona@...1861...>
Date: Sat, 11 Jan 2014 16:53:35 +0100
Message-Id: <1389455615-11543-1-git-send-email-gabriel.corona@...1861...>
Subject: [Openvpn-devel] [PATCH] Add management command to reopen log file.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Useful for better logrotate integration without going the syslog path.
Triggered by the "reopen-log" management command.
---
 configure.ac          |  8 ++++++++
 src/openvpn/error.c   | 14 ++++++++++++++
 src/openvpn/init.c    |  7 +++++++
 src/openvpn/manage.c  | 35 +++++++++++++++++++++++++++++++++++
 src/openvpn/manage.h  |  9 +++++++++
 src/openvpn/options.c |  8 ++++++++
 src/openvpn/options.h |  4 ++++
 7 files changed, 85 insertions(+)

diff --git a/configure.ac b/configure.ac
index 7b35e50..a2079c4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -110,6 +110,13 @@ AC_ARG_ENABLE(
 )
 
 AC_ARG_ENABLE(
+	[reopen-log],
+	[AS_HELP_STRING([--disable-reopen-log], [disable reopening log files @<:@default=yes@:>@])],
+	,
+	[enable_reopen_log="yes"]
+)
+
+AC_ARG_ENABLE(
 	[pkcs11],
 	[AS_HELP_STRING([--enable-pkcs11], [enable pkcs11 support @<:@default=no@:>@])],
 	,
@@ -924,6 +931,7 @@ test "${ac_cv_header_sys_uio_h}" = "yes" && AC_DEFINE([HAVE_IOVEC], [1], [struct
 test "${enable_multi}" = "yes" && AC_DEFINE([ENABLE_CLIENT_SERVER], [1], [Enable client/server capability])
 test "${enable_server}" = "no" && AC_DEFINE([ENABLE_CLIENT_ONLY], [1], [Enable client capability only])
 test "${enable_management}" = "yes" && AC_DEFINE([ENABLE_MANAGEMENT], [1], [Enable management server capability])
+test "${enable_reopen_log}" = "yes" && AC_DEFINE([ENABLE_REOPEN_LOG], [1], [Enable reopening log file])
 test "${enable_socks}" = "yes" && AC_DEFINE([ENABLE_SOCKS], [1], [Enable Socks proxy support])
 test "${enable_http_proxy}" = "yes" && AC_DEFINE([ENABLE_HTTP_PROXY], [1], [Enable HTTP proxy support])
 test "${enable_multihome}" = "yes" && AC_DEFINE([ENABLE_MULTIHOME], [1], [Enable multi-homed UDP server capability])
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 6848425..c0c75e8 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -467,6 +467,20 @@ get_orig_stderr (void)
 
 #endif
 
+#ifdef ENABLE_REOPEN_LOG
+void
+reopen_log (const char* file, bool append)
+{
+  if(file==NULL)
+    return;
+  flockfile(default_out);
+  fflush(default_out);
+  std_redir = false;
+  redirect_stdout_stderr(file, append);
+  funlockfile(stdout);
+}
+#endif
+
 void
 redirect_stdout_stderr (const char *file, bool append)
 {
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2420216..2666236 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3164,6 +3164,10 @@ open_management (struct context *c)
 	  unsigned int flags = c->options.management_flags;
 	  if (c->options.mode == MODE_SERVER)
 	    flags |= MF_SERVER;
+#ifdef ENABLE_REOPEN_LOG
+	  if (c->options.logappend)
+	    flags |= MF_LOG_APPEND;
+#endif
 	  if (management_open (management,
 			       c->options.management_addr,
 			       c->options.management_port,
@@ -3175,6 +3179,9 @@ open_management (struct context *c)
 			       c->options.management_state_buffer_size,
 			       c->options.management_write_peer_info_file,
 			       c->options.remap_sigusr1,
+#ifdef ENABLE_REOPEN_LOG
+			       c->options.logfile,
+#endif
 			       flags))
 	    {
 	      management_set_state (management,
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 0a4542a..d5e3cbf 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -85,6 +85,9 @@ man_help ()
   msg (M_CLIENT, "load-stats             : Show global server load stats.");
   msg (M_CLIENT, "log [on|off] [N|all]   : Turn on/off realtime log display");
   msg (M_CLIENT, "                         + show last N lines or 'all' for entire history.");
+#ifdef ENABLE_REOPEN_LOG
+  msg (M_CLIENT, "reopen-log             : Reopen log file for log file rotation");
+#endif
   msg (M_CLIENT, "mute [n]               : Set log mute level to n, or show level if n is absent.");
   msg (M_CLIENT, "needok type action     : Enter confirmation for NEED-OK request of 'type',");
   msg (M_CLIENT, "                         where action = 'ok' or 'cancel'.");
@@ -587,6 +590,14 @@ man_log (struct management *man, const char *parm)
 	       LOG_PRINT_INT_DATE|LOG_PRINT_MSG_FLAGS);
 }
 
+#ifdef ENABLE_REOPEN_LOG
+static void
+man_reopen_log (struct management *man)
+{
+  reopen_log (man->settings.logfile, man->settings.flags & MF_LOG_APPEND);
+}
+#endif
+
 static void
 man_echo (struct management *man, const char *parm)
 {
@@ -1230,6 +1241,12 @@ man_dispatch_command (struct management *man, struct status_output *so, const ch
 	    man_log (man, p[2]);
 	}
     }
+#ifdef ENABLE_REOPEN_LOG
+  else if (streq (p[0], "reopen-log"))
+    {
+      man_reopen_log (man);
+    }
+#endif
   else if (streq (p[0], "echo"))
     {
       if (man_need (man, p, 1, MN_AT_LEAST))
@@ -1966,6 +1983,9 @@ man_settings_init (struct man_settings *ms,
 		   const int state_buffer_size,
 		   const char *write_peer_info_file,
 		   const int remap_sigusr1,
+#ifdef ENABLE_REOPEN_LOG
+		   const char *logfile,
+#endif
 		   const unsigned int flags)
 {
   if (!ms->defined)
@@ -2031,6 +2051,12 @@ man_settings_init (struct man_settings *ms,
 		(GETADDR_RESOLVE|GETADDR_WARN_ON_SIGNAL|GETADDR_FATAL, addr, 0, NULL, NULL);
 	    }
 	}
+#ifdef ENABLE_REOPEN_LOG
+      if (logfile)
+	{
+	  ms->logfile = strdup(logfile);
+	}
+#endif
       
       /*
        * Log history and echo buffer may need to be resized
@@ -2055,6 +2081,9 @@ static void
 man_settings_close (struct man_settings *ms)
 {
   free (ms->write_peer_info_file);
+#ifdef ENABLE_REOPEN_LOG
+  free (ms->logfile);
+#endif
   CLEAR (*ms);
 }
 
@@ -2156,6 +2185,9 @@ management_open (struct management *man,
 		 const int state_buffer_size,
 		 const char *write_peer_info_file,
 		 const int remap_sigusr1,
+#ifdef ENABLE_REOPEN_LOG
+		 const char *logfile,
+#endif
 		 const unsigned int flags)
 {
   bool ret = false;
@@ -2175,6 +2207,9 @@ management_open (struct management *man,
 		     state_buffer_size,
 		     write_peer_info_file,
 		     remap_sigusr1,
+#ifdef ENABLE_REOPEN_LOG
+		     logfile,
+#endif
 		     flags);
 
   /*
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 28da69f..360022b 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -217,6 +217,9 @@ struct man_settings {
   struct sockaddr_un local_unix;
 #endif
   bool management_over_tunnel;
+#ifdef ENABLE_REOPEN_LOG
+  char* logfile;
+#endif
   struct user_pass up;
   int log_history_cache;
   int echo_buffer_size;
@@ -334,6 +337,9 @@ struct management *management_init (void);
 #define MF_UP_DOWN          (1<<10)
 #define MF_QUERY_REMOTE     (1<<11)
 #define MF_QUERY_PROXY      (1<<12)
+#ifdef ENABLE_REOPEN_LOG
+#define MF_LOG_APPEND       (1<<13)
+#endif
 
 bool management_open (struct management *man,
 		      const char *addr,
@@ -346,6 +352,9 @@ bool management_open (struct management *man,
 		      const int state_buffer_size,
 		      const char *write_peer_info_file,
 		      const int remap_sigusr1,
+#ifdef ENABLE_REOPEN_LOG
+		      const char* logfile,
+#endif
 		      const unsigned int flags);
 
 void management_close (struct management *man);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 23af272..5cdcf09 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4634,6 +4634,10 @@ add_option (struct options *options,
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->log = true;
+#ifdef ENABLE_REOPEN_LOG
+      options->logfile = p[1];
+      options->logappend = false;
+#endif
       redirect_stdout_stderr (p[1], false);
     }
   else if (streq (p[0], "suppress-timestamps"))
@@ -4646,6 +4650,10 @@ add_option (struct options *options,
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->log = true;
+#ifdef ENABLE_REOPEN_LOG
+      options->logfile = p[1];
+      options->logappend = true;
+#endif
       redirect_stdout_stderr (p[1], true);
     }
 #ifdef ENABLE_MEMSTATS
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index f80532c..839d938 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -297,6 +297,10 @@ struct options
   int inetd;
 
   bool log;
+#ifdef ENABLE_REOPEN_LOG
+  char* logfile;
+  bool logappend;
+#endif
   bool suppress_timestamps;
   int nice;
   int verbosity;
-- 
1.8.5.2


