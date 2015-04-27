Date: Mon, 27 Apr 2015 20:25:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150427182539.GS382@...1296...>
References: <1430144937-4149-1-git-send-email-steffan@...1856...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m9FEOsnejx470nED"
Content-Disposition: inline
In-Reply-To: <1430144937-4149-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Call daemon() before initializing
	crypto library
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--m9FEOsnejx470nED
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Apr 27, 2015 at 04:28:57PM +0200, Steffan Karger wrote:
> But keep the chdir to / at the place where deamon() was before, to preser=
ve
> the current behaviour wrt relative paths in the config.
>=20
> This should fix the issue reported in trac #480, without changing the
> behaviour visible to the end user.
>=20
> Note that by moving the daemon() call to an earlier stage of the init
> process, we no longer have to call platform_mlockall() again, or do a
> pkcs11_forkFixup().

I think this is good, so both feature-ACK and code-ACK from me
(after staring at the patch and the doxygen generated call graphs
for nearly an hour... whee is this a twisty maze of passages, all
alike...).

The overamazing thing is that this actually makes the code *more easy*
in a number of places :-)

I'd still like to hear feedback from the reporter on #480 if it
actually solves their issue (though I'm confident it does).

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--m9FEOsnejx470nED
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVT5/IqkuBuNlUUl1AQL/xQP/exYnvCNr61BNBkyfkwXyeIDNqnCGSbfE
hhGbuELPOXVh6JsA2riDyHEG2dHJeJZWpXBSw+gRYc8Sy+otBhgbw8QvfhmX7VFV
1wC08yLHQkH4HvYWeFYmDxM+QvOYRfNzyaz2K7drjxKpTqAKIHDXkQJ+URVaANIE
TKLhU7UXlWw=
=HMkO
-----END PGP SIGNATURE-----

--m9FEOsnejx470nED--

