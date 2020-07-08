Date: Wed, 8 Jul 2020 18:15:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200708161525.GW1431@...1296...>
References: <20200707121615.15736-1-arne@...1227...>
 <20200707121615.15736-4-arne@...1227...>
 <20200708111510.GV1431@...1296...>
 <4c73c51d-6828-57d0-ad24-78b86ecea07d@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="IuQ57q5v8zJEy11C"
Content-Disposition: inline
In-Reply-To: <4c73c51d-6828-57d0-ad24-78b86ecea07d@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Cleanup: Remove unused code of old
 poor man's NCP.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--IuQ57q5v8zJEy11C
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 08, 2020 at 03:15:49PM +0200, Arne Schwabe wrote:
> +++ b/src/openvpn/ssl.c
> @@ -1986,6 +1986,12 @@ tls_session_update_crypto_params(struct
> tls_session *session,
>              options->keysize =3D 0;
>          }
>      }
> +    else
> +    {
> +      /* Very hacky workaround and quick fix for our calculation
> +       * not correct to avoid a regression */
> +        return tls_session_generate_data_channel_keys(session);
> +    }

Just for the record: that nasty hack made the server happy again.

start client jobs...
23...
Test sets succeeded: 1 1a 1b 1d 2 2a 2b 2c 2d 3 4 5 6 8 8a 9.
Test sets failed: none.
24...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 4a 5 6 8 8a 9.
Test sets failed: none.
master...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 5 6 7 7a 8 8a 9 =
2f 4b.
Test sets failed: none.


So we decided to go "with the hack for now" and clean up the mine field
arounding frame size stuff afterwards.

Patch set incoming tomorrow.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--IuQ57q5v8zJEy11C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfBfEdAAoJEB2Cnv7KVigSbfUL/1xtSfWhzEm+KoPfY1k7Ttmy
10LXdJJzt7PMkDBSFb1ZBkxvCTneIPncvT7RWywqGcmG9KkZI+ZjGTSirbQOjX+y
Vucr23YL2sxYGp+mBEDkgmAX+dPDjuZZeGeNrhXjHZnM4+41dy/XnodGx5/vRbph
ufzPZyYmMmXMQaOP+X/IePPDs0ytwFb2a6PxjcSMclgTlLxVQYpiCVdTfGd3qpFh
5Q1JHO7Q5ZS68WWwNcw11+p92iPTwHXSCPUCiTfWxMZZ47WZfRAhDOQN7o5VbKhz
2n1kHnA1tM5R4xfBB6jUY1F+YkKXwEWNgPnuDMZrvGRxkmSycD++KoXDfdSAeZDD
bg66PCnm5/yXBgx39mCxMkGBpyX4UubGcRuVFrM06d8TrcUxRjfz46UDqhpKXVEN
kTfmpYef2VOW4WVR3K0Ed8c/1Oas7V/BM8wMQOsQDA5FuuaJaO+vW88jUkLjbFWl
HmPWy6NLdUlr98Y5JCQweBPnRC9oA+CKTU2rqvsvdQ==
=PRiF
-----END PGP SIGNATURE-----

--IuQ57q5v8zJEy11C--

