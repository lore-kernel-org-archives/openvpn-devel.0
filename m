References: <1480545687-19365-1-git-send-email-davids@...515...>
	<20161201080132.GC78624@...1296...>
	<9796b12f-21c2-d9ed-90e3-51de843b2eb8@...2080...>
	<20161201123306.GK78624@...1296...>
	<CAA1AbxLbWojTD_gzqHGEkpYnSG3GSKakV0QEVptq+YURLqK4Ww@...278...>
	<20161201123813.GM78624@...1296...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <97fcc3fe-9ec9-2da7-4cab-fe03196bc369@...1435...>
Date: Thu, 1 Dec 2016 13:49:19 +0100
MIME-Version: 1.0
In-Reply-To: <20161201123813.GM78624@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="arbogl3vC7gjkkExk3Fvl7skgmOd9Bmmb"
Subject: Re: [Openvpn-devel] [PATCH] push: Provide a warning if
 --ifconfig-push have argument mismatch with --topology
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--arbogl3vC7gjkkExk3Fvl7skgmOd9Bmmb
Content-Type: multipart/mixed; boundary="aL2A7ALBojOii7cwkMse1hpvLhrGjGUVR";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <97fcc3fe-9ec9-2da7-4cab-fe03196bc369@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] push: Provide a warning if
	--ifconfig-push have argument mismatch with --topology
References: <1480545687-19365-1-git-send-email-davids@...515...>
	<20161201080132.GC78624@...1296...>
	<9796b12f-21c2-d9ed-90e3-51de843b2eb8@...2080...>
	<20161201123306.GK78624@...1296...>
	<CAA1AbxLbWojTD_gzqHGEkpYnSG3GSKakV0QEVptq+YURLqK4Ww@...278...>
	<20161201123813.GM78624@...1296...>
In-Reply-To: <20161201123813.GM78624@...1296...>

--aL2A7ALBojOii7cwkMse1hpvLhrGjGUVR
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 01-12-16 13:38, Gert Doering wrote:
> On Thu, Dec 01, 2016 at 01:35:49PM +0100, Steffan Karger wrote:
>> On 1 December 2016 at 13:33, Gert Doering <gert@...1296...> wrote:
>>>    ((uchar *)&c->c2.push_ifconfig_remote_netmask)[0]
>>
>> Looks like dereferencing a type-punned pointer to me ;)
>=20
> I was waiting for this :-)
>=20
> (...but I thought "char *" is allowed by the rules?)

Heh, and I was worried that you had already though of this, so I must
have been wrong ;)

Indeed, "character types" (including unsigned char) are exempt of the
strict aliasing rules.  C99 6.5:

An object shall have its stored value accessed only by an lvalue
expression that has one of the following types:
=97 [...], or
=97 a character type.

Apologies for the noise.

-Steffan


--aL2A7ALBojOii7cwkMse1hpvLhrGjGUVR--

--arbogl3vC7gjkkExk3Fvl7skgmOd9Bmmb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYQBxTAAoJEEEwndWOY1w5X7kIAI+124S14R0gPJX+JPwzXBMT
m93BbcHmXEoNammsLUkVcncb/MsOrIvahJQguuGwf5h3e1rSDhg2LBFYZSc3CO9r
mIcTDZub4dc0xCj5Wt+yxGv7l2pHisTPrBOT6TXp1stdtU5f1FBqXguNaXH0MhE6
GGcOtjeCXLBbPQxzzXbrc4muQo3FMx0hqLYt1EmQmSxFoBnjA+0oQMVPuSbGaZbD
CioywKTS5lnDV1Bgvmnnp8Tkt1lELcVqRNAAJR5J/9mB7jtR5HjP77xrw3joG7ns
tIN1DdZ01PjBzZbUt0Nb2FLm/NsORGsLIhwxu4sjsZgLs3+089M20oi4tlMjFO0=
=rbWS
-----END PGP SIGNATURE-----

--arbogl3vC7gjkkExk3Fvl7skgmOd9Bmmb--

