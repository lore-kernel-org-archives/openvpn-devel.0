Date: Tue, 17 Mar 2015 08:42:36 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20150317074236.GC21893@...1296...>
References: <CAH0cDXEBXs55aTZdn-T7f0E-Kb8ZwD-1dueCsU-+kx-fcKUu-g@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lBP+FhBL9XXtPs84"
Content-Disposition: inline
In-Reply-To: <CAH0cDXEBXs55aTZdn-T7f0E-Kb8ZwD-1dueCsU-+kx-fcKUu-g@...278...>
Subject: Re: [Openvpn-devel] Where to find tap-win32 documentation?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ??? <alexsunchenchen@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--lBP+FhBL9XXtPs84
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 17, 2015 at 09:28:01AM +0800, ??? wrote:
> Hello everyone, Where to find the tap-win32 developer documentation, about
> how to open it(CreateFile), And How to change the stat, How to
> ifconfig(DeviceIoControl), thx..
>=20
> Forgvie my poor english. thx again.

As far as I know, you'd need to look for the "#ifdef WIN32" bits in the
openvpn source - so, no formal documentation outside the source.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--lBP+FhBL9XXtPs84
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVQfa7KkuBuNlUUl1AQLONAP/Uy0qA/fZskVJGRYTOAfD7OjyLyRyoHlY
TYqOezsGCh0YhTl4bgKbeE0EsIpJp6lla1EVxCgX19B/Dg4o9bk6HK5v4md2Rr+F
PaZ29hptovc0tICI9adloTrQz6YiKt++6kBejdDmmrVuqQbsnSaNc8dL0VOV+2vR
e8r0NosjFEw=
=cqPZ
-----END PGP SIGNATURE-----

--lBP+FhBL9XXtPs84--

