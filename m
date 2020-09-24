From: Simon Rozman <simon@...2293...>
Date: Thu, 24 Sep 2020 08:44:51 +0200
Message-Id: <20200924064452.1001-2-simon@...2293...>
In-Reply-To: <20200924064452.1001-1-simon@...2293...>
References: <20200924064452.1001-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] netsh: Clear existing IPv6 DNS servers
 before configuring new ones
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

When there are no IPv6 DNS published, the adapter state is not
sanitized and might contain IPv6 DNS server from a previous session.

netsh_ifconfig_options() clears DNS servers for IPv4 already.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpn/tun.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 8fd3229f..b1cd7a1b 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5281,7 +5281,6 @@ ip_addr_member_of(const in_addr_t addr, const IP_ADDR_STRING *ias)
  * Set the ipv6 dns servers on the specified interface.
  * The list of dns servers currently set on the interface
  * are cleared first.
- * No action is taken if number of addresses (addr_len) < 1.
  */
 static void
 netsh_set_dns6_servers(const struct in6_addr *addr_list,
@@ -5291,6 +5290,13 @@ netsh_set_dns6_servers(const struct in6_addr *addr_list,
     struct gc_arena gc = gc_new();
     struct argv argv = argv_new();
 
+    /* delete existing DNS settings from TAP interface */
+    argv_printf(&argv, "%s%s interface ipv6 delete dns %lu all",
+                get_win_sys_path(),
+                NETSH_PATH_SUFFIX,
+                adapter_index);
+    netsh_command(&argv, 2, M_FATAL);
+
     for (int i = 0; i < addr_len; ++i)
     {
         const char *fmt = (i == 0) ?
-- 
2.28.0.windows.1


