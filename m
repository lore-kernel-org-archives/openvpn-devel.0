Date: Fri, 26 Jun 2015 19:11:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150626171126.GD382@...1296...>
References: <1435248080-12670-1-git-send-email-Holger.Kummert@...1516...>
	<20150626073544.GT382@...1296...> <558D2D98.70905@...1516...>
	<20150626112401.GU382@...1296...> <558D8663.6000308@...1516...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7MD0VOBR9BkgZ/an"
Content-Disposition: inline
In-Reply-To: <558D8663.6000308@...1516...>
Subject: Re: [Openvpn-devel] [PATCH] Del ipv6 addr on close of linux tun
	interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Holger Kummert <Holger.Kummert@...1516...>
Cc: openvpn-devel@lists.sourceforge.net

--7MD0VOBR9BkgZ/an
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 26, 2015 at 07:05:39PM +0200, Holger Kummert wrote:
> >So, what is different on your end?  Why is the tun<x> keeping its addres=
s?
>=20
> This looks similar on my machine. But the difference comes when after
> the disconnect a new connect is forced which failed on my site.

Can you send me (private mail) a log with --verb 3?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--7MD0VOBR9BkgZ/an
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVY2HvqkuBuNlUUl1AQLM3gQAkHg3l1m5k2Qb690DJba5HsEddk3jdsEx
lybxtE/c5Dk7ZJuo7agYQUaTDNUdatZ77SpSm70fJhUCnrXB4ylKvC7Y9AIxEZRA
iYot1hFq7MqP/Kc0Z/0G7gXb20m9HIEJZ5vhAg027OT8ibzaJ0TbfzW91TJ3YTVZ
0nPtkJtuNc4=
=EbFJ
-----END PGP SIGNATURE-----

--7MD0VOBR9BkgZ/an--

