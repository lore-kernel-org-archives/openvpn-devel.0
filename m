Message-ID: <4161A650.1020706@...289...>
From: Vlada Macek <tuttle@...289...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6B52CA41CA66F150D1EE5F66"
Subject: [Openvpn-devel] Again: Feature implementation: Connection refusal based upon CN
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
Date: Mon Oct  4 12:41:58 2004
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6B52CA41CA66F150D1EE5F66
Content-Type: multipart/mixed;
 boundary="------------050705080206080806000800"

This is a multi-part message in MIME format.
--------------050705080206080806000800
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

I'm writing again on the topic of my post sent several hours ago to the
openvpn-users list. The post proposed the --ccd-exclusive option.

Since then I tried to setup chrooted openvpn server with the ccd
directory in the jail as well as the tls-verify script which was
checking the content of the ccd directory (see my previous post for the
reason). Even when I hosted shell, tun device, some so's from /lib in
the jail, openvpn was still unable to run my tls-verify script.

Nevertheless I didn't like the size of the jail directory after all. I
decided to write the proposed feature on my own. So the 2.0-beta11
source files, manual page was modified and an option helptexts was
added. (I have to state, the work on such source text is a delight.)
There was not clear to me, whether I kill the current instance
gracefully, it needs some other eye to check it.

The implementation is tested. IMO it properly reacts on the removal and
appearance of the CN-file in the client-config-directory.

I'm attaching the patch, because I hope someone else could find my
contribution useful. Now I'm able to push the fixed IP addresses by the
certificate CN as well as refuse non approved CN's from the single data
source (ccd). My chroot jail now contains just a couple of non binary
bytes. I'm happy for now. :-)

May I ask James to consider adding some form of this piece to the source
of his wonderful program?

Vlada


--------------050705080206080806000800
Content-Type: text/plain;
 name="openvpn-tuttle2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-tuttle2.diff"

diff -b -U2 openvpn-2.0_beta11-original/multi.c openvpn-2.0_beta11/multi.c
--- openvpn-2.0_beta11-original/multi.c	Mon Oct  4 20:56:44 2004
+++ openvpn-2.0_beta11/multi.c	Mon Oct  4 21:31:48 2004
@@ -847,5 +847,5 @@
  * Called as soon as the SSL/TLS connection authenticates.
  */
-static void
+static bool
 multi_connection_established (struct multi_context *m, struct multi_instance *mi)
 {
@@ -946,6 +946,18 @@
 	 &gc);
 
-      if (!test_file (dynamic_config_file))
+      if (!test_file (dynamic_config_file)) {
 	dynamic_config_file = NULL;
+
+	/*
+	 * In case we have --ccd-exclusive set and didn't find
+	 * appropriate dynamic config file, we kill the instance.
+	 */
+	if (mi->context.options.ccd_exclusive == true) {
+	  msg (D_MULTI_ERRORS, "MULTI: Dynamic config file not found and --ccd-exclusive set, terminating the instance.");
+	  mutex_unlock_static (L_SCRIPT);
+	  gc_free (&gc);
+	  return false;
+	}
+      }
     }
 
@@ -1054,4 +1066,6 @@
   mutex_unlock_static (L_SCRIPT);
   gc_free (&gc);
+
+  return true;
 }
 
@@ -1194,9 +1208,14 @@
 	  if (!mi->connection_established_flag && CONNECTION_ESTABLISHED (&mi->context))
 	    {
-	      multi_connection_established (m, mi);
+              if (multi_connection_established (m, mi) != true) {
+                multi_close_instance (m, mi, false);
+                ret = false;
+              }
 	      mi->connection_established_flag = true;
 	    }
 	}
     }
+
+  if (ret == true) {
   if (IS_SIG (&mi->context))
     {
@@ -1223,4 +1242,5 @@
 #endif
     }
+  }
 
   if (flags & MPP_RECORD_TOUCH && m->mpp_touched)
diff -b -U2 openvpn-2.0_beta11-original/openvpn.8 openvpn-2.0_beta11/openvpn.8
--- openvpn-2.0_beta11-original/openvpn.8	Mon Oct  4 20:56:44 2004
+++ openvpn-2.0_beta11/openvpn.8	Mon Oct  4 21:42:13 2004
@@ -106,4 +106,5 @@
 [\ \fB\-\-cipher\fR\ \fIalg\fR\ ]
 [\ \fB\-\-client\-config\-dir\fR\ \fIdir\fR\ ]
+[\ \fB\-\-ccd\-exclusive\fR\ ]
 [\ \fB\-\-client\-connect\fR\ ]
 [\ \fB\-\-client\-connect\fR\ \fIscript\fR\ ]
@@ -2169,4 +2170,12 @@
 and
 .B --config.
+.\"*********************************************************
+.TP
+.B --ccd-exclusive
+Refuse the connection from client whose
+X509 Common Name is
+.B not
+found in the directory specified by
+.B --client-config-dir.
 .\"*********************************************************
 .TP
diff -b -U2 openvpn-2.0_beta11-original/options.c openvpn-2.0_beta11/options.c
--- openvpn-2.0_beta11-original/options.c	Mon Oct  4 20:56:44 2004
+++ openvpn-2.0_beta11/options.c	Mon Oct  4 21:07:05 2004
@@ -267,4 +267,5 @@
   "--client-disconnect cmd : Run script cmd on client disconnection.\n"
   "--client-config-dir dir : Directory for custom client config files.\n"
+  "--ccd-exclusive : Refuses the conn when its custom client config is not found.\n"
   "--tmp-dir dir   : Temporary directory, used for --client-connect return file.\n"
   "--hash-size r v : Set the size of the real address hash table to r and the\n"
@@ -680,4 +681,5 @@
   SHOW_STR (client_disconnect_script);
   SHOW_STR (client_config_dir);
+  SHOW_BOOL (ccd_exclusive);
   SHOW_STR (tmp_dir);
   SHOW_BOOL (push_ifconfig_defined);
@@ -1183,4 +1185,6 @@
       if (options->explicit_exit_notification)
 	msg (M_USAGE, "Options error: --explicit-exit-notify cannot be used with --mode server");
+      if (options->ccd_exclusive && !options->client_config_dir)
+	msg (M_USAGE, "Options error: --ccd-exclusive cannot be used without --client-config-dir");
 
 #ifdef WIN32
@@ -2844,4 +2848,10 @@
       options->client_config_dir = p[1];
     }
+  else if (streq (p[0], "ccd-exclusive"))
+    {
+      ++i;
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->ccd_exclusive = true;
+    }      
   else if (streq (p[0], "bcast-buffers") && p[1])
     {
diff -b -U2 openvpn-2.0_beta11-original/options.h openvpn-2.0_beta11/options.h
--- openvpn-2.0_beta11-original/options.h	Mon Oct  4 20:56:44 2004
+++ openvpn-2.0_beta11/options.h	Mon Oct  4 21:07:05 2004
@@ -257,4 +257,7 @@
   const char *tmp_dir;
   const char *client_config_dir;
+  
+  bool ccd_exclusive;
+  
   int n_bcast_buf;
   int tcp_queue_limit;

--------------050705080206080806000800--

--------------enig6B52CA41CA66F150D1EE5F66
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBYaZU11BCQx8FlCQRAsaLAJ9BS+48dj1G23qQpFh2kAFiiwXJjgCgxO/k
UkCCVxFpJ9R1PYiq9I5S/+4=
=SFDm
-----END PGP SIGNATURE-----

--------------enig6B52CA41CA66F150D1EE5F66--

