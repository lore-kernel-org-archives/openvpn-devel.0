From: Gert Doering <gert@...1296...>
Date: Tue,  4 Oct 2022 17:31:27 +0200
Message-Id: <20221004153127.527-1-gert@...1296...>
In-Reply-To: <20221004145318.98467-1-gert@...1296...>
References: <20221004145318.98467-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] un-break undo_ifconfig_ipv4()/_ipv6() on
 all non-linux/non-win32 platforms
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

This commit needs a somewhat longer background story to explain the
problem...

undo_ifconfig_ipv4()/_ipv6() started their life as part of the
TARGET_LINUX (only) close_tun() function.

In commit 611fcbc48, these functions were created, to decouple IPv4/IPv6
dependency, still TARGET_LINUX only, with an #ifdef ENABLE_IPROUTE
inside, to differenciate iproute2 vs. old-style ifconfig.

Commit dc7fcd714 changed this to "the new linux API" (sitnl), calling
net_addr_ptp_v4_del() etc. - in the first branch of the #ifdef,
changing from ENABLE_IPROUTE to TARGET_LINUX, inside a TARGET_LINUX,
so the #else branch was never looked at for any platform.  The code
in that #else branch was still "the old linux ifconfig" style to
undo IPv4/IPv6 address config on the tun interface.

Now, commit 0c4d40cb8 comes along and makes undo_ifconfig_ipvX() a
global function, during the bugfix to "don't undo ifconfig if
--ifconfig-noexec is in effect".  Due to "it makes the code a lot
cleaner" undo_ifconfig*() is now called from do_close_tun_simple()
and no longer from (Linux-) close_tun().

*This* now enables the old "linux ifconfig" code to be run on
"all non-windows platforms" - running commands like

   ifconfig tun0 0.0.0.0

to remove the IPv4 address - which plain doesn't work on the BSDs
(and has not been tested anywhere else).

This all said, it's debatable whether any platforms actually NEED
this - all unixoid platforms remove IPv4/IPv6 addresses on interface
destroy time, so for non-persistant tun/tap interfaces, there is no
hard requirement to remove IP addresses on program exit.  For
persistent tun/tap (pre-create with "ifconfig tun7 create") this is
indeed useful to restore the pre-openvpn state by removing anything
OpenVPN configured.

OpenVPN up to 2.5 did not do this IP address removal on any non-Linux
platform, which is better than exec'ing an ifconfig command that does
nothing but print an error message (very annoying in t_client.sh V=1 runs).

This all said: this patch brings an implementation of undo_ifconfig_*()
for TARGET_FREEBSD ("ifconfig tunX $ip -alias"), and brings back the
old "do nothing" behaviour for all other unixoid platforms.  Tested
on FreeBSD 7.4, 12.3, 14.0.

v2: use #elif defined(TARGET_FREEBSD), otherwise it breaks other platforms

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tun.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 5ea460a6..ddee49f9 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1635,17 +1635,20 @@ undo_ifconfig_ipv4(struct tuntap *tt, openvpn_net_ctx_t *ctx)
                 tt->actual_name);
         }
     }
-#elif !defined(_WIN32)  /* if !defined(TARGET_LINUX) && !defined(_WIN32) */
+#elif defined(TARGET_FREEBSD)
+    struct gc_arena gc = gc_new();
+    const char *ifconfig_local = print_in_addr_t(tt->local, 0, &gc);
     struct argv argv = argv_new();
 
-    argv_printf(&argv, "%s %s 0.0.0.0", IFCONFIG_PATH, tt->actual_name);
-
+    argv_printf(&argv, "%s %s %s -alias", IFCONFIG_PATH,
+                tt->actual_name, ifconfig_local);
     argv_msg(M_INFO, &argv);
-    openvpn_execve_check(&argv, NULL, 0, "Generic ip addr del failed");
+    openvpn_execve_check(&argv, NULL, 0, "FreeBSD ip addr del failed");
 
     argv_free(&argv);
+    gc_free(&gc);
 #endif /* if defined(TARGET_LINUX) */
-       /* Empty for _WIN32. */
+       /* Empty for _WIN32 and all other unixoid platforms */
 }
 
 static void
@@ -1657,21 +1660,21 @@ undo_ifconfig_ipv6(struct tuntap *tt, openvpn_net_ctx_t *ctx)
     {
         msg(M_WARN, "Linux can't del IPv6 from iface %s", tt->actual_name);
     }
-#elif !defined(_WIN32)  /* if !defined(TARGET_LINUX) && !defined(_WIN32) */
+#elif defined(TARGET_FREEBSD)
     struct gc_arena gc = gc_new();
     const char *ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0, &gc);
     struct argv argv = argv_new();
 
-    argv_printf(&argv, "%s %s del %s/%d", IFCONFIG_PATH, tt->actual_name,
-                ifconfig_ipv6_local, tt->netbits_ipv6);
+    argv_printf(&argv, "%s %s inet6 %s/%d -alias", IFCONFIG_PATH,
+                tt->actual_name, ifconfig_ipv6_local, tt->netbits_ipv6);
 
     argv_msg(M_INFO, &argv);
-    openvpn_execve_check(&argv, NULL, 0, "Generic ip -6 addr del failed");
+    openvpn_execve_check(&argv, NULL, 0, "FreeBSD ip -6 addr del failed");
 
     argv_free(&argv);
     gc_free(&gc);
 #endif /* if defined(TARGET_LINUX) */
-       /* Empty for _WIN32. */
+       /* Empty for _WIN32 and all other unixoid platforms */
 }
 
 void
-- 
2.37.3


