Date: Fri, 17 Feb 2012 11:44:54 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120217104454.GR7024@...1296...>
References: <1329467975-30716-1-git-send-email-heiko.hund@...1489...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w6U88vdWm8UqIXvc"
Content-Disposition: inline
In-Reply-To: <1329467975-30716-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] move variable declaration to top of
	function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--w6U88vdWm8UqIXvc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 17, 2012 at 09:39:35AM +0100, Heiko Hund wrote:
> MSVC chokes on this as it's not according to C89.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  buffer.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/buffer.c b/buffer.c
> index 6800e6e..391085b 100644
> --- a/buffer.c
> +++ b/buffer.c
> @@ -321,9 +321,9 @@ gc_malloc (size_t size, bool clear, struct gc_arena *=
a)
>  #endif
>  {
>    void *ret;
> +  struct gc_entry *e;
>    ASSERT (NULL !=3D a);
>=20=20
> -  struct gc_entry *e;

Ack.  This has bitten me as well :)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--w6U88vdWm8UqIXvc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTz4vpakuBuNlUUl1AQIfuQQAiMaIP3eCSyhgrktAdjKSRontKXzVkH/t
lGUoNXqzTx+I4AF5bPMzQZqiWkwElO/W/HSM1uwIgGKujB+BY+sF+YztK84bI74J
JbZZfb5YwK/Q4z7wtTnhuCv9zBa/RKjeZIUQ+WdtUtg0fwYUTyyZ+ex+c4EUKowr
CCCRjyxLyi8=
=68AK
-----END PGP SIGNATURE-----

--w6U88vdWm8UqIXvc--

