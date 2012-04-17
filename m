Date: Tue, 17 Apr 2012 16:16:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120417141612.GF1359@...1296...>
References: <4F8D6C6F.3080403@...1698...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcmJb3WyrQSdDnng"
Content-Disposition: inline
In-Reply-To: <4F8D6C6F.3080403@...1698...>
Subject: Re: [Openvpn-devel] adding ipv6 routes wrong for tap
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Sergey Matveychuk <sem@...1698...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

--qcmJb3WyrQSdDnng
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 17, 2012 at 05:13:19PM +0400, Sergey Matveychuk wrote:
> I see openvpn adds ipv6 routes always for interface not addresses. I=20
> think it should be like in add_route(): something like is_on_link() to=20
> determ if interface should be added or address.

IPv6 routes on TAP doesn't work yet, yes.  This is a documented shortcoming
and I'll fix it as soon as possible (which might not be as soon as you=20
hope for).  TUN works, or setting the routes manually from an "up" script.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--qcmJb3WyrQSdDnng
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT417LKkuBuNlUUl1AQJ+GQP/QWjzThYLNciI4Un/Y6MVq4PHTeJ/1Nbb
2QrXEvtCR0nK2sBiKejCz/dwH5HjMNIlWJRPChFiQsVrMrev2LAZEkZlwhcdTo2x
HgYO5FGwcWImNm7l4yCA3FIY6VB14p7PqcJHSIgnO5mr+G+s7IUlbE7sUhpsi3Dk
oQ3H8x0mIH0=
=iSvm
-----END PGP SIGNATURE-----

--qcmJb3WyrQSdDnng--

