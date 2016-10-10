Date: Mon, 10 Oct 2016 20:57:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20161010185745.GZ78279@...1296...>
References: <20160916161354.GM78279@...1296...>
	<1474108576-15534-1-git-send-email-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OjtEKJ7haQoFl5CE"
Content-Disposition: inline
In-Reply-To: <1474108576-15534-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v4] Remove tun-ipv6 Option. Instead
 assume that IPv6 is always supported.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--OjtEKJ7haQoFl5CE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Sep 17, 2016 at 12:36:16PM +0200, Arne Schwabe wrote:
> @@ -1127,6 +1127,8 @@ do_ifconfig (struct tuntap *tt,
>        if ( do_ipv6 )
>  	{
>  #ifdef NETBSD_MULTI_AF
> +#error no IPv6 support for tun interfaces on NetBSD before 4.0, upgrade =
your system.
> +#endif

If we keep this, this needs to be an #ifndef (you change the if/else
branches).  But I think this could also just go - 4.0 has been released
9 years ago.  It will fail at compile time, and then people can either
use 2.3 or upgrade their NetBSD.

Besides that, I think it mostly looks good.  Needs explicit testing
on those platforms where tun.c got changed (which I did not do yet).

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--OjtEKJ7haQoFl5CE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV/vkqakuBuNlUUl1AQL6zAQAiFw2F925d0Nc/D9FZda1uyIEfbQKMZLp
jL9I+aH1ic+Fo2NfMfl0RapvYNqkOf9Eo1TYTsSIrUgK38tnPQbZj1zri68FCOUC
blU7qtxH+rPhbmF5ZpfQzmwuGHngHH1jndGVsQoQ1z+W490pUCJoZFtnWVCRatJg
Q7BcLtOtTmw=
=8hng
-----END PGP SIGNATURE-----

--OjtEKJ7haQoFl5CE--

