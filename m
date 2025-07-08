From: Gert Doering <gert@...1296...>
Date: Tue,  8 Jul 2025 20:52:04 +0200
Message-ID: <20250708185210.30421-1-gert@...1296...>
In-Reply-To: <gerrit.1751571694000.I7e9a0c668e0950257632452cfd9eeb236f0120f2@...2715...>
References: <gerrit.1751571694000.I7e9a0c668e0950257632452cfd9eeb236f0120f2@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dns: do not run updown scripts with
 lwipovpn
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

From: Heiko Hund <heiko@...2662...>

Running the script doesn't make sense with the AFUNIX dev node, so we
simply clear any scripts that have been set before.

Change-Id: I7e9a0c668e0950257632452cfd9eeb236f0120f2
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1077
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index af097f8..0662b49 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -61,6 +61,7 @@
 #include "xkey_common.h"
 #include "dco.h"
 #include "options_util.h"
+#include "tun_afunix.h"
 
 #include <ctype.h>
 
@@ -3593,6 +3594,13 @@
     struct gc_arena gc = gc_new();
     struct dns_options *dns = &o->dns_options;
 
+    if (is_tun_afunix(o->dev_node))
+    {
+        /* Disable running  dns-updown script with lwipovpn */
+        dns->updown_flags = DNS_UPDOWN_NO_FLAGS;
+        dns->updown = NULL;
+    }
+
     if (dns->servers || dns_updown_user_set(dns) || dns_updown_forced(dns))
     {
         /* Clean up env from --dhcp-option DNS config */

