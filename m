From: Gert Doering <gert@...1296...>
Date: Sat, 23 Aug 2025 17:36:46 +0200
Message-ID: <20250823153652.30938-1-gert@...1296...>
In-Reply-To: <gerrit.1755877911000.I5e240c35cd4236e1d845195e4634fd5008f61814@...2715...>
References: <gerrit.1755877911000.I5e240c35cd4236e1d845195e4634fd5008f61814@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Clean up documentation for --tun-mtu-max
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

From: Frank Lichtenheld <frank@...2641...>

There was some confusion about how the option
was called...

Change-Id: I5e240c35cd4236e1d845195e4634fd5008f61814
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1152
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index 4a64e8d..2a06ef6 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -587,7 +587,7 @@
   packets larger than ``tun-mtu`` (e.g. Linux and FreeBSD) but other platforms
   (like macOS) limit received packets to the same size as the MTU.
 
---tun-max-mtu maxmtu
+--tun-mtu-max maxmtu
   This configures the maximum MTU size that a server can push to ``maxmtu``,
   by configuring the internal buffers to allow at least this packet size.
   The default for ``maxmtu`` is 1600. Currently, only increasing beyond 1600
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 5583274..9dd3b96 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2916,7 +2916,7 @@
 
     /* We always allow at least 1600 MTU packets to be received in our buffer
      * space to allow server to push "baby giant" MTU sizes */
-    frame->tun_max_mtu = max_int(1600, frame->tun_max_mtu);
+    frame->tun_max_mtu = max_int(TUN_MTU_MAX_MIN, frame->tun_max_mtu);
 
     size_t payload_size = frame->tun_max_mtu;
 
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 925ef0b..c092461 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -69,6 +69,11 @@
 #define TUN_MTU_DEFAULT 1500
 
 /*
+ * Minimum maximum MTU
+ */
+#define TUN_MTU_MAX_MIN 1600
+
+/*
  * MTU Defaults for TAP devices
  */
 #define TAP_MTU_EXTRA_DEFAULT 32
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e9584a8..0b16c5a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -297,6 +297,7 @@
     "--tun-mtu-extra n : Assume that tun/tap device might return as many\n"
     "                  as n bytes more than the tun-mtu size on read\n"
     "                  (default TUN=0 TAP=%d).\n"
+    "--tun-mtu-max n : Maximum pushable MTU (default and minimum=%d).\n"
     "--link-mtu n    : Take the TCP/UDP device MTU to be n and derive the tun MTU\n"
     "                  from it.\n"
     "--mtu-disc type : Should we do Path MTU discovery on TCP/UDP channel?\n"
@@ -4844,8 +4845,9 @@
 
     fprintf(fp, usage_message, title_string, o.ce.connect_retry_seconds,
             o.ce.connect_retry_seconds_max, o.ce.local_port, o.ce.remote_port, TUN_MTU_DEFAULT,
-            TAP_MTU_EXTRA_DEFAULT, o.verbosity, o.authname, o.replay_window, o.replay_time,
-            o.tls_timeout, o.renegotiate_seconds, o.handshake_window, o.transition_window);
+            TAP_MTU_EXTRA_DEFAULT, TUN_MTU_MAX_MIN, o.verbosity, o.authname, o.replay_window,
+            o.replay_time, o.tls_timeout, o.renegotiate_seconds, o.handshake_window,
+            o.transition_window);
     fflush(fp);
 
 #endif                                       /* ENABLE_SMALL */
@@ -7011,7 +7013,7 @@
             options->ce.occ_mtu = 0;
         }
     }
-    else if (streq(p[0], "tun-mtu-max") && p[1] && !p[3])
+    else if (streq(p[0], "tun-mtu-max") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);
         int max_mtu = positive_atoi(p[1], msglevel);
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 889b268..4f6adfc 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -721,7 +721,7 @@
         {
             msg(M_WARN,
                 "Warning: reported maximum MTU from client (%d) is lower "
-                "than MTU used on the server (%d). Add tun-max-mtu %d "
+                "than MTU used on the server (%d). Add tun-mtu-max %d "
                 "to client configuration.",
                 client_max_mtu, o->ce.tun_mtu, o->ce.tun_mtu);
         }

