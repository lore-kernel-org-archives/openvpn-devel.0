Date: Fri, 12 Aug 2016 22:52:38 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160812205238.GI78279@...1296...>
References: <1470943420-15103-1-git-send-email-gert@...1296...>
	<1471023669-25102-1-git-send-email-gert@...1296...>
	<CAKuzo_jySkzG-fHJzz79-EvScbwnaN_PwD+e4dv17=WCxpagvA@...278...>
	<20160812184556.GG78279@...1296...>
	<CAKuzo_iGNaBV+J79UQw-84MJVsAB3cp0idPZimMrtPvs14kEEA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uvVZtPvgEsTJmsHL"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iGNaBV+J79UQw-84MJVsAB3cp0idPZimMrtPvs14kEEA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Change timestamps to ISO 8601 format.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--uvVZtPvgEsTJmsHL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 12, 2016 at 03:32:57PM -0400, Selva Nair wrote:
> Thanks for the clarification. AFAIK, we do not parse status output in
> OpenVPN GUI.=20

Good :-)

> A UI for server would need to parse those and it would have
> been nicer to have status timestamps sent to management be in unix time as
> well -- not a fault of this patch.

David checked with James, and at least OpenVPN AS supposedly doesn't
parse these timestamps - so, no show stopper yet...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--uvVZtPvgEsTJmsHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV643FqkuBuNlUUl1AQKygwP/ZOXHsVqvYvfW1E1Czh62+23QHVmZESd6
tZF/CSuS/eDG/BSfXpEvcU1nA+mGYLYuA/42kppwDIm40/9zElgQOVbV/thAkTau
obq4u1+EZGA997lSqOZPA6AHBP3tFcKFOzU+TjdpDC2Tml1Z+ioyP1Q4+k4XNCGi
OT/YDiqJIfA=
=lQtu
-----END PGP SIGNATURE-----

--uvVZtPvgEsTJmsHL--

