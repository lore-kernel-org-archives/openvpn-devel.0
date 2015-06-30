Date: Tue, 30 Jun 2015 14:02:42 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150630120242.GR382@...1296...>
References: <1435611582-26553-1-git-send-email-steffan@...1856...>
	<55922E18.2060204@...1227...>
	<20150630075727.GO382@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZV3zrNw988WlJQDT"
Content-Disposition: inline
In-Reply-To: <20150630075727.GO382@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Increase control channel packet size
	for faster handshakes
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

--ZV3zrNw988WlJQDT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 30, 2015 at 09:57:27AM +0200, Gert Doering wrote:
> The option is there, the manpage description of the option "fits", we
> just need to make it visible inside ssl.c... :-) - Steffan?

... and while I have the magic wand, another wish .-) - please log a
message what MTU we've decided to use.  We *will* see "it does not work!"
log files and that might help...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ZV3zrNw988WlJQDT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVZKFYqkuBuNlUUl1AQJZHwP7B5AmetegfJJjEODHTRjy16/ZOlcsWQWb
icvgMrCXSGUKho7Uy2Bc3OXnx+i2qAEhgNJKjIGyjAfA1yez2fj4lCP2Xa4Azk6C
dWHwrWTQmrhku+MrN/Vy7sdPHBw0rwNcCB7K7kUOZGcWBShQcxZ6nt1Bx8xAQKyp
Ma/9x9RdcZc=
=jk5k
-----END PGP SIGNATURE-----

--ZV3zrNw988WlJQDT--

