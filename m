From: Gert Doering <gert@...1296...>
Date: Sat, 23 May 2015 20:01:38 +0200
Message-Id: <1432404098-29401-1-git-send-email-gert@...1296...>
In-Reply-To: <555BF270.3090706@...1147...>
References: <555BF270.3090706@...1147...>
Subject: [Openvpn-devel] [PATCH] repair --dev null breakage caused by
	db950be85d37
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

"make check" self-test was broken after commit db950be85d37 due to
do_ifconfig_setenv() not checking whether tt->did_ifconfig_setup
was set (which isn't, for "dev null" type setups)

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tun.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 9e853c0..e479d4d 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -403,23 +403,27 @@ void
 do_ifconfig_setenv (const struct tuntap *tt, struct env_set *es)
 {
     struct gc_arena gc = gc_new ();
-    bool tun = is_tun_p2p (tt);
     const char *ifconfig_local = print_in_addr_t (tt->local, 0, &gc);
     const char *ifconfig_remote_netmask = print_in_addr_t (tt->remote_netmask, 0, &gc);
 
     /*
      * Set environmental variables with ifconfig parameters.
      */
-    setenv_str (es, "ifconfig_local", ifconfig_local);
-    if (tun)
+    if (tt->did_ifconfig_setup)
     {
-	setenv_str (es, "ifconfig_remote", ifconfig_remote_netmask);
-    }
-    else
-    {
-	const char *ifconfig_broadcast = print_in_addr_t (tt->broadcast, 0, &gc);
-	setenv_str (es, "ifconfig_netmask", ifconfig_remote_netmask);
-	setenv_str (es, "ifconfig_broadcast", ifconfig_broadcast);
+	bool tun = is_tun_p2p (tt);
+
+	setenv_str (es, "ifconfig_local", ifconfig_local);
+	if (tun)
+	{
+	    setenv_str (es, "ifconfig_remote", ifconfig_remote_netmask);
+	}
+	else
+	{
+	    const char *ifconfig_broadcast = print_in_addr_t (tt->broadcast, 0, &gc);
+	    setenv_str (es, "ifconfig_netmask", ifconfig_remote_netmask);
+	    setenv_str (es, "ifconfig_broadcast", ifconfig_broadcast);
+	}
     }
 
     if (tt->did_ifconfig_ipv6_setup)
-- 
2.3.6


