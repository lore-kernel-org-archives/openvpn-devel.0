Resent-Message-ID: <20130331232948.GA17794@...1818...>
Resent-To: openvpn-devel@lists.sourceforge.net
Resent-Message-ID: <20130331232846.GA17720@...1818...>
Resent-To: openvpn-devel@lists.sourceforge.net
Date: Mon, 1 Apr 2013 00:37:02 +0200
From: Samuel Thibault <samuel.thibault@...1817...>
Message-ID: <20130331223702.GH6229@...1818...>
References: <20121228194819.GA17147@...1819...>
MIME-Version: 1.0
In-Reply-To: <20121228194819.GA17147@...1819...>
Subject: Re: [Openvpn-devel] openvpn ipv6 pool env variables
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hello,

To make it short: yes, the ipv6 pool environment variables are useful,
for user-defined scripts to be run at connection for instance to
propagate routes, do accounting, etc.  The patch below adds them.

Thanks,
Samuel


Add IPv6 pool environment variables

Add ifconfig_ipv6_pool_local_ip, ifconfig_ipv6_pool_remote_ip and
ifconfig_ipv6_pool_netbits environment variables, similar to
ifconfig_pool_local_ip, ifconfig_pool_remote_ip, and
ifconfig_pool_netmask.

Signed-off-by: Samuel Thibault <samuel.thibault@...1817...>

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index d590714..70a8f35 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5755,6 +5755,60 @@ and
 scripts.
 .\"*********************************************************
 .TP
+.B ifconfig_ipv6_pool_local_ip
+The local
+virtual IPv6 address for the TUN/TAP tunnel taken from an
+.B \-\-ifconfig-ipv6-push
+directive if specified, or otherwise from
+the ifconfig pool (controlled by the
+.B \-\-ifconfig-ipv6-pool
+config file directive).
+Only set for
+.B \-\-dev tun
+tunnels.
+This option is set on the server prior to execution
+of the
+.B \-\-client-connect
+and
+.B \-\-client-disconnect
+scripts.
+.\"*********************************************************
+.TP
+.B ifconfig_ipv6_pool_netbits
+The
+size of the virtual IPv6 netmask for the TUN/TAP tunnel taken from an
+.B \-\-ifconfig-ipv6-push
+directive if specified, or otherwise from
+the ifconfig pool (controlled by the
+.B \-\-ifconfig-ipv6-pool
+config file directive).
+Only set for
+.B \-\-dev tap
+tunnels.
+This option is set on the server prior to execution
+of the
+.B \-\-client-connect
+and
+.B \-\-client-disconnect
+scripts.
+.\"*********************************************************
+.TP
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
index 0a4542a..72686f3 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2283,6 +2283,8 @@ env_filter_match (const char *env_str, const int env_filter_level)
     "dev=",
     "ifconfig_pool_remote_ip=",
     "ifconfig_pool_netmask=",
+    "ifconfig_ipv6_pool_remote_ip=",
+    "ifconfig_ipv6_pool_netbits=",
     "time_duration=",
     "bytes_sent=",
     "bytes_received="
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index ab3f10c..d38cc8e 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1426,10 +1426,35 @@ multi_set_virtual_addr_env (struct multi_context *m, struct multi_instance *mi)
 	}
     }
 
-    /* TODO: I'm not exactly sure what these environment variables are
-     *       used for, but if we have them for IPv4, we should also have
-     *       them for IPv6, no?
-     */
+  setenv_del (mi->context.c2.es, "ifconfig_ipv6_pool_local_ip");
+  setenv_del (mi->context.c2.es, "ifconfig_ipv6_pool_remote_ip");
+  setenv_del (mi->context.c2.es, "ifconfig_ipv6_pool_netbits");
+
+  if (mi->context.c2.push_ifconfig_ipv6_defined)
+    {
+      const int tunnel_type = TUNNEL_TYPE (mi->context.c1.tuntap);
+      const int tunnel_topology = TUNNEL_TOPOLOGY (mi->context.c1.tuntap);
+
+      setenv_in6_addr_t (mi->context.c2.es,
+			"ifconfig_ipv6_pool_remote_ip",
+			&mi->context.c2.push_ifconfig_ipv6_local,
+			SA_SET_IF_NONZERO);
+
+      if (tunnel_type == DEV_TYPE_TAP || (tunnel_type == DEV_TYPE_TUN && tunnel_topology == TOP_SUBNET))
+	{
+	  setenv_int (mi->context.c2.es,
+			    "ifconfig_ipv6_pool_netbits",
+			    mi->context.c2.push_ifconfig_ipv6_netbits);
+	}
+      else if (tunnel_type == DEV_TYPE_TUN)
+	{
+	  setenv_in6_addr_t (mi->context.c2.es,
+			    "ifconfig_ipv6_pool_local_ip",
+			    &mi->context.c2.push_ifconfig_ipv6_remote,
+			    SA_SET_IF_NONZERO);
+	}
+    }
+
 }
 
 /*
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 8eb112b..8eb27f6 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2381,7 +2381,10 @@ setenv_sockaddr (struct env_set *es, const char *name_prefix, const struct openv
 	}
       break;
     case AF_INET6:
-      openvpn_snprintf (name_buf, sizeof (name_buf), "%s_ip6", name_prefix);
+      if (flags & SA_IP_PORT)
+	openvpn_snprintf (name_buf, sizeof (name_buf), "%s_ip6", name_prefix);
+      else
+	openvpn_snprintf (name_buf, sizeof (name_buf), "%s", name_prefix);
       getnameinfo(&addr->addr.sa, sizeof (struct sockaddr_in6),
 		  buf, sizeof(buf), NULL, 0, NI_NUMERICHOST);
       setenv_str (es, name_buf, buf);
@@ -2409,6 +2412,19 @@ setenv_in_addr_t (struct env_set *es, const char *name_prefix, in_addr_t addr, c
 }
 
 void
+setenv_in6_addr_t (struct env_set *es, const char *name_prefix, struct in6_addr *addr, const bool flags)
+{
+  if ( memcmp(addr, &in6addr_any, sizeof(*addr)) != 0 || !(flags & SA_SET_IF_NONZERO))
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
index 4e7e7f8..788e6ee 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -383,6 +383,11 @@ void setenv_in_addr_t (struct env_set *es,
 		       in_addr_t addr,
 		       const unsigned int flags);
 
+void setenv_in6_addr_t (struct env_set *es,
+			const char *name_prefix,
+			struct in6_addr *addr,
+			const bool flags);
+
 void setenv_link_socket_actual (struct env_set *es,
 				const char *name_prefix,
 				const struct link_socket_actual *act,



