Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170803160304.35518-1-debbie10t@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <df6d3edb-3f2d-6a83-68f0-0899f58bf785@...2080...>
Date: Thu, 3 Aug 2017 18:46:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170803160304.35518-1-debbie10t@...277...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Hh9SFJ1ldk1SDMDTbLJ3eQSiMmT9Si2jh"
Subject: Re: [Openvpn-devel] [PATCH] doc/openvpn.8: Correct
 --verify-x509-name *type* example
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t@...277..., openvpn-devel@lists.sourceforge.net
Cc: Richard Bonhomme <fragmentux@...277...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hh9SFJ1ldk1SDMDTbLJ3eQSiMmT9Si2jh
Content-Type: multipart/mixed; boundary="XhQnBFGO3C1iqVfD1XSSS7vaL9wfLp9Ip";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: debbie10t@...277..., openvpn-devel@lists.sourceforge.net
Cc: Richard Bonhomme <fragmentux@...277...>
Message-ID: <df6d3edb-3f2d-6a83-68f0-0899f58bf785@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] doc/openvpn.8: Correct --verify-x509-name
 *type* example
References: <20170803160304.35518-1-debbie10t@...277...>
In-Reply-To: <20170803160304.35518-1-debbie10t@...277...>

--XhQnBFGO3C1iqVfD1XSSS7vaL9wfLp9Ip
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 03/08/17 18:03, debbie10t@...277... wrote:
> From: Richard Bonhomme <fragmentux@...277...>
>=20
> Signed-off-by: Richard Bonhomme <fragmentux@...277...>
> ---
>  doc/openvpn.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 20bdd91..fdd5dde 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -5340,7 +5340,7 @@ subject DN "C=3DKG, ST=3DNA, L=3DBishkek, CN=3DServ=
er-1" would be matched by:
>  and
>  .B \-\-verify\-x509\-name Server\-1 name
>  or you could use
> -.B \-\-verify\-x509\-name Server -name-prefix
> +.B \-\-verify\-x509\-name Server\- name\-prefix
>  if you want a client to only accept connections to "Server-1", "Server-2=
", etc.

Just wondering ... Shouldn't the "Server-1" and "Server-2" be escaped too?


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--XhQnBFGO3C1iqVfD1XSSS7vaL9wfLp9Ip--

--Hh9SFJ1ldk1SDMDTbLJ3eQSiMmT9Si2jh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZg1OHAAoJEIbPlEyWcf3yMR4P/24PJDgKvmslb/xM+0l3zQZ6
Vujbx3oOs1d7IP6m5/Hra2bPQVDJlnOXsFJsnmSax+xTQ6yKynK1NOZ6YCCL6BXe
MYiIfjMi20Lrn4AL4QA1pmZJhJDHGl1y2LS26/mNcMg4y/nm16zXECVCIcxcNyPf
ahoGX2PPlpna/o06rwMX/1aPBdXDEnQerap1hkHb819BJWuLaIbAA3gIy8iddvAM
Mk75cHLnPmjYn/lcJtsoJldCASQ2Fl0MPW6e5Ebk349lh1Gefvgzy1FtU28HetFE
rdETgxbdyTduIOlqMq9T+8tMQ0Ny9PoD+bht3BxNjoxuRWj1dL+UQzgAO2Lnk+XB
6JJ8AV7Esjq6dmheyrZZgh+swKM2Mi/lDxmK4nzuEJTUrieDhJtF4f5oxft8bXuQ
SVRD1E4fVVICiY/dGci14pIRy1S1ugfc+8ZVcxOJan4w20HE+2JgX+mBd8csDqRv
jGkUHzTGszoacrHervx46a8szqupkt0cA36LCRblSvHjkdEegMOGF0IuzBlFPQTB
zSkJgSmWR8wgl3YrrSxRRy9u0oDRT9uZ1Jv4Wk6KsQ1cUU/s5ktwu8nVY0EinVfJ
btXce8uT/M4B4H0TUDQP1+d4e2Bv/3XxuDeEAnVtnlytjvAM60IrI9nepe4NKB1c
Y0amjTTvzV/Qu6sRoJ+z
=gk+E
-----END PGP SIGNATURE-----

--Hh9SFJ1ldk1SDMDTbLJ3eQSiMmT9Si2jh--

