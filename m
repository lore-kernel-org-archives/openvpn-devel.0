Date: Wed, 5 Mar 2014 15:55:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140305145519.GU16637@...1296...>
References: <1393929449-423915-1-git-send-email-vvk@...1868...>
	<53163C6D.7050801@...1227...> <283911394015829@...1871...>
	<20140305122113.GT16637@...1296...>
	<1296731394023471@...1872...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PIQBdKJ4iu1leRZl"
Content-Disposition: inline
In-Reply-To: <1296731394023471@...1872...>
Subject: Re: [Openvpn-devel] [PATCH] Extract MAC addresses from ARP packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladimir Kamarzin <vvk@...1868...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--PIQBdKJ4iu1leRZl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Mar 05, 2014 at 06:44:31PM +0600, Vladimir Kamarzin wrote:
> > Adding it would solve the issue at hand, but I'm not convinced that you=
'll
> > be happy with the end - it might actually end up saturating VPN links a=
nd
> > making users unhappy if you have "much flooded traffic" (which happens =
in
> > some of the networks).
>=20
> I've patched openvpn this way and testing this setup right now, it=20
> working well for now. I think it may be implemented as an option=20
> (config or ifdef). What do you think?

I'm torn.=20=20

We do not want more options, we really have enough - but that *should* be=20
configurable, and not the default, so if we integrate it, it needs to have=
=20
an option ("tap-flood-unknown-unicast" or something like that).

So on the feature itself, if it has an option, I'd stay neutral in regards
to ACK/NAKing, and focus on the code review.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--PIQBdKJ4iu1leRZl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUxc616kuBuNlUUl1AQJHKAP/aGB+0kk1QorvcAtF2gfeW1IpPaU2F2Gi
53U9O9WtdMwm1uCYD3SYmDrztfId+sqN7RGSOp7u8HgJVbckiRoUo0lT/OrCdSjv
YvBetF8ACjwiqinf8lDoT0yIy2sY9JlQlcVvNmZzHpYlw5kEPd9NXHPaNOLlhgue
Yv1tfIr1kac=
=5Rub
-----END PGP SIGNATURE-----

--PIQBdKJ4iu1leRZl--

