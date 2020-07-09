Date: Thu, 9 Jul 2020 20:43:24 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200709184324.GD1431@...1296...>
References: <20200709101603.11941-1-arne@...1227...>
 <20200709101603.11941-7-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+Vi/AbALo92p26kG"
Content-Disposition: inline
In-Reply-To: <20200709101603.11941-7-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 7/8] Removed unused definition
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--+Vi/AbALo92p26kG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 09, 2020 at 12:16:02PM +0200, Arne Schwabe wrote:
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/ssl.c | 5 +++--
>  src/openvpn/ssl.h | 7 -------
>  2 files changed, 3 insertions(+), 9 deletions(-)
>=20
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 668bcbd9..4ee4c245 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -1988,8 +1988,9 @@ tls_session_update_crypto_params(struct tls_session=
 *session,
>      }
>      else
>      {
> -      /* Very hacky workaround and quick fix for our calculation
> -       * not correct to avoid a regression */
> +      /* Very hacky workaround and quick fix for frame calculation
> +       * different when adjusting frame size when the original and new c=
ipher
> +       * are identical to avoid a regression with client without NCP */
>          return tls_session_generate_data_channel_keys(session);
>      }

This comment has strayed a bit, I think I'll move it over to the previous
patch (6/8) which introduces it - not so useful to add a comment and then
change it right in the next patch.

Also, somewhat unrelated change...

> diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
> index 2f6f7657..58a9b0d4 100644
> --- a/src/openvpn/ssl.h
> +++ b/src/openvpn/ssl.h
> @@ -89,13 +89,6 @@
>  #define TLS_MULTI_HORIZON 2     /* call tls_multi_process frequently for=
 n seconds after
>                                   * every packet sent/received action */
>=20=20
> -/*
> - * The SSL/TLS worker thread will wait at most this many seconds for the
> - * interprocess communication pipe to the main thread to be ready to acc=
ept
> - * writes.
> - */
> -#define TLS_MULTI_THREAD_SEND_TIMEOUT 5
> -
>  /* Interval that tls_multi_process should call tls_authentication_status=
 */
>  #define TLS_MULTI_AUTH_STATUS_INTERVAL 10

This one is easy enough, so

Acked-By: Gert Doering <gert@...1296...>

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--+Vi/AbALo92p26kG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfB2VLAAoJEB2Cnv7KVigSrc4L/3iJc02+/WGa3rEbaI1yBCUe
EeNTiqEdXhDCp7q8YZuYvzTAe6SAy5GiXmbNEuB4o6q8dYZq4AlkabtlXoYnYWFV
MJqTcbJvrEU7W4vhhAXrefqQMH0SxWGC4UZOvy5LE2Ob/FSX4p4++tmQwkajhPcT
K71YwbGfnvjIH89+RAwU9H886eLRBFyHb2a+Ol+RGVFRWyxk+krtwiy3ldeqTNAs
CKAXa3+W3SnBKQrIm12ti0PCjUuDy7IVKiBwsxM6TYr0hbkzoCp6NPP2T2lY90Nf
oCOVOMQAOWtaduhsGA+MUeXNk0y3vvP/BIKE0W5UKBNl96snxmwsAuPmOmpl6OVh
hKBkr3mBkigWXM3nvMUQmI20+VCkGj3Svlqub79qdTXPYD/aL20s6aLPZO0NH0V5
spl388MnHq9tSyomNpZYy3C0yy7S5mk5DrPsb13vS5SAFyaiFb6quDPO/Z5q6jWa
IH4rNJEkpZeBk26omq29iZEgLeZOGWCxhEBXQJXgIQ==
=pbfx
-----END PGP SIGNATURE-----

--+Vi/AbALo92p26kG--

