From: Lev Stipakov <lstipakov@...277...>
Date: Fri,  8 Nov 2019 19:37:35 +0200
Message-Id: <1573234655-905-1-git-send-email-lstipakov@...277...>
In-Reply-To: <CAGyAFMWXS9F3OzSchqGtizgBoj+7E5JTEnKrnCQqMiejTuHs4g@...278...>
References: <CAGyAFMWXS9F3OzSchqGtizgBoj+7E5JTEnKrnCQqMiejTuHs4g@...278...>
Subject: [Openvpn-devel] [PATCH v3] wintun: add --windows-driver config
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

This allows to specify which tun driver openvpn should use,
tap-windows6 (default) or wintun.

Note than wintun support will be added in follow-up patches.

Signed-off-by: Lev Stipakov <lev@...515...>
---

 v3:
  - added man page
  - removed unneccesary assignment
  - make method static
  - removed unneeded _WIN32 define 

 v2:
  - rebased on top of latest master

 doc/openvpn.8         |  8 ++++++++
 src/openvpn/init.c    |  4 ++++
 src/openvpn/options.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 src/openvpn/options.h |  1 +
 src/openvpn/tun.h     |  1 +
 5 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 11daa92..8a7e70f 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -6147,6 +6147,14 @@ Note that pushing unknown options from server does not trigger
 fatal errors.
 .\"*********************************************************
 .TP
+.B \-\-windows\-driver
+Specifies which tun driver to use. Values are
+.B tap-windows6
+(default) and
+.B wintun.
+This is Windows-only option.
+.\"*********************************************************
+.TP
 .B \-\-dhcp\-renew
 Ask Windows to renew the TAP adapter lease on startup.
 This option is normally unnecessary, as Windows automatically
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ae7bd63..0bdb0a9 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1733,6 +1733,10 @@ do_init_tun(struct context *c)
                             c->c2.es,
                             &c->net_ctx);
 
+#ifdef _WIN32
+    c->c1.tuntap->wintun = c->options.wintun;
+#endif
+
     init_tun_post(c->c1.tuntap,
                   &c->c2.frame,
                   &c->options.tuntap_options);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1838a69..a70a822 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -747,9 +747,10 @@ static const char usage_message[] =
     "                       optional parameter controls the initial state of ex.\n"
     "--show-net-up   : Show " PACKAGE_NAME "'s view of routing table and net adapter list\n"
     "                  after TAP adapter is up and routes have been added.\n"
-#ifdef _WIN32
+    "--windows-driver   : Which tun driver to use?\n"
+    "                     tap-windows6 (default)\n"
+    "                     wintun\n"
     "--block-outside-dns   : Block DNS on other network adapters to prevent DNS leaks\n"
-#endif
     "Windows Standalone Options:\n"
     "\n"
     "--show-adapters : Show all TAP-Windows adapters.\n"
@@ -851,6 +852,7 @@ init_options(struct options *o, const bool init_gc)
     o->tuntap_options.dhcp_masq_offset = 0;     /* use network address as internal DHCP server address */
     o->route_method = ROUTE_METHOD_ADAPTIVE;
     o->block_outside_dns = false;
+    o->wintun = false;
 #endif
     o->vlan_accept = VLAN_ONLY_UNTAGGED_OR_PRIORITY;
     o->vlan_pvid = 1;
@@ -2994,6 +2996,12 @@ options_postprocess_mutate_invariant(struct options *options)
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
 
@@ -4039,6 +4047,33 @@ foreign_option(struct options *o, char *argv[], int len, struct env_set *es)
     }
 }
 
+#ifdef _WIN32
+/**
+ * Parses --windows-driver config option
+ *
+ * @param str       value of --windows-driver option
+ * @param msglevel  msglevel to report parsing error
+ * @return bool     true if --windows-driver is wintun, false otherwise
+ */
+static bool
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
@@ -5281,6 +5316,13 @@ add_option(struct options *options,
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
index ff7a5bb..0a24e5e 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -632,6 +632,7 @@ struct options
     bool show_net_up;
     int route_method;
     bool block_outside_dns;
+    bool wintun;
 #endif
 
     bool use_peer_id;
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 5a0a933..df935f6 100644
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


