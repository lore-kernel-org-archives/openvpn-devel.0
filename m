From: Gianmarco De Gregori <gianmarco@...2726...>
Date: Thu, 25 May 2023 16:40:46 +0200
Message-Id: <20230525144045.5484-1-gianmarco@...2726...>
In-Reply-To: <20230509154657.2756-1-gianmarco@...2726...>
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Persist-key: enable persist-key option
 by default.
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

This commit changes the default behavior of the OpenVPN
configuration to enable the persist-key option by default.

This means that all the key file content will be kept
in memory throughout the lifetime of the VPN connection.

Fixes: Trac #1405
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
Changes from v1:
* changed "DEPRECATED OPTION" with "**DEPRECATED**" in the documentation
  and with "(DEPRECATED)" in usage_message().
  
 doc/man-sections/generic-options.rst |  2 ++
 src/openvpn/init.c                   | 13 +++----------
 src/openvpn/options.c                | 26 +++++++++++++-------------
 src/openvpn/options.h                |  1 -
 4 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index 97e1b5aa..6c23aafc 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -303,6 +303,8 @@ which mode OpenVPN is configured as.
   lower priority, ``n`` less than zero is higher priority).
 
 --persist-key
+  **DEPRECATED**, corresponding behavior is now always enabled.
+
   Don't re-read key files across :code:`SIGUSR1` or ``--ping-restart``.
 
   This option can be combined with ``--user`` to allow restarts
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index d358ad00..36d4395c 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3606,14 +3606,6 @@ do_option_warnings(struct context *c)
         {
             msg(M_WARN, "WARNING: you are using user/group/chroot/setcon without persist-tun -- this may cause restarts to fail");
         }
-        if (!o->persist_key
-#ifdef ENABLE_PKCS11
-            && !o->pkcs11_id
-#endif
-            )
-        {
-            msg(M_WARN, "WARNING: you are using user/group/chroot/setcon without persist-key -- this may cause restarts to fail");
-        }
     }
 
     if (o->chroot_dir && !(o->username && o->groupname))
@@ -3687,6 +3679,7 @@ do_option_warnings(struct context *c)
     }
 }
 
+
 struct context_buffers *
 init_context_buffers(const struct frame *frame)
 {
@@ -3901,7 +3894,7 @@ static void
 do_close_free_key_schedule(struct context *c, bool free_ssl_ctx)
 {
     /*
-     * always free the tls_auth/crypt key. If persist_key is true, the key will
+     * always free the tls_auth/crypt key. The key will
      * be reloaded from memory (pre-cached)
      */
     free_key_ctx(&c->c1.ks.tls_crypt_v2_server_key);
@@ -3910,7 +3903,7 @@ do_close_free_key_schedule(struct context *c, bool free_ssl_ctx)
     buf_clear(&c->c1.ks.tls_crypt_v2_wkc);
     free_buf(&c->c1.ks.tls_crypt_v2_wkc);
 
-    if (!(c->sig->signal_received == SIGUSR1 && c->options.persist_key))
+    if (!(c->sig->signal_received == SIGUSR1))
     {
         key_schedule_free(&c->c1.ks, free_ssl_ctx);
     }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e4c596b8..caf45b7e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -275,7 +275,7 @@ static const char usage_message[] =
     "--persist-tun   : Keep tun/tap device open across SIGUSR1 or --ping-restart.\n"
     "--persist-remote-ip : Keep remote IP address across SIGUSR1 or --ping-restart.\n"
     "--persist-local-ip  : Keep local IP address across SIGUSR1 or --ping-restart.\n"
-    "--persist-key   : Don't re-read key files across SIGUSR1 or --ping-restart.\n"
+    "--persist-key   : (DEPRECATED) Don't re-read key files across SIGUSR1 or --ping-restart.\n"
 #if PASSTOS_CAPABILITY
     "--passtos       : TOS passthrough (applies to IPv4 only).\n"
 #endif
@@ -1860,7 +1860,6 @@ show_settings(const struct options *o)
     SHOW_BOOL(persist_tun);
     SHOW_BOOL(persist_local_ip);
     SHOW_BOOL(persist_remote_ip);
-    SHOW_BOOL(persist_key);
 
 #if PASSTOS_CAPABILITY
     SHOW_BOOL(passtos);
@@ -3239,18 +3238,16 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
         ce->tls_crypt_v2_file_inline = o->tls_crypt_v2_file_inline;
     }
 
-    /* Pre-cache tls-auth/crypt(-v2) key file if persist-key was specified and
+    /* Pre-cache tls-auth/crypt(-v2) key file if
      * keys were not already embedded in the config file.
      */
-    if (o->persist_key)
-    {
-        connection_entry_preload_key(&ce->tls_auth_file,
-                                     &ce->tls_auth_file_inline, &o->gc);
-        connection_entry_preload_key(&ce->tls_crypt_file,
-                                     &ce->tls_crypt_file_inline, &o->gc);
-        connection_entry_preload_key(&ce->tls_crypt_v2_file,
-                                     &ce->tls_crypt_v2_file_inline, &o->gc);
-    }
+    connection_entry_preload_key(&ce->tls_auth_file,
+                                 &ce->tls_auth_file_inline, &o->gc);
+    connection_entry_preload_key(&ce->tls_crypt_file,
+                                 &ce->tls_crypt_file_inline, &o->gc);
+    connection_entry_preload_key(&ce->tls_crypt_v2_file,
+                                 &ce->tls_crypt_v2_file_inline, &o->gc);
+
 
     if (!proto_is_udp(ce->proto) && ce->explicit_exit_notification)
     {
@@ -6938,7 +6935,10 @@ add_option(struct options *options,
     else if (streq(p[0], "persist-key") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_PERSIST);
-        options->persist_key = true;
+        msg(M_WARN, "DEPRECATED: --persist-key option ignored."
+            "The corresponding behavior will now always be done automatically."
+            "This option will be removed in a future version, "
+            "please remove it from your configuration.");
     }
     else if (streq(p[0], "persist-local-ip") && !p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index f5890b90..cf9613b2 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -344,7 +344,6 @@ struct options
     bool persist_tun;           /* Don't close/reopen TUN/TAP dev on SIGUSR1 or PING_RESTART */
     bool persist_local_ip;      /* Don't re-resolve local address on SIGUSR1 or PING_RESTART */
     bool persist_remote_ip;     /* Don't re-resolve remote address on SIGUSR1 or PING_RESTART */
-    bool persist_key;           /* Don't re-read key files on SIGUSR1 or PING_RESTART */
 
 #if PASSTOS_CAPABILITY
     bool passtos;
-- 
2.37.2


