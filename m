From: Lars Karlslund <lak@...393...>
Content-Type: multipart/alternative; boundary="=-cgfczQ9Y80p1NoWmtBKH"
Message-Id: <1115651322.10666.20.camel@...394...>
Mime-Version: 1.0
Subject: [Openvpn-devel] OpenVPN double routing problem?
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon May  9 08:10:14 2005
To: openvpn-devel@lists.sourceforge.net

--=-cgfczQ9Y80p1NoWmtBKH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I'm doing some firewalls for remote office sites, and want do have a
dual VPN connection setup:

Two seperate VPN gateways at the main site, each with their own
configuration files, internet connection etc. for redundancy.

On the remote end I specify (amongst others):
remote vpnbox1
ifconfig 10.251.0.2 10.251.0.1
ping 1
ping-restart 3
route 10.0.0.0 255.0.0.0 10.251.0.1 1
route-delay

And the other tunnel:
remote vpnbox2
ifconfig 10.252.0.2 10.252.0.1
ping 1
ping-restart 3
route 10.0.0.0 255.0.0.0 10.251.0.1 2
route-delay

This works, as both tunnels come up (each added with "ip route add
10.0.0.0/8 via <gwip> metrix <metric>", and "ip route" gives me two
routes each with their own metric.

But alas, bringing one tunnel down, removes both routes as the route is
removed with "ip route delete 10.0.0.0/8"

This is a bug, right?


-- 
Lars Karlslund <lak@...393...>

--=-cgfczQ9Y80p1NoWmtBKH
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
Hi,<BR>
<BR>
I'm doing some firewalls for remote office sites, and want do have a dual VPN connection setup:<BR>
<BR>
Two seperate VPN gateways at the main site, each with their own configuration files, internet connection etc. for redundancy.<BR>
<BR>
On the remote end I specify (amongst others):<BR>
remote vpnbox1<BR>
ifconfig 10.251.0.2 10.251.0.1<BR>
ping 1<BR>
ping-restart 3<BR>
route 10.0.0.0 255.0.0.0 10.251.0.1 1<BR>
route-delay<BR>
<BR>
And the other tunnel:<BR>
remote vpnbox2<BR>
ifconfig 10.252.0.2 10.252.0.1<BR>
ping 1<BR>
ping-restart 3<BR>
route 10.0.0.0 255.0.0.0 10.251.0.1 2<BR>
route-delay<BR>
<BR>
This works, as both tunnels come up (each added with &quot;ip route add 10.0.0.0/8 via &lt;gwip&gt; metrix &lt;metric&gt;&quot;, and &quot;ip route&quot; gives me two routes each with their own metric.<BR>
<BR>
But alas, bringing one tunnel down, removes both routes as the route is removed with &quot;ip route delete 10.0.0.0/8&quot;<BR>
<BR>
This is a bug, right?<BR>
<BR>
<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
-- <BR>
Lars Karlslund &lt;<A HREF="mailto:lak@...393...">lak@...393...</A>&gt;
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-cgfczQ9Y80p1NoWmtBKH--


