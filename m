From: Arne Schwabe <arne@...1227...>
Date: Fri, 16 Apr 2021 13:09:55 +0200
Message-Id: <20210416110955.1162574-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add parsing of dhcp-option PROXY_HTTP
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

This adds support for setting a HTTP proxy that should be used after
connecting to a VPN.

The syntax has been picked to have compatibility with OpenVPN3.
Otherwise I would have used HTTP-PROXY instead.

Since this option requires an additional argument compared to the
existing dhcp-option keywords, move checking the number of arguments
to the individual keywords.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/vpn-network-options.rst |  6 ++++++
 src/openvpn/options.c                    | 26 ++++++++++++++++--------
 src/openvpn/tun.c                        |  7 +++++++
 src/openvpn/tun.h                        |  4 ++++
 4 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index 029834aa4..8c1c02dcc 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -183,6 +183,12 @@ routing.
   :code:`DISABLE-NBT`
         Disable Netbios-over-TCP/IP.
 
+  :code: `PROXY_HTTP` ``host`` ``port``
+        Sets a HTTP proxy that should be used when connected to the VPN.
+
+        This option currently only works on OpenVPN for Android and requires
+        Android 10 or later.
+
 --ifconfig args
   Set TUN/TAP adapter parameters. It requires the *IP address* of the local
   VPN endpoint. For TUN devices in point-to-point mode, the next argument
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4bbcf829a..c7e529706 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7403,22 +7403,22 @@ add_option(struct options *options,
     }
 #endif /* ifdef _WIN32 */
 #if defined(_WIN32) || defined(TARGET_ANDROID)
-    else if (streq(p[0], "dhcp-option") && p[1] && !p[3])
+    else if (streq(p[0], "dhcp-option") && p[1])
     {
         struct tuntap_options *o = &options->tuntap_options;
         VERIFY_PERMISSION(OPT_P_IPWIN32);
         bool ipv6dns = false;
 
         if ((streq(p[1], "DOMAIN") || streq(p[1], "ADAPTER_DOMAIN_SUFFIX"))
-            && p[2])
+            && p[2] && !p[3])
         {
             o->domain = p[2];
         }
-        else if (streq(p[1], "NBS") && p[2])
+        else if (streq(p[1], "NBS") && p[2] && !p[3])
         {
             o->netbios_scope = p[2];
         }
-        else if (streq(p[1], "NBT") && p[2])
+        else if (streq(p[1], "NBT") && p[2] && !p[3])
         {
             int t;
             t = atoi(p[2]);
@@ -7429,7 +7429,8 @@ add_option(struct options *options,
             }
             o->netbios_node_type = t;
         }
-        else if ((streq(p[1], "DNS") || streq(p[1], "DNS6")) && p[2] && (!strstr(p[2], ":") || ipv6_addr_safe(p[2])))
+        else if ((streq(p[1], "DNS") || streq(p[1], "DNS6")) && p[2] && !p[3]
+                && (!strstr(p[2], ":") || ipv6_addr_safe(p[2])))
         {
             if (strstr(p[2], ":"))
             {
@@ -7442,19 +7443,19 @@ add_option(struct options *options,
                 dhcp_option_address_parse("DNS", p[2], o->dns, &o->dns_len, msglevel);
             }
         }
-        else if (streq(p[1], "WINS") && p[2])
+        else if (streq(p[1], "WINS") && p[2] && !p[3])
         {
             dhcp_option_address_parse("WINS", p[2], o->wins, &o->wins_len, msglevel);
         }
-        else if (streq(p[1], "NTP") && p[2])
+        else if (streq(p[1], "NTP") && p[2] && !p[3])
         {
             dhcp_option_address_parse("NTP", p[2], o->ntp, &o->ntp_len, msglevel);
         }
-        else if (streq(p[1], "NBDD") && p[2])
+        else if (streq(p[1], "NBDD") && p[2] && !p[3])
         {
             dhcp_option_address_parse("NBDD", p[2], o->nbdd, &o->nbdd_len, msglevel);
         }
-        else if (streq(p[1], "DOMAIN-SEARCH") && p[2])
+        else if (streq(p[1], "DOMAIN-SEARCH") && p[2] && !p[3])
         {
             if (o->domain_search_list_len < N_SEARCH_LIST_LEN)
             {
@@ -7470,6 +7471,13 @@ add_option(struct options *options,
         {
             o->disable_nbt = 1;
         }
+#if defined(TARGET_ANDROID)
+        else if (streq(p[1], "PROXY_HTTP") && p[3] && !p[4])
+        {
+            o->http_proxy_port = atoi(p[3]);
+            o->http_proxy = p[2];
+        }
+#endif
         else
         {
             msg(msglevel, "--dhcp-option: unknown option type '%s' or missing or unknown parameter", p[1]);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 2385377fc..fa0dca949 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1870,6 +1870,13 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
         management_android_control(management, "DNSDOMAIN", tt->options.domain);
     }
 
+    if (tt->options.http_proxy)
+    {
+        struct buffer buf = alloc_buf_gc(strlen(tt->options.http_proxy) + 20, &gc);
+        buf_printf(&buf, "%s %d", tt->options.http_proxy, tt->options.http_proxy_port);
+        management_android_control(management, "HTTPPROXY", BSTR(&buf));
+    }
+    
     int android_method = managment_android_persisttun_action(management);
 
     /* Android 4.4 workaround */
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 60ebfdcba..abc3a7154 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -128,6 +128,10 @@ struct tuntap_options {
 
     struct in6_addr dns6[N_DHCP_ADDR];
     int dns6_len;
+#if defined(TARGET_ANDROID)
+    const char *http_proxy;
+    int http_proxy_port;
+#endif
 };
 
 #elif defined(TARGET_LINUX)
-- 
2.31.1


