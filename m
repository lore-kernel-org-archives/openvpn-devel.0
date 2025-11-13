From: Gert Doering <gert@...1296...>
Date: Thu, 13 Nov 2025 22:21:38 +0100
Message-ID: <20251113212143.30034-1-gert@...1296...>
In-Reply-To: <gerrit.1762958138000.Ia60a393a296f23ac1090d0f2016b5682649ed490@...2715...>
References: <gerrit.1762958138000.Ia60a393a296f23ac1090d0f2016b5682649ed490@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] options: remove --opt-verify
 functionality
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

From: Antonio Quartulli <antonio@...2726...>

As previously agreed, the --opt-verify directive is deprecated
and can be fully removed as of OpenVPN 2.7.0.

GitHub: closes OpenVPN/openvpn#901
Change-Id: Ia60a393a296f23ac1090d0f2016b5682649ed490
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1375
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1375
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/Changes.rst b/Changes.rst
index 8bdb2b0..457d3a7 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -236,6 +236,9 @@
 ``--reneg-bytes`` and ``--reneg-packets`` do not work in DCO mode, and will
     now print an appropriate warning.
 
+``--opt-verify`` feature removed
+    This option was already deprecated and it is now being converted to a
+    no-op. Using this option will only print a warning.
 
 User-visible Changes
 --------------------
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index ade4d41..5243a06 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -413,19 +413,6 @@
   Note that this directive affects OpenVPN's internal routing table, not
   the kernel routing table.
 
---opt-verify
-  **DEPRECATED** Clients that connect with options that are incompatible with
-  those of the server will be disconnected.
-
-  Options that will be compared for compatibility include ``dev-type``,
-  ``link-mtu``, ``tun-mtu``, ``proto``, ``ifconfig``,
-  ``comp-lzo``, ``fragment``, ``keydir``, ``cipher``,
-  ``auth``, ``keysize``,
-  ``tls-auth``, ``key-method``, ``tls-server``
-  and ``tls-client``.
-
-  This option requires that ``--disable-occ`` NOT be used.
-
 --override-username username
   Sets the username of a connection to the specified username.  This username
   will also be used by ``--auth-gen-token``. However, the overridden
diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/unsupported-options.rst
index 11467ca..e8e76eb 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -44,4 +44,8 @@
   Removed in OpenVPN 2.6.  We now always use the PRNG of the SSL library.
 
 --persist-key
-  Ignored since OpenVPN 2.7. Keys are now always persisted across restarts.
\ No newline at end of file
+  Ignored since OpenVPN 2.7. Keys are now always persisted across restarts.
+
+--opt-verify
+  Removed in OpenVPN 2.7.  This option does not make sense anymore as option
+  strings may not match due to the introduction of parameters negotiation.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ecf9374..683543a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -472,8 +472,6 @@
     "                  OTP based two-factor auth mechanisms are in use and\n"
     "                  --reneg-* options are enabled. Optionally a lifetime in seconds\n"
     "                  for generated tokens can be set.\n"
-    "--opt-verify    : (DEPRECATED) Clients that connect with options that are incompatible\n"
-    "                  with those of the server will be disconnected.\n"
     "--auth-user-pass-optional : Allow connections by clients that don't\n"
     "                  specify a username/password.\n"
     "--no-name-remapping : (DEPRECATED) Allow Common Name and X509 Subject to include\n"
@@ -2666,7 +2664,6 @@
                       "verify-client-cert");
         MUST_BE_FALSE(options->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME, "username-as-common-name");
         MUST_BE_FALSE(options->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL, "auth-user-pass-optional");
-        MUST_BE_FALSE(options->ssl_flags & SSLF_OPT_VERIFY, "opt-verify");
         if (options->server_flags & SF_TCP_NODELAY_HELPER)
         {
             msg(M_WARN, "WARNING: setting tcp-nodelay on the client side will not "
@@ -7450,9 +7447,7 @@
     else if (streq(p[0], "opt-verify") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        msg(M_INFO, "DEPRECATION: opt-verify is deprecated and will be removed "
-                    "in OpenVPN 2.7");
-        options->ssl_flags |= SSLF_OPT_VERIFY;
+        msg(M_INFO, "DEPRECATED OPTION: --opt-verify was removed in OpenVPN 2.7.");
     }
     else if (streq(p[0], "auth-user-pass-verify") && p[1])
     {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index d7f55dd..896fd65 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2334,13 +2334,6 @@
 #endif
 
         options_warning(options, remote_options);
-
-        if (session->opt->ssl_flags & SSLF_OPT_VERIFY)
-        {
-            msg(D_TLS_ERRORS,
-                "Option inconsistency warnings triggering disconnect due to --opt-verify");
-            ks->authenticated = KS_AUTH_FALSE;
-        }
     }
 
     buf_clear(buf);
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index de89d30..23da8cf 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -425,7 +425,7 @@
 #define SSLF_CLIENT_CERT_OPTIONAL     (1u << 1)
 #define SSLF_USERNAME_AS_COMMON_NAME  (1u << 2)
 #define SSLF_AUTH_USER_PASS_OPTIONAL  (1u << 3)
-#define SSLF_OPT_VERIFY               (1u << 4)
+/* (1u << 4) free for usage */
 #define SSLF_CRL_VERIFY_DIR           (1u << 5)
 #define SSLF_TLS_VERSION_MIN_SHIFT    6
 #define SSLF_TLS_VERSION_MIN_MASK     0xFu /* (uses bit positions 6 to 9) */

