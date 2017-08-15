Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170701112951.19119-1-steffan@...1856...>
 <b67daad4-362b-3605-5716-3e17c5f0c362@...2080...>
 <CAFHpkQFADMG50xb4UD_bAvT4a94EbLVstAuPEmhkxhUEnZoXQg@...278...>
 <480c51a7-a17d-c29f-1b8e-33c874ca9670@...2181...>
 <CAFHpkQGNS60dNn7eFED26A6ewVFNjw0eMome9CQZ=Tg=23Kmsw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <cde83666-7a39-4aa5-bc51-27ef42dc5a88@...2080...>
Date: Tue, 15 Aug 2017 11:29:50 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQGNS60dNn7eFED26A6ewVFNjw0eMome9CQZ=Tg=23Kmsw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="4DvoI96kgH8VeJbLNQDeaFiPtLT2FJJsc"
Subject: Re: [Openvpn-devel] [PATCH] Deprecate --keysize
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, Antonio Quartulli <a@...2181...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4DvoI96kgH8VeJbLNQDeaFiPtLT2FJJsc
Content-Type: multipart/mixed; boundary="9okgbWgWmOxU7lfvw9VkQ4xk1WrEVXKJL";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
 Antonio Quartulli <a@...2181...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <cde83666-7a39-4aa5-bc51-27ef42dc5a88@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Deprecate --keysize
References: <20170701112951.19119-1-steffan@...1856...>
 <b67daad4-362b-3605-5716-3e17c5f0c362@...2080...>
 <CAFHpkQFADMG50xb4UD_bAvT4a94EbLVstAuPEmhkxhUEnZoXQg@...278...>
 <480c51a7-a17d-c29f-1b8e-33c874ca9670@...2181...>
 <CAFHpkQGNS60dNn7eFED26A6ewVFNjw0eMome9CQZ=Tg=23Kmsw@...278...>
In-Reply-To: <CAFHpkQGNS60dNn7eFED26A6ewVFNjw0eMome9CQZ=Tg=23Kmsw@...278...>

--9okgbWgWmOxU7lfvw9VkQ4xk1WrEVXKJL
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 15/08/17 11:17, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
[...]
>     > there are special cases like Mikrotik openvpn (pretty popular), whe=
re
>     > user simply use what hardware vendor installed (without possibility=
 to
>     > recompile).
>     >
>     > should we contact such hardware vendors as well ?
>=20
>     there might be an non-predictable number of vendors shipping their own
>     openvpn version. We can't contact them all. It's their responsibility=
 to
>     stay behind the changes in what they ship.
>=20
>     If they don't, their users will complain aloud with them ;)
>=20
>     On top of that, this does not prevent users from using their own conf=
ig,
>     right? So they can still configure the client to avoid deprecated
>     options.
>=20
>=20
> you cannot use regular openvpn config with Mikrotik
> https://wiki.mikrotik.com/wiki/OpenVPN
>=20
> you can use mikrotik configuration options

Which just emphasizes even more that Mikrotik needs to do their own
homework on their own.  Their config syntax is completely alien to us,
so we have no direct influence on how their syntax ends up as a
configuration OpenVPN is capable of understanding.  And _we_ shouldn't
care how Mikrotik does that, it's their own implementation design.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--9okgbWgWmOxU7lfvw9VkQ4xk1WrEVXKJL--

--4DvoI96kgH8VeJbLNQDeaFiPtLT2FJJsc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZkr8TAAoJEIbPlEyWcf3y2cEQAICrAK8dkFYVflm0WIacB2L+
MOSS/ELx7U4wVHu8IloDPzm6S+QEmzIKRarF389aU1G7u2ueYO0s0cdRm3XtlGXr
EjYZBKzJhnQMCWN/Tn5SaVDugKFJxpIZMoaInFx74NPwbZ5V0l/95sjdRbgMy/3Y
TitdiHgUdV94rBMcw0qoXBriOr7ld2UkvsjPGN/xX/KWXVj2UTFN4ecosYSk/S0I
KaiYkCoBE5mzekrPOMAo1mG7tcNqN4dx7o8HVAlbe+JZglDBMaFVawM1E4KAVz/w
tsCrpkO1YGUJ/AwCiej/PQ78KsqNLgwB4TffTmVeNDRUYHF6WafSyi5N6yWj+9RA
THOfQe7mMzX0WvVpABc1Bnew5ytKMSCUFxJUjnoJ7mBQ1wIsj21ALe9vVryrdoRj
Gq7sDXU/iHymAtcZE4PT655bSXxJIcHTYOb9WjP40vIQAfGW5cC40NfpSPRAb/CL
9ELCOYLaxTkcRhExLd6TPihw3wlB3VTL7Il5LW2/JAjEYso4yj1GPqwQb93PqI3y
/2Cxi9pSIsyp+GSwbTAOq/FJzj2wvkB7gxU7SlktSaHKRRR/9ghS3PoUoQ4caCBq
5wlktB/RAZJqavy7NAclPQReJPWE8pRyN/WmGDAYKOwSlkhst2xvBbYoxhHYnm7P
eNawdw5G1Krb8SQOeuES
=mEMm
-----END PGP SIGNATURE-----

--4DvoI96kgH8VeJbLNQDeaFiPtLT2FJJsc--

