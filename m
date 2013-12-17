Date: Tue, 17 Dec 2013 14:02:06 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131217130205.GX161@...1296...>
References: <1387279299-24755-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IujVAVPDoVCfvhfJ"
Content-Disposition: inline
In-Reply-To: <1387279299-24755-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Implement an easy parsable log output
	that allows access to flags of the log message
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

--IujVAVPDoVCfvhfJ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 17, 2013 at 12:21:39PM +0100, Arne Schwabe wrote:
> @@ -2273,6 +2273,12 @@ otherwise would be prepended. In particular, this =
applies to
>  log messages sent to stdout.
>  .\"*********************************************************
>  .TP
> +.B \-\-machine-readable-output
> +Always write timestamps and message flags to log messages, even when they
> +otherwise would not be prefixed. In particular, this applies to
> +log messages sent to stdout.
> +.\"*********************************************************
> +.TP

I'm fine with it, but I'd like a bit more review by others - is this
good enough?  Does it cover all corner cases?

It certainly looks nice on the "OpenVPN for Android" App if you can use
the slider to increase/decrease the log level for an already-happened
openvpn connection, in real time :-)

gert=20

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--IujVAVPDoVCfvhfJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUrBLTakuBuNlUUl1AQKSEAP/fOYcRaPUwAXqCgqM4uLOoHHoTLAoKD1S
durPg43ep40U1MzjYukUqWmP4k85MVRjdcf6BOR0NeoelIDBwGHzAn1fd8pCvhar
azqWuocjTQn4pzgQ0J/U11qnI2Kzb1CzXe1fxOw6moGdixsoqbcrClwKFAkTjyqk
2SnLRSMwYtA=
=WMoh
-----END PGP SIGNATURE-----

--IujVAVPDoVCfvhfJ--

