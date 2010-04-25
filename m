From: David Sommerseth <openvpn.list@...1114...>
Date: Mon, 26 Apr 2010 00:42:39 +0200
Message-Id: <1272235359-20280-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] Revamped the script-security warning
	logging (version 2)
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
To: Openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <dazo@...384...>

From: David Sommerseth <dazo@...384...>

The main task of this patch is to avoid reporting the SCRIPT_SECURITY_WARNING
over and over again, in addition to not show this warning when it should not
be a problem.  This general warning should now only appear once, and only when
--script-security is not set, 0 or 1.  In all other cases this warning should
not appear.

In addition, this warning will come close to the script-hook which most probably
will fail.  It will also give a little bit more concrete hint on which script-hook
which failed.  If --script-security is 2 or 3, only the execve failure itself will
be shown.  This message will on the other hand be shown repeatedly.

This is a new rewritten version which simplifies the implementaion of the new
openvpn_run_script() function.  It was considered to remove it completely, but
due to code clearity and easy of use it was decided to make this function a static
inline function instead.  Anyhow, this function will enforce openvpn_execve_check()
to be called with the S_SCRIPT flag.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 common.h |    2 +-
 init.c   |    2 +-
 misc.c   |    7 +++++--
 misc.h   |   10 ++++++++++
 multi.c  |    6 +++---
 socket.c |    2 +-
 ssl.c    |    4 ++--
 win32.c  |    5 ++++-
 8 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/common.h b/common.h
index 94da09e..3ee3fc8 100644
--- a/common.h
+++ b/common.h
@@ -90,6 +90,6 @@ typedef unsigned long ptr_type;
 /*
  * Script security warning
  */
-#define SCRIPT_SECURITY_WARNING "openvpn_execve: external program may not be called unless '--script-security 2' or higher is enabled.  Use '--script-security 3 system' for backward compatibility with 2.1_rc8 and earlier.  See --help text or man page for detailed info."
+#define SCRIPT_SECURITY_WARNING "WARNING: External program may not be called unless '--script-security 2' or higher is enabled.  Use '--script-security 3 system' for backward compatibility with 2.1_rc8 and earlier.  See --help text or man page for detailed info."
 
 #endif
diff --git a/init.c b/init.c
index 19ac032..ec4a4a1 100644
--- a/init.c
+++ b/init.c
@@ -975,7 +975,7 @@ do_route (const struct options *options,
       struct argv argv = argv_new ();
       setenv_str (es, "script_type", "route-up");
       argv_printf (&argv, "%sc", options->route_script);
-      openvpn_execve_check (&argv, es, S_SCRIPT, "Route script failed");
+      openvpn_run_script (&argv, es, 0, "--route-up");
       argv_reset (&argv);
     }
 
diff --git a/misc.c b/misc.c
index 33e6762..9fce0c8 100644
--- a/misc.c
+++ b/misc.c
@@ -230,7 +230,7 @@ run_up_down (const char *command,
 		  ifconfig_local, ifconfig_remote,
 		  context);
       argv_msg (M_INFO, &argv);
-      openvpn_execve_check (&argv, es, S_SCRIPT|S_FATAL, "script failed");
+      openvpn_run_script (&argv, es, S_FATAL, "--up/--down");
       argv_reset (&argv);
     }
 
@@ -493,6 +493,7 @@ openvpn_execve_allowed (const unsigned int flags)
     return script_security >= SSEC_BUILT_IN;
 }
 
+
 #ifndef WIN32
 /*
  * Run execve() inside a fork().  Designed to replicate the semantics of system() but
@@ -504,6 +505,7 @@ openvpn_execve (const struct argv *a, const struct env_set *es, const unsigned i
 {
   struct gc_arena gc = gc_new ();
   int ret = -1;
+  static bool warn_shown = false;
 
   if (a && a->argv[0])
     {
@@ -540,9 +542,10 @@ openvpn_execve (const struct argv *a, const struct env_set *es, const unsigned i
 	      ASSERT (0);
 	    }
 	}
-      else
+      else if (!warn_shown && (script_security < SSEC_SCRIPTS))
 	{
 	  msg (M_WARN, SCRIPT_SECURITY_WARNING);
+          warn_shown = true;
 	}
 #else
       msg (M_WARN, "openvpn_execve: execve function not available");
diff --git a/misc.h b/misc.h
index bf51e89..78f04d9 100644
--- a/misc.h
+++ b/misc.h
@@ -136,6 +136,15 @@ bool openvpn_execve_check (const struct argv *a, const struct env_set *es, const
 bool openvpn_execve_allowed (const unsigned int flags);
 int openvpn_system (const char *command, const struct env_set *es, unsigned int flags);
 
+static inline bool
+openvpn_run_script (const struct argv *a, const struct env_set *es, const unsigned int flags, const char *hook)
+{
+  char msg[256];
+
+  openvpn_snprintf(msg, 255, "WARNING: Failed running command (%s)", hook);
+  return openvpn_execve_check(a, es, flags | S_SCRIPT, msg);
+};
+
 #ifdef HAVE_STRERROR
 /* a thread-safe version of strerror */
 const char* strerror_ts (int errnum, struct gc_arena *gc);
