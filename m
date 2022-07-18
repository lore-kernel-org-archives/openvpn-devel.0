From: Antonio Quartulli <a@...2181...>
Date: Tue, 19 Jul 2022 00:19:23 +0200
Message-Id: <20220718221923.2033-1-a@...2181...>
In-Reply-To: <20220624083809.23487-9-a@...2181...>
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 08/25] dco: allow user to disable it at
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

Changes from v1:
* removed "--dco-disable" option: we just need "--disable-dco"
* added text to manpage about --client-to-client being no-op
* added text to manpage about --disable-dco
* rebased on top of master+"dco: add option check - disable DCO if
  conflict is detected"


 doc/man-sections/generic-options.rst |  9 +++++++++
 doc/man-sections/server-options.rst  |  4 ++++
 src/openvpn/options.c                | 24 ++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index 9060a235..394c2186 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -171,6 +171,15 @@ which mode OpenVPN is configured as.
   on console) and ``--auth-nocache`` will fail as soon as key
   renegotiation (and reauthentication) occurs.
 
+--disable-dco
+  Disable "data channel offload" (DCO).
+
+  On Linux don't use the ovpn-dco device driver, but rather rely on the
+  legacy tun module.
+
+  You may want to use this option if your server needs to allow clients
+  older than version 2.4 to connect.
+
 --disable-occ
   Disable "options consistency check" (OCC).
 
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 08ee7bd3..04f4b4fb 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -146,6 +146,10 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   server. Don't use this option if you want to firewall tunnel traffic
   using custom, per-client rules.
 
+  Please note that when using data channel offload this option has no
+  effect. Packets are always sent to the tunnel interface and then
+  routed based on the system routing table.
+
 --disable
   Disable a particular client (based on the common name) from connecting.
   Don't use this option to disable a client due to key or password
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7b919a1e..d864c6e2 100644
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
@@ -1785,6 +1792,9 @@ show_settings(const struct options *o)
     SHOW_STR(dev);
     SHOW_STR(dev_type);
     SHOW_STR(dev_node);
+#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+    SHOW_BOOL(tuntap_options.disable_dco);
+#endif
     SHOW_STR(lladdr);
     SHOW_INT(topology);
     SHOW_STR(ifconfig_local);
@@ -3401,6 +3411,14 @@ options_postprocess_verify(const struct options *o)
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
@@ -5839,6 +5857,12 @@ add_option(struct options *options,
         options->windows_driver = parse_windows_driver(p[1], M_FATAL);
     }
 #endif
+    else if (streq(p[0], "disable-dco"))
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


