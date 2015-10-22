Date: Thu, 22 Oct 2015 15:59:35 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151022135935.GH22054@...1296...>
References: <1445519360-24866-1-git-send-email-lstipakov@...277...>
	<20151022132635.GF22054@...1296...>
	<1445521155.4113.71.camel@...1866...>
	<CA+UdHn9f9reNrCCdtw8+Ei2KZ9_2beDPCL9Vb-JGs2jJ5nnrXw@...278...>
	<20151022135158.GG22054@...1296...>
	<1445522144.4113.79.camel@...1866...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MgUzYYhgcaJI9ylj"
Content-Disposition: inline
In-Reply-To: <1445522144.4113.79.camel@...1866...>
Subject: Re: [Openvpn-devel] [PATCH] Use adapter index instead of name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Woodhouse <dwmw2@...1866...>
Cc: Olli =?iso-8859-1?Q?M=E4nnist=F6?= <olmannisto@...277...>, openvpn-devel@lists.sourceforge.net

--MgUzYYhgcaJI9ylj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi,

On Thu, Oct 22, 2015 at 02:55:44PM +0100, David Woodhouse wrote:
> > So what is the underlying issue here?  Non-ASCII characters in the=20
> > device name ("this *should* have been fixed a few releases ago")?
>=20
> No, and not spaces (despite the vpn.ccrypto.org link above suggesting
> that it is).

Spaces are known to not cause issues ("I do test things" :-) ).

> The issue is not known. Seriously, "because Windows".
>=20
> Renaming the interface, and then renaming it back to precisely what it
> was before, and doing registry dumps and checking that things really
> *are* just the same as they were before, is sufficient to fix it.

Urgh.

And with interface indexes, it works all the time?  In that case, we'll
just change over... (the new rgi6 stuff uses interface indexes for routing
anyway)  ((meh, git master really is different from 2.3 code here...))

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--MgUzYYhgcaJI9ylj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVijrxqkuBuNlUUl1AQJ6+AP9GfU/itotx0RI/4GYlf7QJq3a6ytpqlZT
F8CDYLHBF/Zv9D2O/FJ3WaPnfDX8/oKRP6+SB5TPkn/wpKAEzhweAtgYMpFRwcid
6ViRnMs2eIptRHSVLiXRdk5zpWMBC8ZnywvH31zkabPSuXAryu5qUHSAwiDqUaRr
xTrRb68UHwA=
=PUeU
-----END PGP SIGNATURE-----

--MgUzYYhgcaJI9ylj--

