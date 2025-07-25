From: Gert Doering <gert@...1296...>
Date: Fri, 25 Jul 2025 21:41:39 +0200
Message-ID: <20250725194147.17517-1-gert@...1296...>
In-Reply-To: <gerrit.1752849659000.I43cd3d564d8c6ad4e41de5a38130d90cb6778395@...2715...>
References: <gerrit.1752849659000.I43cd3d564d8c6ad4e41de5a38130d90cb6778395@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] add flag to print addresses in a
 consistent format during float
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

Introduce the MAPF_SHOW_FAMILY flag to prepend the address family to the
address when printing an mroute_addr object, similar to
print_sockaddr_ex(). This ensures that when logging a float operation,
both the old and new addresses are printed in the same format:
$proto:[$family]$address:$port.

Note: when using this flag with an IPv4-mapped IPv6 address, the output
will appear as: [AF_INET6]a.b.c.d

Change-Id: I43cd3d564d8c6ad4e41de5a38130d90cb6778395
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1092
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index a617b33..e3b1e9b 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -415,6 +415,10 @@
                 {
                     buf_printf(&out, "%s:", proto2ascii(maddr.proto, AF_INET, false));
                 }
+                if (flags & MAPF_SHOW_FAMILY)
+                {
+                    buf_printf(&out, "[AF_INET]");
+                }
                 buf_printf(&out, "%s", print_in_addr_t(ntohl(maddr.v4.addr),
                                                        (flags & MAPF_IA_EMPTY_IF_UNDEF) ? IA_EMPTY_IF_UNDEF : 0, gc));
                 if (maddr.type & MR_WITH_NETBITS)
@@ -442,6 +446,10 @@
                 {
                     buf_printf(&out, "%s:", proto2ascii(maddr.proto, AF_INET6, false));
                 }
+                if (flags & MAPF_SHOW_FAMILY)
+                {
+                    buf_printf(&out, "[AF_INET6]");
+                }
                 if (IN6_IS_ADDR_V4MAPPED( &maddr.v6.addr ) )
                 {
                     buf_printf(&out, "%s", print_in_addr_t(maddr.v4mappedv6.addr,
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index c359fd2..4f9fc03 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -150,6 +150,7 @@
 #define MAPF_SUBNET            (1<<0)
 #define MAPF_IA_EMPTY_IF_UNDEF (1<<1)
 #define MAPF_SHOW_ARP          (1<<2)
+#define MAPF_SHOW_FAMILY       (1<<3)
 const char *mroute_addr_print_ex(const struct mroute_addr *ma,
                                  const unsigned int flags,
                                  struct gc_arena *gc);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 4696686..69ec2da 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3274,8 +3274,8 @@
     msg(D_MULTI_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",
         mi->context.c2.tls_multi->peer_id,
         tls_common_name(mi->context.c2.tls_multi, false),
-        mroute_addr_print(&mi->real, &gc),
-        print_link_socket_actual(&m->top.c2.from, &gc));
+        mroute_addr_print_ex(&mi->real, MAPF_SHOW_FAMILY, &gc),
+        mroute_addr_print_ex(&real, MAPF_SHOW_FAMILY, &gc));
 
     /* remove old address from hash table before changing address */
     ASSERT(hash_remove(m->hash, &mi->real));

