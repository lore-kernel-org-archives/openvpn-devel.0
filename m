Message-ID: <53CC04B8.1070808@...1085...>
Date: Sun, 20 Jul 2014 13:04:40 -0500
From: Josh Cepek <josh.cepek@...1085...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090609000205010208010004"
Subject: [Openvpn-devel] [PATCH] Support IPv6 env-vars for server-provided
	IPs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090609000205010208010004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Patch attached, with detached GPG sig. The patch description follows:

This adds missing IPv6 pool support in the env-vars provided to scripts.
Also adds a setenv_in6_addr() function to socket.c that provides a
v6-version of setenv_in_addr_t().

The ifconfig_ipv6_pool_netbits will in most cases be exactly the same as
ifconfig_ipv6_netbits. However, the code does allow the client to be
pushed a different CIDR range. To support this, and match handling of
IPv4, this is exposed to client scripts. Should this design change in
the future, it is likely both the ifconfig_ipv6_pool_netbits and
ifconfig_pool_netmask can be removed. This patch makes no attempt to
resolve these larger issues.

Aside from the netbits. the ifconfig_ipv6_pool_local_ip is useful to
expose as well. In a p2p topology, the pair of IPs pushed is completely
arbitrary and need not match the IP the server is using. It often will
out of convention, but since an --ifconfig-ipv6-push can supply
arbitrary values, this should again be available to scripts wishing to
take advantage of it.

This fixes #230.

Signed-off-by: Josh Cepek <josh.cepek@...1085...>

--------------090609000205010208010004
Content-Type: text/x-patch;
 name="v6-pool-env-vars.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v6-pool-env-vars.patch"

From 257c18edbe0c0b194f1130a842bc9306c1baee75 Mon Sep 17 00:00:00 2001
From: Josh Cepek <josh.cepek@...1085...>
Date: Fri, 7 Feb 2014 11:40:29 -0600
Subject: [PATCH] Support IPv6 env-vars for server-provided IPs

This adds missing IPv6 pool support in the env-vars provided to scripts.
Also adds a setenv_in6_addr() function to socket.c that provides a
v6-version of setenv_in_addr_t().

The ifconfig_ipv6_pool_netbits will in most cases be exactly the same as
ifconfig_ipv6_netbits. However, the code does allow the client to be
pushed a different CIDR range. To support this, and match handling of
IPv4, this is exposed to client scripts. Should this design change in
the future, it is likely both the ifconfig_ipv6_pool_netbits and
ifconfig_pool_netmask can be removed. This patch makes no attempt to
resolve these larger issues.

Aside from the netbits. the ifconfig_ipv6_pool_local_ip is useful to
expose as well. In a p2p topology, the pair of IPs pushed is completely
arbitrary and need not match the IP the server is using. It often will
out of convention, but since an --ifconfig-ipv6-push can supply
arbitrary values, this should again be available to scripts wishing to
take advantage of it.

This fixes #230.

Signed-off-by: Josh Cepek <josh.cepek@...1085...>
---
 src/openvpn/multi.c  | 37 ++++++++++++++++++++++++++++++++-----
 src/openvpn/socket.c | 13 +++++++++++++
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 5910154..6c18db6 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1403,6 +1403,14 @@ multi_select_virtual_addr (struct multi_context *m, struct multi_instance *mi)
 static void
 multi_set_virtual_addr_env (struct multi_context *m, struct multi_instance *mi)
 {
+  const bool have_v6 = mi->context.c2.push_ifconfig_ipv6_defined;
+
+  if (have_v6)
+    {
+      setenv_del (mi->context.c2.es, "ifconfig_ipv6_pool_local_ip");
+      setenv_del (mi->context.c2.es, "ifconfig_ipv6_pool_remote_ip");
+      setenv_del (mi->context.c2.es, "ifconfig_ipv6_pool_netbits");
+    }
   setenv_del (mi->context.c2.es, "ifconfig_pool_local_ip");
   setenv_del (mi->context.c2.es, "ifconfig_pool_remote_ip");
   setenv_del (mi->context.c2.es, "ifconfig_pool_netmask");
@@ -1417,12 +1425,28 @@ multi_set_virtual_addr_env (struct multi_context *m, struct multi_instance *mi)
 			mi->context.c2.push_ifconfig_local,
 			SA_SET_IF_NONZERO);
 
