References: <2987ae32-9a53-1888-11af-bf7d9741eecd@...2080...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <79f0d75e-7518-e0c5-fd79-960351c94cbd@...1435...>
Date: Wed, 2 Nov 2016 13:30:58 +0100
MIME-Version: 1.0
In-Reply-To: <2987ae32-9a53-1888-11af-bf7d9741eecd@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XmmbPdlBDqlmvxdHn3P6XUuXH0VRQCQd4"
Subject: Re: [Openvpn-devel] OpenVPN v2.4 release progress
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--XmmbPdlBDqlmvxdHn3P6XUuXH0VRQCQd4
Content-Type: multipart/mixed; boundary="Qml616cipsmBtcUGdKTbkSJDoLvs2M1qs";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <79f0d75e-7518-e0c5-fd79-960351c94cbd@...1435...>
Subject: Re: [Openvpn-devel] OpenVPN v2.4 release progress
References: <2987ae32-9a53-1888-11af-bf7d9741eecd@...2080...>
In-Reply-To: <2987ae32-9a53-1888-11af-bf7d9741eecd@...2080...>

--Qml616cipsmBtcUGdKTbkSJDoLvs2M1qs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 01-11-16 23:47, David Sommerseth wrote:
>=20
> [...]
>
> * November 8th
>   If we agree to have 3 stages, alpha3 must be released.  After this
>   date we start to be stricter about the patches for a while.
>=20
>   Patches which should go into this or the next release:
>   - [PATCH] struct argv overhaul
>     <http://bit.ly/2ebnhKz>
>=20
>   - [PATCH] Refactor CRL handling
>     <http://bit.ly/2eYUMkK>
>     Also look at the CRL patches from Antonio as well.
>=20
>   - [PATCH 0/2] auth-gen-token: Inform client why auth-token was
>                rejected
>     <http://bit.ly/2f7GEJ3>
>=20
>   - [PATCH] systemd: Improve the systemd unit files
>     <http://bit.ly/2eboMIq>
>=20
> [...]
>=20
> The list of patches are the most recent ones I spotted on the mailing
> list which seems relevant.  We might consider other patches too, my
> patch list is just a proposal.

If possible at all, I'd like to get --tls-crypt in.  It's not on the
list as a patch set yet, but only as a preview branch on github.  After
some internal review, I think I can get them out as real patches next
week though.

Links:
https://github.com/syzzer/openvpn/tree/tls-crypt-preview
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12357.h=
tml

-Steffan


--Qml616cipsmBtcUGdKTbkSJDoLvs2M1qs--

--XmmbPdlBDqlmvxdHn3P6XUuXH0VRQCQd4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYGdyGAAoJEEEwndWOY1w5mSwIAIGFhrYlJ554SrPQfYKm+k63
kZh58/YjbPa4ZY/b8X3pYWYVH4JtZL1d6gIgNaPdVyT/1JcVGelRW3SSmUl9GO7f
kw9A7YltjCt5uNpwleiVzAJh67p/Tzjes7T0qhcJZ6P9bk4PG55qwkXmW/GI2Aaq
5lkVW7FoaZl+7KkU2rRqDJknJe2jtyXzOSB9AssT2Sqj3mksIv0vWvzBcgdPjX+f
gADXJHSRXPaeAS9jbeSYyCmuBM9d42Tt0i2RhXu3vvJ4pun7n69KGdaZSPIDlrXA
A2fCAw+2IF9azwyi96XP+0CCs5Eu2AQQ861YgTUYqxEcbb2zxw22rcAQQu7e7HU=
=0r79
-----END PGP SIGNATURE-----

--XmmbPdlBDqlmvxdHn3P6XUuXH0VRQCQd4--