@@ -303,6 +312,7 @@ void get_user_pass_auto_userid (struct user_pass *up, const char *tag);
 extern const char *iproute_path;
 #endif
 
+/* Script security */
 #define SSEC_NONE      0 /* strictly no calling of external programs */
 #define SSEC_BUILT_IN  1 /* only call built-in programs such as ifconfig, route, netsh, etc.*/
 #define SSEC_SCRIPTS   2 /* allow calling of built-in programs and user-defined scripts */
diff --git a/multi.c b/multi.c
index 342871a..92ab4ca 100644
--- a/multi.c
+++ b/multi.c
@@ -109,7 +109,7 @@ learn_address_script (const struct multi_context *m,
 		   mroute_addr_print (addr, &gc));
       if (mi)
 	argv_printf_cat (&argv, "%s", tls_common_name (mi->context.c2.tls_multi, false));
-      if (!openvpn_execve_check (&argv, es, S_SCRIPT, "WARNING: learn-address command failed"))
+      if (!openvpn_run_script (&argv, es, 0, "--learn-address"))
 	ret = false;
       argv_reset (&argv);
     }
@@ -480,7 +480,7 @@ multi_client_disconnect_script (struct multi_context *m,
 	  struct argv argv = argv_new ();
 	  setenv_str (mi->context.c2.es, "script_type", "client-disconnect");
 	  argv_printf (&argv, "%sc", mi->context.options.client_disconnect_script);
-	  openvpn_execve_check (&argv, mi->context.c2.es, S_SCRIPT, "client-disconnect command failed");
+	  openvpn_run_script (&argv, mi->context.c2.es, 0, "--client-disconnect");
 	  argv_reset (&argv);
 	}
 #ifdef MANAGEMENT_DEF_AUTH
@@ -1586,7 +1586,7 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 		       mi->context.options.client_connect_script,
 		       dc_file);
 
-	  if (openvpn_execve_check (&argv, mi->context.c2.es, S_SCRIPT, "client-connect command failed"))
+	  if (openvpn_run_script (&argv, mi->context.c2.es, 0, "--client-connect"))
 	    {
 	      multi_client_connect_post (m, mi, dc_file, option_permissions_mask, &option_types_found);
 	      ++cc_succeeded_count;
diff --git a/socket.c b/socket.c
index e42ccb9..7d20bb0 100644
--- a/socket.c
+++ b/socket.c
@@ -1663,7 +1663,7 @@ link_socket_connection_initiated (const struct buffer *buf,
       struct argv argv = argv_new ();
       setenv_str (es, "script_type", "ipchange");
       ipchange_fmt (true, &argv, info, &gc);
-      openvpn_execve_check (&argv, es, S_SCRIPT, "ip-change command failed");
+      openvpn_run_script (&argv, es, 0, "--ipchange");
       argv_reset (&argv);
     }
 
diff --git a/ssl.c b/ssl.c
index d5230f7..a4af6a5 100644
--- a/ssl.c
+++ b/ssl.c
@@ -948,7 +948,7 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
 		   ctx->error_depth,
 		   subject);
       argv_msg_prefix (D_TLS_DEBUG, &argv, "TLS: executing verify command");
-      ret = openvpn_execve (&argv, opt->es, S_SCRIPT);
+      ret = openvpn_run_script (&argv, opt->es, 0, "--tls-verify script");
 
       if (opt->verify_export_cert)
         {
@@ -3232,7 +3232,7 @@ verify_user_pass_script (struct tls_session *session, const struct user_pass *up
       argv_printf (&argv, "%sc %s", session->opt->auth_user_pass_verify_script, tmp_file);
       
       /* call command */
-      retval = openvpn_execve (&argv, session->opt->es, S_SCRIPT);
+      retval = openvpn_run_script (&argv, session->opt->es, 0, "--auth-user-pass-verify");
 
       /* test return status of command */
       if (system_ok (retval))
diff --git a/win32.c b/win32.c
index eb94eb8..4de4139 100644
--- a/win32.c
+++ b/win32.c
@@ -952,6 +952,8 @@ int
 openvpn_execve (const struct argv *a, const struct env_set *es, const unsigned int flags)
 {
   int ret = -1;
+  static bool exec_warn = false;
+
   if (a && a->argv[0])
     {
       if (openvpn_execve_allowed (flags))
@@ -1004,9 +1006,10 @@ openvpn_execve (const struct argv *a, const struct env_set *es, const unsigned i
 	      ASSERT (0);
 	    }
 	}
-      else
+      else if (!exec_warn && (script_security < SSEC_SCRIPTS))
 	{
 	  msg (M_WARN, SCRIPT_SECURITY_WARNING);
+          exec_warn = true;
 	}
     }
   else
-- 
1.6.6.1


