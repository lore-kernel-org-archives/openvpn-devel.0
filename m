Date: Fri, 14 Mar 2014 10:30:55 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140314093055.GM16637@...1296...>
References: <5322C73E.3070602@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Tfg/QR/ZFKX/Snp+"
Content-Disposition: inline
In-Reply-To: <5322C73E.3070602@...515...>
Subject: Re: [Openvpn-devel] Tap-windows NDIS 6 driver now on GitHub
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Tfg/QR/ZFKX/Snp+
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 14, 2014 at 11:09:18AM +0200, Samuli Sepp=E4nen wrote:
> The NDIS 6 version of the tap-windows driver is now available in source
> code form:
>=20
> <https://github.com/OpenVPN/tap-windows6>

Cool!

> The license is the same as that of the old driver (GPLv2). I will
> integrate this new driver with experimental OpenVPN 2.3.2 installers
> soon. The plan is to maintain both NDIS 5 and NDIS 6 drivers for a
> while, because Windows XP lacks NDIS 6 support.

Yeah, that's a good plan.  Give non-XP users the choice what they want,
defaulting to NDIS 6 :-) - and then gather feedback.  Or so...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Tfg/QR/ZFKX/Snp+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUyLMT6kuBuNlUUl1AQLG3gP+I05bpSFgpAbEPyzLqWA/0t9rTnCIMic+
fixE4yaq2AnMrEUQEQuggGINMNMNn09rSe5RtNFGcqLXWPhhkEQy/ICsMYauSUFh
LYYNSp5RQOCJxrdy3NT3PGalEtqMvfK01J1BClhwQVe75MiKG6QMRG9o59tyG4Jp
P8hDCJGUrPE=
=aomZ
-----END PGP SIGNATURE-----

--Tfg/QR/ZFKX/Snp+--

