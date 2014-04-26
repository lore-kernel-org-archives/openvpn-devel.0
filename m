Message-ID: <535B6F81.8030005@...1790...>
Date: Sat, 26 Apr 2014 10:34:09 +0200
From: Tore Anderson <tore@...1790...>
MIME-Version: 1.0
References: <1398452943-18426-1-git-send-email-gert@...1296...>
In-Reply-To: <1398452943-18426-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Rewrite manpage section about
	--multihome
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

* Gert Doering

> +Note 2: if you do an IPv6+IPv4 dual-stack bind on a Linux machine with=20
> +multiple IPv4 address, connections to IPv4 addresses will not work=20
> +right on kernels before 3.14, due to missing kernel support for the=20
> +IPv4-mapped case.

This isn't entirely accurate. There are two patches that are required
for this to work:

=ABipv6: make IPV6_RECVPKTINFO work for ipv4 datagrams=BB
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=
=3D4b261c75a99f29c93a0b6babfc180cdf566bd654

=ABipv6: honor IPV6_PKTINFO with v4 mapped addresses on sendmsg=BB
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=
=3Dc8e6ad0829a723a74cd2fea9996a3392d2579a18

Only the first one is in Linux 3.14, the second one is not (it first
appeared in 3.15-rc1). You should probably say =ABbefore 3.15=BB instead.

Another thing worth noting though, is that Ubuntu backported both
patches to the 3.13-based kernel they are shipping as part of Ubuntu
14.04 =ABTrusty=BB. So it works out of the box there, which is great
news because it's a "Long Term Support" release that will probably
be popular on servers in the years to come. The patches will
eventually make it into the previous LTS release 12.04 =ABPrecise=BB too,
as part of the upcoming 12.04.5 point release (expected in August).

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1284535

Tore

