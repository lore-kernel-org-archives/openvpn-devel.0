Date: Tue, 17 Jul 2012 17:46:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120717154628.GV22125@...1296...>
References: <1342533472-30873-1-git-send-email-heiko.hund@...1489...>
	<CAOazyz0wc=ZGhJnLfvd=AK6_Y=vTfebccmV29Fc5z2DGpJ8EWQ@...278...>
	<21316332.O9di4uRdZn@...1526...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oFMCfUPuRwe/HdF5"
Content-Disposition: inline
In-Reply-To: <21316332.O9di4uRdZn@...1526...>
Subject: Re: [Openvpn-devel] [PATCH] don't treat socket related errors
	special anymore
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

--oFMCfUPuRwe/HdF5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 17, 2012 at 05:09:34PM +0200, Heiko Hund wrote:
>   if (status =3D=3D EINPROGRESS
>   #ifdef WIN32
>     || status =3D=3D WSAEWOULDBLOCK
>   #endif
>   )

Please let's not do that.

> or slightly less disturbing
>=20
>   #ifndef WSAEWOULDBLOCK
>   #define WSAEWOULDBLOCK 10035L
>   #endif

Something like that (possibly autoconf-magick'ed) and then

   if (status =3D=3D EINPROGRESS || status =3D=3D WSAEWOULDBLOCK )

or even

   if (status =3D=3D EINPROGRESS || status =3D=3D EWOULDBLOCK )

(WSAEWOULDBLOCK mapped to EWOULDBLOCK, as I've seen that error code on
some unix platforms as well) would be my favourite, code-readability wise.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--oFMCfUPuRwe/HdF5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUAWI1KkuBuNlUUl1AQINXwQAkahQIF0glUIaMbTpat0zpi6E7vb1QjYN
jETe+2D5lGd9anzBkwN5cnkvaflRr74flg/m7Cmvd39QrTV6wZOxQPf4wsfQ/ayu
LKpCdy6C7KKAfVWqPN4lltIgWc8z93P3zgB1iBXecJ1fqYz+kyqO4Ib/O68nKyFN
4Kqxs0ghg7k=
=K+Kh
-----END PGP SIGNATURE-----

--oFMCfUPuRwe/HdF5--

