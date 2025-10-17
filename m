From: Gert Doering <gert@...1296...>
Date: Fri, 17 Oct 2025 21:16:06 +0200
Message-ID: <20251017191612.15642-1-gert@...1296...>
In-Reply-To: <gerrit.1760629750000.I7b718a14b81e3759398e7a52fe151102494cc821@...2715...>
References: <gerrit.1760629750000.I7b718a14b81e3759398e7a52fe151102494cc821@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] options: warn and ignore
 --reneg-bytes/pkts when DCO is enabled
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

From: Ralf Lici <ralf@...2726...>

Thresholds specified by --reneg-bytes and --reneg-pkts cannot be
enforced when DCO is enabled, as it only provides global statistics.

Rather than adding complexity to support these options, ignore them when
DCO is enabled. Print a warning to inform users and update the manpage
accordingly.

Change-Id: I7b718a14b81e3759398e7a52fe151102494cc821
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1280
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1280
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/doc/man-sections/renegotiation.rst b/doc/man-sections/renegotiation.rst
index 1e7c340..f5eb90d 100644
--- a/doc/man-sections/renegotiation.rst
+++ b/doc/man-sections/renegotiation.rst
@@ -19,10 +19,18 @@
   the SWEET32 attack vector. For more information see the ``--cipher``
   option.
 
+  When data channel offload (DCO) is enabled, this option is ignored. DCO
+  does not support configurable renegotiation thresholds; automatic key
+  renegotiation mechanisms are sufficient for modern ciphers.
+
 --reneg-pkts n
   Renegotiate data channel key after **n** packets sent and received
   (disabled by default).
 
+  When data channel offload (DCO) is enabled, this option is ignored. DCO
+  does not support configurable renegotiation thresholds; automatic key
+  renegotiation mechanisms are sufficient for modern ciphers.
+
 --reneg-sec args
   Renegotiate data channel key after at most ``max`` seconds
   (default :code:`3600`) and at least ``min`` seconds (default is 90% of
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 44f68c7..65c6b3b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3317,11 +3317,22 @@
 
     dns_options_verify(M_FATAL, &o->dns_options);
 
-    if (dco_enabled(o) && o->enable_c2c)
+    if (dco_enabled(o))
     {
-        msg(M_WARN, "Note: --client-to-client has no effect when using data "
-                    "channel offload: packets are always sent to the VPN "
-                    "interface and then routed based on the system routing table");
+        if (o->enable_c2c)
+        {
+            msg(M_WARN, "Note: --client-to-client has no effect when using data "
+                        "channel offload: packets are always sent to the VPN "
+                        "interface and then routed based on the system routing table");
+        }
+
+        if (o->renegotiate_bytes > 0 || o->renegotiate_packets)
+        {
+            msg(M_WARN, "Note: '--reneg-bytes' and '--reneg-pkts' are not supported "
+                        "by data channel offload; automatic key renegotiation "
+                        "mechanisms are sufficient for modern ciphers. "
+                        "Ignoring these options.");
+        }
     }
 }
 

