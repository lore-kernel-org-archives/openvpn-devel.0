Date: Thu, 28 Jun 2018 18:56:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180628165617.GZ57262@...1296...>
References: <DM5PR08MB36429068FCBF60610B6E85CFB94F0@...2422...>
 <20180628065703.GS57262@...1296...>
 <046f2ff7-2340-abd0-7f3a-6a31455b2fc3@...515...>
 <DM5PR08MB36420E57A6907302D18A515FB94F0@...2422...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UC9Pqt0g2dk+bzO1"
Content-Disposition: inline
In-Reply-To: <DM5PR08MB36420E57A6907302D18A515FB94F0@...2422...>
Subject: Re: [Openvpn-devel] OpenVPN GUI, and routes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Morris, Russell" <rmorris@...1315...>
Cc: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>, Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--UC9Pqt0g2dk+bzO1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 28, 2018 at 04:50:41PM +0000, Morris, Russell wrote:
> Thanks for the thoughts - and they do align with my understanding as well=
. But it is failing unfortunately - only if the GUI is run as non-admin. Lo=
g for this case is below, from Windows of course (as it shows). Suggestions?
>=20
> Thu Jun 28 11:46:35 2018 TAP-WIN32 device [OpenVPN] opened: \\.\Global\{7=
D008A8F-BEC3-4196-9CCE-C8970FB55962}.tap
> Thu Jun 28 11:46:36 2018 NETSH: C:\WINDOWS\system32\netsh.exe interface i=
p set address OpenVPN dhcp

This looks like the tap interface has been (manually) set to "static
IP address" - and it seems we can't change it back using the service
yet.

Please change the config of the TAP adapter to "DHCP" and re-try.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--UC9Pqt0g2dk+bzO1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbNRMxAAoJEB2Cnv7KVigShhIMAIJuj1ieVzOOEVmi9jy6L4NY
burhpBqc0IWLZDAYAAXTtoBTDC9b6a7qPMK6JFbrurvfaQISn108gtQKNW4oAQ8y
G6bVvAT05b1bm7eeHoXT2bIf7jA8LFKZNYxQNVTGqLpx/TbdGPFnB6hYrqRyQp4j
VXckBWS1XkPTcW7ZCF55XdQ2hRJ/OS5CtJJgFwWp7ZJzWYR1oMT0baeCdriQlzxn
ieDkNzpKyv31FVL0hseomYisNSjiXLD6I9ULlwOT1RJbdqIgdbj9JWK4O9s0r/pE
DpefrPlKTJpferUbi1cWDDS/DCPl1rNW0BsOnz38TkMDP0XSMalPdm9DVOHWGhWi
2ootcovM+L0vEFBOUeDXF1uEeLAyT2RM7Dd7jhpFARSptHB8CX7GfaUmdT1c4/qw
TyrrxoGDwbov/LAmel4VleYqiWtICQwWxDE4mIBEjvwW22b9UZSwemlbGpU9BDJQ
ZMzbaAue46ZBeOBtSMOmQhKUPoF6syBE0ardYd3q4A==
=Kwqd
-----END PGP SIGNATURE-----

--UC9Pqt0g2dk+bzO1--

