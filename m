Date: Sun, 3 Jun 2018 12:54:57 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180603105457.GO79551@...1296...>
References: <1528020718-12721-1-git-send-email-steffan@...1856...>
 <1528020718-12721-2-git-send-email-steffan@...1856...>
 <20180603104836.GN79551@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dWDJ72qfEa57oDWE"
Content-Disposition: inline
In-Reply-To: <20180603104836.GN79551@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Reject unadvertised compression
 algorithms
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--dWDJ72qfEa57oDWE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi

On Sun, Jun 03, 2018 at 12:48:36PM +0200, Gert Doering wrote:
> On Sun, Jun 03, 2018 at 12:11:57PM +0200, Steffan Karger wrote:
> > A server should not push us compression algorithms we didn't specify.  =
If
> > the server does so anyway, reject the compression algorithm.
>=20
> I can see why you do this, but if I understand this right, this will
> break lots of currently-working OpenVPN setups - where we use the IV_
> variables to parse out "what can the client do?" and send matching
> "compress <foo>" PUSH_REPLYs.
>=20
> So, feature-NAK.

As clarified on IRC, I misread the text.  So I withdraw the feature-NAK
and need to read this more closely and better think through the problem
space.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--dWDJ72qfEa57oDWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbE8kBAAoJEB2Cnv7KVigS4scL/jpxNPUrNcxaAkoNKX1LKXv+
htCoFBcEVqdAI2KTPZT/qItD/pl4s7WxeABIDijwXPyEUOOHj4M/kZTY7gvaYwXH
n14NcADEGhuUGNLy7n+i7CoSjq79O+rYv6k2fSHxr6WqI/YRJ61DSEOqz/BoHSRW
9BV+yyP7kFBJIuwoIJ35EnnuTsBkwHdTcAwCc8/gIrxXJu/qGLvNdUtRGqLbUC+z
mZreBTfCS1xgp6NlF/fTJMNJSCinzYfRnir5g/tchuXgnANjapiyNwdHTidA2o1z
n2QQ3urgyJMX5xyVwK6D1x7KDXzznvLXl+JV2c5yalv5JDAv81mtquQnFWdHXnlf
J5pMqEH4Bz4TLcCTYEfH0Ct5kvlRZmk5C0itiTsI/pvyVZUKGuamUAXNKZVU1q9E
ss1Y8VWjjFn4zyqk0YesX42oXBT0JZwYShqCAxLOF0XgQjTHPrfPmDCAdAUiZ4Ob
307I8jftem1ypHi8RSqap3TNfErwvhG/TiREp/in2g==
=fBX8
-----END PGP SIGNATURE-----

--dWDJ72qfEa57oDWE--

