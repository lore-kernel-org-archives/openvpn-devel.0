Date: Mon, 7 Nov 2016 19:26:48 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161107182648.GW28918@...1296...>
References: <915ececd-c052-01b7-6051-74b3bc87b5fb@...515...>
	<CAFHpkQHU-AO88yQBuxpV9yWGYAsaMjkPX6_cramD4fHP5PtSBg@...278...>
	<992ac0c7-1938-1f18-3b85-67d39c114c75@...515...>
	<CAFHpkQFD4W=Mk1VMQXvGtJa2RwjOasDxZ7=ibmE9+d2gEHz-_w@...278...>
	<d76496aa-07f1-0819-35fc-96c9416858a5@...515...>
	<CAFHpkQELZELZC+OJF6BtciQEWkbTJcuCQE66PJr=o-ELm8uCKg@...278...>
	<bd61206b-bdf7-3585-53ed-bc6ea1667add@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iGS4/Q/M16VRPju2"
Content-Disposition: inline
In-Reply-To: <bd61206b-bdf7-3585-53ed-bc6ea1667add@...515...>
Subject: Re: [Openvpn-devel] Topics for the upcoming (Monday,
 7th Nov 2016) community meeting
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

--iGS4/Q/M16VRPju2
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 07, 2016 at 07:32:05PM +0200, Samuli Sepp=E4nen wrote:
> Il 07/11/2016 19:16, ???????? ?????????????? ha scritto:
> > the automatic update functionality is definetily missing for windows pa=
rt.
> > I'll try chocolatey for that.
>=20
> Yeah. The last time I checked (~year ago) setting up Chocolatey repos=20
> was a bit painful. The "normal" way to setup a repository was to use=20
> some horrible Visual Studio kludge integrated with IIS. There were, at=20
> that time, other options for settin up repositories on *NIX, but I did=20
> not have time to look into them in any detail.

You could use "wpkg" instead - also a bit annoying for the initial=20
setup (and you can't use arbitrary internet sources, I think, but need
to use a smb:// path for config + sources) - but afterwards it's quite
nice.  The master host has rules which client gets what package, and
clients check at bootup "is there anything I need?" and go fetch recipes
to then "do stuff".

http://wpkg.org/

No special tools needed, just a bunch of XML files residing on the
network share (which could be a unix system) and an agent installed on=20
the windows clients.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--iGS4/Q/M16VRPju2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWCDHaKkuBuNlUUl1AQJkNwQAuCIcB2KL+qggfUqiWt/h4p//aDD5yVdB
oAuW/9c3kp0IBmm9uPBfxnP4gYCXs/fHCSQsLpCnFagSNrVnPbWuHdwLe13lf/W3
XOE5Z7IkM6/ogxRroOcVidjQvGAuC2iU9UQoxSQ73+W5vNAYMAQFI8N9LBKQ/fMi
+8fWI+3pIPY=
=97Vw
-----END PGP SIGNATURE-----

--iGS4/Q/M16VRPju2--

