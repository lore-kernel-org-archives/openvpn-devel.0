From: Gert Doering <gert@...1296...>
Date: Wed, 10 Dec 2025 08:50:50 +0100
Message-ID: <20251210075056.27185-1-gert@...1296...>
In-Reply-To: <gerrit.1765287788000.I59995bf0fd6bc48a738a94e41141ed37d8d637ba@...2715...>
References: <gerrit.1765287788000.I59995bf0fd6bc48a738a94e41141ed37d8d637ba@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] options: Remove some verbose error
 messages for options deprecated in 2.4
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

From: Frank Lichtenheld <frank@...2641...>

It has been a long time since 2.3. So move this from the code
to the documentation.

Includes some minimal drive-by fixes.

Change-Id: I59995bf0fd6bc48a738a94e41141ed37d8d637ba
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1427
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1427
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/unsupported-options.rst
index 821ac07..6e77333 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -6,9 +6,16 @@
 longer supported
 
 --client-cert-not-required
-  Removed in OpenVPN 2.5.  This should be replaxed with
+  Removed in OpenVPN 2.5.  This should be replaced with
   ``--verify-client-cert none``.
 
+--http-proxy-retry
+  Removed in OpenVPN 2.4.  All retries are controlled by ``--max-connect-retry``.
+
+--http-proxy-timeout
+  Removed in OpenVPN 2.4.  Connection timeout is controlled by
+  ``--connect-timeout``.
+
 --ifconfig-pool-linear
   Removed in OpenVPN 2.5.  This should be replaced with ``--topology p2p``.
 
@@ -21,6 +28,9 @@
   Removed in OpenVPN 2.6.  The built-in packet filtering (pf) functionality
   has been removed.
 
+--max-routes
+  Removed in OpenVPN 2.4.  The limit was removed.
+
 --ncp-disable
   Removed in OpenVPN 2.6.  This option mainly served a role as debug option
   when NCP was first introduced.  It should no longer be necessary.
@@ -50,6 +60,9 @@
   Removed in OpenVPN 2.7.  This option does not make sense anymore as option
   strings may not match due to the introduction of parameters negotiation.
 
+--socks-proxy-retry
+  Removed in OpenVPN 2.4.  All retries are controlled by ``--max-connect-retry``.
+
 --windows-driver
   Removed in OpenVPN 2.7. OpenVPN will always use ovpn-dco as the default
   driver on Windows. It will fall back to tap-windows6 if options are used
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1be105b..bd6dc07 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6699,19 +6699,10 @@
         ho->auth_file_up = p[1];
         ho->inline_creds = is_inline;
     }
-    else if (streq(p[0], "http-proxy-retry") || streq(p[0], "socks-proxy-retry"))
+    else if (streq(p[0], "http-proxy-retry") || streq(p[0], "socks-proxy-retry") || streq(p[0], "http-proxy-timeout"))
     {
         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
-        msg(M_WARN, "DEPRECATED OPTION: http-proxy-retry and socks-proxy-retry: "
-                    "In OpenVPN 2.4 proxy connection retries are handled like regular connections. "
-                    "Use connect-retry-max 1 to get a similar behavior as before.");
-    }
-    else if (streq(p[0], "http-proxy-timeout") && p[1] && !p[2])
-    {
-        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
-        msg(M_WARN,
-            "DEPRECATED OPTION: http-proxy-timeout: In OpenVPN 2.4 the timeout until a connection to a "
-            "server is established is managed with a single timeout set by connect-timeout");
+        msg(M_WARN, "DEPRECATED OPTION: %s option ignored.", p[0]);
     }
     else if (streq(p[0], "http-proxy-option") && p[1] && !p[4])
     {
@@ -6826,7 +6817,7 @@
     else if (streq(p[0], "persist-key") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_PERSIST);
-        msg(M_WARN, "DEPRECATED: --persist-key option ignored. "
+        msg(M_WARN, "DEPRECATED OPTION: --persist-key option ignored. "
                     "Keys are now always persisted across restarts. ");
     }
     else if (streq(p[0], "persist-local-ip") && !p[1])
@@ -6875,10 +6866,7 @@
     }
     else if (streq(p[0], "max-routes") && !p[2])
     {
-        msg(M_WARN, "DEPRECATED OPTION: --max-routes option ignored. "
-                    "The number of routes is unlimited as of OpenVPN 2.4. "
-                    "This option will be removed in a future version, "
-                    "please remove it from your configuration.");
+        msg(M_WARN, "DEPRECATED OPTION: --max-routes option ignored.");
     }
     else if (streq(p[0], "route-gateway") && p[1] && !p[2])
     {

