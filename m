Date: Fri, 8 Jan 2016 14:51:50 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160108135150.GG24952@...1296...>
References: <1451931920-4248-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UUb2ES+9krqwiP+z"
Content-Disposition: inline
In-Reply-To: <1451931920-4248-1-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCHv2] Update INSTALL-win32.txt for OpenVPN
 2.3.10
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: samuli@...515...
Cc: openvpn-devel@lists.sourceforge.net

--UUb2ES+9krqwiP+z
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 04, 2016 at 08:25:20PM +0200, samuli@...515... wrote:
> From: Samuli Sepp=E4nen <samuli@...515...>
>=20
> OpenVPN 2.3.10 includes an OpenVPN-GUI which automatically requests eleva=
tion of
> privileges using UAC. Modified INSTALL-win32.txt to reflect this behavior.

I wonder if these bits should not be removed from the INSTALL-win32.txt
we ship in the main openvpn repo - since this is a gui thing and happens
totally outside the main repo...  move it to the windows build tree,
maybe, and show it from the installer upon installation?

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--UUb2ES+9krqwiP+z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVo++9akuBuNlUUl1AQIJXQP/WMoOptTJJal5/+cSsYo1QhK3GS3dUR55
EB/EpyXT9s8lvs0yn8l/uExETxiIBolc53ukX7f+OXKFdJesJjgo+bPhrJvOXsQj
AIvwBbm9ioWwdEu1tLqcMbNRr+Fueror7dmFTKtgT4CWfApZoKn9WVvyMAfrvsSJ
EoTCZuqbYoY=
=qqYL
-----END PGP SIGNATURE-----

--UUb2ES+9krqwiP+z--

