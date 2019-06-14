References: <cc9094b8-caa6-34b6-ed7a-3ccb34560113@...1918...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <feb80979-0bcf-fdc4-31df-c3a86d497135@...1227...>
Date: Fri, 14 Jun 2019 12:01:39 +0200
MIME-Version: 1.0
In-Reply-To: <cc9094b8-caa6-34b6-ed7a-3ccb34560113@...1918...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tPjChXi3wShfgko7sWbwwmfY7ICaPWyzS"
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Send auth fail to client on
 reneg failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eric Thorpe <eric@...1918...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tPjChXi3wShfgko7sWbwwmfY7ICaPWyzS
Content-Type: multipart/mixed; boundary="Mj08iu5tcpIHvPNqZxiK6lOQnSQdcDPXd";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Eric Thorpe <eric@...1918...>, openvpn-devel@lists.sourceforge.net
Message-ID: <feb80979-0bcf-fdc4-31df-c3a86d497135@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Send auth fail to client on reneg
 failure
References: <cc9094b8-caa6-34b6-ed7a-3ccb34560113@...1918...>
In-Reply-To: <cc9094b8-caa6-34b6-ed7a-3ccb34560113@...1918...>

--Mj08iu5tcpIHvPNqZxiK6lOQnSQdcDPXd
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 11.04.19 um 04:07 schrieb Eric Thorpe:
> Hi All,
>=20
> This patch relies on Arne's "Add send_control_channel_string_dowork
> variant" patch.
>=20
> This patch modifies auth so that on a renegotiation the client is
> informed of a SESSION re-auth failure during a renegotiation if either
> their auth-token has expired, or they enter a wrong password in the case
> of auth-nocache for example.

Unfortenately this patch modifies the same code path that the auth-token
patch set modifies and creates conflicts.

So this patch depends on the earlier patches of the patch set (which
happen to be already applied) but breaks the later ones of the patch set

So while the patch looks good enough, I would like to postpone it after
the auth-token set has been applied.

Arne


--Mj08iu5tcpIHvPNqZxiK6lOQnSQdcDPXd--

--tPjChXi3wShfgko7sWbwwmfY7ICaPWyzS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl0DcI4ACgkQFRhsZwKx
RFTn0BAApYBKKC9aSL5lSLm3ronBfDC5p3SKbss6Dl7ZMcFtfKiqfxPJKyQM03xi
DnYGQEYnvG1FA95HvQa6VkifDY69H7K9No99ZiMfnV0znDMPQXfEXfiNhtDONLWz
oa/0YK6zsWXPsRz+EeDXt/CJqnKklEtG4opD+5KWpRnIjVfYOPr9syh7GAhKSEED
kxNDMz7OEAdZFSFk56er2OwhT+vu+IAo70BXhpy5F2/+WomST4NHqkgNqVLMTZgB
7DI3UE4JXf8UXzYEkPj19ck+KtpgTKgQtFvamp9rwxVwRdzTXOElcgIqjcROVUlk
Tw/BR/fI2usuJXW3LWduYfsCJ3wX7bcIGH1377ZtkKMCOctqWEO2egBGrnU2pA8E
rVh2No74uDqb6QOhqDZA+H6zXcPQi0B4dYF9o4nEqck8+SWwCNLd8BnZOsoEAvkz
UlhSRBI18IZrjhxOwXM5V56SlIQbNOPIDYvDm+xTuzMgM9NP2rbobV5lQ6OwhNQ1
ghJHqkFHKJumzyLZb8vr6T2YxQyrhQGQ8NjP1Be8ryzb0r2KUcZDE3k2fxm0NoHR
+snWwztM4R+jWN40G7PKjdMRHDzSlFOlupsvoE7JzGypw7ycpzJ60Cg+a5Ia54DP
3oIqLx/yroejCSh6Cxs917YjVAModQKTjLY+HIc/QZvGedDJXh4=
=HvoZ
-----END PGP SIGNATURE-----

--tPjChXi3wShfgko7sWbwwmfY7ICaPWyzS--

