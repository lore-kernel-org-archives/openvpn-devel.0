From: Gert Doering <gert@...1296...>
Date: Thu,  7 Mar 2024 15:03:55 +0100
Message-ID: <20240307140355.32644-1-gert@...1296...>
In-Reply-To: <gerrit.1708351044000.I57f1c2ed42bd9dfd43577238749a9b7f4c1419ff@...2715...>
References: <gerrit.1708351044000.I57f1c2ed42bd9dfd43577238749a9b7f4c1419ff@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] Persist-key: enable persist-key option
 by default
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

From: Gianmarco De Gregori <gianmarco@...2726...>

Change the default behavior of the OpenVPN configuration
by enabling the persist-key option by default.

This means that all the keys will be kept in memory
across restart.

Fixes: Trac #1405
Change-Id: I57f1c2ed42bd9dfd43577238749a9b7f4c1419ff
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/529
This mail reflects revision 5 of this Change.
Acked-by according to Gerrit (reflected above):

        
diff --git a/Changes.rst b/Changes.rst
index 58cb3db..4cded98 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -20,6 +20,8 @@
     When configured to authenticate with NTLMv1 (``ntlm`` keyword in
     ``--http-proxy``) OpenVPN will try NTLMv2 instead.
 
+``persist-key`` option has been enabled by default.
+    All the keys will be kept in memory across restart.
 
 Overview of changes in 2.6
 ==========================
diff --git a/doc/man-sections/connection-profiles.rst b/doc/man-sections/connection-profiles.rst
index c8816e1..520bbef 100644
--- a/doc/man-sections/connection-profiles.rst
+++ b/doc/man-sections/connection-profiles.rst
@@ -39,7 +39,6 @@
    http-proxy 192.168.0.8 8080
    </connection>
 
-   persist-key
    persist-tun
    pkcs12 client.p12
    remote-cert-tls server
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index 30c990d..f8a0f48 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -302,17 +302,6 @@
   Change process priority after initialization (``n`` greater than 0 is
   lower priority, ``n`` less than zero is higher priority).
 
---persist-key
-  Don't re-read key files across :code:`SIGUSR1` or ``--ping-restart``.
-
-  This option can be combined with ``--user`` to allow restarts
-  triggered by the :code:`SIGUSR1` signal. Normally if you drop root
-  privileges in OpenVPN, the daemon cannot be restarted since it will now
-  be unable to re-read protected key files.
-
-  This option solves the problem by persisting keys across :code:`SIGUSR1`
-  resets, so they don't need to be re-read.
-
 --providers providers
   Load the list of (OpenSSL) providers. This is mainly useful for using an
   external provider for key management like tpm2-openssl or to load the
@@ -402,7 +391,7 @@
 
   Like with chroot, complications can result when scripts or restarts are
   executed after the setcon operation, which is why you should really
-  consider using the ``--persist-key`` and ``--persist-tun`` options.
+  consider using the ``--persist-tun`` option.
 
 --status args
   Write operational status to ``file`` every ``n`` seconds. ``n`` defaults
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index ca26bfe..ca192c3 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -283,7 +283,7 @@
   See the signals section below for more information on :code:`SIGUSR1`.
 
   Note that the behavior of ``SIGUSR1`` can be modified by the
-  ``--persist-tun``, ``--persist-key``, ``--persist-local-ip`` and
+  ``--persist-tun``, ``--persist-local-ip`` and
   ``--persist-remote-ip`` options.
 
   Also note that ``--ping-exit`` and ``--ping-restart`` are mutually
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 98f5340..0632e31 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -452,7 +452,7 @@
   ``--route``, ``--route-gateway``, ``--route-delay``,
   ``--redirect-gateway``, ``--ip-win32``, ``--dhcp-option``, ``--dns``,
   ``--inactive``, ``--ping``, ``--ping-exit``, ``--ping-restart``,
-  ``--setenv``, ``--auth-token``, ``--persist-key``, ``--persist-tun``,
+  ``--setenv``, ``--auth-token``, ``--persist-tun``,
   ``--echo``, ``--comp-lzo``, ``--socket-flags``, ``--sndbuf``,
   ``--rcvbuf``, ``--session-timeout``
 
