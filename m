Date: Thu, 22 Aug 2013 13:51:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130822115102.GL16543@...1296...>
References: <5215D0BA.6040009@...515...> <5215E945.7080105@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E9lJRGffXdNhqRfL"
Content-Disposition: inline
In-Reply-To: <5215E945.7080105@...1114...>
Subject: Re: [Openvpn-devel] Topics for today's community meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--E9lJRGffXdNhqRfL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 22, 2013 at 12:34:45PM +0200, David Sommerseth wrote:
> * openvpn-build issues + snappy topic.
>=20
>    "The problem is that snappy pulls in a 8MB library as a dependency,
>     increasing installer size considerably "
>=20
> Is this really a problem?  It's not a small library, but it could still
> be worse.

The 8MB library is libstdc++, which can be statically linked if we figure
out how (this is on *windows*).  Libsnappy is tiny.

And yes, this is a relevant difference if the overall installer without
libstdc++ is just 1.7 Mb sized today

   1723560 Jan 18 2013  openvpn-install-2.3.0-I001-x86_64.exe

(And no, making the installer even bigger by shipping two binaries
*and* the huge library is not a good plan :-))

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--E9lJRGffXdNhqRfL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUhX7JqkuBuNlUUl1AQImAwP/frDrmCpOANHcEdoq5feBQYTgBv/hvDh1
+2G5GekSCMkcLATtuTxem68v3Aqg8+le2q0seMvE5v42cDQY/N/h2liahcF4glet
H+2hZMmLSF36YE9dHeQwzYhP0gDnfI2cXXVjhBQXAwT9QaxIzSZDHvXegsnKhAlc
GeRKaM7kBbA=
=2Sqa
-----END PGP SIGNATURE-----

--E9lJRGffXdNhqRfL--

