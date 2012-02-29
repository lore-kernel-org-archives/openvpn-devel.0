Date: Wed, 29 Feb 2012 22:28:32 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120229212832.GC7024@...1296...>
References: <4F4CE4FE.3010009@...515...> <7855235.EvfmKnZP6h@...1526...>
	<CAP+U6t+ZUA3UpYfKms0Qr=-Cn1M-GP1EJtGybG0+j+O2xnfv7g@...278...>
	<1404593.Apkr3x9kAi@...1526...>
	<CAP+U6t+-8n=fFk+QP0Dm-H9YijcssjZjOHOpU5pwkSrXt1+qMQ@...278...>
	<20120229154604.GA7024@...1296...>
	<1056463883.20120229194318@...449...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtBqmokgY1evbO3C"
Content-Disposition: inline
In-Reply-To: <1056463883.20120229194318@...449...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Carsten =?iso-8859-1?Q?Kr=FCger?= <C.Krueger@...448...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--vtBqmokgY1evbO3C
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Feb 29, 2012 at 07:43:18PM +0100, Carsten Kr=FCger wrote:
> > Part of the assumption here is "the user controls the openvpn config",
> > and as such, he can make openvpn.exe run arbitrary scripts anyway - and
> > to stop this from being a problem, just run openvpn.exe with your uid.
>=20
> What operation could be in script that is usefull when it's executed
> in user context.
>=20
> I never used script with openvpn. I've no idea which are real world
> applications for it.

Scripts are for creative uses that the programmers of openvpn have not
foreseen.  Like "after the VPN is up, auto-sync all your git repositories"
or "open up a few xterms with ssh's to $internalhosts".

David had some other idea recently, which I forgot.

I use scripts for routing table changes on the OpenVPN *server* side
(dynamic "route" behaviour).  But that's a bad example because it wouldn't
work in the "openvpn and all its script childs are not privileged".

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--vtBqmokgY1evbO3C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT06YgKkuBuNlUUl1AQJpKQP/Rhc9JE2scSrw6bJSkYVuFIYGq1b0sG9l
e9ju6TivqQ1zzfa+1LIhCwMglcTyGah9Erc1ZpUtMm408mm9+eg36u++ZStxhcvQ
8sG8u98mqwKSUXZFUIds5xMpk8su8rDFO1Qdkqox5mfzfgN0AhFMKxC2SxTj6Pda
0kvL14kRXNI=
=OO4G
-----END PGP SIGNATURE-----

--vtBqmokgY1evbO3C--

