Date: Sun, 5 Feb 2012 16:57:27 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120205155727.GA9813@...1296...>
References: <1328442685-8550-1-git-send-email-dejong@...1435...>
	<1328442685-8550-2-git-send-email-dejong@...1435...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <1328442685-8550-2-git-send-email-dejong@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Removed support for calling
	gc_malloc with a NULL gc_arena struct
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Feb 05, 2012 at 12:51:25PM +0100, Adriaan de Jong wrote:
> Signed-off-by: Adriaan de Jong <dejong@...1435...>
> ---
>  buffer.c |   29 ++++++++++-------------------
>  1 files changed, 10 insertions(+), 19 deletions(-)
>=20
> diff --git a/buffer.c b/buffer.c
> index 2f8e4b8..c39bbcb 100644
> --- a/buffer.c
> +++ b/buffer.c
> @@ -310,28 +310,19 @@ gc_malloc (size_t size, bool clear, struct gc_arena=
 *a)
>  #endif
>  {
>    void *ret;
> -  if (a)
> -    {
> -      struct gc_entry *e;

NACK on that.  We discovered that there are use cases where "second-level"
callers pass NULL, seemingly on purpose to allocate global memory instead
of "in the GC".

main(), in openvpn.c:

          /* initialize environmental variable store */
          c.es =3D env_set_create (NULL);

... which calls into misc.c:

struct env_set *
env_set_create (struct gc_arena *gc)=20=20=20
{
  struct env_set *es;
  ALLOC_OBJ_CLEAR_GC (es, struct env_set, gc);
  es->list =3D NULL;
  es->gc =3D gc;
  return es;
}

... and boom, assert() fail.


Adriaan saw the crash ("my nice OpenBSD test run!!!") and promised to work
on this on the way back in the train.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTy6m56kuBuNlUUl1AQI/YQQAnmkyLMsXxnpuqb1cF2s1cxbWj/CZty0p
GUMe40LRA250dr2pQzFM5eGD9RamO0mvduR+INRfC+JS2ofYp66BkbLkmN5OIh9A
PEhcM4Bnlov5GdyvNYm4uVa+fdA2gbiTTNNSHUZwwGM7dj8qLtn7p3JvRYf9hPuD
b9GPDS56Y9w=
=aGY2
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--