diff --git a/doc/man-sections/signals.rst b/doc/man-sections/signals.rst
index 63611b3..01e8e5b 100644
--- a/doc/man-sections/signals.rst
+++ b/doc/man-sections/signals.rst
@@ -10,9 +10,8 @@
     Like :code:`SIGHUP``, except don't re-read configuration file, and
     possibly don't close and reopen TUN/TAP device, re-read key files,
     preserve local IP address/port, or preserve most recently authenticated
-    remote IP address/port based on ``--persist-tun``, ``--persist-key``,
-    ``--persist-local-ip`` and ``--persist-remote-ip`` options respectively
-    (see above).
+    remote IP address/port based on ``--persist-tun``, ``--persist-local-ip``
+    and ``--persist-remote-ip`` options respectively (see above).
 
     This signal may also be internally generated by a timeout condition,
     governed by the ``--ping-restart`` option.
diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/unsupported-options.rst
index a0c1232..11467ca 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -42,3 +42,6 @@
 
 --prng
   Removed in OpenVPN 2.6.  We now always use the PRNG of the SSL library.
+
+--persist-key
+  Ignored since OpenVPN 2.7. Keys are now always persisted across restarts.
\ No newline at end of file
diff --git a/sample/sample-config-files/client.conf b/sample/sample-config-files/client.conf
index 15cb1b3..f51e017 100644
--- a/sample/sample-config-files/client.conf
+++ b/sample/sample-config-files/client.conf
@@ -62,7 +62,6 @@
 ;group openvpn
 
 # Try to preserve some state across restarts.
-persist-key
 persist-tun
 
 # If you are connecting through an
diff --git a/sample/sample-config-files/server.conf b/sample/sample-config-files/server.conf
index d9345b6..009fe56 100644
--- a/sample/sample-config-files/server.conf
+++ b/sample/sample-config-files/server.conf
@@ -274,11 +274,10 @@
 ;user openvpn
 ;group openvpn
 
-# The persist options will try to avoid
+# The persist option will try to avoid
 # accessing certain resources on restart
 # that may no longer be accessible because
 # of the privilege downgrade.
-persist-key
 persist-tun
 
 # Output a short status file showing
diff --git a/sample/sample-windows/sample.ovpn b/sample/sample-windows/sample.ovpn
index 51e3274..be24faa 100755
--- a/sample/sample-windows/sample.ovpn
+++ b/sample/sample-windows/sample.ovpn
@@ -89,7 +89,6 @@
 ; ping-restart 60
 ; ping-timer-rem
 ; persist-tun
-; persist-key
 ; resolv-retry 86400
 
 # keep-alive ping
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 52b4308..52b3931 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3559,14 +3559,6 @@
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
@@ -3857,7 +3849,7 @@
 do_close_free_key_schedule(struct context *c, bool free_ssl_ctx)
 {
     /*
-     * always free the tls_auth/crypt key. If persist_key is true, the key will
+     * always free the tls_auth/crypt key. The key will
      * be reloaded from memory (pre-cached)
      */
     free_key_ctx(&c->c1.ks.tls_crypt_v2_server_key);
@@ -3866,7 +3858,7 @@
     buf_clear(&c->c1.ks.tls_crypt_v2_wkc);
     free_buf(&c->c1.ks.tls_crypt_v2_wkc);
 
-    if (!(c->sig->signal_received == SIGUSR1 && c->options.persist_key))
+    if (!(c->sig->signal_received == SIGUSR1))
     {
         key_schedule_free(&c->c1.ks, free_ssl_ctx);
     }
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index dabc5be..df93b0e 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -48,7 +48,7 @@
 
 /*
  * Our global key schedules, packaged thusly
- * to facilitate --persist-key.
+ * to facilitate key persistence.
  */
 
 struct key_schedule
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2c79a1e..94a88f9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -273,7 +273,6 @@
     "--persist-tun   : Keep tun/tap device open across SIGUSR1 or --ping-restart.\n"
     "--persist-remote-ip : Keep remote IP address across SIGUSR1 or --ping-restart.\n"
     "--persist-local-ip  : Keep local IP address across SIGUSR1 or --ping-restart.\n"
-    "--persist-key   : Don't re-read key files across SIGUSR1 or --ping-restart.\n"
 #if PASSTOS_CAPABILITY
     "--passtos       : TOS passthrough (applies to IPv4 only).\n"
 #endif
@@ -1857,7 +1856,6 @@
     SHOW_BOOL(persist_tun);
     SHOW_BOOL(persist_local_ip);
     SHOW_BOOL(persist_remote_ip);
-    SHOW_BOOL(persist_key);
 
 #if PASSTOS_CAPABILITY
     SHOW_BOOL(passtos);
@@ -3240,18 +3238,16 @@
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
@@ -6963,7 +6959,8 @@
     else if (streq(p[0], "persist-key") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_PERSIST);
-        options->persist_key = true;
+        msg(M_WARN, "DEPRECATED: --persist-key option ignored. "
+            "Keys are now always persisted across restarts. ");
     }
     else if (streq(p[0], "persist-local-ip") && !p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 85de887..2b37d1f 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -344,7 +344,6 @@
     bool persist_tun;           /* Don't close/reopen TUN/TAP dev on SIGUSR1 or PING_RESTART */
     bool persist_local_ip;      /* Don't re-resolve local address on SIGUSR1 or PING_RESTART */
     bool persist_remote_ip;     /* Don't re-resolve remote address on SIGUSR1 or PING_RESTART */
-    bool persist_key;           /* Don't re-read key files on SIGUSR1 or PING_RESTART */
 
 #if PASSTOS_CAPABILITY
     bool passtos;

