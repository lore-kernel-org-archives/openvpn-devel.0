Date: Wed, 20 May 2020 21:33:44 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200520193344.GQ1431@...1296...>
References: <20200520183404.54822-1-code@...2557...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="weQJQHBTbgja3yMa"
Content-Disposition: inline
In-Reply-To: <20200520183404.54822-1-code@...2557...>
Subject: Re: [Openvpn-devel] [PATCH] Switch assertion failure to returning
 false
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jeremy Evans <code@...2557...>
Cc: openvpn-devel@lists.sourceforge.net

--weQJQHBTbgja3yMa
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, May 20, 2020 at 11:34:04AM -0700, Jeremy Evans wrote:
> To give some background, we hit this assertion failure, with the
> following log output:

This should not happen, asserting out in "normal server use" is bad.=20=20

(Neither should it ever reach that point without ks->authenticated being=20
true)

> Tue May 19 15:57:05 2020 username/73.135.141.11:1194 Assertion failed at =
/path/to/openvpn-2.4.7/src/openvpn/ssl.c:1944 (ks->authenticated)

Is this with true 2.4.7, or is this something more recent?

> @@ -1930,7 +1930,10 @@ tls_session_generate_data_channel_keys(struct tls_=
session *session)
>                                            &ks->session_id_remote : &sess=
ion->session_id;
>=20=20
> -    ASSERT(ks->authenticated);
> +    if (!ks->authenticated) {
> +        msg(D_TLS_ERRORS, "TLS Error: key_state not authenticated");
> +        goto cleanup;
> +    }
>=20=20
>      ks->crypto_options.flags =3D session->opt->crypto_flags;
>      if (!generate_key_expansion(&ks->crypto_options.key_ctx_bi,

I'm not sure if that code is correct, though - it will erase key
material (in cleanup) without actually having generated a session
key.  So "bad things might happen later".

But I leave that to Steffan or Arne who understands these intricacies
better than I do.

(Just confirmed, the ASSERT() is still like this in master)


Trying to understand the somewhat twisted maze how ks->authenticated
is set to true/false leads me to more questions...

 - are plugins or auth scripts involved on your side?
 - can you reproduce this, or was this a once-in-a-lifetime crash?

(reproduceable is better, of course :-) - as this could be a plugin
or script authentication interfering with changes brought by NCP...)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--weQJQHBTbgja3yMa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJexYYXAAoJEB2Cnv7KVigS1M0L/1hdczv1N224Tsno8xR9tOUf
U7uciDByDAH1qHfCcZ2w1RlDKnp8KbezsGnGyDV77ZxioTe5uUCCMCvfqHGDXB5q
FoNMsj2EuKYqgwJWGFUzQNBzvxhBYZzw+evgpMRC7WNLnJpPB6bZZPL20gRhP82Y
NH6zqEhj/9bv/Q12Yz9GyBAAoghzahPCDmZqOJ361BXpIAKc5+Z/y/UtAvJgrjN7
QZ93fZE9ynjSblm5SsPNgjsD293RtLKlJeHQcBs7TYjl07QkJrCdwdMxqcIT6y8g
QB7KD0xGXjkLGNrM2aApDavIOoTg6QAlMAreWTj2WgE2cTdtoQOKwPb9Vdy3WlIr
NAibQtV0bFFzFjwDY5Q5DRE4DBhNHHAwYsAJFsI5jADTnn8uqom1TdG+PbkoPCMk
uwaCPgSY8hOE077fTZjQRYk7dXadLuGM/DvuRsEMHbqFp9Qph2qXLjVzMEhukUhy
68NU6tgum/edoF7IrqCWNvtOTPSrIfgWRyDPpQYmfA==
=J9SP
-----END PGP SIGNATURE-----

--weQJQHBTbgja3yMa--

