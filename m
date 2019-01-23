Date: Wed, 23 Jan 2019 20:14:05 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20190123191405.GW962@...1296...>
References: <1cfa91c6-2c77-1d82-812b-269c941eba4d@...2489...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fXHnzzUzchrr8Ukn"
Content-Disposition: inline
In-Reply-To: <1cfa91c6-2c77-1d82-812b-269c941eba4d@...2489...>
Subject: Re: [Openvpn-devel] [PATCH] Fix various spelling mistakes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jonathan Tooker <jonathan@...2489...>
Cc: openvpn-devel@lists.sourceforge.net

--fXHnzzUzchrr8Ukn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jan 22, 2019 at 09:31:03PM -0600, Jonathan Tooker wrote:
> Fork @ github: https://github.com/JDTX/openvpn (76ab12606155f51aaaf376a46=
f4a52a459af105c)
>=20
> From: Jonathan Tooker <jonathan@...2489...>
> Date: Tue, 22 Jan 2019 18:27:39 -0600
> Subject: [PATCH] Fix various spelling mistakes
>=20
> Fix spelling mistakes in code/headers/manpages/etc.

While I'm always happy to receive spelling/documentation fixes, *this*
patch got mangled by your mail client and git refuses to apply it - your
mail client removed leading blanks in *some* lines, so pieces like this:

> diff --git a/distro/rpm/openvpn.init.d.suse b/distro/rpm/openvpn.init.d.s=
use
> index 270024e8..1b4bcf06 100644
> --- a/distro/rpm/openvpn.init.d.suse
> +++ b/distro/rpm/openvpn.init.d.suse
> @@ -72,7 +72,7 @@
> #                            - removed sourcing "network"
> #                            - removed network checking. it seemed not to=
 work with SuSE.
> #                            - added sourcing "rc.status", comments and "=
rc_reset" command
> -#                            - removed "succes; echo" and "failure; echo=
" lines
> +#                           - removed "success; echo" and "failure; echo=
" lines

... are no longer a valid patch.

Can you please re-send with "git send-email", which normally gets things
right even though everything out there is intent on massacring mails=20
these days?

thanks,

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--fXHnzzUzchrr8Ukn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcSLz9AAoJEB2Cnv7KVigS53IMAKqjkt9e98B17vxXWf7j119t
IvxAAmFMMnombbS8UEN37BaA/ZBrbsjA5NuFSLr5zaqTLP5q9nlT655EGDBMsPUi
yXFdIVibHXFu6yDs0pbCrG/eBuEGkRh1E7CX4m1k46EVDb1RUX/ByI+iXBq9E4V3
FWGryvmnM7SXGpqSXjNrzFaUIscaxCmOCeMTidGfRiEd73ieXY1ESq6PDr0lSxc9
dKCMSVIo2qmOEb9yrdv6qWbIRbS2XB7aiQsFlNiLvSoqWhqInr89+5J2cOg5ZNgB
7Njr3Po92VRoAKmrY2JBUXfTAFW9CUgdjuWZoM/VdEOGLStTu8vRtQFTNAs0diHu
Cz3O69BTP1yVpfP1KfF5CI3ceoZ2v1WAa+JR3eWIgVk0PAaXSkrZWoBAj7OnIwSi
JdSWjCo2JDIyzlXhZiBpkZ4Np0e1G98+Osf6S1B3J0qeaduO20BDrF1Ck9+lVVcR
Fb2dJ1V6nMPrs8XYroCXmWiVkz882G17aLkZjoRPXA==
=9dd6
-----END PGP SIGNATURE-----

--fXHnzzUzchrr8Ukn--

