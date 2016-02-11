Date: Thu, 11 Feb 2016 19:38:55 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160211183855.GN24952@...1296...>
References: <56B86D5C.5070506@...515...> <56BCB9ED.7050802@...515...>
	<CAKuzo_jrxEp9cASNQ3LO0bcKm3qfraTHL80EeC5dNcoiN++w+g@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PdvXm2VuwMZ2GHtP"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jrxEp9cASNQ3LO0bcKm3qfraTHL80EeC5dNcoiN++w+g@...278...>
Subject: Re: [Openvpn-devel] OpenVPN installers with openvpn-gui pull
 request #13's code included
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--PdvXm2VuwMZ2GHtP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 11, 2016 at 01:14:05PM -0500, Selva Nair wrote:
> (ii) openvpnserv.exe --start interactive
>=20
> Do not start the automatic service by default as that is meant for expert
> users. Else it will spawn-up openvpn.exe for all configs found and possib=
ly
> mess-up with interactive use.

Right.

Maybe even change the "openvpnvsrv.exe --install" command to require
"--install interactive / --install automatic" and even *install* only
the iservice by default.

> > Given that OpenVPNService and OpenVPNServiceInteractive have been
> > separated, replacing the non-interactive variant with openvpnserv2
> > should not be too difficult.
>=20
> While the two services can be independently stopped and started the two a=
re
> installed and removed together:
> openvpnserv.exe --install sets up two
> services OpenVPNService and OpenVPNServiceInteractive. So any replacement
> will have to use a name distinct from those. I think openvpnserv2 uses the
> same name "OpenVPNService" which will cause a conflict.
>=20
> In the long run it may be better to remove the automatic service complete=
ly
> from the openvpnsev.exe code.

I'm not going to disagree, but this should happen somewhat coordinated with
inclusion of openvpnserv2 in the installers & "an appropriate" git repo.

thanks,

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--PdvXm2VuwMZ2GHtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVrzVPqkuBuNlUUl1AQK9AAP/d+aHKMxb6PMgXdS2SdbQLo0CWkbZAXQJ
oDibFzkJsqVyEGRkLZEBclP7Ps/xaN73CKiKxj8A826jBd3KGiVjae0VKU/XNwUL
lWotqvm6hR/1oF7/mDbJ84K8l7voJOW1ZcE2nCujnn7O9AkUuF3Rla2MrioaMuZ+
uc+XIX4LDac=
=osUB
-----END PGP SIGNATURE-----

--PdvXm2VuwMZ2GHtP--