+      if (have_v6)
+        {
+          setenv_in6_addr (mi->context.c2.es,
+			   "ifconfig_ipv6_pool_remote_ip",
+			   mi->context.c2.push_ifconfig_ipv6_local,
+			   SA_SET_IF_NONZERO);
+        }
+
       if (tunnel_type == DEV_TYPE_TAP || (tunnel_type == DEV_TYPE_TUN && tunnel_topology == TOP_SUBNET))
 	{
 	  setenv_in_addr_t (mi->context.c2.es,
 			    "ifconfig_pool_netmask",
 			    mi->context.c2.push_ifconfig_remote_netmask,
 			    SA_SET_IF_NONZERO);
+
+	  if (have_v6)
+	    {
+	      setenv_int (mi->context.c2.es,
+			  "ifconfig_ipv6_pool_netbits",
+			  mi->context.c2.push_ifconfig_ipv6_netbits);
+	    }
+
 	}
       else if (tunnel_type == DEV_TYPE_TUN)
 	{
@@ -1430,13 +1454,16 @@ multi_set_virtual_addr_env (struct multi_context *m, struct multi_instance *mi)
 			    "ifconfig_pool_local_ip",
 			    mi->context.c2.push_ifconfig_remote_netmask,
 			    SA_SET_IF_NONZERO);
+
+	  if (have_v6)
+	    {
+	      setenv_in6_addr (mi->context.c2.es,
+			       "ifconfig_ipv6_pool_local_ip",
+			       mi->context.c2.push_ifconfig_ipv6_remote,
+			       SA_SET_IF_NONZERO);
+	    }
 	}
     }
-
-    /* TODO: I'm not exactly sure what these environment variables are
-     *       used for, but if we have them for IPv4, we should also have
-     *       them for IPv6, no?
-     */
 }
 
 /*
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 9e6bd10..b0065ca 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2593,6 +2593,19 @@ setenv_in_addr_t (struct env_set *es, const char *name_prefix, in_addr_t addr, c
 }
 
 void
+setenv_in6_addr (struct env_set *es, const char *name_prefix, struct in6_addr addr, const unsigned int flags)
+{
+  if (addr.s6_addr || !(flags & SA_SET_IF_NONZERO))
+    {
+      struct openvpn_sockaddr si;
+      CLEAR (si);
+      si.addr.in6.sin6_family = AF_INET6;
+      si.addr.in6.sin6_addr = addr;
+      setenv_sockaddr (es, name_prefix, &si, flags);
+    }
+}
+
+void
 setenv_link_socket_actual (struct env_set *es,
 			   const char *name_prefix,
 			   const struct link_socket_actual *act,
-- 
1.9.1


--------------090609000205010208010004
Content-Type: text/plain; charset=UTF-8;
 name="v6-pool-env-vars.patch.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="v6-pool-env-vars.patch.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG

iQGcBAABAgAGBQJTzAcPAAoJENcx2Xpgb9RjmpgMAKt/u5gXGBtf5xQtmu59MuDP
HzFetN52BvP1FIHMR0LulOKkUmWDKCWuorSN9dGir7mk13ob/6pNL6eLi/X0J4BD
+Zi97wXVrJz7TdAcdKQKBwhNiAkl2f2RUDrKeOK60AuA3fL7Bv7EMNpSzo94Q25y
h4TMQul9N3M8le6Oqc5bq6RnBwnV/9KacN6GvSp3OP9lEpOB+9dB0uC3JMnh2CA0
rpX7GY/3rHF9DmpsKtZz05Txg4EmYJfj5uwdqJNKss04bvxuD0UrADaTH932N9o4
pSiEfZq1OGzHUitcMOKkUMKjbbFN1vBzMUR7Kyk5aLug+tlycJiw16ov1g/CBM+Q
8kZHQEa4uVPa33aXj4Ji7ec4KDHh2DMeinAY3hPV8NU2bcxdS6vGaVkz8EXKEkyu
SrXId1CvRltnu5fnh5QSfAnPcdQcig06OSsfWXfodGfCySIsPki3BCEYKh51oKfl
vcJAMaXvIHKyrM8HXqxqsND+Yb9PE+en8oBUjqqBbA==
=rceb
-----END PGP SIGNATURE-----

--------------090609000205010208010004--

