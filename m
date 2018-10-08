References: <de02e114-2f3e-3176-1230-11787eaa4eae@...2181...>
 <20181007223035.21179-1-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <b6ad45cd-83d2-14c1-cf30-fa6a67e488e0@...2181...>
Date: Mon, 8 Oct 2018 17:11:59 +0800
MIME-Version: 1.0
In-Reply-To: <20181007223035.21179-1-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sxEcbGvvJWkwqayTJgGZM0hyLNwlgun0R"
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Add support for
 CHACHA20-POLY1305 in the data channel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sxEcbGvvJWkwqayTJgGZM0hyLNwlgun0R
Content-Type: multipart/mixed; boundary="yIbKCOyE8AaYdbSZdY8pEsOMVRgvc8njO";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <b6ad45cd-83d2-14c1-cf30-fa6a67e488e0@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Add support for CHACHA20-POLY1305
 in the data channel
References: <de02e114-2f3e-3176-1230-11787eaa4eae@...2181...>
 <20181007223035.21179-1-steffan@...1856...>
In-Reply-To: <20181007223035.21179-1-steffan@...1856...>

--yIbKCOyE8AaYdbSZdY8pEsOMVRgvc8njO
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

thanks for fixing the ifdef condition!
Tested again and it works as expected between two clients when disabling
NCP and setting CHACHA20-POLY1305 as cipher:

Mon Oct  8 17:11:36 2018 us=3D670345 127.0.0.1 Outgoing Data Channel:
Cipher 'CHACHA20-POLY1305' initialized with 256 bit key
Mon Oct  8 17:11:36 2018 us=3D670351 127.0.0.1 Incoming Data Channel:
Cipher 'CHACHA20-POLY1305' initialized with 256 bit key


On 08/10/18 06:30, Steffan Karger wrote:
> We explicitly only supported GCM as a valid AEAD mode, change that to also
> allow ChaCha20-Poly1305 as an AEAD cipher.  That works nicely with our new
> (GCM) data channel format, because is has the same 96-bit IV.
>=20
> Note that we need some tricks to not treat the cipher as insecure, because
> we used to only look at the block size of a cipher to determine if find a
> cipher insecure.  But ChaCha20-Poly1305 is a stream cipher, which essenti=
ally
> has a 'block size' of 1 byte and is reported as such.  So, special-case t=
his
> cipher to be in the list of secure ciphers.
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
> v2: code style fixes, remove unneeded version check

Acked-by: Antonio Quartulli <antonio@...515...>


Cheers,


--=20
Antonio Quartulli


--yIbKCOyE8AaYdbSZdY8pEsOMVRgvc8njO--

--sxEcbGvvJWkwqayTJgGZM0hyLNwlgun0R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlu7H18ACgkQ9FVsWUWD
Dm3NkhAAg8AnTMc37LKmQSIdXx/W/7DOkb8Kfond5K+xCirSzQasR6YnD3TmCbQP
5mkPx7QaL1uIABHOIwPKcAzlMDyOj82sveVwEjprxJAOQko2qukREKgF2xSQaV7Z
VsmdjhEGG586Z8IgNQR4tiMCihxfk9/+YQRdSRNdxKmDA27s2djSMQUYf6pMurti
Twn9eUP+0DauqPvxbCD5qy7wUZxJLkmgCMTsg/mLh6xb2D9FKuUR4G0cl1Kv4LWI
770JQ+EQ4I7/7gDgzXpLs05GE6OGCgZFFEZyZJaGWsFMoauxCrjkutMmD0YnrfII
i2+PyQse3VtVgeY1YvaNPR2BfYMZaqfqcsRR52mNf3A1PO/EkZ+v6dBToxSssE9J
Yhs2QS9hAau26q4NPSbjhrQ0l3amelN6AwyCNyis+riypdqVkWHKWQCS5z0dqcb9
1n/F5J/y0DYPmhmJNqhlbGx18DqcUuWVCVuzgp3YGBWgNSblE+VbnlY+oY6ERgLm
CcA1QAQJVs5+mQCYz+QqNTsmQnuDOMBwgN+XVdqj5h2EloiY9I222Sf2Zvn1Sl8X
zuG6gXz4VXx0/mj3KjklKKSwblOhwcXvtGit04H0cTx2Jldy/FdngrJzCF5YJsEX
0spJLJsteGqgmqscbfaR3iyuOgUh5zOBrZnbPExO0dMFvrCfpE8=
=6eDA
-----END PGP SIGNATURE-----

--sxEcbGvvJWkwqayTJgGZM0hyLNwlgun0R--

