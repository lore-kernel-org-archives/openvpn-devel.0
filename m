Message-ID: <20110313015913.30049.qmail@...1287...>
Date: Sun, 13 Mar 2011 02:59:13 +0100
From: Peter Stuge <peter@...1287...>
References: <20110311122309.1292c1dd@...1451...>
	<4D7A7455.4070805@...1114...>
	<20110312003517.3a86c508@...1451...>
	<20110312153620.8987.qmail@...1287...>
	<20110312184423.3fee2f17@...1451...>
	<20110312215420.31033.qmail@...1287...>
	<20110312195923.55eaa915@...1451...>
	<20110312232602.10422.qmail@...1287...>
	<20110312213345.694340df@...1451...>
	<20110313014000.27475.qmail@...1287...>
MIME-Version: 1.0
In-Reply-To: <20110313014000.27475.qmail@...1287...>
Subject: Re: [Openvpn-devel] [PATCH] Bind only to specified interface
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

Peter Stuge wrote:
> Changing startup scripts or wrapping openvpn is one way. But I
> would probably drive everything from the DHCP client instead.
> 
> As I wrote, udhcpc is very very easy to deal with.

Your /usr/share/udhcpc/default.script to accomplish this would be:

#!/bin/sh
test "$1" = bound || exit 0
sed -i "/^local /s/.*/local $ip/" /etc/openvpn/something/local.conf
/etc/init.d/openvpn.something restart


This covers initial config and reconfig. Zero distro changes. How
much simpler do you need?


//Peter

