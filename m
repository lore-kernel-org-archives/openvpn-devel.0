Date: Sat, 29 Jun 2019 20:29:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190629182952.GW1097@...1296...>
References: <CAKuzo_j6F2+_JxosdVF3iB4kzWsR7Wq2FT8Vgi9Cg3yvT_A1JQ@...278...>
 <20190628210334.GU1097@...1296...>
 <CAKuzo_ji9qNyc1vtQRhuuuYXgmpb6Qey2+L7GRqbhLNqbSwx9A@...278...>
 <20190629095732.GV1097@...1296...>
 <CAGyAFMVxD3+jZ+RR_U-x46Z89DV-feqyXcV599=SaogW-0Qgsw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Lz6jMTqI3BNRrqA1"
Content-Disposition: inline
In-Reply-To: <CAGyAFMVxD3+jZ+RR_U-x46Z89DV-feqyXcV599=SaogW-0Qgsw@...278...>
Subject: Re: [Openvpn-devel] Using AllowNonAdmin in the advanced options of
 tap adapter
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Lz6jMTqI3BNRrqA1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 29, 2019 at 05:34:51PM +0300, Lev Stipakov wrote:
> Indeed that registry key is confusing. If we fix it in tap6, won't we bre=
ak
> existing setups, which open tap6
> from unprivileged process and do not use --allow-nonadmin?

Well, the default on installation would either have to be "as before"
(allow unprivileged access) or the installer would ask...

And of course this would need to be pointed out very clearly in the
tap6 release notes - for OpenVPN "we would now" but other users of
tap6 might be caught by surprise.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Lz6jMTqI3BNRrqA1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdF64gAAoJEB2Cnv7KVigSFXoMAJIyxNEsDZ+rHlf5RP+Yb+bt
x96AKnJsxFvHRej11K+7SZzTWVNc+2qRMQ+jZUzT48NT2jP9NG7oYqKMRUCOr92M
9sgxnV0qwUuBuPcOVAeLyb2dmJqyXBzHNHdOV5GY79bhzjQj0W3cuPk8OKaLPUzf
IhyjguozISmDwVRo7eZs+VlTKDopFzB9gEJYwSfXOruGh3tps9OEupEHjPMW7k1D
lY977ySOuWk0NqDxtFwIFRT2gi/n95gDXkLKLo1zsOm8V3ntcfWlGlYfbjmL1ZMm
KGAKV8aWIlXF9dK61wT/cAR+ZLD5udB/n1JVzNY1CElVw82ndZQdLLDmlLSY8ggG
5/YCFZaGjyG7PSJ6hm6rF1x8utGEQb7Ou6SE3hcFepM7hN3bdE9Ut6/Bsux6pGfI
XKQuU2HYEgaYrGGr1180TgIw/xUquXlvKjJvS98F1HKq2Y/UKYal12GRTLR9SmmW
x0upft3cAd5F2yzeSsBq+jGqS5b/DkWZ0RKX4VB19g==
=dwDh
-----END PGP SIGNATURE-----

--Lz6jMTqI3BNRrqA1--

