Date: Wed, 10 Jul 2024 21:32:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Zo7h18ecLwg2lDdB@...1296...>
References: <gerrit.1720531952000.I72934e747d1ad68a7e3675afbeb1b63df7941186@...2715...>
 <20240710160306.190351-1-frank@...2641...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="PeUsfMOV0eu5cIml"
Content-Disposition: inline
In-Reply-To: <20240710160306.190351-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH v2] configure: Switch to C11 by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net, Arne Schwabe <arne-openvpn@...1227...>

--PeUsfMOV0eu5cIml
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 10, 2024 at 06:03:06PM +0200, Frank Lichtenheld wrote:
> Mostly so we can use anonymous structs without jumping through
> hoops or relying on unofficial support.
>=20
> Change-Id: I72934e747d1ad68a7e3675afbeb1b63df7941186
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> Acked-by: Arne Schwabe <arne-openvpn@...1227...>
> ---
>=20
> This change was reviewed on Gerrit and approved by at least one
> developer. I request to merge it to master.

This breaks all OpenBSD 6.8 builds.  Are you intentionally ignoring
this ("this OS is out of support, we'll discontinue this buildbot"?  If
yes, we might want to point out that this change has fallout on older
"build environments" - not sure what is problematic here, C compiler or
system headers, or libc...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--PeUsfMOV0eu5cIml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJmjuHXAAoJEB2Cnv7KVigS3M4L/AyjidYBu3hU1Vr95mlCcxzq
u8/m7aW8fxjIdBDWKeh8fiNjVwaijcqbXc+wpn2t9W4FFlxBIoDyHjAz8rBifq2R
m8YjY1Tn335zkbTWmtAbVQOsIxzNUg8GmYYE1V0bJopvWccTMfeszDvTDEYeoOAT
Zl668AM6mbWVTJqyejh++LdMZU9ZVyXitdB9L8XqPeJ2FHh5D+UjtMMt3sBl9s1I
JCaFNz3Qq23WJDhXvvahRjT8KannRVThIsHwa+OANmq2rT+SJXNZXQlRTDsVW6vn
BBnkzl2cYOfC3z4e2eut7Klt23OnKcylAEFUcsGU8efHQM1tmxAbT8+/2DAwO2fC
tHA62cwLBIwF00k1Zp2FXS+beUW6wV7F0RZ+mV57gK+dVurJR2s85uEYjuxLzPTC
nzFHFQmLodZoVmZeqJMVhE1rrEh74IXu7Mpve7azChzCfK//7mzMxon++8b1gutH
T/MEM8G+6X9pYCg8ppt5xoLWdGGpTQ6blN9H78hpqQ==
=xKD3
-----END PGP SIGNATURE-----

--PeUsfMOV0eu5cIml--

