From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 25 Nov 2015 17:46:49 +0100
Message-Id: <1448470009-5243-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1448383504-20376-1-git-send-email-heiko.hund@...1489...>
References: <1448383504-20376-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCHv3] put virtual IPv6 addresses into env
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

Add missing environment variables for IPv6 virtual addresses:

  * ifconfig_pool_local_ip6
  * ifconfig_pool_remote_ip6
  * ifconfig_pool_ip6_netbits

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/multi.c  |   22 ++++++++++++++++++----
 src/openvpn/socket.c |   16 ++++++++++++++++
 src/openvpn/socket.h |    5 +++++
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a2ab16e..6e6d457 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1506,10 +1506,24 @@ multi_set_virtual_addr_env (struct multi_context *m, struct multi_instance *mi)
 	}
     }
 
-    /* TODO: I'm not exactly sure what these environment variables are
-     *       used for, but if we have them for IPv4, we should also have
-     *       them for IPv6, no?
-     */
+  setenv_del (mi->context.c2.es, "ifconfig_pool_local_ip6");
+  setenv_del (mi->context.c2.es, "ifconfig_pool_remote_ip6");
+  setenv_del (mi->context.c2.es, "ifconfig_pool_ip6_netbits");
+
+  if (mi->context.c1.tuntap->ipv6 && mi->context.c2.push_ifconfig_ipv6_defined)
+    {
+      setenv_in6_addr (mi->context.c2.es,
+                       "ifconfig_pool_remote",
+                       &mi->context.c2.push_ifconfig_ipv6_local,
+                       SA_SET_IF_NONZERO);
+      setenv_in6_addr (mi->context.c2.es,
+                       "ifconfig_pool_local",
+                       &mi->context.c2.push_ifconfig_ipv6_remote,
+                       SA_SET_IF_NONZERO);
+      setenv_int (mi->context.c2.es,
+                  "ifconfig_pool_ip6_netbits",
+                  mi->context.c2.push_ifconfig_ipv6_netbits);
+    }
 }
 
 /*
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 8e6b4bc..bc2a80c 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2611,6 +2611,22 @@ setenv_in_addr_t (struct env_set *es, const char *name_prefix, in_addr_t addr, c
 }
 
 void
+setenv_in6_addr (struct env_set *es,
+                 const char *name_prefix,
+                 const struct in6_addr *addr,
+                 const unsigned int flags)
+{
+  if (!IN6_IS_ADDR_UNSPECIFIED (addr) || !(flags & SA_SET_IF_NONZERO))
+    {
+      struct openvpn_sockaddr si;
+      CLEAR (si);
+      si.addr.in6.sin6_family = AF_INET6;
+      si.addr.in6.sin6_addr = *addr;
+      setenv_sockaddr (es, name_prefix, &si, flags);
+    }
+}
+
+void
 setenv_link_socket_actual (struct env_set *es,
 			   const char *name_prefix,
 			   const struct link_socket_actual *act,
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 54cdc88..3a540df 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -402,6 +402,11 @@ void setenv_in_addr_t (struct env_set *es,
 		       in_addr_t addr,
 		       const unsigned int flags);
 
+void setenv_in6_addr (struct env_set *es,
+                      const char *name_prefix,
+                      const struct in6_addr *addr,
+                      const unsigned int flags);
+
 void setenv_link_socket_actual (struct env_set *es,
 				const char *name_prefix,
 				const struct link_socket_actual *act,
-- 
1.7.9.5


