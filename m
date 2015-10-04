Date: Sun, 4 Oct 2015 22:33:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151004203351.GA22054@...1296...>
References: <1435693496-10931-1-git-send-email-steffan@...1856...>
	<201507011539.t61FdhZl007032@...1295...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lQSB8Tqijvu1+4Ba"
Content-Disposition: inline
In-Reply-To: <201507011539.t61FdhZl007032@...1295...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Increase control channel
 packet size for faster handshakes
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

--lQSB8Tqijvu1+4Ba
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 01, 2015 at 05:39:43PM +0200, Gert Doering wrote:
> ACK.
>=20
> Your patch has been applied to the master branch.

... and to release/2.3 as agreed on the last IRC meeting (and since this
has seen quite a bit of testing by ValdikSS on his servers and lots of
Android OpenVPN users, we consider this "safe enough" for 2.3).

> commit fc91d4b0071178e298052078431fb86f03be84fc (master)
  commit 29b65ffdb2e7ed3d3b7bcac4048f6cd919ed13b3 (release/2.3)

>=20
> Author: Steffan Karger
> Date:   Tue Jun 30 21:44:56 2015 +0200
>=20
>      Increase control channel packet size for faster handshakes
>=20
>      Signed-off-by: Steffan Karger <steffan@...1856...>
>      Acked-by: Gert Doering <gert@...1296...>
>      Message-Id: <1435693496-10931-1-git-send-email-steffan@...1856...>
>      URL: http://article.gmane.org/gmane.network.openvpn.devel/9841
>      Signed-off-by: Gert Doering <gert@...1296...>

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--lQSB8Tqijvu1+4Ba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVhGNLqkuBuNlUUl1AQJpSwP/aX2lsGevAmcF/ZAafnFNwt8G7SdtmEEz
W4zQykFH/t0Na4zxKu3XNeBIa/dultKmtQlbVXP1jRBPx5BrlFZV8g4ypp2GeV2N
ZJ4ycHef4rP2TzasEgbfHAR3OLBPYUSsglEogxMIy+VSZ1MtWmMYrd9lIn/MjECq
5iCW8KwRXRA=
=j8sd
-----END PGP SIGNATURE-----

--lQSB8Tqijvu1+4Ba--

