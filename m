From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 17 Sep 2019 15:44:48 +0300
Message-Id: <1568724293-5069-2-git-send-email-lstipakov@...277...>
In-Reply-To: <1568724293-5069-1-git-send-email-lstipakov@...277...>
References: <1568724293-5069-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH 2/7] wintun: add --windows-driver config
 option
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

From: Lev Stipakov <lev@...515...>

This allows to specify which tun driver openvpn should use,
tap-windows6 (default) or wintun.

Note than wintun support will be added in follow-up patches.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/init.c    |  7 +++++++
 src/openvpn/options.c | 37 +++++++++++++++++++++++++++++++++++++
 src/openvpn/options.h |  1 +
 src/openvpn/tun.h     |  1 +
 4 files changed, 46 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b5a034d..edd11c2 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1727,6 +1727,10 @@ do_init_tun(struct context *c)
                             c->c2.es,
                             &c->net_ctx);
 
+#ifdef _WIN32
+    c->c1.tuntap->wintun = c->options.wintun;
+#endif
+
     init_tun_post(c->c1.tuntap,
                   &c->c2.frame,
                   &c->options.tuntap_options);
@@ -1769,6 +1773,9 @@ do_open_tun(struct context *c)
     /* store (hide) interactive service handle in tuntap_options */
     c->c1.tuntap->options.msg_channel = c->options.msg_channel;
     msg(D_ROUTE, "interactive service msg_channel=%u", (unsigned int) c->options.msg_channel);
+
+    c->c1.tuntap->wintun = c->options.wintun;
+
 #endif
 
     /* allocate route list structure */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2d3865a..9f8e92b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -744,6 +744,9 @@ static const char usage_message[] =
     "                       optional parameter controls the initial state of ex.\n"
     "--show-net-up   : Show " PACKAGE_NAME "'s view of routing table and net adapter list\n"
     "                  after TAP adapter is up and routes have been added.\n"
+    "--windows-driver   : Which tun driver to use?\n"
+    "                     tap-windows6 (default)\n"
+    "                     wintun\n"
 #ifdef _WIN32
     "--block-outside-dns   : Block DNS on other network adapters to prevent DNS leaks\n"
 #endif
@@ -848,6 +851,7 @@ init_options(struct options *o, const bool init_gc)
     o->tuntap_options.dhcp_masq_offset = 0;     /* use network address as internal DHCP server address */
     o->route_method = ROUTE_METHOD_ADAPTIVE;
     o->block_outside_dns = false;
+    o->wintun = false;
 #endif
 #if P2MP_SERVER
     o->real_hash_size = 256;
@@ -2935,6 +2939,12 @@ options_postprocess_mutate_invariant(struct options *options)
         options->ifconfig_noexec = false;
     }
 
+    /* for wintun kernel doesn't send DHCP requests, so use ipapi to set IP address and netmask */
+    if (options->wintun)
+    {
+        options->tuntap_options.ip_win32_type = IPW32_SET_IPAPI;
+    }
+
     remap_redirect_gateway_flags(options);
 #endif
 
@@ -3980,6 +3990,26 @@ foreign_option(struct options *o, char *argv[], int len, struct env_set *es)
     }
 }
 
+#ifdef _WIN32
+bool
+parse_windows_driver(const char *str, const int msglevel)
+{
+    if (streq(str, "tap-windows6"))
+    {
+        return false;
+    }
+    else if (streq(str, "wintun"))
+    {
+        return true;
+    }
+    else
+    {
+        msg(msglevel, "--windows-driver must be tap-windows6 or wintun");
+        return false;
+    }
+}
+#endif
+
 /*
  * parse/print topology coding
  */
@@ -5222,6 +5252,13 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->dev_type = p[1];
     }
+#ifdef _WIN32
+    else if (streq(p[0], "windows-driver") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->wintun = parse_windows_driver(p[1], M_FATAL);
+    }
+#endif
     else if (streq(p[0], "dev-node") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 63f0f4c..37dee71 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -621,6 +621,7 @@ struct options
     bool show_net_up;
     int route_method;
     bool block_outside_dns;
+    bool wintun;
 #endif
 
     bool use_peer_id;
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 69831c4..a61aa22 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -175,6 +175,7 @@ struct tuntap
      * ~0 if undefined */
     DWORD adapter_index;
 
+    bool wintun; /* true if wintun is used instead of tap-windows6 */
     int standby_iter;
 #else  /* ifdef _WIN32 */
     int fd; /* file descriptor for TUN/TAP dev */
-- 
2.7.4


