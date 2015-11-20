From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 20 Nov 2015 18:23:58 +0100
Message-ID: <1448040238-21813-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] put virtual IPv6 addresses into env
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Add missing environment variables for IPv6 virtual addresses:

  * ifconfig_pool_local_ipv6
  * ifconfig_pool_remote_ipv6
  * ifconfig_pool_ipv6_netbits

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/multi.c  | 22 ++++++++++++++++++----
 src/openvpn/socket.c | 16 ++++++++++++++++
 src/openvpn/socket.h |  5 +++++
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 2839b30..7424c3f 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1432,10 +1432,24 @@ multi_set_virtual_addr_env (struct multi_context *m=
, struct multi_instance *mi)
        }
     }

-    /* TODO: I'm not exactly sure what these environment variables are
-     *       used for, but if we have them for IPv4, we should also have
-     *       them for IPv6, no?
-     */
+  setenv_del (mi->context.c2.es, "ifconfig_pool_local_ipv6");
+  setenv_del (mi->context.c2.es, "ifconfig_pool_remote_ipv6");
+  setenv_del (mi->context.c2.es, "ifconfig_pool_ipv6_netbits");
+
+  if (mi->context.c1.tuntap->ipv6 && mi->context.c2.push_ifconfig_ipv6_def=
ined)
+    {
+      setenv_in6_addr (mi->context.c2.es,
+                       "ifconfig_pool_remote_ipv6",
+                       &mi->context.c2.push_ifconfig_ipv6_local,
+                       SA_SET_IF_NONZERO);
+      setenv_in6_addr (mi->context.c2.es,
+                       "ifconfig_pool_local_ipv6",
+                       &mi->context.c2.push_ifconfig_ipv6_remote,
+                       SA_SET_IF_NONZERO);
+      setenv_int (mi->context.c2.es,
+                  "ifconfig_pool_ipv6_netbits",
+                  mi->context.c2.push_ifconfig_ipv6_netbits);
+    }
 }

 /*
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 100eedd..2f4ee56 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2443,6 +2443,22 @@ setenv_in_addr_t (struct env_set *es, const char *na=
me_prefix, in_addr_t addr, c
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
+      si.addr.in6.sin6_family =3D AF_INET6;
+      memcpy (&si.addr.in6.sin6_addr, addr, sizeof (*addr));
+      setenv_sockaddr (es, name_prefix, &si, flags|SA_NO_IP_SUFFIX);
+    }
+}
+
+void
 setenv_link_socket_actual (struct env_set *es,
                           const char *name_prefix,
                           const struct link_socket_actual *act,
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index e0e0fff..6e9b9b6 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -410,6 +410,11 @@ void setenv_in_addr_t (struct env_set *es,
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
1.8.2.3



Sophos Technology GmbH, Amalienbadstra=E1=BA=9Ee 41/Bau 52, D-76227 Karlsru=
he, Deutschland
Tel +49 (0)721 25516 0 Fax +49 (0)721 25516 200 E-Mail info@...2075... www.=
sophos.de
Sitz der Gesellschaft: Karlsruhe, Amtsgericht Mannheim HRB 712658
Gesch=C3=A4ftsf=C3=BChrer: Nicholas Bray, Pino von Kienlin, Wolfgang Hilper=
t, Jennifer Onslow.
Sophos GmbH, Gustav-Stresemann-Ring 1, 65189 Wiesbaden, Deutschland
Tel +49 (0) 611 5858-0 Fax +49 (0) 611 5858-1042 E-Mail info@...2075... www=
.sophos.de
Sitz der Gesellschaft: Wiesbaden, Amtsgericht Wiesbaden HRB 25915 Gesch=C3=
=A4ftsf=C3=BChrer: Nicholas Bray, Wolfgang Hilpert, Pino von Kienlin, Jenni=
fer Onslow

