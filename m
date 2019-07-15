References: <201906051034.x55AYdRT080096@...2054...>
 <20190708224806.19887-1-a@...2181...> <20190714200227.GG1097@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <94403000-31cc-3390-ee64-b88ce98faba8@...2181...>
Date: Mon, 15 Jul 2019 16:45:34 +0200
MIME-Version: 1.0
In-Reply-To: <20190714200227.GG1097@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RlDFY7PmAdHG9waVJ3QAJmdOIRfqn36jt"
Subject: Re: [Openvpn-devel] [PATCH v4] route.c: use sitnl to implement
 get_default_gateway_ipv6()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RlDFY7PmAdHG9waVJ3QAJmdOIRfqn36jt
Content-Type: multipart/mixed; boundary="XPiqU8JYhrgtqfVqXvh0BwOIBBXYIhjw1";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net,
 Antonio Quartulli <antonio@...515...>
Message-ID: <94403000-31cc-3390-ee64-b88ce98faba8@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v4] route.c: use sitnl to implement
 get_default_gateway_ipv6()
References: <201906051034.x55AYdRT080096@...2054...>
 <20190708224806.19887-1-a@...2181...> <20190714200227.GG1097@...1296...>
In-Reply-To: <20190714200227.GG1097@...1296...>

--XPiqU8JYhrgtqfVqXvh0BwOIBBXYIhjw1
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 14/07/2019 22:02, Gert Doering wrote:
> It *must not* set the ON_LINK flag for routes that are behind a gatway
> ("route to gateway" vs. "route to interface"), but it still does.
>=20

[SKIP SKIP]

>=20
> as you can see, it now insists on "everything is ON_LINK".
>=20

interesting to note that on my test machine I don't see this behaviour.
ON_LINK is returned only when appropriate.

>=20
> Now... I think the issue might be just that you removed the
>=20
> -    CLEAR(*rgi6);
>=20
> bit, so "there is cruft in that structure, and it is flagged as=20
> 'the ON_LINK bit is set'" - but it's too late for me to do a full
> code review, so can't say for sure.  If I just add it back, it
> behaves correctly, but it would be good to give this function another
> long and hard stare...
>=20

This makes a lot of sense: that CLEAR() statement has been removed by
accident.

And honestly this missing initialization is somewhat compatible with not
always seeing the problem (initialization of stack variables may differ
on different platforms based on compiler version, kernel options, etc..).

Actually I also realized that the 'gw' variable introduced next to this
line was not used, so I have got rid of it.

> However - as it is today, I need to NAK this.  Sorry.  (And I should
> have been much quicker)

No worries. v5 incoming!!

Cheers,

>=20
> gert
>=20
> (PS: FreeBSD is, as expected, showing the same things before/after, with
> ON_LINK only for test 3+4 - but that's a totally different code path, so
> no surprises here)
>=20

--=20
Antonio Quartulli


--XPiqU8JYhrgtqfVqXvh0BwOIBBXYIhjw1--

--RlDFY7PmAdHG9waVJ3QAJmdOIRfqn36jt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAl0skY4ACgkQ9FVsWUWD
Dm3yJRAAlBSZSuk7FgFW0DCbIXH+71JPajxJ2dopzS9PTRt/+l9DF8+tt43UjIEA
M0nyNdcg94Wb/MlJGc12W40eZmmNsWi20ZsSaqEAj0zFwF44wwasR6GDJWX+//rB
guWp2+kcMmnQi+Qn1SBzOterOFLpHMZom2BbwmyPpl6RZX8cYLJCszZIaoANfwHW
76Z00TAiB2PblBLvp4r0iE7PfT5KISkKxQbH/v0HLddbX5xTT5Mz6YVzDovHW8o0
OluMmznsD0F1Yntaa8DwdmLuLRYlIqY4VNcraLOlT4ezYatILEkJGA7pQBCXcWrx
IMhdrAYSp+KWs4pmrJMSw//AUHdi+qfLxttnY8OrledBZkMqnnV3KEZnBabVdo+8
bthfEq++wTP+FwOjc2YCJl1a9wdiSc+M3CMrP65GdhXJEv8IRE9j/fU5V0gN44q8
ZA+hEvQnof8v8X5ry3UtjKVNusToiXNTGB3x86bqpHGf07dPgW9iO5i5b4Xlv86c
/2G1IjFMRbaxbgXnlqUjDIE8oI7A1U+XxiGeFun2Qxf4nVj6zwFx4Ogusm9Zslhq
DnNGPwyrz4odoB+yF1YZrqTEHS9Phv2yYZ1EAYjb2vTOh2X8tC9OvHFv7Z2SJWpj
4xaS9H88Am+4cUoVHTORaLh5hPbWdlMwEsj00UKyiABgo34TOb4=
=LUcQ
-----END PGP SIGNATURE-----

--RlDFY7PmAdHG9waVJ3QAJmdOIRfqn36jt--

