Date: Tue, 22 Nov 2016 22:18:35 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161122211835.GJ28918@...1296...>
References: <1479661698-31368-1-git-send-email-steffan@...1856...>
	<1479844631-14517-1-git-send-email-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V9ABGQrVMw+oEm4j"
Content-Disposition: inline
In-Reply-To: <1479844631-14517-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v4] Poor man's NCP for non-NCP peers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--V9ABGQrVMw+oEm4j
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I totally want to have this, and overall the changes all make sense
(so ACK for the refactoring part, needs a few windows held side by
side in addition to tkdiff... :-) ), but something puzzles me...

On Tue, Nov 22, 2016 at 08:57:11PM +0100, Steffan Karger wrote:
[..]
> @@ -2320,6 +2318,26 @@ key_method_2_read (struct buffer *buf, struct cont=
ext *c, struct tls_session *se
>        /* Peer does not support NCP */
>        session->opt->ncp_enabled =3D false;
>      }
> +
> +  /* "Poor man's NCP": Use peer cipher if it is an allowed (NCP) cipher.
> +   * Allows non-NCP client to upgrade their cipher individually. */
> +  char *remote_cipher =3D options_string_extract_option (options, "ciphe=
r", &gc);
> +  if (c->options.ncp_enabled && !session->opt->ncp_enabled && remote_cip=
her &&
> +      0 !=3D strcmp(c->options.ciphername, remote_cipher))
> +    {

This looks totally logical and all, until I try to compile it - and
then the compiler ruins the day for me...

../../../openvpn/src/openvpn/ssl.c: In function 'key_method_2_read':
../../../openvpn/src/openvpn/ssl.c:2313:7: error: 'c' undeclared (first use=
 in this function)
   if (c->options.ncp_enabled && !session->opt->ncp_enabled && remote_ciphe=
r &&
       ^

... and I can not seriously argue with it here... - there is no "c".

(David pointed out that *his* patch brings in the "c" here, but that one
didn't receive enough love yet, so is not in *my* tree...)

So - this needs to be sorted out.


There is another catch here - options_string_extract_option() is wrapped
in an #ifdef ENABLE_OCC, which is turned off if you configure --enable-small
(so linking breaks).  That second catch can be easily fixed by wrapping
this whole code new code block in #ifdef ENABLE_OCC as well (if the data
is just not enable in this case) or by moving the "extract" function
after the corresponding #endif...


Finally, moving over tls_limit_reneg_bytes() broke the whitespace in
weird ways - it got mangled to=20

  tls_limit_reneg_bytes (session->opt->key_type.cipher,
        &session->opt->renegotiate_bytes);

while it was

  tls_limit_reneg_bytes (session->opt->key_type.cipher,
                         &session->opt->renegotiate_bytes);

(I could fix that on the fly, and also the #ifdef ENABLE_OCC, but not
the "c" one)


"Can I have a v5, please...?"

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--V9ABGQrVMw+oEm4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWDS2KqkuBuNlUUl1AQJAqgQAwkXoGzsQvilAkmLdkT3iIoh+J67EeDaJ
O1elDNNb/29JnQB0Ceju46Bw8pOykbwRYLvhgUqwYtyR/vPRKNS455R7XnKWMqrH
NKh19Whr1mg9G3GHWXEhrtYYo/RsYcGKkXEwUApb6Yolb4VBlc2ntQmY8eQUONBw
ug2NMMWGLVA=
=8Gci
-----END PGP SIGNATURE-----

--V9ABGQrVMw+oEm4j--

