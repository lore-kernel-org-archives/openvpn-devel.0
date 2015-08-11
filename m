Date: Tue, 11 Aug 2015 07:59:06 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150811055906.GX382@...1296...>
References: <20150730233727.GW3676@...2049...>
	<CAGyAFMWagBfdJtNvX_sK9CGH-SvvxgsnVBX3xx1Z2Ym41hhaGw@...278...>
	<20150810232802.GX3494@...2049...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Emn5l+AVSEkxEPsS"
Content-Disposition: inline
In-Reply-To: <20150810232802.GX3494@...2049...>
Subject: Re: [Openvpn-devel] Packet loss due to radius issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuel Thibault <samuel.thibault@...1817...>, Lev Stipakov <lstipakov@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Emn5l+AVSEkxEPsS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 11, 2015 at 01:28:02AM +0200, Samuel Thibault wrote:
> Looking at the source code in openvpn_plugin_open_v2, I see:
>=20
> context->acctsocketbackgr.send ( ADD_USER );
> ...
> context->acctsocketbackgr.send ( newuser->getVsaBuf(), newuser->getVsaBuf=
Len() );
> //get the response
> const int status =3D context->acctsocketbackgr.recvInt();
>=20
> This is again synchronous code, and this time I don't see any option
> to make it asynchronous...=20=20

I'm not proposing anything right now (this stuff is not exactly my field
of expertise with OpenVPN code), but maybe a quick hack...

> I can see that when accounting fails, an
> exception is thrown, to return an error to openvpn and thus prevent
> the connection.  I guess this is an important part that shouldn't be
> dropped, but I don't see a way to make it asynchronous without modifying
> the openvpn core.
>=20
> In our case we don't actually make use of radius accounting...

... you could modify the radiusplugin to just "do not do accounting" -
just return "success!" right away, and quickly so...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Emn5l+AVSEkxEPsS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVcmPKqkuBuNlUUl1AQIhxQP/VrTTfE8/09f0Bi+cNKmmJRcU5LY81fl6
8xKoBQH2jmg+YueGEPwLGVUHury4+/MKuBnw7wA3bW67UuV+4m/Wp4IH56qpXcBQ
9xt6QBdu02H37v/eurUGbNjpf9OtKcEb/O5ej/iEl0N6/6211PU8XVVKnqqcciG2
R1WLMLAF9eo=
=exRf
-----END PGP SIGNATURE-----

--Emn5l+AVSEkxEPsS--

