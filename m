References: <20180602034206.9459-1-a@...2181...>
 <9f251992-0397-41e3-e1a5-506330c33aba@...2181...>
 <ceb7f155-cfc4-ac89-4703-fed77e662881@...1147...>
 <20180604071508.GS79551@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <b8d1241a-18af-2043-a5c1-903042f07e25@...2181...>
Date: Mon, 4 Jun 2018 15:20:14 +0800
MIME-Version: 1.0
In-Reply-To: <20180604071508.GS79551@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rqKAo5hj4qLF6TBlbKwRrsPC4ZVY1luf8"
Subject: Re: [Openvpn-devel] [PATCH 1/2] make tls-auth a
 per-connection-block option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rqKAo5hj4qLF6TBlbKwRrsPC4ZVY1luf8
Content-Type: multipart/mixed; boundary="81KgHRRNA4n7VGjlC3Hufx3VCQZpbnufj";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>, Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <b8d1241a-18af-2043-a5c1-903042f07e25@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] make tls-auth a per-connection-block
 option
References: <20180602034206.9459-1-a@...2181...>
 <9f251992-0397-41e3-e1a5-506330c33aba@...2181...>
 <ceb7f155-cfc4-ac89-4703-fed77e662881@...1147...>
 <20180604071508.GS79551@...1296...>
In-Reply-To: <20180604071508.GS79551@...1296...>

--81KgHRRNA4n7VGjlC3Hufx3VCQZpbnufj
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Gert has been faster to reply :-)

On 04/06/18 15:15, Gert Doering wrote:
> Hi,
>=20
> On Mon, Jun 04, 2018 at 09:10:23AM +0200, Jan Just Keijser wrote:
>> What's the particular use case for putting tls-auth files in connection=
=20
>> blocks?=A0=20
>=20
> "I have one existing server that is not using tls-auth yet, and a new one
> that has tls-auth, and I want both in the same config file"
>=20

Exactly. Or even extend the same reasoning to tls-crypt:
"one server was migrated to tls-crypt and one is still on tls-auth, and
both have to be in the same config file".


> Plus, what Steffan mentioned: tls-auth rollover
>=20

>> Does it apply only to tls-auth/tls-crypt files or also the=20
>> certificate/private keys?=A0 I could see a use case for that as well...
>=20
> Right now, only tls-auth/tls-crypt, but this is the same question I asked
> on IRC yesterday :-)
>=20
> The "traditional" use case ("my key/cert is my identity") would see=20
> "a single identity for all remotes", but indeed, upgrading to a new server
> with a new CA (--ca -> <connection>) and newly distributed identities
> might also be an interesting use case.  For @work, I've decided to tackle
> this part with "just distribute two .ovpn files", but it's worth thinking
> through the idea.
>=20

Once the issue with "--persist-key" has been fixed (will be in v2 of
this patchset) I think it should be easy[tm] to also implement
key/cert/ca per connection block.

Cheers,


--=20
Antonio Quartulli


--81KgHRRNA4n7VGjlC3Hufx3VCQZpbnufj--

--rqKAo5hj4qLF6TBlbKwRrsPC4ZVY1luf8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsU6C4ACgkQB6U8WA7y
zXRKOA//SjOQZjHjmKBm5qAY7RgN5rqp12phPwTnhuz69XxYFJ5VHdlRPsZTkDYK
HHqkCZrGKoxTdiOuZOO1Jv1QjkeDuj59y/3G+CzCWbWIcq7zXxfH79AnBw7m5c4Q
0f0unMhSjbtYr1mbfRLYLiTiK9DdaU01MxOlyQbSyWNs7uSK2xcya7ZxEirB/3Bw
HQQpTyAbpELUuLckapO7Oe1Uz1b/yzc8v0U4+Cut+SRH4Z92G2QLqK+3Kh+XqItQ
/HibMtfaw79o0hjmTJcBEeg/xHSM3682y8wU6nDn0rnCv593JZ2+M6v00qyVHbRY
xnXwnCto74W3t1uow7bGyCi1HYoOrfm5zOTff1dIoKZ4LrmDguQBXhsb6qwjs6fG
ullJkULlcc3btQKXew9BEapWS6dbcDC11nrgCZirD9OuXs6cz99MfFg6vA4KoKQd
Ft1rL8fHXT96m+CaiTuZf6JWerQAtzQtg6NpNgF0U0qrhYCgh/MI4z0pOBu4skrG
pIkpfOTQPXsagQT/VEQypU1QxFkMH0miUBs1sEaJ8nksJ5SYSf8Yn3unr3DdQ6qc
+uieQ0rvT4iMJ/5z0Eic2MleTMbCtZ/n4+nzXRZVQiPQ8sQMEzb2sKEEY23ZE/BA
QhwYqIN392l9ezfNGMXTG7UN0lfK0aPqksZIPwxFgeBDhjAUPmo=
=8URG
-----END PGP SIGNATURE-----

--rqKAo5hj4qLF6TBlbKwRrsPC4ZVY1luf8--

