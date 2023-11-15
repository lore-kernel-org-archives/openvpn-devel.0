From: Gert Doering <gert@...1296...>
Date: Wed, 15 Nov 2023 13:06:56 +0100
Message-ID: <20231115120656.6825-1-gert@...1296...>
In-Reply-To: <gerrit.1699891289000.Ie512544329a91fae15409cb18f29d8be617051a1@...2715...>
References: <gerrit.1699891289000.Ie512544329a91fae15409cb18f29d8be617051a1@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Warn if pushed options require DHCP
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

Some pushed options (such as DOMAIN-SEARCH) require
DHCP server to work. Warn user that some options
will not work if the current driver (such as dco-win)
doesn't support DHCP.

Change-Id: Ie512544329a91fae15409cb18f29d8be617051a1
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/428
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index abd2e0c..b34e2f6 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2477,10 +2477,10 @@
 
     if (options->tuntap_options.dhcp_options & DHCP_OPTIONS_DHCP_REQUIRED)
     {
-        const char *prefix = "Some dhcp-options require DHCP server";
+        const char *prefix = "Some --dhcp-option or --dns options require DHCP server";
         if (options->windows_driver != WINDOWS_DRIVER_TAP_WINDOWS6)
         {
-            msg(M_USAGE, "%s, which is not supported by selected %s driver",
+            msg(M_USAGE, "%s, which is not supported by the selected %s driver",
                 prefix, print_windows_driver(options->windows_driver));
         }
         else if (options->tuntap_options.ip_win32_type != IPW32_SET_DHCP_MASQ
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f857ed1..1b79d42 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6826,6 +6826,13 @@
 open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
          openvpn_net_ctx_t *ctx)
 {
+    if ((tt->options.dhcp_options & DHCP_OPTIONS_DHCP_REQUIRED)
+        && tt->windows_driver != WINDOWS_DRIVER_TAP_WINDOWS6)
+    {
+        msg(M_WARN, "Some --dhcp-option or --dns options require DHCP server, which is not supported by the selected %s driver. They will be ignored.",
+            print_windows_driver(tt->windows_driver));
+    }
+
     /* dco-win already opened the device, which handle we treat as socket */
     if (tuntap_is_dco_win(tt))
     {

