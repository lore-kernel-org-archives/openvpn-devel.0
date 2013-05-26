Date: Mon, 27 May 2013 00:36:39 +0200
From: Samuel Thibault <samuel.thibault@...1817...>
Message-ID: <20130526223639.GK26337@...1818...>
References: <20130524215902.GM5874@...1818...>
	<20130525115819.GS20843@...1296...>
MIME-Version: 1.0
In-Reply-To: <20130525115819.GS20843@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn ipv6 pool env variables
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Gert Doering, le Sat 25 May 2013 13:58:19 +0200, a =E9crit :
> > To make it short: yes, the ipv6 pool environment variables are useful,
> > for user-defined scripts to be run at connection for instance to
> > propagate routes, do accounting, etc.  The patch below adds them.
>=20
> You keep claiming that "yes it's useful".  The lack of feedback on the
> list is partly due to the "To make it short" part of your mail...

Ok. I was simply wondering whether it had perhaps got somehow dropped
without reason.

As I mentioned too briefly, the reason we need it is the same as for the
IPv4 case: to announce the route to our bird daemon on connection, and
drop it on disconnection.

> Specifically, "ifconfig_ipv6_local" and "ifconfig_ipv6_netbits" already e=
xist,

Ah, ifconfig_ipv6_netbits didn't when I worked on this patch, I hadn't
noticed that had changed. These can indeed go away.

> So the only thing that I couldn't see right away
> in the environment is "what IPv6 address did the remote receive?" and
> that one *is* available as parameter to the "learn-address" script already
> today...

But we need it from the disconnect script too, to remove the route
announcement. It is available for IPv4, I don't see why things should
be different between IPv6 and IPv4 here. It would make our script way
more obscure for sure (having to record the route somewhere, re-read on
disconnect).

> This whole bit is overly complicated.  Unlike IPv4, there is no "this
> could be a remote or a netmask" distinction,

Right, here is a simpler patch.

Samuel


Add IPv6 pool environment variable

Add the ifconfig_ipv6_pool_remote_ip environment variable, similar to
ifconfig_pool_remote_ip.

Signed-off-by: Samuel Thibault <samuel.thibault@...1817...>

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 397e2bf..afcedef 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5776,6 +5776,22 @@ and
 scripts.
 .\"*********************************************************
 .TP
+.B ifconfig_ipv6_pool_remote_ip
+The remote
+virtual IPv6 address for the TUN/TAP tunnel taken from an
+.B \-\-ifconfig-ipv6-push
+directive if specified, or otherwise from
+the ifconfig pool (controlled by the
+.B \-\-ifconfig-ipv6-pool
+config file directive).
+This option is set on the server prior to execution
+of the
+.B \-\-client-connect
+and
+.B \-\-client-disconnect
+scripts.
+.\"*********************************************************
+.TP
 .B link_mtu
 The maximum packet size (not including the IP header)
 of tunnel data in UDP tunnel transport mode.
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 5d2c36c..23f2714 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2384,6 +2384,7 @@ env_filter_match (const char *env_str, const int env_=
filter_level)
     "dev=3D",
     "ifconfig_pool_remote_ip=3D",
     "ifconfig_pool_netmask=3D",
+    "ifconfig_ipv6_pool_remote_ip=3D",
     "time_duration=3D",
     "bytes_sent=3D",
     "bytes_received=3D"
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f016b14..d5267db 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1437,10 +1437,16 @@ multi_set_virtual_addr_env (struct multi_context *m=
, struct multi_instance *mi)
 	}
     }
=20
-    /* TODO: I'm not exactly sure what these environment variables are
-     *       used for, but if we have them for IPv4, we should also have
-     *       them for IPv6, no?
-     */
+  setenv_del (mi->context.c2.es, "ifconfig_ipv6_pool_remote_ip");
+
+  if (mi->context.c2.push_ifconfig_ipv6_defined)
+    {
+      setenv_in6_addr_t (mi->context.c2.es,
+			"ifconfig_ipv6_pool_remote_ip",
+			&mi->context.c2.push_ifconfig_ipv6_local,
+			SA_SET_IF_NONZERO);
+    }
+
 }
=20
 /*
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 94d2b10..74320ce 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2391,7 +2391,10 @@ setenv_sockaddr (struct env_set *es, const char *nam=
e_prefix, const struct openv
 	}
       break;
     case AF_INET6:
-      openvpn_snprintf (name_buf, sizeof (name_buf), "%s_ip6", name_prefix=
);
+      if (flags & SA_IP_PORT)
+	openvpn_snprintf (name_buf, sizeof (name_buf), "%s_ip6", name_prefix);
+      else
+	openvpn_snprintf (name_buf, sizeof (name_buf), "%s", name_prefix);
       getnameinfo(&addr->addr.sa, sizeof (struct sockaddr_in6),
 		  buf, sizeof(buf), NULL, 0, NI_NUMERICHOST);
       setenv_str (es, name_buf, buf);
@@ -2419,6 +2422,19 @@ setenv_in_addr_t (struct env_set *es, const char *na=
me_prefix, in_addr_t addr, c
 }
=20
 void
+setenv_in6_addr_t (struct env_set *es, const char *name_prefix, struct in6=
_addr *addr, const bool flags)
+{
+  if ( memcmp(addr, &in6addr_any, sizeof(*addr)) !=3D 0 || !(flags & SA_SE=
T_IF_NONZERO))
+    {
+      struct openvpn_sockaddr si;
+      CLEAR (si);
+      si.addr.in6.sin6_family =3D AF_INET6;
+      si.addr.in6.sin6_addr =3D *addr;
+      setenv_sockaddr (es, name_prefix, &si, flags);
+    }
+}
+
+void
 setenv_link_socket_actual (struct env_set *es,
 			   const char *name_prefix,
 			   const struct link_socket_actual *act,
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 4e7e7f8..788e6ee 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -383,6 +383,11 @@ void setenv_in_addr_t (struct env_set *es,
 		       in_addr_t addr,
 		       const unsigned int flags);
=20
+void setenv_in6_addr_t (struct env_set *es,
+			const char *name_prefix,
+			struct in6_addr *addr,
+			const bool flags);
+
 void setenv_link_socket_actual (struct env_set *es,
 				const char *name_prefix,
 				const struct link_socket_actual *act,

