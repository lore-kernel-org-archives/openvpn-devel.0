References: <5abb34c1-22c7-ffd8-80eb-06250175ccff@...2080...>
 <1540889615-24868-1-git-send-email-lstipakov@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <1ae380a7-b385-d843-5a5f-97cc51aad4d4@...1227...>
Date: Wed, 23 Jan 2019 16:00:35 +0100
MIME-Version: 1.0
In-Reply-To: <1540889615-24868-1-git-send-email-lstipakov@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6MLQtyiKHsKK5edn97lvrDW11dPf4nfKS"
Subject: Re: [Openvpn-devel] [PATCH v2] Fix various compiler warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6MLQtyiKHsKK5edn97lvrDW11dPf4nfKS
Content-Type: multipart/mixed; boundary="6pUIHRfctdKIL6izSeBUxeBpXCXagGLCZ";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <1ae380a7-b385-d843-5a5f-97cc51aad4d4@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix various compiler warnings
References: <5abb34c1-22c7-ffd8-80eb-06250175ccff@...2080...>
 <1540889615-24868-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1540889615-24868-1-git-send-email-lstipakov@...277...>

--6pUIHRfctdKIL6izSeBUxeBpXCXagGLCZ
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 30.10.18 um 09:53 schrieb Lev Stipakov:
> From: Lev Stipakov <lev@...515...>
>=20
> This patch fixes "unused variable/unreferenced format parameter"
> warnings in different places, kudos to Visual Studio compiler
> for discoveing some of those.
>=20
> This also also removes unneeded uninit_management_callback_multi()
> wrapper.
>=20

This looks good to me, compiles and David already give his ACK on the
patch and demanded a small change, which has happend, so:

Acked-by: Arne Schwabe <arne@...1227...>


--6pUIHRfctdKIL6izSeBUxeBpXCXagGLCZ--

--6MLQtyiKHsKK5edn97lvrDW11dPf4nfKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlxIgZMACgkQFRhsZwKx
RFR1Sg//TciHeNz7gYSApzk6e2jHQi77/cOGIoIk5GXOp90RnMQO0Nz1hlvTRzPA
PetTSb7n8rFUlhSocxsRJMR91kwEj29wabJCufyfgrE1tIPDgDCUsTiic4F+Owve
Do1BS34Rv3WeEu97sH0B7TZCncF+BMQfAR8dk8TumFFw/J+0WudYJQBN9O7eGtep
9qnrhwomXkhlELnSkLRzldlVpiXz2VBHaMtztg8asLtJ2+OQh07/HjGL+GOwe7Uk
nmqfnJBeVwqIFlSi+cvi4/hXsgQZzHceEE719sHuVtk6MoXwX6BkOa8gqSHagkIP
4u0/xoPBUArq6wFSbMwyUwIw53rLGjItarWvmqrFEiLjsAY1DpoGXU60Mx+Mzj1N
j65S7GmooUMEaLNaGx2avRjw0MG1vr3FHhedoeE8BO2aqMROLUv50OYVT66ouS9A
red6cY2oJORgO5MV+u0EaH8L2B050RCf/ELpJr/qdH4gf7VxOkiAWkTSVvgxQm/2
+V83LYYKcBB+lpClyDRe92kJm7/AMGpISB9CZuTx+2Wo4Y9JrfBjLG0mCdV4D7+U
HA8i9AaGHWWbPjqCf5e+lJpXHgSe5xPLNnQYYF8y6h7xD8W7yB9gPWOJt1RGNPYX
sjmzg2780//8MQAw6CjQlV661Sr1lzzoXlRg/loMZEP4gVHXrw8=
=vO+c
-----END PGP SIGNATURE-----

--6MLQtyiKHsKK5edn97lvrDW11dPf4nfKS--

