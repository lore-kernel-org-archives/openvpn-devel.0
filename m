Date: Wed, 27 Apr 2016 20:14:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160427181433.GZ53051@...1296...>
References: <1451931741-4126-1-git-send-email-samuli@...515...>
	<572092B5.8090908@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6s/G0Ait2f6IH9MX"
Content-Disposition: inline
In-Reply-To: <572092B5.8090908@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Update INSTALL-win32.txt for OpenVPN
 2.3.10
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--6s/G0Ait2f6IH9MX
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Apr 27, 2016 at 01:21:41PM +0300, Arne Schwabe wrote:
> Am 04.01.16 um 20:22 schrieb samuli@...515...:
> > From: Samuli Sepp=E4nen <samuli@...515...>
> >=20
> > OpenVPN 2.3.10 includes an OpenVPN-GUI which automatically requests ele=
vation of
> > privileges using UAC. Modified INSTALL-win32.txt to reflect this behavi=
or.
>=20
> ACK from me. This seems to be still not applied.

Well, it isn't, but I answered Samuli's mail, and he agreed that we do
not want to go there:

---------------------------------------------------
[..]
> I wonder if these bits should not be removed from the INSTALL-win32.txt
> we ship in the main openvpn repo - since this is a gui thing and happens
> totally outside the main repo...  move it to the windows build tree,
> maybe, and show it from the installer upon installation?
>
> gert

Hi,

Looking at the the full contents of INSTALL-win32.txt your suggestion makes
sense. I'll migrate the file to openvpn-build and then send a removal patch
for openvpn/INSTALL-win32.txt.
---------------------------------------------------

... and this patch never came... :-)

So, what next?  Samuli?  Apply, based on Arne's ACK, or remove?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--6s/G0Ait2f6IH9MX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVyEBiakuBuNlUUl1AQJWeAP/TtaRL/4/G0Lgzh7cN2vhrhd5Mb5hg3uZ
az3OkuKOuj3zS01MnsP9E9x3swB/wVPNJD60G+UHePPoOUoXoIqC14ilTjmhuioO
pfaF5axteWhR4wKca2h4GgGYZplUuZ3SWqlLXqcsrxjbPykEW4lIi0GJ7+AOi/+P
7VUkK4PB0qI=
=LRfM
-----END PGP SIGNATURE-----

--6s/G0Ait2f6IH9MX--

