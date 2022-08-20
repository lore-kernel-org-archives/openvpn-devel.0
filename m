Date: Sat, 20 Aug 2022 23:07:00 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YwFM9NwntsRr5+F/@greenie.muc.de>
References: <20220810153006.18860-1-maximilian.fillinger@...2507...>
 <202208191704.27JH4qSZ095097@...2054...>
 <YwFL9rEyCr+RfaaV@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LpeQ1tZz3we3L5JI"
Content-Disposition: inline
In-Reply-To: <YwFL9rEyCr+RfaaV@...1296...>
Subject: Re: [Openvpn-devel] Followup work on "Don't undo ifconfig on exit
 if it wasn't done"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--LpeQ1tZz3we3L5JI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Sat, Aug 20, 2022 at 11:02:46PM +0200, Gert Doering wrote:
> I did lots of testing on FreeBSD today, and it turns out that the
> generic "undo" code is just a mess and clutters the log with garbage...
>=20
> 2022-08-20 22:58:02 /sbin/ifconfig tun4 0.0.0.0
> ifconfig: ioctl (SIOCAIFADDR): Destination address required

... interesting enough, on *tap* interfaces, OpenVPN can do that...

2022-08-20 23:05:34 /sbin/ifconfig tap0 0.0.0.0
ifconfig: WARNING: setting interface address without mask is deprecated,
default mask may not be correct.

... but the kernel logs a warning...

Aug 20 23:05:34 fbsd14 kernel: tap0: set address: WARNING: network mask sho=
uld be specified; using historical default

*shake head*

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--LpeQ1tZz3we3L5JI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjAUzzAAoJEB2Cnv7KVigSwZwL/j5fpnftdPa8ohUDzqjOjBvy
TMN2Kl69WfX0UA9yGlKfoeNEzOoSKUMcoXZmcVY9Lmcf38rfTxHdTHi4N6Tfa46d
LpxWeShs/6jW3Ng2mO3CKEZnUnIWQx24C/MHSGJ5vAzgamE61UzuayXlu0iHjVyJ
p8a0s9SUr+I/JIFiDccAXCiy7YQDPe9anSU8sVuD6zAtYYSYcMSvl2JgaJHHMw8z
ZbC+qMKaml5qefneYAuBlixLKwg6r726y8XaiZgdd2AE//zYxBk7vJ2JkRGTCjib
2w9Vg5K4+q1GQRySG3mHxsXphf0CbPAa9TXTEF1IoAMugukW7Rw6u662WL0l+gTo
GdQJaaBfstD1qeL7i+z8wNvnCIj/GVv+iFv9NEc/LxYWIqGsTszFjHgg66HZX9Zv
8enNOrANSxlYlNtLz7ep7/HRR9ohXS79r9xEIAMi+tnTIgTHQXHT8uAup64ZU9cp
2SaUDevtSnTgQ4XIuu3g5D2WTCAOJJSdWy28nrHchQ==
=5VrH
-----END PGP SIGNATURE-----

--LpeQ1tZz3we3L5JI--

