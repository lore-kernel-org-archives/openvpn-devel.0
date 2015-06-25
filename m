From: Holger Kummert <Holger.Kummert@...1516...>
Date: Thu, 25 Jun 2015 18:01:20 +0200
Message-ID: <1435248080-12670-1-git-send-email-Holger.Kummert@...1516...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Del ipv6 addr on close of linux tun
	interface
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

When a linux tun interface is closed (e.g. on disconnect)
an optional ipv6 addr that was previously set is deleted now.
Without this patch a later reconnect would fail with
'Linux ip -6 addr add failed: external program exited with error status: 2'
and openvpn would exit.

---
 src/openvpn/tun.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
old mode 100644
new mode 100755
index ba4b15e..8a2bccc
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1687,6 +1687,32 @@ close_tun (struct tuntap *tt)
 	    argv_msg (M_INFO, &argv);
 	    openvpn_execve_check (&argv, NULL, 0, "Linux ip addr del failed");
 
+            if (tt->ipv6 && tt->did_ifconfig_ipv6_setup)
+              {
+                const char * ifconfig_ipv6_local = print_in6_addr (tt->local_ipv6, 0, &gc);
+
+#ifdef ENABLE_IPROUTE
+                argv_printf (&argv, "%s -6 addr del %s/%d dev %s",
+                                    iproute_path,
+                                    ifconfig_ipv6_local,
+                                    tt->netbits_ipv6,
+                                    tt->actual_name
+                                    );
+                argv_msg (M_INFO, &argv);
+                openvpn_execve_check (&argv, NULL, 0, "Linux ip -6 addr del failed");
+#else
+                argv_printf (&argv,
+                            "%s %s del %s/%d",
+                            IFCONFIG_PATH,
+                            tt->actual_name,
+                            ifconfig_ipv6_local,
+                            tt->netbits_ipv6
+                            );
+                argv_msg (M_INFO, &argv);
+                openvpn_execve_check (&argv, NULL, 0, "Linux ifconfig inet6 del failed");
+#endif
+              }
+
 	    argv_reset (&argv);
 	    gc_free (&gc);
 	  }
-- 
tg: (b8ae847..) c/0007/del_ipv6_on_close (depends on: c/0006/override_common_name)

