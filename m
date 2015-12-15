Date: Tue, 15 Dec 2015 22:18:53 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151215211853.GW24952@...1296...>
References: <1450191626-24633-1-git-send-email-samuli@...515...>
	<A9F464ED000E41E49522FF9AE5BCBC84@...2089...>
	<CAKuzo_j-nHghOXSW67kmQyQVk1zOH6tij=Tdf5pD-wFYwn-yUg@...278...>
	<20151215205402.GV24952@...1296...>
	<CAKuzo_g4J=4ZYV9CiWhm5B3LCASxdRTL7jkKHcFby0WA7x88vA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SAq4wbarO1ybdq7f"
Content-Disposition: inline
In-Reply-To: <CAKuzo_g4J=4ZYV9CiWhm5B3LCASxdRTL7jkKHcFby0WA7x88vA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Updates to Changes.rst
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--SAq4wbarO1ybdq7f
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 15, 2015 at 04:12:25PM -0500, Selva Nair wrote:
> > Make that "setenv opt block-outside-dns".  ignore-unknown-option will
> > *not* help here, as it is not "unknown", but just "not working".
>=20
> You are right, ignore-unknown .. would have worked with valdikSS patch,
> but not any more as its handled right away at msglevel_fc. Which is a
> bit disconcerting as on non-windows platforms ignore-unknown-option will
> make it non-FATAL but not on XP.

Right.  So, just use "setenv opt" always here, and don't worry any longer :)

> My original comment about this to an early version of valdikSS' patch
> was on a different level -- if the user want DNS blocked, failure to block
> should be FATAL. But not respecting ignore-unknown-option only on
> some platforms doesn't look right.

Well, it is not an "unknown option" on XP...  and the code doesn't really
lend itself to "just claim it's an unknown option if it cannot be enabled"
without being truly ugly...

(setenv opt wouldn't make it non-fatal if the functionality is *there*=20
but cannot be enabled for whatever reason - so on Vista+, you still have
the "failure to block is FATAL")

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--SAq4wbarO1ybdq7f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVnCDvakuBuNlUUl1AQKAWAP/Ww+H9jYQ1IuVHPdu8OnxHKwWa/9TEy2i
CInZH3OchbZvebaEcj98nDj/AyxBt/QlWqUdxZWaVgJrw4R9Kx4/q8c+RJKYTjL9
JRVTRZgIcKj5mfcVMRmVfu/q+yzL3VnHHYlNrRhSlzOqpO9g1csHZzOY2tr8Eyrb
moQ1wTOeXdA=
=0kKF
-----END PGP SIGNATURE-----

--SAq4wbarO1ybdq7f--

