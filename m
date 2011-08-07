Date: Sun, 7 Aug 2011 19:51:43 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110807175142.GS8496@...1296...>
References: <1312714757-10317-1-git-send-email-beber@...1472...>
	<430b86c89889b28e473dfed2fc3ae817@...1492...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q1JJyjvUz2rL7ka/"
Content-Disposition: inline
In-Reply-To: <430b86c89889b28e473dfed2fc3ae817@...1492...>
Subject: Re: [Openvpn-devel] Allow to fill Details tab for exe files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Bertrand Jacquin <beber@...1472...>
Cc: openvpn-devel@lists.sourceforge.net

--q1JJyjvUz2rL7ka/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Aug 07, 2011 at 04:13:03PM +0200, Bertrand Jacquin wrote:
> > [PATCH 1/4] WIN32: Check for windres tool
> > [PATCH 2/4] Win32: Add OpenVPN RC file to add fill "Details" exe
> > [PATCH 3/4] Win32: Fill "Details" properties for openvpn.exe
> > [PATCH 4/4] Win32: Fill "Details" properties for openvpnserv.exe
>=20
>  I just can't figure out why my patch are not diffused even when SF MX=20
>  say they have been accepted.

Your patches have arrived here just fine.

I think the functionality is useful, but don't know enough about windows
to give this a full technical ACK.

Two questions:

 - what happens if windres is not found?  will the compilation break?
   (I'm not sure whether windres will always be there or not)

 - if I read this right, it will only work for the autoconf / mingw based
   build, but not for the msvc++ / python based build, right?  will it
   co-exist, or break the python build?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--q1JJyjvUz2rL7ka/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTj7QrqkuBuNlUUl1AQKthwQAvsYHom4CGCGnXEhH21Vc5NqYcV4J3TG8
LQLMZi0QbIzsjCA81AQVr/W8vRYj7LJPq7vB8ykS55EW0DlautKhD9pEV9UDK2Gr
TBKfA9yypTacgxTpciPsKOVAUzPL8kz8fPNVX5s/E8FCKYt23cQkNeMkFZIe4Vf4
JwkieHruT0I=
=+CS8
-----END PGP SIGNATURE-----

--q1JJyjvUz2rL7ka/--

