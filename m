Date: Sun, 27 Apr 2014 22:11:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140427201132.GK16637@...1296...>
References: <20140426210044.GF16637@...1296...>
	<535CD403.6040603@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K58F4s3/rVH+eL1A"
Content-Disposition: inline
In-Reply-To: <535CD403.6040603@...1227...>
Subject: Re: [Openvpn-devel] socket.c issues when building snapshots on
	windows...
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

--K58F4s3/rVH+eL1A
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 27, 2014 at 11:55:15AM +0200, Arne Schwabe wrote:
> The option seems to be supported since Windows Vista. I think we should=20
> add something like this to the windows ifdefs (copied from=20
> http://marc.info/?l=3Dapr-dev&m=3D121392734329754&w=3D2):
>=20
> +/* Ugly solution - only the Windows 2008 SDK or later have this symbol=20
> defined.
> + * The symbol doesn't guarantee that the socket option is supported on
> + * the runtime version of Windows, so we define it here (for build=20
> systems)
> + * and always check at runtime if it is supported.
> + */
> +#ifndef IPV6_V6ONLY
> +#define IPV6_V6ONLY 27
> +#endif

That's an interesting twist.  I wonder why MinGW does not have it
(or maybe my MinGW installation is too old).

And then we'll see whether it will blow up at run-time on XP or not -
having setsockopt() return an error is something our code will handle
("report, go on"), but on Windows, I wouldn't be surprised to see=20
"it fails with OS error" translate to "crash"...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--K58F4s3/rVH+eL1A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU11kdKkuBuNlUUl1AQJjggQAo9DYFhX6I1LK5fToinaekRXFJyRs5bKK
9fRPBrdG2FNb55WqRw36P+4C9LNtduw7RgcaYeWWx7uXFwqcmZYwo5n509OUaaIT
Y4BW42FyIBZ7ioBGOCcnM2FKOqVbaOgj/OEpVF/a3GnKEWXiuHBGtATF/y2Dfb/H
csp3W0rt5fE=
=zHzD
-----END PGP SIGNATURE-----

--K58F4s3/rVH+eL1A--

