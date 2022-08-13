Date: Sat, 13 Aug 2022 20:47:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yvfx377UAHN199zH@...1296...>
References: <20220812130657.29899-1-a@...2181...>
 <20220812130657.29899-8-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tdcwueHLu1Klqwto"
Content-Disposition: inline
In-Reply-To: <20220812130657.29899-8-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v100 07/10] dco-win: ensure the DCO API
 is not used when running on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--tdcwueHLu1Klqwto
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 12, 2022 at 03:06:54PM +0200, Antonio Quartulli wrote:
> On Windows the high level API should still use the link_socket object to
> read and write packets. For this reason, even if dco_installed is true,
> we still need to rely on the classic link_socket object.
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  src/openvpn/dco_win.c |  4 ++--
>  src/openvpn/forward.c | 23 ++++++++++++++++++++++-
>  2 files changed, 24 insertions(+), 3 deletions(-)
>=20
> diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
> index f1160c7d..18ce9f3a 100644
> --- a/src/openvpn/dco_win.c
> +++ b/src/openvpn/dco_win.c
> @@ -355,14 +355,14 @@ dco_available(int msglevel)
>  int
>  dco_do_read(dco_context_t *dco)
>  {
> -    /* no-op on windows */
> +    ASSERT(false);
>      return 0;
>  }

I think this ASSERT(0) should go into the patch that introduces
dco_win.c - this is just a few patches upstream, so introducing it
and then changing it right again sounds like a bit of needless
commit noise...

> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 650f7c59..8af41072 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -1601,6 +1601,27 @@ process_ip_header(struct context *c, unsigned int =
flags, struct buffer *buf)
>      }
>  }
>=20=20
> +/* Depending on the platform, we may have to not use the DCO socket, eve=
n if DCO
> + * is being used for a specific link.
> + *
> + * This happens with Windows, where the standard link_socket API have to=
 be used
> + * also with DCO.
> + *
> + * For this reason we must make the right decision and not always look at
> + * dco_installed. Note that on Windows the dco_installed field is still =
supposed
> + * to be true, because it is used in the lower level code to use the pro=
per API
> + * (socket vs handle). This is why we need this function with some ifdef=
 sauce
> + */

This comment could use a bit of rewording, like

 /* Linux-like DCO implementations pass the socket to the kernel and
  * disallow usage of it from userland, so (control) packets sent and
  * received by OpenVPN need to go through the DCO interface.
  *
  * Windows DCO needs the control packets to be sent via the normal
  * Socket API.
  *
  * Hide that complexity (... especially if more platforms show up
  * in future...) in a small inline function
  */

> +static bool
> +should_use_dco_socket(struct link_socket *sock)
> +{
> +#if defined(TARGET_LINUX)
> +    return sock->info.dco_installed;
> +#else
> +    return false;
> +#endif
> +}

... which really should be "inline", no? ;-)

**WARNING** - this breaks FreeBSD DCO, so with FreeBSD DCO merged now,
it needs to be #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--tdcwueHLu1Klqwto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi9/HfAAoJEB2Cnv7KVigSMqoMALOAmZSLr0gSh2Y1nJfZcgR/
a/rbw4xJh8D74hNBPppD8AqGwOXCaKS+QLHvxcu0TStC1Ps+b7GB1Bf/httdfAAg
5DWIYBeOzA5qOx81YiF8JJFGDUAUkDQTab5Wom3nAUPEyA5CycYIinY8MPwBx2AM
U4CIW/v79KNm8oGBSp2rBwxQ7GVMj6D4pHtuDL9uB7LV/B67BF2BFQgKYIs7WlEl
MsXtyIb8zBi8hlXGf0AeNN0PtS4xCpR7AUIO9a4gs0SGl7fkwUNxuPMUVIH67TjZ
m7KBSuet7FcxyGAaEn86VIaGOXRtfwsGIiliC5AAPenudyeNijfsf539xMRhvc+p
gK1WKNb/MkaOWngsME8hOGZSi2L+4mg7BAsvBBFtRlLqH0b9jis3pjD42Oyj+oGb
AZhVD3VzqwVIV1NXJ8s7JksVTfcJQ7gnso0oprBS6MEDmYvLW30KXkHGtl8uONXL
jt3Ls+cTy6zlg1HP+X7RScyd8Hx4S3TY3i+VX3bggg==
=ojgL
-----END PGP SIGNATURE-----

--tdcwueHLu1Klqwto--

