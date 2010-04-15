Message-ID: <4BC78077.80301@...1114...>
Date: Thu, 15 Apr 2010 23:09:11 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080700050403080703080402"
Subject: [Openvpn-devel] [PATCH] Harden create_temp_filename()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Yonan <james@...515...>
Cc: Openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080700050403080703080402
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi James,

As promised in the meeting today, a patch for hardening
create_temp_filename().

I've added more checks to what create_temp_filename() returns where it
is called in addition, to make it even safer.

Please let me know what you think.  If you give it an ACK, I'll add it
to the bugfix2.1 branch and you can pull it in this way via the git tree.


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvHgHcACgkQDC186MBRfrqMJQCglUwA/PADkK68C0w8RKYfEXtS
TO8Anj3WYgx8dLQjdFILRYfRd26+7fw8
=eAtA
-----END PGP SIGNATURE-----

--------------080700050403080703080402
Content-Type: text/plain;
 name="0001-Harden-create_temp_filename.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-Harden-create_temp_filename.patch"

From 4eb6bce934492e3b6bf00e86bbaae4026d4da51d Mon Sep 17 00:00:00 2001
From: David Sommerseth <dazo@...384...>
Date: Thu, 15 Apr 2010 23:00:27 +0200
Subject: [PATCH] Harden create_temp_filename()

In a Debian bug report [1] there were worries that the --client-connect
script hook was prune to a "symlink" attack.  Even though this can
be recognised if --tmp-dir is set to a world writable directory, it is not
considered standard practice to do so.

By hardening the create_temp_filename() function to check if the generated
filename exists and to create the temp file with only S_IRUSR|S_IWUSR bit
files set before calling the script, it should become even more difficult to
exploit such a scenario.

[1] <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=534908>

Signed-off-by: David Sommerseth <dazo@...384...>
---
 misc.c    |   38 ++++++++++++++++++++++++++++++++------
 multi.c   |   15 ++++++++++++---
 openvpn.8 |    2 +-
 pf.c      |   31 ++++++++++++++++---------------
 ssl.c     |   32 +++++++++++++++++++-------------
 5 files changed, 80 insertions(+), 38 deletions(-)

