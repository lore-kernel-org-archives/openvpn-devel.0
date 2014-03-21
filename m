Date: Fri, 21 Mar 2014 19:51:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140321185104.GU16637@...1296...>
References: <1387279299-24755-1-git-send-email-arne@...1227...>
	<20131217130205.GX161@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Tp5pVI73MC2cHD9F"
Content-Disposition: inline
In-Reply-To: <20131217130205.GX161@...1296...>
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

--Tp5pVI73MC2cHD9F
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Dec 17, 2013 at 02:02:06PM +0100, Gert Doering wrote:
> On Tue, Dec 17, 2013 at 12:21:39PM +0100, Arne Schwabe wrote:
> > @@ -2273,6 +2273,12 @@ otherwise would be prepended. In particular, thi=
s applies to
> >  log messages sent to stdout.
> >  .\"*********************************************************
> >  .TP
> > +.B \-\-machine-readable-output
> > +Always write timestamps and message flags to log messages, even when t=
hey
> > +otherwise would not be prefixed. In particular, this applies to
> > +log messages sent to stdout.
> > +.\"*********************************************************
> > +.TP
>=20
> I'm fine with it, but I'd like a bit more review by others - is this
> good enough?  Does it cover all corner cases?
>=20
> It certainly looks nice on the "OpenVPN for Android" App if you can use
> the slider to increase/decrease the log level for an already-happened
> openvpn connection, in real time :-)

Just FTR, as nobody has complained about this, I'm ACKing it now and
merging it.

We *could* use a bit more of your attention in reviewing code, not only
in lengthy what-if discussions... :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Tp5pVI73MC2cHD9F
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUyyKGKkuBuNlUUl1AQIJ6gP9F0q0qRCLODTctIpGp7XscqSMiahsornY
hLcbZqm+9O2+8L0Hwhh30iT0xqgPECDIT52IFbN3Y/ogAnirKrYMPSaNvTF56nJ0
NvoSVQzTCs43U+I0ABD5BHjZHLuqCQTwVyqDtl2eqcS+wMeUDq/fJrOe0vFCQE1t
JG5ikDjXs4w=
=eyuX
-----END PGP SIGNATURE-----

--Tp5pVI73MC2cHD9F--

