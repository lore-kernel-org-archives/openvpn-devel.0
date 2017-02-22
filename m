Date: Wed, 22 Feb 2017 17:22:27 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170222092227.GG12961@...2182...>
References: <345db0ac-f6e8-8490-a80a-ffbd81972c07@...1856...>
	<20170221211205.GF93896@...1296...>
	<250998c4-9b20-dcc0-90eb-d432a911e7ba@...2080...>
	<20170222073910.GG93896@...1296...>
	<dc42f147-496f-1ea7-0fb3-a14197a697dd@...1435...>
	<CAFHpkQG4XgaBSq=N9OwO5Qiv2MZMERGcBDzWObX8TT28CUvKtA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n8884J15jRwcBTvu"
Content-Disposition: inline
In-Reply-To: <CAFHpkQG4XgaBSq=N9OwO5Qiv2MZMERGcBDzWObX8TT28CUvKtA@...278...>
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
To: =?utf-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--n8884J15jRwcBTvu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, Feb 22, 2017 at 02:07:06PM +0500, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=
=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:
> 2017-02-22 13:30 GMT+05:00 Steffan Karger <steffan.karger@...1435...>:
>=20
> > On 22-02-17 08:39, Gert Doering wrote:
> > > On Wed, Feb 22, 2017 at 02:21:35AM +0100, David Sommerseth wrote:
> > >>>> >From d97f526a2ddbf2abe60a64260601ebd742fc00cc Mon Sep 17 00:00:00
> > 2001
> > >>>> From: "Simon (simix)" <via-trac>
> > >>>
> > >>> Do we have a policy how to handle patches with missing author info?
> > >>
> > >> I see no reason at all why we should not give proper credit with full
> > >> name.
> > >
> > > That was only half the question - of course I *want* to give full
> > credits,
> > > but is "not having this information available & no SoB line" a reason
> > > for rejecting a patch?
> > >
> > > The patch in question is quite obvious, so this is not something to b=
ring
> > > in the lawyers - more a matter of general policy.
> >
> > Same here.
> >
> > For this specific patch:  I asked the reporter on trac for full name and
> > email last night.  We can wait for a bit to see if he replies.
> >
> > In general: what do we do when we don't get a full name and email, but
> > do want to apply the patch?  Wait forever?  Claim authorship (but refer
> > to the trac ticket in the commit msg)?  Apply anyway?  ...?
> >
>=20
> if there are trac templates (I'm not very familiar with trac internals), =
we
> can turn on the requirement of
>=20
> 1) full name
> 2) legacy agreements
>=20
> on the trac side

personally I think that trac is not the place to submit patches, and this
problem could re-appear anywhere: i.e. a patch for openvpn submitted somewh=
ere
else reporting no name/email.



--=20
Antonio Quartulli

--n8884J15jRwcBTvu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYrVhQAAoJEJ6F1zG2JyOsyzoP/RvFlAaEbcKq3+fQXzP3Hn/E
k237ugG9fBDWuprUU8T5RfOKa+gu5P38DsGlpSo9UAe+jvQxRj40pp5YNJtzg/a6
Clsky752WQWS0UJbIogTxl0NXGQjKRQHf7PNaCbc1olKH/5ZqkBsvrH3/zC5vr+b
ptKhxtUp6sjRw/C6wpq9LfZjP0w6ZEhgt07WlT0iuOgMJ8ltMydcUha+o7qyFm/6
7tVr0c3ZxqNttS2CCwX3Mxw3fTl1cdUuA1rAGaKPI/fNCG5XIrkpc5vJJA9DvfVT
Awm2l2pZ1TDAVEsjjQ20y5kQyvyu/2pO0oW6jeIFNebB9u9p8Fs0kUJPjI8mAou8
dHmj7KYHnV2F89YVLPuhowniNbi2TPLFhktA1CEu0T+YUO/V6CIlK2YDs4OkI91D
iUc5okAuWM8+AGKrajvZ24XgaMLaApaJZQCYuBfkBhdA8yssLolZpOAbihT5BJgz
nkGpTLncX+G1UONIVxACtix46kTxdVOVAAvrGyTgFje5F3n1l4TRfx73Hf9gcyhI
l9BRRst/4kO4U15sEevAD6u47ROaPn3aER2ijIMPf81Kbhe2mNaf3imL+YCP8RBg
2BDaH4Z17gFVjIBGnnul/jDC2XkhQW2qr7uDjV1Z98zLbuVAltuBawtnqtNfwNJK
xqlfydc6/YsWK7zip+6F
=sbTj
-----END PGP SIGNATURE-----

--n8884J15jRwcBTvu--

