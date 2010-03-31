From: Fabian Knittel <fabian.knittel@...1338...>
Date: Wed, 31 Mar 2010 23:58:15 +0200
Message-Id: <4d8042aeaf26115fa4c444888e688cc792ad6430.1270060247.git.fabian.knittel@...1338...>
In-Reply-To: <cover.1270060247.git.fabian.knittel@...1338...>
References: <cover.1270060247.git.fabian.knittel@...1338...>
Subject: [Openvpn-devel] [PATCH 2/9] vlan: Add global --vlan-tagging option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This patch adds the new "--vlan-tagging" boolean option.  The option is valid
in server mode.  It is off by default.

The flag indicates whether openvpn should assume the tap device
to be in tagged mode, i.e. packets coming in on the device are tagged via
IEEE 802.1Q and packets going out through the device should be tagged likewise.

The option has no immediate effect yet, but will be used by later patches.
---
 options.c |   13 +++++++++++++
 options.h |    2 ++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/options.c b/options.c
index 36b9913..506fb49 100644
--- a/options.c
+++ b/options.c
@@ -651,6 +651,8 @@ static const char usage_message[] =
   "--show-pkcs11-ids provider [cert_private] : Show PKCS#11 available ids.\n" 
   "                                            --verb option can be added *BEFORE* this.\n"
 #endif				/* ENABLE_PKCS11 */
+  "\n"
+  "--vlan-tagging  : Enable VLAN tagging/untagging to/from TAP device.\n"
  ;
 
 #endif /* !ENABLE_SMALL */
@@ -1175,6 +1177,8 @@ show_settings (const struct options *o)
   SHOW_BOOL (ifconfig_noexec);
   SHOW_BOOL (ifconfig_nowarn);
 
+  SHOW_BOOL (vlan_tagging);
+
 #ifdef HAVE_GETTIMEOFDAY
   SHOW_INT (shaper);
 #endif
@@ -1742,6 +1746,8 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 
 	if ((options->ssl_flags & SSLF_NO_NAME_REMAPPING) && script_method == SM_SYSTEM)
 	  msg (M_USAGE, "--script-security method='system' cannot be combined with --no-name-remapping");
+      if (options->vlan_tagging && dev != DEV_TYPE_TAP)
+	msg (M_USAGE, "--vlan-tagging only works with --dev tap");
     }
   else
     {
@@ -1788,6 +1794,8 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
       if (options->port_share_host || options->port_share_port)
 	msg (M_USAGE, "--port-share requires TCP server mode (--mode server --proto tcp-server)");
 #endif
+      if (options->vlan_tagging)
+	msg (M_USAGE, "--vlan-tagging requires --mode server");
 
     }
 #endif /* P2MP_SERVER */
@@ -5730,6 +5738,11 @@ add_option (struct options *options,
       options->persist_mode = 1;
     }
 #endif
+  else if (streq (p[0], "vlan-tagging"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->vlan_tagging = true;
+    }
   else
     {
       if (file)
diff --git a/options.h b/options.h
index 740e18e..49fa596 100644
--- a/options.h
+++ b/options.h
@@ -509,6 +509,8 @@ struct options
   bool show_net_up;
   int route_method;
 #endif
+
+  bool vlan_tagging;
 };
 
 #define streq(x, y) (!strcmp((x), (y)))
-- 
1.7.0


