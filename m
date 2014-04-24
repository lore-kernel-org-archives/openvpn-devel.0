Date: Thu, 24 Apr 2014 16:59:30 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140424145929.GS16637@...1296...>
References: <CABBOjCJuPbKa-ocaqVQDtFT3PreE=GrZPm0Dv_12o1A14ZNkBA@...278...>
	<CABBOjC+m6LTk+TYtCXswYH017GAh7CFe8tSqOOr-idR+q_dTfg@...278...>
	<1398345955.723.137.camel@...1904...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rA0uFh46BbZscfDx"
Content-Disposition: inline
In-Reply-To: <1398345955.723.137.camel@...1904...>
Subject: Re: [Openvpn-devel] TAP adapter detection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Woodhouse <dwmw2@...1866...>
Cc: Greg Toombs <gtoombs@...1905...>, openvpn-devel@lists.sourceforge.net, openconnect-devel@...1906...

--rA0uFh46BbZscfDx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 24, 2014 at 02:25:55PM +0100, David Woodhouse wrote:
> Hm, really "tapoas"? Where did that driver come from?

Looking more closely, I see

        if self.opt.oas:
            kv['PRODUCT_NAME'] =3D "OpenVPNAS"
            kv['PRODUCT_TAP_WIN_DEVICE_DESCRIPTION'] =3D "TAP-Win32 Adapter=
 OAS (NDIS 6.0)"
            kv['PRODUCT_TAP_WIN_PROVIDER'] =3D "TAP-Win32 Provider OAS"
            kv['PRODUCT_TAP_WIN_COMPONENT_ID'] =3D "tapoas"

in the tap-windows6 build script...   so I'd assume that there is a=20
commercial OpenVPN client (Connect or PrivateTunnel) on that machine,=20
and it brought the new driver with it.

But that's pure guesswork.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--rA0uFh46BbZscfDx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU1km0akuBuNlUUl1AQLkeAQAwKqKJKS5jnniJmkDtOoTgTlOG+5uPstF
7oQkhv243KJdqUpzVo7lwnA98TVjU9xh7GEPWNY020WM27IGD4PEFuiMoDlA48tr
XU9fP4XNEccZiW1tfaDryOb02uOT/MgMxOxVx+TgJ9clhZwsDJvy6biJesMnX5e3
scLeeMwHctM=
=BgVk
-----END PGP SIGNATURE-----

--rA0uFh46BbZscfDx--

