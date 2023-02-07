From: Lev Stipakov <lstipakov@...277...>
Date: Tue,  7 Feb 2023 11:42:47 +0200
Message-Id: <20230207094247.241-1-lstipakov@...277...>
In-Reply-To: <20230207085339.1492-1-lstipakov@...277...>
References: <20230207085339.1492-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 release/2.6] Allow certain DHCP options
 to be used without DHCP server
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Followin DHCP options:

  DOMAIN, ADAPTER_DOMAIN_SUFFIX, DNS, WINS

don't require DHCP server in order to be used.

This change allows those options to be used with dco and wintun
drivers. If an option specified which requires DHCP server and
tap-windows6 driver is not used, print a clear error message
instead of obscure reference to --ip-win32.

This fixes https://github.com/OpenVPN/openvpn/issues/239

Reported-by: Marek Zarychta
Signed-off-by: Lev Stipakov <lev@...515...>
---
 v2: replace enum with defines, which are more suitable
     as bit flags

 src/openvpn/options.c | 39 +++++++++++++++++++++++----------------
 src/openvpn/tun.h     |  6 +++++-
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6ae3faf8..9c05217c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1290,7 +1290,7 @@ show_tuntap_options(const struct tuntap_options *o)
     SHOW_INT(dhcp_masq_offset);
     SHOW_INT(dhcp_lease_time);
     SHOW_INT(tap_sleep);
-    SHOW_BOOL(dhcp_options);
+    SHOW_INT(dhcp_options);
     SHOW_BOOL(dhcp_renew);
     SHOW_BOOL(dhcp_pre_release);
     SHOW_STR(domain);
@@ -2478,12 +2478,20 @@ options_postprocess_verify_ce(const struct options *options,
         msg(M_USAGE, "On Windows, --ip-win32 doesn't make sense unless --ifconfig is also used");
     }
 
-    if (options->tuntap_options.dhcp_options
-        && options->windows_driver != WINDOWS_DRIVER_WINTUN
-        && options->tuntap_options.ip_win32_type != IPW32_SET_DHCP_MASQ
-        && options->tuntap_options.ip_win32_type != IPW32_SET_ADAPTIVE)
+    if (options->tuntap_options.dhcp_options & DHCP_OPTIONS_DHCP_REQUIRED)
     {
-        msg(M_USAGE, "--dhcp-option requires --ip-win32 dynamic or adaptive");
+        const char *prefix = "Some dhcp-options require DHCP server";
+        if (options->windows_driver != WINDOWS_DRIVER_TAP_WINDOWS6)
+        {
+            msg(M_USAGE, "%s, which is not supported by selected %s driver",
+                prefix, print_windows_driver(options->windows_driver));
+        }
+        else if (options->tuntap_options.ip_win32_type != IPW32_SET_DHCP_MASQ
+                 && options->tuntap_options.ip_win32_type != IPW32_SET_ADAPTIVE)
+        {
+            msg(M_USAGE, "%s, which requires --ip-win32 dynamic or adaptive",
+                prefix);
+        }
     }
 
     if (options->windows_driver == WINDOWS_DRIVER_WINTUN && dev != DEV_TYPE_TUN)
