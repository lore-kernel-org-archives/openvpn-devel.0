Message-ID: <20110313020838.31171.qmail@...1287...>
Date: Sun, 13 Mar 2011 03:08:38 +0100
From: Peter Stuge <peter@...1287...>
References: <4D7A7455.4070805@...1114...>
	<20110312003517.3a86c508@...1451...>
	<20110312153620.8987.qmail@...1287...>
	<20110312184423.3fee2f17@...1451...>
	<20110312215420.31033.qmail@...1287...>
	<20110312195923.55eaa915@...1451...>
	<20110312232602.10422.qmail@...1287...>
	<20110312213345.694340df@...1451...>
	<20110313014000.27475.qmail@...1287...>
	<20110313015913.30049.qmail@...1287...>
MIME-Version: 1.0
In-Reply-To: <20110313015913.30049.qmail@...1287...>
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
> Your /usr/share/udhcpc/default.script to accomplish this would be:
> 
> #!/bin/sh
> test "$1" = bound || exit 0
> sed -i "/^local /s/.*/local $ip/" /etc/openvpn/something/local.conf
> /etc/init.d/openvpn.something restart
> 
> 
> This covers initial config and reconfig. Zero distro changes. How
> much simpler do you need?

Actually no, you get to also apply address changes. So more like this:

#!/bin/bash
case "${1}" in
deconfig)
  ip a f dev "${interface}"
  ;;
bound)
  ip a a "${ip}/${mask}" dev "${interface}"
  ip r a default via "${router}" dev "${interface}"
  sed -i "/^local /s/.*/local ${ip}/" /etc/openvpn/something/local.conf
  /etc/init.d/openvpn.something restart
  ;;
*)
  exit 1
  ;;
esac
exit 0


(Might work also with plain sh, but this is similar to what I had in
production so known working, as opposed to the previous which I just
wrote from memory. :)

Suggest you name (or at least symlink) the vpn config to the
interface name, then the above can be generic for all interfaces by
substituing ${interface} for "something".


//Peter

