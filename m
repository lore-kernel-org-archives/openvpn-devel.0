Date: Wed, 21 Jun 2017 17:18:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170621151835.GU97029@...1296...>
References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
	<CAEsd45RR25O+vw=70Q5ZXRc+nnw19t+gjtz4+yiuOMM350vgcg@...278...>
	<173d674815ccc3a42fc615dbebeb3b0a.squirrel@...2257...>
	<5ffac4ab73daf53a27b5df238e7548e8.squirrel@...2257...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vqCYXlPyQFtVi6O7"
Content-Disposition: inline
In-Reply-To: <5ffac4ab73daf53a27b5df238e7548e8.squirrel@...2257...>
Subject: Re: [Openvpn-devel] OpenVPN 2.4.3 released (with security fixes)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--vqCYXlPyQFtVi6O7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 21, 2017 at 04:18:41PM +0200, Simon Matter wrote:
> An additional source of confusion seems that the tarball of the .gz and
> .xz files don't match. Maybe this could easily be fixed in the build
> process.

.gz is built with "make distcheck", .xz right after from the same
tree with "make dist-xz".

What differs?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--vqCYXlPyQFtVi6O7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZSo5KAAoJEB2Cnv7KVigSRJcL/3v/Tt7V3uhg3haA9ajaKfUV
L55N/0ZyrNMQghpBQTiifV88lhaXNyyta2pCm0WFk4Z8POkxuXiAi2EgbiqXxGRb
lb+7LKha9coT4vCQpLXW0OELHC4sRbB4w9vuJwOWXTgKhHKzwzfRxl5NVO7CINj9
+4zhcoysV64iUORjqowIOq1RXFW4caFR2WDhEHXJDKDOfzfM2DlnVg6gXgKxobYH
kiJn9VZcv5voiAvfVHue+EHg8ELvjdA577+mfMXh2hKKuR8gpfNoRc8uikKzJMnh
wWRMOj3ou+dPi0T05ZQBMNeYIvxWuyn5U0ZVwz5thQYtQ8bkJ3yPTsxbCcqnU0lv
H3K0LSbVrAll4mMwa2hTVmLEX22jUIAnShKQ8/RezkflffqtmQhnKybuNWj+wlbx
RZS34qqp9dngXNyVA9eRr0yZBdAbXZzpT3cPPu8zWO965VoIdPCL3ttpwuB4nNmd
XZs9utjdJMrwCe35OPz9EXeTxZhs7S5w07i2oeAT8A==
=LF38
-----END PGP SIGNATURE-----

--vqCYXlPyQFtVi6O7--

