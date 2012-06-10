Date: Sun, 10 Jun 2012 19:04:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120610170452.GC1059@...1296...>
References: <4F8D6C6F.3080403@...1698...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2YJj5f1P6Th4nBRw"
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

--2YJj5f1P6Th4nBRw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 17, 2012 at 05:13:19PM +0400, Sergey Matveychuk wrote:
> I see openvpn adds ipv6 routes always for interface not addresses. I=20
> think it should be like in add_route(): something like is_on_link() to=20
> determ if interface should be added or address.

This has now been implemented for all affected platforms (2x Linux,
FreeBSD, MacOS X/Darwin).  Patches have just been sent to the list,
but sf-mail is sllloowwwww today...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--2YJj5f1P6Th4nBRw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT9TTtKkuBuNlUUl1AQJ6FQQAgIjc1Bb8/Pi0H19A1vEoXuwsjvRRf3tk
qTEwFO3GFn9xpvVJ0yVX79VGPPOARUcgTEpv9ntTmVu9sEEMzRFTfpwVM4okKZLS
xzDn6bfjyPlnTXZsRuQlADhYFKJAoDjECOqci1rRRo209dQGKvM2hULhxX7g9Yfu
qKpoM8YcWZU=
=/ywS
-----END PGP SIGNATURE-----

--2YJj5f1P6Th4nBRw--

