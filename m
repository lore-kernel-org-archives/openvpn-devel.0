Date: Mon, 9 Sep 2024 09:30:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Zt6j-5lWDxlhAglc@...1296...>
References: <20240708210912.566-1-chipitsine@...277...>
 <20240708210912.566-4-chipitsine@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bstEqgOMnsDDoRsA"
Content-Disposition: inline
In-Reply-To: <20240708210912.566-4-chipitsine@...277...>
Subject: Re: [Openvpn-devel] [PATCH 3/5] src/openvpn/auth_token.c: handle
 strdup errors
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Ilia Shipitsin <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--bstEqgOMnsDDoRsA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 08, 2024 at 11:08:20PM +0200, Ilia Shipitsin wrote:
>      multi->auth_token =3D strdup((char *)BPTR(&session_token));
> +    if (!multi->auth_token)
> +    {
> +        msg( M_FATAL, "Failed allocate memory for multi->auth_token");
> +    }

I do wonder if this is the right approach here.  For "openvpn itself"
we have the check_malloc_return() macro, which will purposely not call
msg() - as msg() does internal malloc()s, and if we cannot allocate
20 bytes for an auth_token, the chance that msg() will not succeed is
fairly high...

In plugins or unit tests, the infrastructure is different, but for 3/ and
4/, please resend with

      multi->auth_token =3D strdup((char *)BPTR(&session_token));
 +    check_malloc_return(multi->auth_token);

(etc)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--bstEqgOMnsDDoRsA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJm3qP7AAoJEB2Cnv7KVigSE9ML/0dqWPnG5zKBnBE9I9Ke8Kyy
8Q1eC8HC08dJckJ4JxpymztIQqoH02CejhR4QcMe2zrq+Ejfm3Bz7wxD7mjL2M5N
Lhwmcw4jhgcA4YcgrJiDxWghqAMp1izDXzAHuWBLMphWlUU2FfY9d7YRmtFA2mGF
H8EaBN2ZSrqZZpRM5mRotvmawHP3KLAWozeeZ6cOcH+fq9YbCHVnkZ+NtiQwZjeC
Ve6Ng+TWtMbZviC37l+UKe3LoMU84U5WKb4XqvzDEglz6RSQgH6YJ6/hBUQV+BEL
6As4qGaGF7I+zvZDuoHlF6HMbUJ+TlJeSzW+yj6xko67nNLAnp9oEeQu/VbRaU9D
f10Bd8sLzoYWL+6u/W3vyMrCD09n+ZVkAziqH0g7yfMGS3MQxYUeojF7PGqrBAlD
giZhZIceWoyQ0EWz1g4rWuWKYW7kTf8mlyy0lSb0hWQsgpkDUo6NamJk0lU90E5C
vSweUeoorg8jfzWiPt7cD1lJ5kKWSpMz5L9njGd8Fg==
=prO3
-----END PGP SIGNATURE-----

--bstEqgOMnsDDoRsA--

