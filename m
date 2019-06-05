Date: Wed, 5 Jun 2019 11:35:27 +0200 (CEST)
Message-Id: <201906050935.x559ZRUB079748@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20181219050118.6568-5-a@...2181...>
References: <20181219050118.6568-5-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: route.c: use new networking API
 to handle routing table on Linux
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master branch.

Tested with t_client test, one binary with --enable-iproute2, one without.

"Route add"-Diffs look nicely different, including the /128 bypass...

Wed Jun  5 11:09:02 2019 /bin/ip route add 194.97.144.0/24 via x.x.x.73
Wed Jun  5 11:09:02 2019 add_route_ipv6(2001:x:x:x::f000:11/128 -> fe80::250:43ff:fe01:dc37 metric 1) dev enp0s25
Wed Jun  5 11:09:02 2019 /bin/ip -6 route add 2001:x:x:x::f000:11/128 dev enp0s25 via fe80::250:43ff:fe01:dc37 metric 1
Wed Jun  5 11:09:02 2019 add_route_ipv6(2001:608::/32 -> 2001:x:x:x::1 metric -1) dev tun0
Wed Jun  5 11:09:02 2019 /bin/ip -6 route add 2001:608::/32 dev tun0

Wed Jun  5 11:09:21 2019 net_route_v4_add: 194.97.144.0/24 via x.x.x.73 dev [NULL] table 0 metric -1
Wed Jun  5 11:09:21 2019 add_route_ipv6(2001:x:x:x::f000:11/128 -> fe80::250:43ff:fe01:dc37 metric 1) dev enp0s25
Wed Jun  5 11:09:21 2019 net_route_v6_add: 2001:x:x:x::f000:11/128 via fe80::250:43ff:fe01:dc37 dev enp0s25 table 0 metric 1
Wed Jun  5 11:09:21 2019 add_route_ipv6(2001:608::/32 -> 2001:x:x:x::1 metric -1) dev tun0
Wed Jun  5 11:09:21 2019 net_route_v6_add: 2001:608::/32 via :: dev tun0 table 0 metric -1


.. but the resulting output of "ip route" + "ip -6 route" is exactly
the same.  Well done :-)


OTOH... :-) - looking at all the changes needed to transport &c->net_ctx,
I wonder why you didn't just hide it in c->c1.tuntap, as we did for the
windows socket... (tt->options.msg_channel).  Almost everything related 
to "routing and ifconfig" needs to have the tt pointer available already
today...

Warts:

+#else
+    const char *iface;
+    int metric;
+#endif

.. I think this really should be inside the #ifdef TARGET_LINUX block,
not outside in an #else for an #if !defined(TARGET_LINUX)...  so the
code further down would then become

#if defined(TARGET_LINUX)
    const char *ifcace = NULL;
    if (is_on_link(...))

.. having declaration and initialization in one place, and "where it
belongs".  Same thing for add_route_ipv6()...

+#if defined(TARGET_LINUX)
+    int metric;
+#endif

.. this is adding an extra #ifdef and taking 3 extra lines instead of
just having "int metric = -1;" down where it's initialized.

delete_route() sports this beauty...

+#if !defined(TARGET_LINUX)
     const char *network;
 #if !defined(ENABLE_IPROUTE) && !defined(TARGET_AIX)
     const char *netmask;
 #endif
 #if !defined(TARGET_LINUX) && !defined(TARGET_ANDROID)
     const char *gateway;
+#endif

.. so you have two linux-specific defines (ENABLE_IPROUTE and TARGET_LINUX)
*inside* an "#if !defined(TARGET_LINUX)"...  plus the "metric" thing...


commit aec4a3d1b6a9e4d9e584b368126da061c15b174b
Author: Antonio Quartulli
Date:   Wed Dec 19 15:01:15 2018 +1000

     route.c: use new networking API to handle routing table on Linux

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20181219050118.6568-5-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18029.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