@@ -8083,16 +8091,17 @@ add_option(struct options *options,
     {
         struct tuntap_options *o = &options->tuntap_options;
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
-        bool ipv6dns = false;
 
         if ((streq(p[1], "DOMAIN") || streq(p[1], "ADAPTER_DOMAIN_SUFFIX"))
             && p[2] && !p[3])
         {
             o->domain = p[2];
+            o->dhcp_options |= DHCP_OPTIONS_DHCP_OPTIONAL;
         }
         else if (streq(p[1], "NBS") && p[2] && !p[3])
         {
             o->netbios_scope = p[2];
+            o->dhcp_options |= DHCP_OPTIONS_DHCP_REQUIRED;
         }
         else if (streq(p[1], "NBT") && p[2] && !p[3])
         {
@@ -8104,31 +8113,35 @@ add_option(struct options *options,
                 goto err;
             }
             o->netbios_node_type = t;
+            o->dhcp_options |= DHCP_OPTIONS_DHCP_REQUIRED;
         }
         else if ((streq(p[1], "DNS") || streq(p[1], "DNS6")) && p[2] && !p[3]
                  && (!strstr(p[2], ":") || ipv6_addr_safe(p[2])))
         {
             if (strstr(p[2], ":"))
             {
-                ipv6dns = true;
                 dhcp_option_dns6_parse(p[2], o->dns6, &o->dns6_len, msglevel);
             }
             else
             {
                 dhcp_option_address_parse("DNS", p[2], o->dns, &o->dns_len, msglevel);
+                o->dhcp_options |= DHCP_OPTIONS_DHCP_OPTIONAL;
             }
         }
         else if (streq(p[1], "WINS") && p[2] && !p[3])
         {
             dhcp_option_address_parse("WINS", p[2], o->wins, &o->wins_len, msglevel);
+            o->dhcp_options |= DHCP_OPTIONS_DHCP_OPTIONAL;
         }
         else if (streq(p[1], "NTP") && p[2] && !p[3])
         {
             dhcp_option_address_parse("NTP", p[2], o->ntp, &o->ntp_len, msglevel);
+            o->dhcp_options |= DHCP_OPTIONS_DHCP_REQUIRED;
         }
         else if (streq(p[1], "NBDD") && p[2] && !p[3])
         {
             dhcp_option_address_parse("NBDD", p[2], o->nbdd, &o->nbdd_len, msglevel);
+            o->dhcp_options |= DHCP_OPTIONS_DHCP_REQUIRED;
         }
         else if (streq(p[1], "DOMAIN-SEARCH") && p[2] && !p[3])
         {
@@ -8141,10 +8154,12 @@ add_option(struct options *options,
                 msg(msglevel, "--dhcp-option %s: maximum of %d search entries can be specified",
                     p[1], N_SEARCH_LIST_LEN);
             }
+            o->dhcp_options |= DHCP_OPTIONS_DHCP_REQUIRED;
         }
         else if (streq(p[1], "DISABLE-NBT") && !p[2])
         {
             o->disable_nbt = 1;
+            o->dhcp_options |= DHCP_OPTIONS_DHCP_REQUIRED;
         }
 #if defined(TARGET_ANDROID)
         else if (streq(p[1], "PROXY_HTTP") && p[3] && !p[4])
@@ -8158,14 +8173,6 @@ add_option(struct options *options,
             msg(msglevel, "--dhcp-option: unknown option type '%s' or missing or unknown parameter", p[1]);
             goto err;
         }
-
-        /* flag that we have options to give to the TAP driver's DHCPv4 server
-         *  - skipped for "DNS6", as that's not a DHCPv4 option
-         */
-        if (!ipv6dns)
-        {
-            o->dhcp_options = true;
-        }
     }
 #endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
 #ifdef _WIN32
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 3b0a0d24..e19e1a2e 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -62,6 +62,10 @@ enum windows_driver_type {
 #define IPW32_SET_ADAPTIVE_DELAY_WINDOW 300
 #define IPW32_SET_ADAPTIVE_TRY_NETSH    20
 
+/* bit flags for DHCP options */
+#define DHCP_OPTIONS_DHCP_OPTIONAL (1<<0)
+#define DHCP_OPTIONS_DHCP_REQUIRED (1<<1)
+
 struct tuntap_options {
     /* --ip-win32 options */
     bool ip_win32_defined;
@@ -90,7 +94,7 @@ struct tuntap_options {
 
     /* --dhcp-option options */
 
-    bool dhcp_options;
+    int dhcp_options;
 
     const char *domain;      /* DOMAIN (15) */
 
-- 
2.23.0.windows.1


