References: <1498913642-32459-5-git-send-email-steffan.karger@...1435...>
 <1514541271-19597-1-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <324069b9-a7f9-8ef4-5ad1-eb5d98cb6742@...2181...>
Date: Wed, 10 Oct 2018 16:27:19 +0800
MIME-Version: 1.0
In-Reply-To: <1514541271-19597-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Vidtc6kuboOjbTUVTLhoCGqwEuquj28gf"
Subject: Re: [Openvpn-devel] [PATCH 5/5 v2]
 buffer_list_aggregate_separator(): simplify code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Vidtc6kuboOjbTUVTLhoCGqwEuquj28gf
Content-Type: multipart/mixed; boundary="vnzu6XADcW1yzUzzhzfC402ibJouBq02D";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <324069b9-a7f9-8ef4-5ad1-eb5d98cb6742@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 5/5 v2] buffer_list_aggregate_separator():
 simplify code
References: <1498913642-32459-5-git-send-email-steffan.karger@...1435...>
 <1514541271-19597-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1514541271-19597-1-git-send-email-steffan.karger@...1435...>

--vnzu6XADcW1yzUzzhzfC402ibJouBq02D
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 29/12/17 17:54, Steffan Karger wrote:
> Clean up the function by slightly simplifying the logic.
>=20
> Mostly witespace changes, so best reviewed using 'git diff -w'.
          ^ missing 'h' here

>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
> v2: rebase on new version of preceding patches
>=20

Other than the typ0 above, the patch does what it says and does not
introduce any functional change.

Even though it was "easier" to review with "git show -w", I still had to
dig into the original function to make sure I understood the original
logic and I was later able to guarantee it was not changed by the patch.

For this reason I wrote some doc for the buffer_list_* functions which I
will send as a new patch soon.

Acked-by: Antonio Quartulli <a@...2181...>


--=20
Antonio Quartulli


--vnzu6XADcW1yzUzzhzfC402ibJouBq02D--

--Vidtc6kuboOjbTUVTLhoCGqwEuquj28gf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlu9t+cACgkQ9FVsWUWD
Dm19whAApKgQgOHZL+Dq4zO3AInqX5r/HMD9Mc8m66+CBkHuWyGNrANwAoatPoep
8ugsrPVm7tsIVmXCl8/TFXYpM5EpEnI1hwoPSgZSA4G73tq4QYiwKD9VVADuw25/
t5/T5L+KggqkmjYMdMhv3xN7TPZJa7UxIxYj5u/saQgUXTGLS6c4HI9OiKd8ECrP
m3k0UGjP+rW+30uC5ThnhU5f8LrGVwJV8i9xc3u/u3Nxk7TgzXwteEXV32xL0TJO
zoiZBWIE35MNP7976pUh7RIB73wHqmKozyT8fLqaQr7GmVI4/+x3Q0sNkzOYJ0Dc
tP+Y8PiJEm0ioN7jMkAHbGJMMEUaSHpW/BwOcbDTW5ihKV8VoMALgANkxNboCEHD
UbTokbeMUYXZwNFfVq5BPnObWoZrNtBK4xEfDuf1pScZfzn+w5/n/bNK7S5UdvRP
gtgL2WObuvqepLk0KL36LT2PJzhF+9A+7HtTI5ySbG8VHJE9iXfkcLHtElfNTP0r
1Utax1o1T82a4evWDIsNDJISrWNtXjnvHNGB2JHnnxFFKF9ZXFGEVY3NzlLhAO9b
UCNnB2YfzbMEXUF8Si8ES1wBdRTqe5rUqqvckf5IOGAH/7hj/joAu1k8HE8A5Iqz
ozhKuLkPyK3E0WbItdrCWGOu51Fd9uCXC/Vy/B2A10nEMfUlD5g=
=MybG
-----END PGP SIGNATURE-----

--Vidtc6kuboOjbTUVTLhoCGqwEuquj28gf--

