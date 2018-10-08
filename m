Date: Mon, 8 Oct 2018 19:56:30 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20181008175630.GT962@...1296...>
References: <20181008175044.8289-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2UusUvefyJ2PB+/T"
Content-Disposition: inline
In-Reply-To: <20181008175044.8289-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Fix building with --disable-management
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

--2UusUvefyJ2PB+/T
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 08, 2018 at 07:50:44PM +0200, Arne Schwabe wrote:
>  src/openvpn/push.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 9075d63b..af6d44f7 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -177,7 +177,6 @@ server_pushed_signal(struct context *c, const struct =
buffer *buffer, const bool
>=20=20
>  void server_pushed_info(struct context *c, const struct buffer *buffer, =
const int adv)
>  {
> -  struct gc_arena gc;
>    const char *m =3D "";
>    struct buffer buf =3D *buffer;

Not sure which branch this is coming from...

$ git branch -v
* master      674b1664 build: Fix build warnings related to get_random()
$ git grep server_pushed_info
$ git checkout -=20=20
Switched to branch 'release/2.4'
Your branch is up to date with 'stable/release/2.4'.
$ git grep server_pushed_info
$=20

... but it does not seem to be anything official...?

*scratch head*

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--2UusUvefyJ2PB+/T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbu5pNAAoJEB2Cnv7KVigSVZwL/2SCImEmzpQEmkFhQHcsT8cx
fVYOGrIr0zm/B4yabowugz2EJVMOqlYFSU/rdWaI09otKtLRCA+fT2vBo6S1KVNj
yi7mGf+olGj46YSEaeX76GbzEMS7Q7lVVGxEcKNIZFApRnt16a3Aw/hIBToa9Dm9
JLQVN9jm5EVCj1/fl76FRrGid3yw3wtUcjm/fm7V9tShOLtQvhKMgg04yuptpBUq
qfD4Yk+aiRKDfNBzfmegFxzUfDKCndM8scXD9hacydLwnLlBCTLUr+iVMBBay95m
LDlAgmSrxhLeAwDdraYbgI3FweLQyv76Y6brFQRO4dJw8u30q20d3TQMabXdfivp
Y4ANzueQs0tNg1xcKGVNPP46YunzoS/fqfBmOpCA7+gW2jouhc8ur4jDwLavoBfm
iMh+GnLUfiIdJWkJkl1iK2toMIu75rktI0uekvIfLk0xDiy7X+tYWhMZdD3lzk7l
pMKYFNdxLqDUMaihGFNQefQC9zAhkWkYYMtowhePcQ==
=eevh
-----END PGP SIGNATURE-----

--2UusUvefyJ2PB+/T--

