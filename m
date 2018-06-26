Date: Tue, 26 Jun 2018 21:15:11 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180626191511.GI57262@...1296...>
References: <42bafab6-9e6f-56b5-2c44-b449ec503ce7@...515...>
 <20180611075242.GF57262@...1296...>
 <bb55cab5-2523-b899-0ead-6f34886c4d2b@...515...>
 <DM5PR2101MB1112279487CBA7B6DE9A3ABDB0710@...2412...>
 <20180618205610.GI57262@...1296...>
 <20180618205916.GJ57262@...1296...>
 <DM5PR2101MB11120F3A5F61835EE906C481B0710@...2412...>
 <f7cffd19-6db7-a622-3268-fbb198531387@...515...>
 <DM5PR2101MB1112A510BA8E7FCE6FA1166FB0760@...2412...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mjW8NYtUK+J8SUBS"
Content-Disposition: inline
In-Reply-To: <DM5PR2101MB1112A510BA8E7FCE6FA1166FB0760@...2412...>
Subject: Re: [Openvpn-devel] Regarding tap-windows6 driver signatures and
 driver distribution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jon Kunkee <jkunkee@...2393...>
Cc: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>, Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--mjW8NYtUK+J8SUBS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

as a quick note - sorry, we won't make "June 27" as release date for
the new tap driver.  The Windows HLK tests for Server 2016 are somewhat
"demanding" from what I hear from Samuli (you need to have a larger=20
setup than "just the machine with the driver", it actually wants to
talk through the driver to "things" - which need to be provisioned,=20
etc.).

We tentatively plan for "one more week" now, which would be July 4th.

Jon, do you have experience with the HLK test suite and could help
explain some of the test failures ("what does the system expect to
find here?") - what's remaining does not seem to be "driver" related
but "things the tests expect to see in the network behind that driver"...

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--mjW8NYtUK+J8SUBS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbMpC+AAoJEB2Cnv7KVigS/ZAL/0PxbAs9LLYRILNjgU2rDJyI
STYSTDD3ce88kBRoonQ6ThFHF9KYoGCb2V48M8sbhMPxv8p26/D/RgbDz/bmYHlX
icW3VSWpEbPRRRgXyJioxCkEMBN7oYJEnDoIqjO2bFeWbNZXu3vIjO8nUzDdMYDC
blVy7HrJ56lDlWyWATyajbv+b7N/ykjc5mOX91Lo5lFgiARfR+snS6e9RZWMpcK0
7T3lEh5N2XOCCXFI7wiMXxDx+NRs2ai9a7vzqUyrmS60iuVTcfoYYmi89ARuYRmE
0O1/pLkyZAyW+8dPJmnj2mygWlx05VYSY8aQHHDsm5xb4tF7YTbrKOvjoYBY2Ecl
3EpU9Fl2U2a99F5EG1Tt9N3sdc/J+mIrvbEa8dVOBo2pI3QEXga7nP0ZGslA8V6p
CAWni2fqcmn2lIJ+aZoBZgvU26On5ti/fuUC83PLms7YzNRR0+cjRvGxjJvznATQ
1Ti9B6dQXmisbPA4P19fkY3vN9VRyK9uUuEctwlKIA==
=moVO
-----END PGP SIGNATURE-----

--mjW8NYtUK+J8SUBS--

