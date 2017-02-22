Date: Wed, 22 Feb 2017 08:39:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170222073910.GG93896@...1296...>
References: <345db0ac-f6e8-8490-a80a-ffbd81972c07@...1856...>
	<20170221211205.GF93896@...1296...>
	<250998c4-9b20-dcc0-90eb-d432a911e7ba@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4KXkm8CArhzjwJ+m"
Content-Disposition: inline
In-Reply-To: <250998c4-9b20-dcc0-90eb-d432a911e7ba@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Fix segfault when using crypto lib
 without AES-256-CTR or SHA256
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--4KXkm8CArhzjwJ+m
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Feb 22, 2017 at 02:21:35AM +0100, David Sommerseth wrote:
> >> >From d97f526a2ddbf2abe60a64260601ebd742fc00cc Mon Sep 17 00:00:00 2001
> >> From: "Simon (simix)" <via-trac>
> >=20
> > Do we have a policy how to handle patches with missing author info?
>=20
> I see no reason at all why we should not give proper credit with full
> name.=20=20

That was only half the question - of course I *want* to give full credits,
but is "not having this information available & no SoB line" a reason
for rejecting a patch?

The patch in question is quite obvious, so this is not something to bring
in the lawyers - more a matter of general policy.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--4KXkm8CArhzjwJ+m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYrUAdAAoJEB2Cnv7KVigSKJEL/ArPGqieTdfXhxoHwzTtaXv3
gwEA/2gQE9KhmtrZJUCB/fs4dtxf6NUevGhMo9ay0ctU+tTeVnzYvemY5ta6WOib
zmKdFlJaFZQ6lDhGkLZa0E0C9uY01LXVaL2UqxJoH+16Homln9ZnfKR2HLhCoBGX
9O+/IyY5hbNwjMcR5khFGl+cQGSAaSEXkHNFgsFb1ADtyRd7datW/yzHy0MrGd9X
ScbYoQ8glLVIoEblcjME2WrN34qItr1DFvAP3vEZ+2PbTQ4HhTxM3st92N/5fow3
1mvwYHs3kqupH2pp+wFP71QK6wXZtzarRXxiinCQP1QO4d+0diFoeAUg/ajJI/78
EeMSGlWRI8g9LswUtTR5+pdjqkFWEa1UkSlL25zBMlrK5MRMQBA41m2M1HNBko0w
agIivPDounbp2N3S69OJRmqqBYA1imr+bHLOeQkamVWx95GMBfhJ9CsxbADCBbi1
TBch3kYBHQzsdvoEX4NzetzF3Vajo19ALWi6TzDQ6g==
=tiz0
-----END PGP SIGNATURE-----

--4KXkm8CArhzjwJ+m--

