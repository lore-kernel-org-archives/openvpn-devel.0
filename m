References: <20180613081218.1834-1-a@...2181...>
 <20180613081218.1834-4-a@...2181...> <20180613112806.GP57262@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <fbe0231d-8e86-7654-ef27-8f9e019d60e8@...2181...>
Date: Wed, 13 Jun 2018 19:38:13 +0800
MIME-Version: 1.0
In-Reply-To: <20180613112806.GP57262@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qbZQj795KuyXG4bSlWtNZgarxy70vdlzI"
Subject: Re: [Openvpn-devel] [PATCH 2/3] tun: always pass a valid tt pointer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qbZQj795KuyXG4bSlWtNZgarxy70vdlzI
Content-Type: multipart/mixed; boundary="MZFoGOyU0mJDRITauupp55e4eYA8uW5yE";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <fbe0231d-8e86-7654-ef27-8f9e019d60e8@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] tun: always pass a valid tt pointer
References: <20180613081218.1834-1-a@...2181...>
 <20180613081218.1834-4-a@...2181...> <20180613112806.GP57262@...1296...>
In-Reply-To: <20180613112806.GP57262@...1296...>

--MZFoGOyU0mJDRITauupp55e4eYA8uW5yE
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 13/06/18 19:28, Gert Doering wrote:
> Hi,
>=20
> On Wed, Jun 13, 2018 at 04:12:17PM +0800, Antonio Quartulli wrote:
>> From: Antonio Quartulli <antonio@...515...>
>>
>> This patch is a small "logic restyle" which basically moves the
>> check for "tt !=3D NULL" outside of the various close_tun()
>> implementations and replaces it with an ASSERT.
>>
>> This way the check is done only once and the function can rely
>> on the assumption that "tt" is always valid.
>>
>> This change is mainly to improve the code style inside close_tun()
>> implementations by removing one level of indentation.
>>
>> No functional change is present.
>=20
> Mostly-ACK-but :-)
>=20
> The changes look good.  It won't apply after the gc_arena-fixed 1/3 of
> this series, so we need a new one.
>=20
> I've applied the patch and checked with "git diff -w", and it does what
> it says on the lid...
>=20
> Not sure the ASSERT(tt) is needed in solaris_error_close() - tt can
> never be NULL there (because all the caller functions are working with
> an active tt).  So I'd tend to leave that out, it's not doing something=20
> useful.

It's implicitly assumed, so I thought it would be helpful to make it
explicit (mostly to warn other devs to forget about that).

But I'll remove it if you think it's superfluous.


>=20
>=20
> In those close_tun() instances where you removed the
>=20
> else if (tt)
> {
>=20
> }
>=20
> part - some of them had a comment ("/* close and destroy */").  Maybe
> keep the comment?
>=20
> As in
>=20
>      if (tt->persistent_if)        /* keep pre-existing if around */
>      {
>          close_tun_generic(tt);
>          free(tt);
>          return;
>      }
>=20
>      /* close and destroy */            <<<<< this one
>      struct argv argv =3D argv_new();
>=20
> gert
>=20


ACK for the rest of the comments.


Cheers,

--=20
Antonio Quartulli


--MZFoGOyU0mJDRITauupp55e4eYA8uW5yE--

--qbZQj795KuyXG4bSlWtNZgarxy70vdlzI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlshAiUACgkQB6U8WA7y
zXSUoRAAilr7CKgjwnbipxL1qRtqT2LsrlPnaNaM57izAXeNiHnGMP6d0x/HzIu1
RpbugluLujbSJdD6T8XpmdB4QGPeaZxNC/F9hd/0LSwqSaKvlpxG1QJ5pF5JJpic
1FJ/437b/fPk1vWdn4MtSoIUim2OActLq1XZVjUQMbhElZavpyPB0WmcRrRdrawh
jSX20m0DE6JWgq9UxUKwgtkHCXul3arE3uxWPqv467A2sd4IIFqMBjhojhmIKu94
pYElAgmQfdob7MrHzTMkndDgG0RFbZCCj6b3xENEbmSHGj/tes12Mx5uVbhhU69o
yMBmhpoGhlieXR3z7JpJFuxfGfPXFtSHrHLiaey4t6SL9m3k2IpO/eeDaia7gM3G
qaOPdVdGzSynp6JJqFnl/PwQYlmE07QqtSZg21qztzqje3638sRnurRjfCcqt/9m
QRAd93MVAUKdv8Xd9CH/N5h3YW57xeazRccCUkADeBQXgqv5NAusGqYqTzG+wBH6
e9jz0xexf5z6AS+tzZy24AfWqc5zNpUNulHqEzLOzcxa79sMYFfms1BRFz+8gMlD
Jr9qNjwuRztOc5mq6r+GrzYvMlmvoMmARHoc4yxxY+yixe0k7IY6taWFt7IiZz1e
pyqAd1FeUNqYLnKkTjYfkPyUTgDrP/TPjEgrytroGQ53/ZoE80E=
=DecV
-----END PGP SIGNATURE-----

--qbZQj795KuyXG4bSlWtNZgarxy70vdlzI--

