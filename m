Date: Wed, 10 Feb 2016 11:13:39 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160210101339.GZ24952@...1296...>
References: <CACqLfMnrWmytCz9Oz9ES1qsQienJXbxOjGAHydx2RS=5sL=waQ@...278...>
	<CACqLfMkwi_Y+jQg4zyivzwyTkPApNVQx6XWYBXiSxBANYC5nOg@...278...>
	<CACqLfMnBXwSY=MXyc7B1oMKwYE2Z_49G3mpkEPxbSAuG61tgZA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QR+pW7Qagd5SsK+M"
Content-Disposition: inline
In-Reply-To: <CACqLfMnBXwSY=MXyc7B1oMKwYE2Z_49G3mpkEPxbSAuG61tgZA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix misleading socket error code on
 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Leonardo <leobasilio@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--QR+pW7Qagd5SsK+M
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Feb 07, 2016 at 06:21:49PM -0200, Leonardo wrote:
> So it seems like socket.c is getting its value from winsock.h. Here's
> a better patch:
>=20
> Signed-off-by: Leonardo Basilio <leobasilio@...277...>
> ---
>  src/openvpn/socket.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index 396fa54..37fa129 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -1177,7 +1177,11 @@ openvpn_connect (socket_descriptor_t sd,
>          {
>            if (--connect_timeout < 0)
>          {
> +#ifdef WIN32
> +          status =3D WSAETIMEDOUT;
> +#else
>            status =3D ETIMEDOUT;
> +#endif
>            break;
>          }
>            openvpn_sleep (1);

Indeed, this patch works - built a windows binary, tested, get a proper
log message when connecting to a server that is unreachable:

  TCP: connect to ... failed: Connection timed out (WSAETIMEOUT)

So, I'd be happy to merge this.  Alas :-) - it does not apply automatically,
because spaces are all mangled (tabs got replaced by spaces).  Mail clients=
=20
tend to do this, so I'll have to do this manually (not hard here).  For you=
r=20
next patch, please use

  git send-email --to=3Dopenvpn-devel@lists.sourceforge.net

(test with --to=3Dyourown@...2122...) - it will usually get everything done
perfectly.  If you use an Exchange server as outgoing MTA, things get
more complicated because exchange always breaks stuff - in that case,
git-send-email can be configured to use authenticated SMTP to an outside
server that is well-behaved (like, gmail).

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--QR+pW7Qagd5SsK+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVrsNU6kuBuNlUUl1AQIF0AP/fVP4Mbug9Vxr3v6PU2V2NpM/34K17flF
8b4oeqiK0eJ1YolAA1UZDP/kUcOHNY3Jqrnj05YiRlbTbCQC1ImG8Hn+mjxhFyvE
T/mRqikZJ8Hb1a5sJurNfID4CXrYNqWMXJvjmTR/J4A13LRx66l0c4Ie+PS86SDa
D+HZoim0L8E=
=j/lP
-----END PGP SIGNATURE-----

--QR+pW7Qagd5SsK+M--

