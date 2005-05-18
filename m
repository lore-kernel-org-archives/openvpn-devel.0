From: Simon Perreault <nomis80@...401...>
References: <200505180940.09835.nomis80@...401...>
In-Reply-To: <200505180940.09835.nomis80@...401...>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Gq1iCsfj0Xoc7VY"
Message-Id: <200505181108.54879.nomis80@...401...>
Subject: [Openvpn-devel] Re: PAM plugin doesn't daemonize correctly [PATCH]
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
Date: Wed May 18 09:43:33 2005
To: openvpn-devel@lists.sourceforge.net

--Boundary-00=_Gq1iCsfj0Xoc7VY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 18 May 2005 09:40, Simon Perreault wrote:
> 1) reopen stdin, stdout and stderr to /dev/null when --daemon option is
> specified (need a way to access options structure in the plugin)

Here's a patch using the first solution. Please consider applying.

--Boundary-00=_Gq1iCsfj0Xoc7VY
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="openvpn-2.0-daemon-pam.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="openvpn-2.0-daemon-pam.patch"

Index: options.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/options.c,v
retrieving revision 1.62
diff -u -p -r1.62 options.c
--- options.c	18 May 2005 08:21:54 -0000	1.62
+++ options.c	18 May 2005 14:55:28 -0000
@@ -622,6 +622,7 @@ setenv_settings (struct env_set *es, con
   setenv_str (es, "local", o->local);
   setenv_int (es, "local_port", o->local_port);
   setenv_int (es, "verb", o->verbosity);
+  setenv_int (es, "daemon", o->daemon);
 
   if (o->remote_list)
     {
Index: plugin/auth-pam/auth-pam.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/plugin/auth-pam/auth-pam.c,v
retrieving revision 1.5
diff -u -p -r1.5 auth-pam.c
--- plugin/auth-pam/auth-pam.c	30 Apr 2005 22:21:16 -0000	1.5
+++ plugin/auth-pam/auth-pam.c	18 May 2005 14:55:28 -0000
@@ -373,6 +373,16 @@ openvpn_plugin_open_v1 (unsigned int *ty
       /* Ignore most signals (the parent will receive them) */
       set_signals ();
 
+      /*
+       * Daemonize if --daemon option is set.
+       */
+      {
+        const char *daemon_string = get_env ("daemon", envp);
+        if (daemon_string && daemon_string[0] == '1')
+          if (daemon (0, 0) < 0)
+            perror ("AUTH-PAM: daemonization failed");
+      }
+
       /* execute the event loop */
       pam_server (fd[1], argv[1], context->verb, &name_value_list);
 

--Boundary-00=_Gq1iCsfj0Xoc7VY--

