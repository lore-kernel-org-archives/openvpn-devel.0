Date: Mon, 19 Jun 2017 15:16:30 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170619131630.GK97029@...1296...>
References: <20170619130507.13892-1-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+z1uOwmvmmbFBAc"
Content-Disposition: inline
In-Reply-To: <20170619130507.13892-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] auth-token with auth-nocache fix broke
 --disable-crypto builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--U+z1uOwmvmmbFBAc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Mon, Jun 19, 2017 at 03:05:07PM +0200, David Sommerseth wrote:
> After adding commit 571165360db0392fa83e, it broke builds where
> the --disable-crypto was used with ./configure.  This was due to
> the delayed_auth_pass_purge() which requires the crypto code paths
> being called from init.c without the proper #ifdef encapsulation.
>=20
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  src/openvpn/init.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 0832f1d1..a54307ad 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1382,6 +1382,8 @@ initialization_sequence_completed(struct context *c=
, const unsigned int flags)
>      /* If we delayed UID/GID downgrade or chroot, do it now */
>      do_uid_gid_chroot(c, true);
>=20=20
> +
> +#ifdef ENABLE_CRYPTO
>      /*
>       * In some cases (i.e. when receiving auth-token via
>       * push-reply) the auth-nocache option configured on the
> @@ -1393,6 +1395,7 @@ initialization_sequence_completed(struct context *c=
, const unsigned int flags)
>      {
>          delayed_auth_pass_purge();
>      }
> +#endif /* ENABLE_CRYPTO */
>=20=20
>      /* Test if errors */
>      if (flags & ISC_ERRORS)

ACK.

Somewhat ugly (is there no existing #ifdef ENABLE_CRYPTO block nearby
that we could hide this in?) but I need a clean tree tonight, and this
will fix things.  So, will to go with it.

(ACK-with-space-change for 2.3 :-) - "git cherry-pick -X ignore-all-space"
should do nicely)

thanks,

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--U+z1uOwmvmmbFBAc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZR86tAAoJEB2Cnv7KVigSl/UL/1tNd74C+XYR/XZVvSFPae0M
oPQAaZF+ngpQNNNaaLkWFG+lJza0AtsQyoAcsNYAqtVx8dbZ6zMdaoVNTG6limog
Ds7AeCqY+xME8US4HDfquwDsbP4E9DFyhCbuEDJ6rO+otOi5GuLLTirZsbXi+vvd
uJeuWgujjq3xA0wM+1quxNrFESNnSLNFGd7UUmZk+jijCM8ctffgG5n3Ot0ZmHq3
FLi/g/Vk90/zLUSmf1ZQcls/DpXBXsp/NhJcxmqP417pHGsXoobQAmN4b6W8C/tL
63kzPNTAsvXbltwtHlrgKSgGlcVnSeeL85VghATJxJiZ1cycbwwbz5L5u2sWfw9I
SfzfT5It39qaTEa+5UjtIT9BPapYdc9y/+wAG2Rldhlte+Uk8jMCfGNrOIs1qMol
b1uJnyZPra9fcPoageyKoR+SgRULYUrXFz9fmK5gxKMALP6v4nrd86ATHm9KBw/W
1+da0oFAJQ36Q+EEfHWFt8M2gaKBmLBxAHp0XhpB4Q==
=vsko
-----END PGP SIGNATURE-----

--U+z1uOwmvmmbFBAc--

