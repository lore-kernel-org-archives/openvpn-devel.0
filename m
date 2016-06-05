Date: Sun, 5 Jun 2016 19:03:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160605170308.GQ53051@...1296...>
References: <1465055649-13628-1-git-send-email-selva.nair@...277...>
	<1465055833-13681-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W3XMD47762gBWfyb"
Content-Disposition: inline
In-Reply-To: <1465055833-13681-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH master] Make block-outside-dns work with
 persist-tun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--W3XMD47762gBWfyb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 04, 2016 at 11:57:13AM -0400, Selva Nair wrote:
> - Remove and recreate WFP filters during restart even when
>   tun/tap is not re-opened. This is needed for resolving the remote.
>   Patch same as for v2.3 except for passing 'msg_channel'.
>=20
> See also: http://article.gmane.org/gmane.network.openvpn.user/36990
>=20
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/init.c |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 42baf97..fb45bc1 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1556,6 +1556,15 @@ do_open_tun (struct context *c)
>  		     NULL,
>  		     "up",
>  		     c->c2.es);
> +#if defined(WIN32)
> +      if (c->options.block_outside_dns)
> +        {
> +          dmsg (D_LOW, "Blocking outside DNS");
> +          if (!win_wfp_block_dns(c->c1.tuntap->adapter_index, c->options=
.msg_channel))
> +            msg (M_FATAL, "Blocking DNS failed!");
> +        }
> +#endif
> +

I understand why this is needed, but the code is getting increasingly
ugly here, with the else { } branch duplicating more and more code lines
of the if () part (run_up_down(), win_wfp_block_nds())...

Looking at it, I think the patch itself is perfectly fine (so I'll apply=20
later on) and not to blame for this  - but for master at least, we might=20
consider some refactoring here...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--W3XMD47762gBWfyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1RbTKkuBuNlUUl1AQLx6QP9EC4cAsVJG6A6xkKEidOoQyULnu/T2NUK
Iyy9ocwYD2obIasIYoRuRl3zQ/lStq5KwFbXf3xkxp/IL4QOfq0Bd6APFSpgF5/j
DOEZUdwTaotJ6F/Do+iOET0rwHEub6JGuDmmd9tv6VgatcDIQnxPIQI+6gj3MoRf
L+x5UQDcZ3k=
=VGAC
-----END PGP SIGNATURE-----

--W3XMD47762gBWfyb--

