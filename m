From: Antonio Quartulli <a@...2181...>
Date: Fri, 24 Jun 2022 10:37:52 +0200
Message-Id: <20220624083809.23487-9-a@...2181...>
In-Reply-To: <20220624083809.23487-1-a@...2181...>
References: <20220624083809.23487-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 08/25] dco: allow user to disable it at
 runtime
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
Cc: Antonio Quartulli <a@...2181...>

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/options.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9a0634a5..7b450296 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -61,6 +61,7 @@
 #include "ssl_verify.h"
 #include "platform.h"
 #include "xkey_common.h"
+#include "dco.h"
 #include <ctype.h>
 
 #include "memdbg.h"
@@ -106,6 +107,9 @@ const char title_string[] =
 #endif
 #endif
     " [AEAD]"
+#ifdef ENABLE_DCO
+    " [DCO]"
+#endif
     " built on " __DATE__
 ;
 
@@ -177,6 +181,9 @@ static const char usage_message[] =
     "                  does not begin with \"tun\" or \"tap\".\n"
     "--dev-node node : Explicitly set the device node rather than using\n"
     "                  /dev/net/tun, /dev/tun, /dev/tap, etc.\n"
+#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+    "--disable-dco   : Do not attempt using Data Channel Offload.\n"
+#endif
     "--lladdr hw     : Set the link layer address of the tap device.\n"
     "--topology t    : Set --dev tun topology: 'net30', 'p2p', or 'subnet'.\n"
 #ifdef ENABLE_IPROUTE
@@ -1711,6 +1718,9 @@ show_settings(const struct options *o)
     SHOW_STR(dev);
     SHOW_STR(dev_type);
     SHOW_STR(dev_node);
+#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+    SHOW_BOOL(tuntap_options.disable_dco);
+#endif
     SHOW_STR(lladdr);
     SHOW_INT(topology);
     SHOW_STR(ifconfig_local);
@@ -3210,6 +3220,14 @@ options_postprocess_verify(const struct options *o)
     }
 
     dns_options_verify(M_FATAL, &o->dns_options);
+
+    if (dco_enabled(o) && o->enable_c2c)
+    {
+        msg(M_WARN, "Note: --client-to-client has no effect when using data "
+            "channel offload: packets are always sent to the VPN "
+            "interface and then routed based on the system routing "
+            "table");
+    }
 }
 
 /**
@@ -3454,6 +3472,11 @@ options_postprocess_mutate(struct options *o)
         o->verify_hash_no_ca = true;
     }
 
+    /* check if any option should force disabling DCO */
+#if defined(TARGET_LINUX)
+    o->tuntap_options.disable_dco = !dco_check_option_conflict(D_DCO, o);
+#endif
+
     /*
      * Save certain parms before modifying options during connect, especially
      * when using --pull
@@ -5759,6 +5782,12 @@ add_option(struct options *options,
         options->windows_driver = parse_windows_driver(p[1], M_FATAL);
     }
 #endif
+    else if (streq(p[0], "disable-dco") || streq(p[0], "dco-disable"))
+    {
+#if defined(TARGET_LINUX)
+        options->tuntap_options.disable_dco = true;
+#endif
+    }
     else if (streq(p[0], "dev-node") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-- 
2.35.1


