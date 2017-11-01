From: Steffan Karger <steffan@...1856...>
Date: Wed,  1 Nov 2017 23:03:41 +0100
Message-Id: <20171101220342.14648-4-steffan@...1856...>
In-Reply-To: <20171101220342.14648-1-steffan@...1856...>
References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
 <20171101220342.14648-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 3/4 v2] Don't throw fatal errors from
 create_temp_file()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Steffan Karger <steffan.karger@...1435...>

This function is called in response to connecting clients, and can fail
when I/O fails for some (possibly temporary) reason.  In such cases we
should not exit the process, but just reject the connecting client.

This commit changes the function to actually return NULL on errors, and
(where needed) changes the callers to check for and handle errors.

Since the tls-crypt-v2 metadata code also calls create_temp_file() when
clients connect, I consider this a prerequisite for tls-crypt-v2.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
v2: put || at the beginning of a line (not the end)

 src/openvpn/misc.c       |  6 +++---
 src/openvpn/ssl_verify.c | 32 +++++++++++++++++++++-----------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 8c7f6116..25f38003 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -740,7 +740,7 @@ create_temp_file(const char *directory, const char *prefix, struct gc_arena *gc)
         retfname = gen_path(directory, BSTR(&fname), gc);
         if (!retfname)
         {
-            msg(M_FATAL, "Failed to create temporary filename and path");
+            msg(M_WARN, "Failed to create temporary filename and path");
             return NULL;
         }
 
@@ -755,14 +755,14 @@ create_temp_file(const char *directory, const char *prefix, struct gc_arena *gc)
         else if (fd == -1 && errno != EEXIST)
         {
             /* Something else went wrong, no need to retry.  */
-            msg(M_FATAL | M_ERRNO, "Could not create temporary file '%s'",
+            msg(M_WARN | M_ERRNO, "Could not create temporary file '%s'",
                 retfname);
             return NULL;
         }
     }
     while (attempts < 6);
 
-    msg(M_FATAL, "Failed to create temporary file after %i attempts", attempts);
+    msg(M_WARN, "Failed to create temporary file after %i attempts", attempts);
     return NULL;
 }
 
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 9cd36d7a..de54fb74 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -547,14 +547,14 @@ verify_cert_export_cert(openvpn_x509_cert_t *peercert, const char *tmp_dir, stru
     FILE *peercert_file;
     const char *peercert_filename = "";
 
-    if (!tmp_dir)
+    /* create tmp file to store peer cert */
+    if (!tmp_dir
+        || !(peercert_filename = create_temp_file(tmp_dir, "pcf", gc)))
     {
+        msg (M_WARN, "Failed to create peer cert file");
         return NULL;
     }
 
-    /* create tmp file to store peer cert */
-    peercert_filename = create_temp_file(tmp_dir, "pcf", gc);
-
     /* write peer-cert in tmp-file */
     peercert_file = fopen(peercert_filename, "w+");
     if (!peercert_file)
@@ -589,10 +589,13 @@ verify_cert_call_command(const char *verify_command, struct env_set *es,
 
     if (verify_export_cert)
     {
-        if ((tmp_file = verify_cert_export_cert(cert, verify_export_cert, &gc)))
+        tmp_file = verify_cert_export_cert(cert, verify_export_cert, &gc);
+        if (!tmp_file)
         {
-            setenv_str(es, "peer_cert", tmp_file);
+            ret = false;
+            goto cleanup;
         }
+        setenv_str(es, "peer_cert", tmp_file);
     }
 
     argv_parse_cmd(&argv, verify_command);
@@ -609,6 +612,7 @@ verify_cert_call_command(const char *verify_command, struct env_set *es,
         }
     }
 
+cleanup:
     gc_free(&gc);
     argv_reset(&argv);
 
@@ -879,21 +883,21 @@ key_state_rm_auth_control_file(struct key_state *ks)
     }
 }
 
-static void
+static bool
 key_state_gen_auth_control_file(struct key_state *ks, const struct tls_options *opt)
 {
     struct gc_arena gc = gc_new();
-    const char *acf;
 
     key_state_rm_auth_control_file(ks);
-    acf = create_temp_file(opt->tmp_dir, "acf", &gc);
+    const char *acf = create_temp_file(opt->tmp_dir, "acf", &gc);
     if (acf)
     {
         ks->auth_control_file = string_alloc(acf, NULL);
         setenv_str(opt->es, "auth_control_file", ks->auth_control_file);
-    } /* FIXME: Should have better error handling? */
+    }
 
     gc_free(&gc);
+    return acf;
 }
 
 static unsigned int
@@ -1184,7 +1188,12 @@ verify_user_pass_plugin(struct tls_session *session, const struct user_pass *up,
 
 #ifdef PLUGIN_DEF_AUTH
         /* generate filename for deferred auth control file */
-        key_state_gen_auth_control_file(ks, session->opt);
+        if (!key_state_gen_auth_control_file(ks, session->opt))
+        {
+            msg (D_TLS_ERRORS, "TLS Auth Error (%s): "
+                 "could not create deferred auth control file", __func__);
+            goto cleanup;
+        }
 #endif
 
         /* call command */
@@ -1209,6 +1218,7 @@ verify_user_pass_plugin(struct tls_session *session, const struct user_pass *up,
         msg(D_TLS_ERRORS, "TLS Auth Error (verify_user_pass_plugin): peer provided a blank username");
     }
 
+cleanup:
     return retval;
 }
 
-- 
2.14.1