diff --git a/misc.c b/misc.c
index b52a042..435d745 100644
--- a/misc.c
+++ b/misc.c
@@ -1169,21 +1169,47 @@ create_temp_filename (const char *directory, const char *prefix, struct gc_arena
 {
   static unsigned int counter;
   struct buffer fname = alloc_buf_gc (256, gc);
+  int fd;
+  const char *retfname = NULL;
+  unsigned int attempts = 0;
 
-  mutex_lock_static (L_CREATE_TEMP);
-  ++counter;
-  mutex_unlock_static (L_CREATE_TEMP);
-
-  {
+  do {
     uint8_t rndbytes[16];
     const char *rndstr;
 
+    attempts++;
+    mutex_lock_static (L_CREATE_TEMP);
+    ++counter;
+    mutex_unlock_static (L_CREATE_TEMP);
+
     prng_bytes (rndbytes, sizeof (rndbytes));
     rndstr = format_hex_ex (rndbytes, sizeof (rndbytes), 40, 0, NULL, gc);
     buf_printf (&fname, PACKAGE "_%s_%s.tmp", prefix, rndstr);
+
+    retfname = gen_path (directory, BSTR (&fname), gc);
+    if( !retfname ) {
+      msg (M_FATAL, "Failed to create temporary filename and path");
+      return NULL;
+    }
+  } while ( test_file (retfname) && (attempts < 6) );
+
+  if( attempts > 5 ) {
+    msg (M_FATAL, "Failed to create temporary file after %i attempts", attempts);
+    return NULL;
+  }
+
+  /* Create the tempfile to avoid a race condition */
+  fd = creat (retfname, S_IRUSR | S_IWUSR);
+  if( fd == -1 ) {
+    struct gc_arena gcerr = gc_new ();
+    msg (M_FATAL, "Could not create temporary file '%s': %s",
+         retfname, strerror_ts (errno, &gcerr));
+    gc_free (&gcerr);
+    return NULL;
   }
+  close (fd);
 
-  return gen_path (directory, BSTR (&fname), gc);
+  return retfname;
 }
 
 /*
diff --git a/multi.c b/multi.c
index 2b04428..e8d5eb4 100644
--- a/multi.c
+++ b/multi.c
@@ -1531,6 +1531,12 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 	{
 	  struct argv argv = argv_new ();
 	  const char *dc_file = create_temp_filename (mi->context.options.tmp_dir, "cc", &gc);
+
+          if( !dc_file ) {
+            cc_succeeded = false;
+            goto script_depr_failed;
+          }
+
 	  argv_printf (&argv, "%s", dc_file);
 	  delete_file (dc_file);
 	  if (plugin_call (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT, &argv, NULL, mi->context.c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
@@ -1543,6 +1549,7 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 	      multi_client_connect_post (m, mi, dc_file, option_permissions_mask, &option_types_found);
 	      ++cc_succeeded_count;
 	    }
+        script_depr_failed:
 	  argv_reset (&argv);
 	}
 
@@ -1579,8 +1586,10 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 	  setenv_str (mi->context.c2.es, "script_type", "client-connect");
 
 	  dc_file = create_temp_filename (mi->context.options.tmp_dir, "cc", &gc);
-
-	  delete_file (dc_file);
+          if( !dc_file ) {
+            cc_succeeded = false;
+            goto script_failed;
+          }
 
 	  argv_printf (&argv, "%sc %s",
 		       mi->context.options.client_connect_script,
@@ -1593,7 +1602,7 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 	    }
 	  else
 	    cc_succeeded = false;
-
+        script_failed:
 	  argv_reset (&argv);
 	}
 
diff --git a/openvpn.8 b/openvpn.8
index 82e7d24..301cd37 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -2814,7 +2814,7 @@ on client connection.  The script is passed the common name
 and IP address of the just-authenticated client
 as environmental variables (see environmental variable section
 below).  The script is also passed
-the pathname of a not-yet-created temporary file as $1
+the pathname of a freshly created temporary file as $1
 (i.e. the first command line argument), to be used by the script
 to pass dynamically generated config file directives back to OpenVPN.
 
diff --git a/pf.c b/pf.c
index 027eb69..c979461 100644
--- a/pf.c
+++ b/pf.c
@@ -555,23 +555,24 @@ pf_init_context (struct context *c)
   if (plugin_defined (c->plugins, OPENVPN_PLUGIN_ENABLE_PF))
     {
       const char *pf_file = create_temp_filename (c->options.tmp_dir, "pf", &gc);
-      delete_file (pf_file);
-      setenv_str (c->c2.es, "pf_file", pf_file);
-
-      if (plugin_call (c->plugins, OPENVPN_PLUGIN_ENABLE_PF, NULL, NULL, c->c2.es) == OPENVPN_PLUGIN_FUNC_SUCCESS)
-	{
-	  event_timeout_init (&c->c2.pf.reload, 1, now);
-	  c->c2.pf.filename = string_alloc (pf_file, NULL);
-	  c->c2.pf.enabled = true;
+      if( pf_file ) {
+        setenv_str (c->c2.es, "pf_file", pf_file);
+
+        if (plugin_call (c->plugins, OPENVPN_PLUGIN_ENABLE_PF, NULL, NULL, c->c2.es) == OPENVPN_PLUGIN_FUNC_SUCCESS)
+          {
+            event_timeout_init (&c->c2.pf.reload, 1, now);
+            c->c2.pf.filename = string_alloc (pf_file, NULL);
+            c->c2.pf.enabled = true;
 #ifdef ENABLE_DEBUG
-	  if (check_debug_level (D_PF_DEBUG))
-	    pf_context_print (&c->c2.pf, "pf_init_context#1", D_PF_DEBUG);
+            if (check_debug_level (D_PF_DEBUG))
+              pf_context_print (&c->c2.pf, "pf_init_context#1", D_PF_DEBUG);
 #endif
-	}
-      else
-	{
-	  msg (M_WARN, "WARNING: OPENVPN_PLUGIN_ENABLE_PF disabled");
-	}
+          }
+        else
+          {
+            msg (M_WARN, "WARNING: OPENVPN_PLUGIN_ENABLE_PF disabled");
+          }
+      }
     }
 #endif
 #ifdef MANAGEMENT_PF
diff --git a/ssl.c b/ssl.c
index ddd5ee7..b467368 100644
--- a/ssl.c
+++ b/ssl.c
@@ -1095,9 +1095,10 @@ key_state_gen_auth_control_file (struct key_state *ks, const struct tls_options
 
   key_state_rm_auth_control_file (ks);
   acf = create_temp_filename (opt->tmp_dir, "acf", &gc);
-  ks->auth_control_file = string_alloc (acf, NULL);
-  setenv_str (opt->es, "auth_control_file", ks->auth_control_file);
-
+  if( acf ) {
+    ks->auth_control_file = string_alloc (acf, NULL);
+    setenv_str (opt->es, "auth_control_file", ks->auth_control_file);
+  } /* FIXME: Should have better error handling? */
   gc_free (&gc);					  
 }
 
@@ -3145,16 +3146,21 @@ verify_user_pass_script (struct tls_session *session, const struct user_pass *up
 	  struct status_output *so;
 
 	  tmp_file = create_temp_filename (session->opt->tmp_dir, "up", &gc);
-	  so = status_open (tmp_file, 0, -1, NULL, STATUS_OUTPUT_WRITE);
-	  status_printf (so, "%s", up->username);
-	  status_printf (so, "%s", up->password);
-	  if (!status_close (so))
-	    {
-	      msg (D_TLS_ERRORS, "TLS Auth Error: could not write username/password to file: %s",
-		   tmp_file);
-	      goto done;
-	    }
-	}
+          if( tmp_file ) {
+            so = status_open (tmp_file, 0, -1, NULL, STATUS_OUTPUT_WRITE);
+            status_printf (so, "%s", up->username);
+            status_printf (so, "%s", up->password);
+            if (!status_close (so))
+              {
+                msg (D_TLS_ERRORS, "TLS Auth Error: could not write username/password to file: %s",
+                     tmp_file);
+                goto done;
+              }
+          } else {
+            msg (D_TLS_ERRORS, "TLS Auth Error: could not create write "
+                 "username/password to temp file");
+          }
+        }
       else
 	{
 	  setenv_str (session->opt->es, "username", up->username);
-- 
1.6.6.1


--------------080700050403080703080402
Content-Type: application/pgp-signature;
	name="0001-Harden-create_temp_filename.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0001-Harden-create_temp_filename.patch.sig"

iEYEABECAAYFAkvHgHcACgkQDC186MBRfro0kQCeJ8Xt7Fhs9F4Go2CrqHngMOa5/RMAoKBX
riwIP/jVW3MAKbL1NGFl4hgN
--------------080700050403080703080402--

