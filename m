References: <CAFHpkQEM9P8P4vUuzySan4Mt3CRscrio+D87jeGZY=zzNZm=Pw@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <52012840-b1b5-10a5-89d3-01252f784b7e@...2181...>
Date: Sun, 3 Dec 2017 18:06:43 +0800
MIME-Version: 1.0
In-Reply-To: <CAFHpkQEM9P8P4vUuzySan4Mt3CRscrio+D87jeGZY=zzNZm=Pw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ed2IAPOkiE191gKDTWJHt9hr5g8O1sW4w"
Subject: Re: [Openvpn-devel] strange behaviour of "auth-token"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ed2IAPOkiE191gKDTWJHt9hr5g8O1sW4w
Content-Type: multipart/mixed; boundary="a7akuc4WTrFfxuCXas5l9W0r5cuqCkmok";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <52012840-b1b5-10a5-89d3-01252f784b7e@...2181...>
Subject: Re: [Openvpn-devel] strange behaviour of "auth-token"
References: <CAFHpkQEM9P8P4vUuzySan4Mt3CRscrio+D87jeGZY=zzNZm=Pw@...278...>
In-Reply-To: <CAFHpkQEM9P8P4vUuzySan4Mt3CRscrio+D87jeGZY=zzNZm=Pw@...278...>

--a7akuc4WTrFfxuCXas5l9W0r5cuqCkmok
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 03/12/17 17:57, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
> Hello,
>=20
> I noticed strange "TLS Auth Error: Auth Username/Password verification
> failed for peer" when I restarted openvpn server.
>=20
> deeper digging into that discovered the following flow
>=20
> 1) client is authenticated via login/password --> auth token is assigned
> 2) reauth is done via username/token (token is kept in server memory)
> 3) server is restarted
> 4) username/token is passed to auth program --> auth failed
>=20
> so..

shouldn't the client re-start its session after the server has been
restarted and so restart with auth/pass right away instead of trying the
token?

>=20
> 1) shouldn't client retry auth with username/password if username/token is
> failed ?
> 2) shouldn't server just fail token and not pass it to "extrenla script" ?
>=20
> Cheers,
> Ilya Shipitsin
>=20
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
Antonio Quartulli


--a7akuc4WTrFfxuCXas5l9W0r5cuqCkmok--

--ed2IAPOkiE191gKDTWJHt9hr5g8O1sW4w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlojzLMACgkQB6U8WA7y
zXTZ8Q//cvXgHKOnGPnRT0KevxmXVOQb7AwNQuEN1Bzd8rmBHAMQhrS2JqfdwHnE
cV5CWkFvGUrJs8EajOdt3YG4/HiHH1/15JLV6+6b4R6qmweR2bq02MECspPd4vxU
eMbDzDq63EZrCOofirGRcTcfFX1YqqA8qETUyOltNZWZr6dDP6EdfGkWhroeCoNC
J/zOVV+nowkLD1NPfQWRT7Clf/J9/aAEwaSpDILbhZ+ueIdwVQf/vgiqqZZMNiUi
GqIHPHDhuzly2eybOgPjB2Czx97/4C1d3jZXQe+9tbqqKUTwVb6osrhp4gNTeHGd
NxxMQchuidLQmU5CtBsuaw3aofgEDjzPJTZ8LKBnrZa/2rghIIZTr2prhRpF/hxe
V/IbozPjhbBpI3gR7DXJuJ+QrezNrji+rQCZEUPrsdYLOk2UNysAh3VoCl0S840j
M7aj9pxmktdmvcrK0PZPAdbsk7UMlNtGuzjmhRlhUs9inFQU06+75dI+EdhJaZyw
YDpoS9mL9q3kCbAl8GPwV3MMKFuoOSEIhmAR/ea2Jzqwi6bgI9n2upVPHxZD7mim
VrRwuIbh0aj4b39+wlcdQtLb0dV0Vwmx9Cj95grnWxwqPF4fuG9Srhk9QBUpboP5
W6YcjYCLDZIAGgVzzlIx0u9VkV84c/E+f3q8As3KFlDjRAGa4L4=
=RVgL
-----END PGP SIGNATURE-----

--ed2IAPOkiE191gKDTWJHt9hr5g8O1sW4w--

