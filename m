From: Gert Doering <gert@...1296...>
Date: Sat, 30 Dec 2023 15:38:17 +0100
Message-ID: <20231230143817.4880-1-gert@...1296...>
In-Reply-To: <gerrit.1699031887000.I199f83e2db5fc7c48a0ac9280cdbf9fa45f42300@...2715...>
References: <gerrit.1699031887000.I199f83e2db5fc7c48a0ac9280cdbf9fa45f42300@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] configure: allow to disable NTLM
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

Since we want to get rid of it, might be useful to
allow users to remove the support completely.

Change-Id: I199f83e2db5fc7c48a0ac9280cdbf9fa45f42300
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/378
This mail reflects revision 3 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/config.h.cmake.in b/config.h.cmake.in
index baf9556..3348f93 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -35,6 +35,9 @@
 /* Enable LZO compression library */
 #cmakedefine ENABLE_LZO
 
+/* Enable NTLMv2 proxy support */
+#define ENABLE_NTLM 1
+
 /* Enable management server capability */
 #define ENABLE_MANAGEMENT 1
 
diff --git a/configure.ac b/configure.ac
index 54f79ab..29d55e7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -109,6 +109,13 @@
 )
 
 AC_ARG_ENABLE(
+	[ntlm],
+	[AS_HELP_STRING([--disable-ntlm], [disable NTLMv2 proxy support @<:@default=yes@:>@])],
+	,
+	[enable_ntlm="yes"]
+)
+
+AC_ARG_ENABLE(
 	[plugins],
 	[AS_HELP_STRING([--disable-plugins], [disable plug-in support @<:@default=yes@:>@])],
 	,
@@ -1316,6 +1323,7 @@
 test "${enable_fragment}" = "yes" && AC_DEFINE([ENABLE_FRAGMENT], [1], [Enable internal fragmentation support])
 test "${enable_port_share}" = "yes" && AC_DEFINE([ENABLE_PORT_SHARE], [1], [Enable TCP Server port sharing])
 
+test "${enable_ntlm}" = "yes" && AC_DEFINE([ENABLE_NTLM], [1], [Enable NTLMv2 proxy support])
 test "${enable_crypto_ofb_cfb}" = "yes" && AC_DEFINE([ENABLE_OFB_CFB_MODE], [1], [Enable OFB and CFB cipher modes])
 if test "${have_export_keying_material}" = "yes"; then
 	AC_DEFINE(
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2594b66..f692532 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6762,8 +6762,7 @@
         if (p[3])
         {
             /* auto -- try to figure out proxy addr, port, and type automatically */
-            /* semiauto -- given proxy addr:port, try to figure out type automatically */
-            /* (auto|semiauto)-nct -- disable proxy auth cleartext protocols (i.e. basic auth) */
+            /* auto-nct -- disable proxy auth cleartext protocols (i.e. basic auth) */
             if (streq(p[3], "auto"))
             {
                 ho->auth_retry = PAR_ALL;
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 76e27cb..3b6f7df 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -638,8 +638,6 @@
 {
     struct gc_arena gc = gc_new();
     char buf[512];
-    char buf2[129];
-    char get[80];
     int status;
     int nparms;
     bool ret = false;
@@ -758,6 +756,7 @@
         {
 #if NTLM
             /* look for the phase 2 response */
+            char buf2[129];
 
             while (true)
             {
@@ -768,7 +767,8 @@
                 chomp(buf);
                 msg(D_PROXY, "HTTP proxy returned: '%s'", buf);
 
-                openvpn_snprintf(get, sizeof get, "%%*s NTLM %%%ds", (int) sizeof(buf2) - 1);
+                char get[80];
+                openvpn_snprintf(get, sizeof(get), "%%*s NTLM %%%zus", sizeof(buf2) - 1);
                 nparms = sscanf(buf, get, buf2);
                 buf2[128] = 0; /* we only need the beginning - ensure it's null terminated. */
 
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 7181b94..a021c91 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -472,7 +472,9 @@
 /*
  * Should we include NTLM proxy functionality
  */
+#ifdef ENABLE_NTLM
 #define NTLM 1
+#endif
 
 /*
  * Should we include proxy digest auth functionality

