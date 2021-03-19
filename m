Date: Fri, 19 Mar 2021 18:30:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210319173004.GU976@...1296...>
References: <AM0PR04MB53311DBD4346F75A380F7198B1689@...2601...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fQYdLxWgTe9KToWp"
Content-Disposition: inline
In-Reply-To: <AM0PR04MB53311DBD4346F75A380F7198B1689@...2601...>
Subject: Re: [Openvpn-devel] [Patch] Wipe Socks5 credentials after use
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Maximilian Fillinger <maximilian.fillinger@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--fQYdLxWgTe9KToWp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 19, 2021 at 04:45:18PM +0000, Maximilian Fillinger via Openvpn-=
devel wrote:
[..]

The patch itself is OK (I think), but actually applying it will mess up the
Author: information in git, because you are sending from a domain that
has DMARC p=3Dreject.  So mailman is massacring your From: line into this

From: Maximilian Fillinger via Openvpn-devel <openvpn-devel@...1768...=
ge.net>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20

... and this is what will be the Author of the commit.

Can you send this from an account that is not set up to intentionally
harm mailing lists?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--fQYdLxWgTe9KToWp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgVN+bAAoJEB2Cnv7KVigSiW0L/izuJVdJcfAv2MhOv8YOcfFh
P/H62z0ZKJpmNsKCdtGQnxsa9zqgszQ/luTOPh5UiQMcbaouObFSXB8nvwdkPOUt
rEN4MCi/o2yMTqBf3OFj01Dy42Ofw8331wASeohhYoGmCLHO+VWMRxOiZxGR3oaD
+etl3GmiUnm4NAU9cmkiRZyjtSgt5IwU3CtD+xq5vm4ddLaoy4RZPktEEk+859GB
oEPzCmGpgRwsKNZlZ0kydduBrMSz7o/t+vTLLM2errhd3Zj0OopQJJYx2qmrScYh
9vuQbWwUcdc846zgH8Jp0UkzDN8caaRWmuRMTXHQQ9JemRsQ4kU0To4sr0bALFE/
sJLjkDd91EbM9dDYDRDSIsq8ZybYpOwKD3qGJOVzvyIo5KZa8ZO1AmAglQb65CWf
o9sd2lHWyCR1H6DYtkk3s3LPjcwEQ2um1cMnjPAHNgJOtuUQtKMKDRN2E4nIkPIf
TTO/EJqySOZjHNWI897Yv9s6t0ZGxggFBJt1EznWrQ==
=4rNH
-----END PGP SIGNATURE-----

--fQYdLxWgTe9KToWp--

