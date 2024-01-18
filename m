From: Gert Doering <gert@...1296...>
Date: Thu, 18 Jan 2024 16:12:42 +0100
Message-ID: <20240118151242.12169-1-gert@...1296...>
In-Reply-To: <gerrit.1705068839000.Iec74e88f86cd15328f993b6cdd0317ebda81563c@...2715...>
References: <gerrit.1705068839000.Iec74e88f86cd15328f993b6cdd0317ebda81563c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] NTLM: when NTLMv1 is requested,
 try NTLMv2 instead
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

Commit 21910ebc2ee8a6138eb2af8d38056d2b94e59f9c removed
support for NTLMv1 authentication. This adjusts the
behavior for existing configurations that specify
"ntlm" keyword.

Do not error out hard, instead just try to upgrade. This
should work fine in many cases and will avoid breaking
user configs unnecessarily on upgrade.

In addition it fixes an issue with the mentioned patch
where "auto" wasn't working correctly for NTLM anymore.

Change-Id: Iec74e88f86cd15328f993b6cdd0317ebda81563c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/500
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/Changes.rst b/Changes.rst
index 69c811d..58cb3db 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -12,8 +12,13 @@
     ``--allow-deprecated-insecure-static-crypto`` but will be removed in
     OpenVPN 2.8.
 
-NTLMv1 support has been removed because it is completely insecure.
-    NTLMv2 support is still available, but will removed in a future release.
+NTLMv1 authentication support for HTTP proxies has been removed.
+    This is considered an insecure method of authentication that uses
+    obsolete crypto algorithms.
+    NTLMv2 support is still available, but will be removed in a future
+    release.
+    When configured to authenticate with NTLMv1 (``ntlm`` keyword in
+    ``--http-proxy``) OpenVPN will try NTLMv2 instead.
 
 
 Overview of changes in 2.6
diff --git a/doc/man-sections/proxy-options.rst b/doc/man-sections/proxy-options.rst
index ad49c60..38c4578 100644
--- a/doc/man-sections/proxy-options.rst
+++ b/doc/man-sections/proxy-options.rst
@@ -48,6 +48,8 @@
      </http-proxy-user-pass>
 
   Note that support for NTLMv1 proxies was removed with OpenVPN 2.7.
+  :code:`ntlm` now is an alias for :code:`ntlm2`; i.e. OpenVPN will always
+  attempt to use NTLMv2 authentication.
 
 --http-proxy-user-pass userpass
   Overwrite the username/password information for ``--http-proxy``. If specified
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index e2324f4..eeb3989 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -502,7 +502,7 @@
         msg(M_FATAL, "HTTP_PROXY: server not specified");
     }
 
-    ASSERT( o->port);
+    ASSERT(o->port);
 
     ALLOC_OBJ_CLEAR(p, struct http_proxy_info);
     p->options = *o;
@@ -522,7 +522,8 @@
 #if NTLM
         else if (!strcmp(o->auth_method_string, "ntlm"))
         {
-            msg(M_FATAL, "ERROR: NTLM v1 support has been removed. For now, you can use NTLM v2 by selecting ntlm2 but it is deprecated as well.");
+            msg(M_WARN, "NTLM v1 authentication has been removed in OpenVPN 2.7. Will try to use NTLM v2 authentication.");
+            p->auth_method = HTTP_AUTH_NTLM2;
         }
         else if (!strcmp(o->auth_method_string, "ntlm2"))
         {
@@ -536,7 +537,9 @@
         }
     }
 
-    /* only basic and NTLM/NTLMv2 authentication supported so far */
+    /* When basic or NTLMv2 authentication is requested, get credentials now.
+     * In case of "auto" negotiation credentials will be retrieved later once
+     * we know whether we need any. */
     if (p->auth_method == HTTP_AUTH_BASIC || p->auth_method == HTTP_AUTH_NTLM2)
     {
         get_user_pass_http(p, true);
@@ -649,7 +652,8 @@
 
     /* get user/pass if not previously given */
     if (p->auth_method == HTTP_AUTH_BASIC
-        || p->auth_method == HTTP_AUTH_DIGEST)
+        || p->auth_method == HTTP_AUTH_DIGEST
+        || p->auth_method == HTTP_AUTH_NTLM2)
     {
         get_user_pass_http(p, false);
     }
@@ -753,7 +757,7 @@
         {
             processed = true;
         }
-        else if ((p->auth_method == HTTP_AUTH_NTLM2) && !processed) /* check for NTLM */
+        else if (p->auth_method == HTTP_AUTH_NTLM2 && !processed) /* check for NTLM */
         {
 #if NTLM
             /* look for the phase 2 response */

