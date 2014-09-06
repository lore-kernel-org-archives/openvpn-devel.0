Date: Sat, 6 Sep 2014 13:56:15 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140906115615.GY1118@...1296...>
References: <1409930731-15263-1-git-send-email-davids@...1347...>
	<1409930731-15263-5-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nOzxAaGBfJwFK2kS"
Content-Disposition: inline
In-Reply-To: <1409930731-15263-5-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH 4/4] White-space clean-up of
	openvpn_popen()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: davids@...1347...
Cc: openvpn-devel@lists.sourceforge.net, fcrozat@...1519...

--nOzxAaGBfJwFK2kS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Sep 05, 2014 at 05:25:31PM +0200, davids@...1347... wrote:
> Reformatted to 2 space indents (no tabs).

NAK, as our current coding style is "2 space indents, tab=3D8" - even if
not consistently used everywhere, *if* we do reformatting at this stage,
do it towards the current style.

(I agree that we might want to reformat prior to releasing 2.4, and
should discuss this in Munich)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--nOzxAaGBfJwFK2kS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVAr2XqkuBuNlUUl1AQJvfAQAlv4VO/Ma8hMQvjKS0SlpBqrSUi3CSoiG
hG9R9oYXOLFa7xwWffgx9kEnTXCQHCozs0UqFQNtC+WawyQpNessKG0Yeb7xUiFN
MrEvgoTPA2wUjs5HISSpORQt5V/bYCNUMgf8slroPbnyPA93ttZaPeePk6eZTHzW
VG/HEs8XXW4=
=vXwt
-----END PGP SIGNATURE-----

--nOzxAaGBfJwFK2kS--

