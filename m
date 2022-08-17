From: Arne Schwabe <arne@...1227...>
Date: Wed, 17 Aug 2022 09:59:25 +0200
Message-Id: <20220817075925.815184-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Rename OPT_P_IPWIN32 to OPT_P_DHCPDNS and
 include --dns in it
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

The dns options are very similar to dhcp-option and should fall
under the same option mask. For that rename the OPT_P_IPWIN32 mask
to OPT_P_DHCPDNS and include dns in it.

This effects currently route-nopull which block all host side
network/dns configuration but did not block the new dns option.
---
 src/openvpn/init.c    |  4 ++--
 src/openvpn/options.c | 20 ++++++++++----------
 src/openvpn/options.h |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 4d4c71923..05c2ee9bc 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2271,7 +2271,7 @@ pull_permission_mask(const struct context *c)
 
     if (!c->options.route_nopull)
     {
-        flags |= (OPT_P_ROUTE | OPT_P_IPWIN32);
+        flags |= (OPT_P_ROUTE | OPT_P_DHCPDNS);
     }
 
     return flags;
@@ -2395,7 +2395,7 @@ do_deferred_options(struct context *c, const unsigned int found)
     {
         msg(D_PUSH, "OPTIONS IMPORT: route-related options modified");
     }
-    if (found & OPT_P_IPWIN32)
+    if (found & OPT_P_DHCPDNS)
     {
         msg(D_PUSH, "OPTIONS IMPORT: --ip-win32 and/or --dhcp-option options modified");
     }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 14cb4cc4e..bd6db8262 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -226,7 +226,7 @@ static const char usage_message[] =
     "--route-noexec  : Don't add routes automatically.  Instead pass routes to\n"
     "                  --route-up script using environmental variables.\n"
     "--route-nopull  : When used with --client or --pull, accept options pushed\n"
-    "                  by server EXCEPT for routes and dhcp options.\n"
+    "                  by server EXCEPT for routes, dns, and dhcp options.\n"
     "--allow-pull-fqdn : Allow client to pull DNS names from server for\n"
     "                    --ifconfig, --route, and --route-gateway.\n"
     "--redirect-gateway [flags]: Automatically execute routing\n"
@@ -7744,7 +7744,7 @@ add_option(struct options *options,
         const int index = ascii2ipset(p[1]);
         struct tuntap_options *to = &options->tuntap_options;
 
-        VERIFY_PERMISSION(OPT_P_IPWIN32);
+        VERIFY_PERMISSION(OPT_P_DHCPDNS);
 
         if (index < 0)
         {
@@ -7798,7 +7798,7 @@ add_option(struct options *options,
 #endif /* ifdef _WIN32 */
     else if (streq(p[0], "dns") && p[1])
     {
-        VERIFY_PERMISSION(OPT_P_DEFAULT);
+        VERIFY_PERMISSION(OPT_P_DHCPDNS);
 
         if (streq(p[1], "search-domains") && p[2])
         {
@@ -7906,7 +7906,7 @@ add_option(struct options *options,
     else if (streq(p[0], "dhcp-option") && p[1])
     {
         struct tuntap_options *o = &options->tuntap_options;
-        VERIFY_PERMISSION(OPT_P_IPWIN32);
+        VERIFY_PERMISSION(OPT_P_DHCPDNS);
         bool ipv6dns = false;
 
         if ((streq(p[1], "DOMAIN") || streq(p[1], "ADAPTER_DOMAIN_SUFFIX"))
@@ -8014,7 +8014,7 @@ add_option(struct options *options,
     else if (streq(p[0], "tap-sleep") && p[1] && !p[2])
     {
         int s;
-        VERIFY_PERMISSION(OPT_P_IPWIN32);
+        VERIFY_PERMISSION(OPT_P_DHCPDNS);
         s = atoi(p[1]);
         if (s < 0 || s >= 256)
         {
@@ -8025,12 +8025,12 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "dhcp-renew") && !p[1])
     {
-        VERIFY_PERMISSION(OPT_P_IPWIN32);
+        VERIFY_PERMISSION(OPT_P_DHCPDNS);
         options->tuntap_options.dhcp_renew = true;
     }
     else if (streq(p[0], "dhcp-pre-release") && !p[1])
     {
-        VERIFY_PERMISSION(OPT_P_IPWIN32);
+        VERIFY_PERMISSION(OPT_P_DHCPDNS);
         options->tuntap_options.dhcp_pre_release = true;
         options->tuntap_options.dhcp_renew = true;
     }
@@ -8057,12 +8057,12 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "register-dns") && !p[1])
     {
-        VERIFY_PERMISSION(OPT_P_IPWIN32);
+        VERIFY_PERMISSION(OPT_P_DHCPDNS);
         options->tuntap_options.register_dns = true;
     }
     else if (streq(p[0], "block-outside-dns") && !p[1])
     {
-        VERIFY_PERMISSION(OPT_P_IPWIN32);
+        VERIFY_PERMISSION(OPT_P_DHCPDNS);
         options->block_outside_dns = true;
     }
     else if (streq(p[0], "rdns-internal") && !p[1])
@@ -8130,7 +8130,7 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "dhcp-option") && p[1] && !p[3])
     {
-        VERIFY_PERMISSION(OPT_P_IPWIN32);
+        VERIFY_PERMISSION(OPT_P_DHCPDNS);
         setenv_foreign_option(options, (const char **)p, 3, es);
     }
     else if (streq(p[0], "route-method") && p[1] && !p[2]) /* ignore when pushed to non-Windows OS */
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 212f4b05d..83c97ded1 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -691,7 +691,7 @@ struct options
 #define OPT_P_GENERAL         (1<<0)
 #define OPT_P_UP              (1<<1)
 #define OPT_P_ROUTE           (1<<2)
-#define OPT_P_IPWIN32         (1<<3)
+#define OPT_P_DHCPDNS         (1<<3)    /* includes ip windows options like */
 #define OPT_P_SCRIPT          (1<<4)
 #define OPT_P_SETENV          (1<<5)
 #define OPT_P_SHAPER          (1<<6)
-- 
2.32.1 (Apple Git-133)


