Date: Sun, 12 Nov 2017 21:21:19 +0100
From: Simon Ruderich <simon@...2161...>
Message-ID: <20171112202119.m337ikprgrcrc6hp@...2161...>
References: <4e9ea26fee7e606cdb0636dd377bf1bc.squirrel@...2257...>
 <20171111134758.7373-1-steffan@...1856...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="=_zucker.schokokeks.org-25394-1510518080-0001-2"
Content-Disposition: inline
In-Reply-To: <20171111134758.7373-1-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v3] Add per session pseudo-random jitter
 to --reneg-sec intervals
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-25394-1510518080-0001-2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sat, Nov 11, 2017 at 02:47:58PM +0100, Steffan Karger wrote:
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2693,7 +2693,20 @@ do_init_crypto_tls(struct context *c, const unsign=
ed int flags)
>      to.packet_timeout =3D options->tls_timeout;
>      to.renegotiate_bytes =3D options->renegotiate_bytes;
>      to.renegotiate_packets =3D options->renegotiate_packets;
> -    to.renegotiate_seconds =3D options->renegotiate_seconds;
> +    if (options->renegotiate_seconds_min < 0)
> +    {
> +        /* Add 10% jitter to the reneg-sec of each connection by default=
 */

Maybe change that to "of each server connection".

> +        int auto_jitter =3D options->mode !=3D MODE_SERVER ? 0 :
> +                get_random() % max_int(options->renegotiate_seconds / 10=
, 1);
> +        to.renegotiate_seconds =3D options->renegotiate_seconds - auto_j=
itter;
> +    }
> +    else
> +    {
> +        /* Add user-specific jitter to the renge-sec of each connection =
*/

s/renge/reneg/

> +        to.renegotiate_seconds =3D options->renegotiate_seconds -
> +                (get_random() % max_int(options->renegotiate_seconds
> +                                        - options->renegotiate_seconds_m=
in, 1));
> +    }
>      to.single_session =3D options->single_session;
>      to.mode =3D options->mode;
>      to.pull =3D options->pull;

Regards
Simon
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-25394-1510518080-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO7rfWMMObpFkF3n0kv79t+RMMvkFAloIrS4ACgkQkv79t+RM
MvkGdQ/8Dcwh+snAjudQgR9FEk09HtOY+NMfJaiWLoM0Xbd9pTogNZZXuM4xMo6K
Rnfg/qWZVxOuq/607At4Oz2wnDavP/xGndvg2aiVmS5CNU1b1bV+vBvKfRdquahA
4ib2WRV7gItL8e7j7zJtej+f5wUUcMpej8wKBwkNObmZ3YPuJIooBTOmKXMEkgeL
3RvAHibDYNjbY/pJ1OI+reDXcap/dRTIu3G2osGf2FoPyGDUFJF41UeB+hrBEQzl
o7A4ctdxQNTsPbD5kDMcw832zkRARe7yWhSa8Xw5L57nMPrBuAy7BTVdUKBIFN5C
8zLrk7+GrrQHLTLA+Isag+hDkN+xo92RtunMvPZ84Hsq64w3EuWvDc1/9FY9Eild
+WEGXNSUVt+CkGQez+QwBcny4/1kU9W1C7mtf7iT3hvvq51gET0MakOe20q6+taq
+5hzm+7Gpw7BjHcB+kANN/zI3eGXFrtjCi7pE7Hpdh3dZArvz/WmuLIXNl1NAjLO
HRH8eLzBZLwAYEvyuwXEAFZ9AdtLAXQOeeHpAF2T2N5WzETEX0Q5oWzu4Uvum/Ud
lxMaOH4DhfTp9qnyLjXChbZoc07tm3aAmLxfx4uGedGknZbCRfu4bkfe0bZ4LwqJ
xgkV+r8GbtuDWUXrRLPCxU26HYl8T3/d8rXokAyz4TbUKYp4HwM=
=fgpu
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-25394-1510518080-0001-2--

