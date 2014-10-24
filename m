Date: Fri, 24 Oct 2014 15:20:41 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20141024132041.GB396@...1296...>
References: <CAGyAFMV6kZzTFwdp21n8GTNa-fbPx_S-TpYjpiC+R862WoMhAA@...278...>
	<53B03B43.2040009@...1227...> <53BD10EB.9010509@...1227...>
	<alpine.DEB.2.02.1408121108120.3669@...1831...>
	<CAGyAFMVzDaygh1d-jtZSRXYqq+hm5qphmtEQE8f7eyhpD8Am_w@...278...>
	<5436E6E5.8060002@...1856...>
	<CAGyAFMUQnZYLNAeLeAw4SR7zJgmqc1k+mgEwBKwL+TXLAOU2ZA@...278...>
	<5448B3C9.4010403@...1435...>
	<CAGyAFMWNSP25mqjNLW0w=fjHNWwZjrLnY7uc7LMhw1Ds+Z5kmA@...278...>
	<CAGyAFMU5VN1xwx1r1xEqHVHS5NjPqTDcP1P_o_HuvgO6q=MwiA@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tfaCjp4mryZ5LVvS"
Content-Disposition: inline
In-Reply-To: <CAGyAFMU5VN1xwx1r1xEqHVHS5NjPqTDcP1P_o_HuvgO6q=MwiA@...278...>
Subject: Re: [Openvpn-devel] session-id implementation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--tfaCjp4mryZ5LVvS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Oct 24, 2014 at 02:23:48PM +0300, Lev Stipakov wrote:
> As discussed on IRC meeting, we replace session-id with peer-id.
>=20
> So, waiting for review and code-ACK :)

A few bits of review on the "non-critical" parts - so, most of it is style,
but nevertheless:

>        /* Decrypt packet ID + payload */
> -
>        if (ctx->cipher)

... please don't do whitespace changes in places where no code changes
(as it makes it harder to see where changes happened)

[..]
> +  int i;
> +  m->instances =3D malloc(sizeof(struct multi_instance*) * m->max_client=
s);
> +  for (i =3D 0; i < m->max_clients; ++ i)
> +    {
> +      m->instances[i] =3D NULL;
> +    }
> +

This doesn't look right :-) - what's wrong with calloc()?

> @@ -3922,9 +3923,9 @@ apply_push_options (struct options *options,
>        ++line_num;
>        if (parse_line (line, p, SIZE (p), file, line_num, msglevel, &opti=
ons->gc))
>  	{
> -	  add_option (options, p, file, line_num, 0, msglevel, permission_mask,=
 option_types_found, es);
> +	      add_option (options, p, file, line_num, 0, msglevel, permission_m=
ask, option_types_found, es);
> +	    }
>  	}
> -    }
>    return true;
>  }

Here's an escaped tab-to-space conversion or so, but "just whitespace=20
change" nonetheless.

[..]
> @@ -2799,7 +2808,12 @@ tls_pre_decrypt (struct tls_multi *multi,
>  		  opt->pid_persist =3D NULL;
>  		  opt->flags &=3D multi->opt.crypto_flags_and;
>  		  opt->flags |=3D multi->opt.crypto_flags_or;
> +
>  		  ASSERT (buf_advance (buf, 1));
> +		  if (op =3D=3D P_DATA_V2) {
> +		    buf_advance (buf, 3);
> +		  }
> +

I think that one should be "ASSERT(buf_advance(buf, 3 ));"

I'm not sure it is possible to exploit this, but since *every* buf_advance()
is protected, this one should be as well.

> @@ -3296,6 +3310,7 @@ tls_pre_decrypt_lite (const struct tls_auth_standal=
one *tas,
>    return ret;
>=20=20
>   error:
> +
>    tls_clear_error();
>    gc_free (&gc);
>    return ret;

Whitespace...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--tfaCjp4mryZ5LVvS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVEpSKakuBuNlUUl1AQJB9AP+J4Xe4tO4013U312y0UG3Bz5vogHx2R2Q
ggJVVBU4aCd4Oyw1LrrMi8t5kA2matYQasfaM/rSV1LJsGAuggpuwWz6TmhBetzl
duozaJWpN/DOdv+gIk9ckrBrXyHx5/jq4+/eHjKK7Ay+0P6w8Roqx59+/cK74kzk
OZad5itl9/Q=
=WA6C
-----END PGP SIGNATURE-----

--tfaCjp4mryZ5LVvS--

