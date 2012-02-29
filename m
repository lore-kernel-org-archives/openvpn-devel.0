Date: Wed, 29 Feb 2012 22:59:43 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120229215943.GF7024@...1296...>
References: <4F4CE4FE.3010009@...515...> <7855235.EvfmKnZP6h@...1526...>
	<CAP+U6t+ZUA3UpYfKms0Qr=-Cn1M-GP1EJtGybG0+j+O2xnfv7g@...278...>
	<1404593.Apkr3x9kAi@...1526...>
	<CAP+U6t+-8n=fFk+QP0Dm-H9YijcssjZjOHOpU5pwkSrXt1+qMQ@...278...>
	<20120229154604.GA7024@...1296...>
	<1056463883.20120229194318@...449...>
	<20120229212832.GC7024@...1296...>
	<CAOazyz3t+=2SsDA0+_sqByekvbE7R5Y+qHN2ysGDLw2hsiK8wg@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oYHLzUxHEKq3fcvW"
Content-Disposition: inline
In-Reply-To: <CAOazyz3t+=2SsDA0+_sqByekvbE7R5Y+qHN2ysGDLw2hsiK8wg@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Carsten =?iso-8859-1?Q?Kr=FCger?= <C.Krueger@...448...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--oYHLzUxHEKq3fcvW
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Feb 29, 2012 at 11:36:46PM +0200, Alon Bar-Lev wrote:
> > Scripts are for creative uses that the programmers of openvpn have not
> > foreseen. =A0Like "after the VPN is up, auto-sync all your git reposito=
ries"
> > or "open up a few xterms with ssh's to $internalhosts".
> >
> > David had some other idea recently, which I forgot.
>=20
> This is a great example why this functionality should *MOVE OUT* of
> the openvpn code base.
> The UI can monitor OpenVPN and run scripts when such events are
> detected via the management interface.
> The UI already runs in the context of the interactive user.

But then you still have all the network, crypto and ssl stuff in the=20
privileged process - and the holy cow of security aware programming is=20
"keep the code base that runs privileged as small as possible".

So moving out the (very small) bits that need privileges and leaving
the rest in the runs-as-user code base is achieving the same thing
(scripts run with user privileges) with a much smaller code base for
privileged operations.

But I'm leaving this discussion now.  Heiko is doing the implementation
work, James, David and I have agreed (and told the list via IRC session
minutes!) that we think it's a useful way forward, and this is developing=20
into a bikeshed.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--oYHLzUxHEKq3fcvW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT06fz6kuBuNlUUl1AQKdaAP/akuhH8Zj18D9FN7AIQhrEv6Z01056bC7
UTTtiqZlhj66yE5LWgPqrm8q76pVZq1Q+Kgj8AomyYOFLMRUD2SO576krzzK6Qhv
cT2dzFuh806kqsYEWbpHe3Au4vcBMwBHOw7S0BX6DMTiDfc1tByUpFTrllHJ1y6r
16iCg1ylvI8=
=SAqd
-----END PGP SIGNATURE-----

--oYHLzUxHEKq3fcvW--

