Message-ID: <b16cab79-188f-41a3-af32-f944a387400f@...68...>
Date: Mon, 16 Dec 2024 13:22:38 +0100
MIME-Version: 1.0
References: <7e42399c-3a94-40a2-bcaa-15545c3b761c@...68...>
 <6a00da72-dc11-409e-9d47-4694e1d6f02f@...68...>
 <a986633d-69d7-4bd1-b288-2f0de53b106e@...2181...>
Content-Language: de-CH
From: corubba <corubba@...68...>
In-Reply-To: <a986633d-69d7-4bd1-b288-2f0de53b106e@...2181...>
Subject: [Openvpn-devel] [PATCH v2 1/2] port-share: Normalize IPv4-mapped
 IPv6 addresses
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Before passing IPv4-mapped IPv6 addresses to the proxy journal,
translate them to plain IPv4 addresses. Whether the connection was
accepted by OpenVPN on a "dual stack" socket is of no importance to the
proxy receiver.

Signed-off-by: Corubba Smith <corubba@...68...>
---
 src/openvpn/ps.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 06bf91a8..36ea63b8 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -330,6 +330,22 @@ proxy_list_housekeeping(struct proxy_connection **list)
     }
 }

+/*
+ * In-place transformation of an openvpn_sockaddr with an IPv4-mapped IPv6
+ * address to one with a plain IPv4 address. No-op otherwise.
+ */
+static void
+transform_mapped_v4_sockaddr(struct openvpn_sockaddr *sock)
+{
+    if (sock->addr.sa.sa_family =3D=3D AF_INET6 && IN6_IS_ADDR_V4MAPPED(&s=
ock->addr.in6.sin6_addr))
+    {
+        sock->addr.in4.sin_family =3D AF_INET;
+        /* sin_port and sin6_port are the same already */
+        memcpy(&sock->addr.in4.sin_addr, &sock->addr.in6.sin6_addr.s6_addr=
[12], 4);
+        memset(&sock->addr.in4 + 1, 0, sizeof(sock->addr) - sizeof(sock->a=
ddr.in4));
+    }
+}
+
 /*
  * Record IP/port of client in filesystem, so that server receiving
  * the proxy can determine true client origin.
@@ -349,6 +365,8 @@ journal_add(const char *journal_dir, struct proxy_conne=
ction *pc, struct proxy_c
     if (!getpeername(pc->sd, (struct sockaddr *) &from.addr.sa, &slen)
         && !getsockname(cp->sd, (struct sockaddr *) &to.addr.sa, &dlen))
     {
+        transform_mapped_v4_sockaddr(&from);
+        transform_mapped_v4_sockaddr(&to);
         const char *f =3D print_openvpn_sockaddr(&from, &gc);
         const char *t =3D print_openvpn_sockaddr(&to, &gc);
         fnlen =3D  strlen(journal_dir) + strlen(t) + 2;
--
2.47.1

