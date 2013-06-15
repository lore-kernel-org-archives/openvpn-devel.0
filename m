Content-Type: multipart/signed;
	boundary="Apple-Mail=_DED612B5-9054-4623-AEAC-80CB64D9C1E3";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
From: Peter Sagerson <psagers@...1829...>
In-Reply-To: <51BCF5D1.6070407@...1227...>
Date: Sat, 15 Jun 2013 16:41:15 -0700
Message-Id: <BC613B74-D9A7-48B9-94B3-2AFF99BF8847@...1829...>
References: <5C629764-6A77-4E0D-8B27-AF0AE8B29025@...1829...>
	<51BCF5D1.6070407@...1227...>
Subject: Re: [Openvpn-devel] Native OS X tunnels
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Apple-Mail=_DED612B5-9054-4623-AEAC-80CB64D9C1E3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Nice, glad to see I'm not the only one working on this. Apple has been pret=
ty clear that they're aware of the kext conflicts but don't have much inter=
est in addressing the situation. If we can get native tunnel support in one=
 way or another, we can stop the insanity.

I toyed with the idea of various auto-detect or fallback modes, but I ended=
 up opting for explicit behavior and backward compatibility. With the inher=
ent uncertainties in a change like this, my inclination would be to start w=
ith a release that calls it an experimental feature, which users can turn o=
n if they want to. Given the substantial benefits of not having to deal wit=
h kernel extensions, I think we would see both users and vendors promoting =
its use. If all goes well, the question of making it the default behavior p=
robably belongs in the context of a major release.

Thanks


On Jun 15, 2013, at 4:16 PM, Arne Schwabe <arne@...1227...> wrote:

> Am 15.06.13 23:13, schrieb Peter Sagerson:
>=20
> [tun on OS X]
>=20
> I have not looked at your patch yet but there is also a utun from patch f=
rom me, waiting for review:
>=20
> http://thread.gmane.org/gmane.network.openvpn.devel/7464
>=20
> Arne
>=20


--Apple-Mail=_DED612B5-9054-4623-AEAC-80CB64D9C1E3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)

iQIcBAEBAgAGBQJRvPucAAoJENfXJ2LQ+g52WoIQALKZwkU8bTIlwAW6LL6YEgN7
4nE1EJKF4MkqNUm7sd48xhWViEiUNB4McGgxD0TJXVykK0jrrVckbh5IbRkdV6wD
BllUIItEHUQQnZCswzaCPVVWueVwGDGUEFqqycyfHwSUc595aTU4wrkzCu85VVhJ
ejBmKfb9qDDjPgV2DCzz9lyAp/CHIR4ipNcwsez2+ioETl+0dZwBnyA6fDkDVU0P
yUhCOqt30IxlQ9YGtjU11g0u+ogCixEfg/VjVxJMQ8tkqLPsqWnl4kDRBtMQKlPL
TjdRcMgPrFeDq1rPnHefu5+Sia0SzWIGM/tC3xL+5pKiDHTCHYYicBnOZWlhGEe1
0zojxv8K3Xdh/m5gIOgP4pCXeqbuXpHqsHjt9u9om2ZlF6Ml/37vaJmy7trLLfue
MUL4MNpMWg54LNIDXlgnIzUCTxYblAgI72ROuFJIwr/uVoaeQIfXu+5Ysm1shdf0
rWVyJ37RRV0BYHfSX4LdJyEdegS56nfaGO1XEo8FkVg/+mcvbtUSZ7hSJ6ztvc1O
go/pOxWKN2jPjdvl9a/jYgHaVgxNNzi+LZeGI7NYMHadfnTXYR/KG384JX/jG0dX
VENpu1SAcHum/7txkWWNfMpkw8tOfPcMlYMhu5RZyFugMTJMe+PFG2OLOsZdII17
Wuwk1qYpvN4XwtvccUCS
=xPVb
-----END PGP SIGNATURE-----

--Apple-Mail=_DED612B5-9054-4623-AEAC-80CB64D9C1E3--

