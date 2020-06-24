References: <20200622113022.23047-1-davids@...515...>
 <CAKuzo_g7QxVL90ikT57H6b4+St2c860us6S3cN_6jbfeHujpzw@...278...>
 <a1cfd42d-e371-187a-55c2-f14a3a986b34@...1823...>
 <4562876f-45c1-d3bb-f725-52e9b78600de@...1227...>
 <ed88a719-731d-0995-5473-be5d3e2ebefd@...1823...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <3b6f724e-d1a3-f048-b4c1-6cffa168e2cb@...1227...>
Date: Wed, 24 Jun 2020 12:12:12 +0200
MIME-Version: 1.0
In-Reply-To: <ed88a719-731d-0995-5473-be5d3e2ebefd@...1823...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FQMpMeI67aooioMLQQFvUMRtx0dMsPPJO"
Subject: Re: [Openvpn-devel] [PATCH] systemd: Change the default cipher to
 AES-256-GCM for server configs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Dmitry Melekhov <dm@...1823...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FQMpMeI67aooioMLQQFvUMRtx0dMsPPJO
Content-Type: multipart/mixed; boundary="gAo5rwjXQRP0XqD8rZTJp7Lgov0xLScRX"

--gAo5rwjXQRP0XqD8rZTJp7Lgov0xLScRX
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


> There are openvpn 2.3 clients in 3g routers which=C2=A0 are built without
> ability to inform server about cipher, so server uses default cipher for
> them,
>=20
> in case you need to change default cipher on server you can't do this ,
> because clients will not work, it is also impossible to change default
> cipher on all clients at once,
>=20
> so this is where ability to set default cipher on ccd helps.=C2=A0 All th=
ese
> are explained in ticket.
>=20
> Thanks to patch author we were able to change default cipher without
> downtime.
>=20
> btw, we still run such routers but can't do the same procedure because
> patch is not compatible with 2.4.9 if for some reason current cipher
> will became nonsecure as blowfish.
>=20

Allowing to be able to specify ncp-fallback-cipher from my proposal per
ccd if no NCP could be performed would also fix your use case, right?

Arne


--gAo5rwjXQRP0XqD8rZTJp7Lgov0xLScRX--

--FQMpMeI67aooioMLQQFvUMRtx0dMsPPJO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl7zJvwACgkQFRhsZwKx
RFTgEw/+NargDg82nQ+Q3qLZ0zhpsxg5df9sUKjjRp3dn91Eg9VVdCII+CCipXFo
T8aMSifulVChYFOz0XM9OiYOT47pZl3byaLWvRKPNsPZmQuOKwKFnX7kPUcC4YYE
SgfpeBI4RcKqxTZJ8SLtuZOCEBFjY1xZexFNsJtjtn+2OYHjtn1H9qB2DnDlW8Au
R/UGkVvQL7UsISqI6E8v8YKOv/mNSooP0TjQFQ43KZti1XHFjQFQcnE45fc+QoBl
L2z51nn9+E/1uV6H4hLNuWRONu8/ptnx00VSYpotP0s+9accwWjF/B27FrL5KVMj
y4JhKbYAAG66qzsMyUVzdTv4g4vu4OdbnEfOTUFbbq+t3dTuFaXIeOjfsDEcxxJ9
uzCmQkslfaY85UtwL7UttrexPdOuNsRA0dIO7LK7UyLGYXV20NLABhsDgwR5kHpr
o2UgAndplzD6KLUxF+RSh4+WIfaDayzY4CwKqmoCvh5zQ6ADTXFL3jzlzitTO52a
QqQbYBsRJC7qr74QHm1+EojqofVbfwkoAxa19p5pjkjsZu+ZnW5MQCWjQDVKCmGx
IZ9aL4pgprRRcQesiNe1x16n4wny3UeMTV7a/IWZIhlZkketNpIDmwPtw8vnT+9n
PpR1ODGCC4N2DqC1T2QgmaYKRgO59xet+UrhuwNYFPJgvEL8Gow=
=oBAt
-----END PGP SIGNATURE-----

--FQMpMeI67aooioMLQQFvUMRtx0dMsPPJO--

