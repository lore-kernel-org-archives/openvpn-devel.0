Date: Thu, 24 Apr 2014 09:01:16 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140424070116.GN16637@...1296...>
References: <53572C4E.7010701@...1901...> <20140423081058.GJ16637@...1296...>
	<53579C5D.5000902@...1435...> <5357DDFC.2010401@...1901...>
	<53581D43.6060501@...1856...> <53584B0C.8020209@...1901...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="497qEvNZ5FLyAhdb"
Content-Disposition: inline
In-Reply-To: <53584B0C.8020209@...1901...>
Subject: Re: [Openvpn-devel] Progress on Version negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Timothe Litt <litt@...1901...>
Cc: openvpn-devel@lists.sourceforge.net

--497qEvNZ5FLyAhdb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Apr 23, 2014 at 07:21:48PM -0400, Timothe Litt wrote:
> As I can't build the windows client (it's really annoying that it=20
> requires commercial tools), further debug will need help from folks who c=
an.

Uh, this is a double misinformation :-)

 - you can build with MSVC, and you can get a MSVC version for free for
   some sort of "non-commercial use" (I'm not sure about the exact terms) -
   but you don't really want that, as building on windows is more painful
   than the alternative

 - you build with mingw64 on linux, see here:

https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsystem

   (basically cross-compiling).  It's still not as easy as building on
   the linux target platform, but I find it much easier than with MSVC.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--497qEvNZ5FLyAhdb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU1i2vKkuBuNlUUl1AQLz4AP/RJOFaxLaSQY3sLKvf8tL+oohXGQKK2i5
klOqtnDUzPmNlrkuSEUyXmJIWMYjvxVFWMPJ4Og0X6wNI13jy6Y4swYF0d2GqCUQ
JMm5U7KnDuRgo5WOUzHeAz6uDJ+XO1do9GtjfEMoYIqgTlUTN1+tsSWLeFhsicuQ
bKpc3XJKifk=
=OXQC
-----END PGP SIGNATURE-----

--497qEvNZ5FLyAhdb--

