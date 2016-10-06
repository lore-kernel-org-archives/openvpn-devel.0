Date: Thu, 6 Oct 2016 14:17:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20161006121736.GB78279@...1296...>
References: <784d3a54-24a9-dc57-b1f3-a8010d7e99db@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ozg8T3YPHc/WIgk3"
Content-Disposition: inline
In-Reply-To: <784d3a54-24a9-dc57-b1f3-a8010d7e99db@...277...>
Subject: Re: [Openvpn-devel] Slight change to buildbot t_client.sh.in &
 t_client.rc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--ozg8T3YPHc/WIgk3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 06, 2016 at 01:02:57PM +0100, debbie10t wrote:
> -R
> Instead of using all-zeros as the packet data, generate random bytes.=20
> Use to defeat, e.g., link data compression

-R is unlikely to have an effect here, as test 6 is run without
compression anyway (to the contrary, it would *fail* your tests that
succeed today due to compression :-) )

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ozg8T3YPHc/WIgk3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV/ZA36kuBuNlUUl1AQJExgP+I18MJd8F/RSoIONdU0D0PmHKIGuOvstz
rMBKkJvWDLq3Mqtr2RFqvk0d9SYLu9/bO3jdH6kPDtcGtVz11Sku6lNVF3vLt9e4
ydrGCn7m5tY0e86bc4uA95W7OqN3o6VzkzzeHE16vS4LmwTWTEOgAaUmekfa0FIP
5/vl34rKvr8=
=q0pK
-----END PGP SIGNATURE-----

--ozg8T3YPHc/WIgk3--

