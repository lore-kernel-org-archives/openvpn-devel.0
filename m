Date: Thu, 7 Sep 2017 15:07:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170907130754.GK70062@...1296...>
References: <20170906235202.26551-1-davids@...515...>
 <20170907061646.GD70062@...1296...>
 <79762b44-c8c8-b765-1711-22ba3f210af0@...515...>
 <1e1b1ed5-5a4e-5234-1e57-06a609a6f2b9@...515...>
 <20170907081340.GG70062@...1296...>
 <e9b6e95e-7a98-23a1-e6cd-4d250a6cee05@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ylUvUtShPtQAJVVd"
Content-Disposition: inline
In-Reply-To: <e9b6e95e-7a98-23a1-e6cd-4d250a6cee05@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Gert Doering <gert@...1296...>, Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>, David Sommerseth <davids@...515...>

--ylUvUtShPtQAJVVd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 07, 2017 at 03:02:20PM +0200, David Sommerseth wrote:
> > Which is not what I hoped for... "turn it off and leave it so" is non
> > helpful (it might be a transient error preventing the startup).
>=20
> I'm confused.  What is it you want?
>=20
> * try restarting in an endless loop?
> * try restarting X times and then stop trying?

"exponential decay"

Restart a few times quickly, and then slow down, like "re-try after 1s, 3s,
5s, 10s, 15s, 30s, 60s, ... and then stick to every-5-minutes" or so
(like OpenVPN's own connection re-try logic :-) ).=20=20=20

That way you get quick restart if a temporary failure happens, and avoid=20
filling logs with useless crap if the error persists - like "bind to an
IP address that is not present in the system, because the ppp0 interface
where it would show up is down", or something like this.

But if that cannot be done, that's how it is - and in that case, "stop
trying" is not what I want.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ylUvUtShPtQAJVVd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZsUSpAAoJEB2Cnv7KVigSNM0L/3thd+INKTGT4Txat0mRTVph
t3x1Y6kXq+vyPKmtEnavX09RMsDajCmuWZixCGR217AJQIipjLHvgFzUe4PObMbS
1NcWTwdkcqUq4GctttPQVAKwoOGihlAQHX4dp8vz5/A/s2mI8rdNRD+/xxxU5dI+
NoKEgm/B+xJPAdHra6rNABldx0+WTKVLn4ftqt1WKnpbutCw/Eb6CjpSFioflW6x
PMOGFDwgrJGH4HMw9bdNWj4e/KO1ZNRDjHjdujRGK9SXlu3+GpFrj+KWQB5ZmCd3
MQ5aem1z3czc1dcfgEDqfaTXYlbKcxJJZxRLwCQ66KdoNTQ+UXL0PmFDcBxIzUns
Tgvpl9rij8hNHyP/Xgrr1Rg0fF6ANTgh9Z/q32slJ31GoXcul8QQvhZ5+9feNz5u
NrUsWckbpTIZwbZ4E4eBJowZMXefCnoUoZzzPMY34V+pTUaJivFCf78FaRMts6ob
eYmgOwD2Xb32NN3T+/l1tq0wBdNmGSnFlxRq5bhdTg==
=djOM
-----END PGP SIGNATURE-----

--ylUvUtShPtQAJVVd--

