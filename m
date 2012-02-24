Date: Fri, 24 Feb 2012 18:45:48 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120224174548.GE7024@...1296...>
References: <4F438CF2.1060305@...515...> <4F4601A5.3080203@...1549...>
	<4F4610F1.7020002@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/8Xxy37xq6kDVsli"
Content-Disposition: inline
In-Reply-To: <4F4610F1.7020002@...1114...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 preview 1
	installer now available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--/8Xxy37xq6kDVsli
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 23, 2012 at 11:12:01AM +0100, David Sommerseth wrote:
> Please try the attached patch and see if this works better.  I've flipped
> the flag about explicit IPv6 support for OSX/Darwin.  Your tests obviously
> shows the support is present.

ACK.  I just checked the code, and the missing "true" there is just an=20
oversight, OSX is considered "full IPv6 support".  I've considered ripping
out the whole check, error message and argument to open_tun_generic(),
but there actually are three cases left where "no IPv6 support" is true
(old Linux, old NetBSD, "we don't really know anything about this platform"=
),
so let's stick to the simple bit-flip for now :)

Also ACK on the added text to the warning message.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--/8Xxy37xq6kDVsli
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT0fMzKkuBuNlUUl1AQJdAwQAhrVkqyux+JWBP3U+PkgEAZjCxE9pwSHQ
lowBXICNspTo7+6Clu7ANIxW68k2Htj5B4R6IrHAPsaMHGVGoOTjnCYRTfF1Aw4G
5RTomkYv3bOqH4JiHTT1OB9c5zXtuEjHYiJXnVsQS3zClU4ITNQwKmk5Wi+gWL/g
QhkcJwJghZc=
=kYPi
-----END PGP SIGNATURE-----

--/8Xxy37xq6kDVsli--

