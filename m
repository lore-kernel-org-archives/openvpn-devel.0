Date: Tue, 31 May 2011 15:25:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110531132528.GA8496@...1296...>
References: <1306416185-4901-1-git-send-email-samuli@...515...>
	<1306847860-11695-1-git-send-email-samuli@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aJ71jK7Pm60ygaWR"
Content-Disposition: inline
In-Reply-To: <1306847860-11695-1-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Fix a Visual Studio 2008 build issue in
	socket.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--aJ71jK7Pm60ygaWR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, May 31, 2011 at 04:17:40PM +0300, Samuli Sepp=E4nen wrote:
> Signed-off-by: Gert Doering <gert@...1296...>
> Signed-off-by: Samuli Sepp=E4nen <samuli@...515...>
> ---
>  socket.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20
> diff --git a/socket.c b/socket.c
> index 69be132..6659bcc 100644
> --- a/socket.c
> +++ b/socket.c
> @@ -647,8 +647,9 @@ update_remote (const char* host,
>        if (host && addr)
>          {
>            struct sockaddr_in6 sin6;
> +          int success;
>            CLEAR(sin6);
> -          int success =3D getaddr6 (
> +          success =3D getaddr6 (
>                                      sf2gaf(GETADDR_RESOLVE|GETADDR_UPDAT=
E_MANAGEMENT_STATE, sockflags),

Well, ACK, obviously :-)

This is the usual windows compiler problem that doesn't permit variable
declarations "right in the middle of the code".

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--aJ71jK7Pm60ygaWR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTeTsSKkuBuNlUUl1AQKT+QQAr1cfYHcM+tRCyePlfTgynWiCWcPkz/bt
VTy/tB05MnQnt+c/H5/3Zz57gfOR1AW9qvVol8bDXAmsBR/AIUJQPnCKHMMK2MmC
LwY7AahWQCUTrRzPMXHHB3S0VcGLORm/rY15d/5nbSY/NwcS0Y9p/+cNkWQLObph
JK/ErFXN5HI=
=BqK6
-----END PGP SIGNATURE-----

--aJ71jK7Pm60ygaWR--

