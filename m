Date: Tue, 14 Oct 2014 17:17:09 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20141014151709.GT396@...1296...>
References: <543B9FC6.3010800@...1937...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1RkCiX/UEfbG28Bk"
Content-Disposition: inline
In-Reply-To: <543B9FC6.3010800@...1937...>
Subject: Re: [Openvpn-devel] Default gateway can't be determined on
	illumos/solaris
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alexander Pyhalov <alp@...1937...>
Cc: openvpn-devel@lists.sourceforge.net

--1RkCiX/UEfbG28Bk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 13, 2014 at 01:47:50PM +0400, Alexander Pyhalov wrote:
> In openvpn 2.3.4 on illumos/Solaris clients gateway for client can't be=20
> determined, because default stub is used instead of=20
> get_default_gateway() function. This means that the following push route=
=20
> option in server config is not working:
> push "route remote_host 255.255.255.255 net_gateway"
>=20
> OpenVPN  client says that it doesn't know net_gateway.
> The following patch mostly uses existing FreeBSD code to add=20
> get_default_gateway() implementation:=20
> https://github.com/pyhalov/oi-userland/blob/openvpn/components/openvpn/pa=
tches/get_default_gateway.patch=20
> .

Thanks.  Feature-ACK, but... please rebase against git master, as the
code in question looks quite a bit different now, after

commit cab6305be749930eae9c4a1348fb90c4c515d8d7
Author: Gert Doering <gert@...1296...>
Date:   Tue Jan 14 14:33:18 2014 +0100

    Merge get_default_gateway() implementation for all 4+1 BSD variants.

(maybe send both patches, against 2.3.4 and git master, as the code is
really different enough that "git cherry-pick" won't work... that's what
you get for cleaning up - more maintenance work!)


Please then send to the list with "git-send-email" - our ACKing process=20
works on what is here on the list, so "somthing on github" can't be=20
properly archived.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1RkCiX/UEfbG28Bk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVD0+dakuBuNlUUl1AQJbEwP+NsR2/JlzwAqG/2yd5lNNMjhrD01Tjvm+
7muyvrXWHuFcga6XkzSn21wT82jDRlWqDlSslRw+9lAGS2UggoZleScea64Sw/qT
HGW7Gt1OHrEJwJwUlsCHQIqWDJNanv+/saUVC1XN3IYAYfr1gq2kd4zAK3cmfPLF
TrkpW/6AbQY=
=9uqW
-----END PGP SIGNATURE-----

--1RkCiX/UEfbG28Bk--

