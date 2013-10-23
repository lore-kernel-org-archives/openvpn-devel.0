Date: Wed, 23 Oct 2013 12:56:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20131023105634.GM161@...1296...>
References: <OF80C424FD.27405071-ONC1257C07.004692C7-C1257C07.004BC866@...1846...>
	<20131017141929.GC161@...1296...>
	<OF103608A1.B8847B78-ONC1257C0B.002E1D46-C1257C0B.002F1965@...1846...>
	<20131022114017.GD161@...1296...>
	<OFBB1A3798.4E8F6223-ONC1257C0C.00463442-C1257C0C.0048EC64@...1846...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+9uAEI//NVSmpZEF"
Content-Disposition: inline
In-Reply-To: <OFBB1A3798.4E8F6223-ONC1257C0C.00463442-C1257C0C.0048EC64@...1846...>
Subject: Re: [Openvpn-devel] Openvpn 2.3.2 potential memory-leak after
	24hours (addendum3)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: arno.odermatt@...1845...
Cc: openvpn-devel@lists.sourceforge.net

--+9uAEI//NVSmpZEF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 22, 2013 at 03:16:30PM +0200, arno.odermatt@...1845... wrote:
> thank you so much.
> Meanwhile, we can define the substantial memory growth for the phase of=20
> the first renegotiation cycle.
> Memory is growing by almost double.
> Surely, if one had only 50 to 100 concurrent sessions, it is not quit=20
> hurting anything. But driving the amount of concurrent session as we got=
=20
> it in our scenario, memory treatment seems to become key.

I'm not sure I found everything yet, but what I've seen to far will
definitely raise memory consumption for long-term connected clients
(as in: for every renegotiation, memory goes up).  This particular gc=20
is cleared upon client disconnection, thogh - so maybe that is why it
wasn't noticed earlier.

About your user base: is this more dynamic clients (like "mobile users"),
or are these very persistent long-term sessions (like "1000s of sensors
that come online upon reboot, and stay online for weeks at a time")?

I'd like to understand your usage scenaro better to see whether what I'm=20
tracking can be relevant at all, or not.


(As an extra question: if I find something and have tested it enough to
say "this should fix things for you", can you run a test version in=20
your environment?  Or is this all production and needs to come in form
of a binary distribution, etc.?)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--+9uAEI//NVSmpZEF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUmerYqkuBuNlUUl1AQKdfgP/elWgFMF1msctlOm2t+6IGzNWpNdB7PRj
HQ3LLZJeeRq2bG6KtQbX7epKbtAEqRomcCi/z7gcJO4oer9XeGAl3GlfV0mtf3z0
RVpHJxh3W/QNN0/2XTyMG6L7WffW7Ej7/x/bPXjgjIwxWRKKY33ZeJAjPIUgZvbE
pIhbELsPkn0=
=3zv2
-----END PGP SIGNATURE-----

--+9uAEI//NVSmpZEF--

